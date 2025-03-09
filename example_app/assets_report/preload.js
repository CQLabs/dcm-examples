let d = 'dark';
if (localStorage.getItem('dcm-theme') == d) {
  document.querySelector('html').setAttribute('data-theme', d);
}
