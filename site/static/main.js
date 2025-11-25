function toggle_search(target) {
  let search_div = document.querySelector("#search");
  let search_input = document.querySelector("#search input");
  let search_loading = document.querySelector("#search .loading");
  let result_div = document.querySelector("#search .results");

  if (target.classList.contains("search-open")) {
    search_div.style.display = "none";
    target.classList.remove("search-open");
  } else {
    search_div.style.display = "block";
    search_input.classList.add("hidden");
    target.classList.add("search-open");

    load_search_index(() => {
      search_loading.style.display = "none";
      search_input.classList.remove("hidden");
      search_input.focus();
    });

  }
}

function close_search() {
  let button = document.querySelector(".search button");
  if (button.classList.contains("search-open")) {
    toggle_search(button);
  }
}

function load_search_index(callback) {
    if (document.querySelectorAll("script[src*='search_index']")[0] != undefined) {
      callback();
      return;
    }

    let elasticlunr = document.createElement("script");
    let search_index = document.createElement("script");

    elasticlunr.src = elasticlunr_path;
    search_index.src = search_index_path;

    elasticlunr.onload = () => {
      document.head.appendChild(search_index);
    }

    search_index.onload = () => {
      callback();
    }

    document.head.appendChild(elasticlunr);
}

function search_index(text) {
  let index = elasticlunr.Index.load(window.searchIndex);

  let options = {
    bool: "AND",
    fields: {
      title: {boost: 2},
      body: {boost: 1},
    }
  };

  return index.search(text, options);
}

function init_search() {
  let search_div = document.querySelector("#search");
  let form = search_div.getElementsByTagName("form")[0];

    document.querySelector(".search button").addEventListener("keypress", (event) => {
      toggle_search(event.target);
      event.preventDefault();
    });

    document.querySelector(".search button").addEventListener("click", (event) => {
      toggle_search(event.target);
      event.preventDefault();
    });

    form.addEventListener("submit", (event) => {
      let text = event.target.getElementsByTagName("input")[0].value;
      do_search(index, options, text);
      event.preventDefault();
    });

    document.addEventListener("keyup", (event) => {
      if (event.key == "Escape") {
        close_search();
      }
    });

    form.addEventListener("keyup", (event) => {
      do_search(event.target.value);
    });
}

function do_search(text) {

  let result_div = document.querySelector("#search .results");
  result_div.style.opacity = "1";

  let results = search_index(text);
  var ul = document.createElement("ul");
    
  result_div.innerHTML = "";

  if (results.length == 0) {
    var li = document.createElement("li");
    li.innerHTML = "No results found";
    ul.appendChild(li);
    result_div.style.height = "2em";
  }

  results.forEach(r => {
    var li = document.createElement("li");
    var a = document.createElement("a");
    
    if (r.doc.title == "") {
      a.innerHTML = "➢ No title";
    } else {
      a.innerHTML = "➢ " + r.doc.title;
    }

    a.href = r.doc.id;
    li.appendChild(a);
    ul.appendChild(li);

  });
  
  if (results.length > 0) {
    result_div.style.height = Math.ceil(results.length * 2.1) + "em";
  }

  result_div.appendChild(ul);
  result_div.style.display = "block";
}

function os_prefer_dark_mode() {
  return window.matchMedia("(prefers-color-scheme: dark)").matches
}

function get_saved_theme() {
  return localStorage.getItem("theme");
}

function update_theme() {
  let toggle = document.getElementById('theme-toggle')
  const theme = toggle.checked ? 'dark' : 'light';
  set_theme(theme);
  localStorage.setItem("theme", theme);
}

function set_theme(mode) {
  document.documentElement.setAttribute('data-theme', mode);
}

function init_theme() {
  let toggle = document.getElementById('theme-toggle')
  let slider = document.querySelector('.theme-toggle .slider')

  // Set initial state from the theme that was set in the inline script
  // This prevents the animation from playing on page load
  if (window.__initialTheme) {
    toggle.checked = window.__initialTheme === 'dark';
  }

  // Remove preload class to enable transitions after initial state is set
  setTimeout(() => {
    slider.classList.remove('preload');
  }, 100);

  toggle.addEventListener('change', (event) => {
    update_theme()
  });
}

function content_loaded() {
  init_search();
  init_theme();
}

document.addEventListener("DOMContentLoaded", content_loaded());
