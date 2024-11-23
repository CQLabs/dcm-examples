import 'dart:io';

import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.dcmService,
    required this.mode,
  });

  final AuthService dcmService;
  final String mode;

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final WebViewController flutterWebviewPlugin = WebViewController();

  bool urlOutOfIntranet = false;

  Future<void> checkAndRequestPermissions() async {
    await [
      Permission.camera,
      Permission.mediaLibrary,
      Permission.microphone,
      Permission.notification,
      Permission.photos,
      Permission.videos,
      Permission.audio,
      Permission.storage,
      Permission.location,
    ].request();
  }

  hideFormLoginOnWeb() {
    flutterWebviewPlugin.runJavaScript(
      """
        document.querySelector('#login').style.display = 'none'
        document.cookie = "mode=${widget.mode}";
      """,
    );
  }

  Future<void> loginAndRegisterDevice() async {
    final (:userDeviceToken, :platform, :user, :pass) = await getUserData();

    flutterWebviewPlugin.runJavaScript("""
                Wo_CacheMobileDeviceToken("$userDeviceToken", "$platform", "$user", "$pass");
                document.cookie = "is_native_app=1";
                document.cookie = "mode=${widget.mode}";
                """);
  }

  Future<
      ({
        String? userDeviceToken,
        String platform,
        String? user,
        String? pass
      })> getUserData() async {
    final String platform = Platform.operatingSystem;
    final (user, pass) = widget.dcmService.getUserPass();
    final userDeviceToken = await widget.dcmService.getUserDeviceToken();
    return (
      userDeviceToken: userDeviceToken,
      platform: platform,
      user: user,
      pass: pass
    );
  }

  @override
  void initState() {
    flutterWebviewPlugin
      ..runJavaScript("document.cookie = 'mode=${widget.mode}';")
      ..addJavaScriptChannel(
        'Print',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('JavascriptChannel ${message.message}');
        },
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadRequest(Uri.parse(widget.dcmService.intranetBaseUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // debugPrint('progress: $progress');
          },
          onPageStarted: (String url) {
            debugPrint('PageStarted: $url');
            if (url.startsWith(widget.dcmService.intranetBaseUrl)) {
              setState(() {
                urlOutOfIntranet = false;
              });
            } else {
              setState(() {
                urlOutOfIntranet = true;
              });
            }
            if (url == "${widget.dcmService.intranetBaseUrl}/logout") {
              handleLogoutWebsite();
            }
          },
          onPageFinished: (String url) {
            debugPrint('PageFinished: $url');

            if (url == "${widget.dcmService.intranetBaseUrl}/welcome") {
              hideFormLoginOnWeb();
              loginAndRegisterDevice();
            }
            if (url == "${widget.dcmService.intranetBaseUrl}/") {
              loginAndRegisterDevice();
              checkAndRequestPermissions();
            }
          },
          onWebResourceError: (error) {
            debugPrint(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url == "${widget.dcmService.intranetBaseUrl}/logout") {
              handleLogoutWebsite();
            }
            // if (!request.url.contains('dcm.dev')) {
            //   return NavigationDecision.prevent;
            // }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(true);
    if (Platform.isAndroid) {
      final controller = (flutterWebviewPlugin.platform
          as webview_flutter_android.AndroidWebViewController);
      controller.setOnShowFileSelector(_androidFilePicker);
      controller.enableZoom(true);
    }
    super.initState();
  }

  Future<List<String>> _androidFilePicker(
    webview_flutter_android.FileSelectorParams params,
  ) async {
    if (params.acceptTypes.any((type) => type == 'image/*')) {
      final picker = image_picker.ImagePicker();
      final photo = await picker.pickImage(
        source: image_picker.ImageSource.gallery,
      );

      if (photo == null) {
        return [];
      }

      return [Uri.file(photo.path).toString()];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: urlOutOfIntranet
              ? AppBar(
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      flutterWebviewPlugin.runJavaScript(
                        'window.location.href = "${widget.dcmService.intranetBaseUrl}"',
                      );
                    },
                  ),
                )
              : null,
          body: Column(
            children: <Widget>[
              Expanded(
                child: scaffoldWebView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  scaffoldWebView() {
    return WebViewWidget(
      controller: flutterWebviewPlugin,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> handleLogoutWebsite() async {
    debugPrint('>>> LogoutFinished In Flutter');
    await widget.dcmService.clearStorage();
    await flutterWebviewPlugin.clearCache();
    await flutterWebviewPlugin.clearLocalStorage().then((value) {
      Navigator.of(context).pushReplacementNamed('/auth');
    });
  }
}
