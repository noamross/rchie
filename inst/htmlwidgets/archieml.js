replace_el = (obj, key, el, markdown, inline, md) => {
  for (var i in key) {
    obj = obj[key[i]];
  }
  if (markdown) {
    if (inline) {
      obj = md.renderInline(obj);
    } else {
      obj = md.render(obj);
    }
  }
  el.innerHTML = obj;
};

render_archieml_cache = () => {
  let cache = {};
  let md = window.markdownit();
  return (el, src, key, markdown, inline) => {
    if (cache[src]) {
      replace_el(cache[src], key, el, markdown, inline, md);
    } else {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          cache[src] = archieml.load(xhttp.responseText);
          replace_el(cache[src], key, el, markdown, inline, md);
        }
      };
      xhttp.open("GET", src, true);
      xhttp.send();
    }
  };
};

render_archieml = render_archieml_cache();


HTMLWidgets.widget({
  name: 'archieml',
  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        el.innerText = x.fallback;
        render_archieml(el, x.src, x.key, x.markdown, x.inline);
      },
      resize: function(width, height) {}
    };
  }
});
