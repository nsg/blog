function init_search() {
    let search_div = document.getElementsByClassName("search")[0];
    let form = search_div.getElementsByTagName("form")[0];
    let result_div = search_div.getElementsByClassName("search-result")[0];
    let index = elasticlunr.Index.load(window.searchIndex);
    let options = {
        bool: "AND",
        fields: {
          title: {boost: 2},
          body: {boost: 1},
        }
      };

    form.addEventListener("submit", (event) => {
        let text = event.target.getElementsByTagName("input")[0].value;
        let results = index.search(text, options);
        var ul = document.createElement("ul");

        results.forEach(r => {
            var li = document.createElement("li");
            var a = document.createElement("a");
            a.innerHTML = r.doc.title;
            a.href = r.doc.id;
            li.appendChild(a);
            ul.appendChild(li);
        });
        
        result_div.appendChild(ul);
        result_div.style.display = "block";

        event.preventDefault();
    });
}

document.addEventListener("DOMContentLoaded", init_search());
