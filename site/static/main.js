function toggle_search(target) {
  let search_div = document.querySelector("#search");

  if (target.classList.contains("search-open")) {
    search_div.style.display = "none";
    target.classList.remove("search-open");
  } else {
    search_div.style.display = "block";
    target.classList.add("search-open");
    document.querySelector("#search input").focus();
  }
}

function close_search() {
  let button = document.querySelector(".search button");
  if (button.classList.contains("search-open")) {
    toggle_search(button);
  }
}

function init_search() {
    let search_div = document.querySelector("#search");
    let form = search_div.getElementsByTagName("form")[0];
    let index = elasticlunr.Index.load(window.searchIndex);
    let options = {
        bool: "AND",
        fields: {
          title: {boost: 2},
          body: {boost: 1},
        }
      };

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
      do_search(index, options, event.target.value);
    });
}

function do_search(index, options, text) {
  let result_div = document.querySelector("#search .results");
  result_div.style.opacity = "1";

  let results = index.search(text, options);
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

document.addEventListener("DOMContentLoaded", init_search());
