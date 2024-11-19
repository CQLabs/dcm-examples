import 'package:flutter/material.dart';

class DropdownNotification extends StatelessWidget {
  const DropdownNotification({
    super.key,
    required this.onTap,
    required this.title,
    required this.body,
  });

  final void Function()? onTap;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 55),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45.0),
            bottomRight: Radius.circular(45.0),
          ),
          color: Colors.black,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 20.0,
              offset: Offset(0, 15.0),
              color: Color.fromRGBO(218, 218, 218, .25),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 17.0),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    body,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
