(() => {
let s = document.querySelector.bind(document);
let ls = localStorage;
s('#theme-button').addEventListener('click', () => {
  let a = 'data-theme';
  let k = 'dcm-theme';
  let h = s('html');

  let t = h.getAttribute(a);
  if (t === 'dark') {
    ls.setItem(k, 'light');
    h.removeAttribute(a);
  } else {
    ls.setItem(k, 'dark');
    h.setAttribute(a, 'dark');
  }
});

let n = window.location.pathname.split("/").pop();
let e = s(`.sidebar a[href='./${n}']`);

e?.classList.add('selected');
e?.scrollIntoViewIfNeeded();


let table = s('table.sortable');
if (table != null) {
  let sort = JSON.parse(ls.getItem(table.id));
  if (sort != null && sort.element) {
    let element = s(`#${sort.element}`);
    element?.click();
    if (sort.order == 'asc') {
      element?.click();
    }
  }

  document.querySelectorAll('.sortable th').forEach(item => item.addEventListener('click', (event) => {
    let target = event.target;
    ls.setItem(table.id, JSON.stringify({element: target.id, order: target.ariaSort == 'descending' ? 'asc' : 'desc'}));
  }));
}
})()
