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
      do_search(text);
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
    li.className = "empty";
    li.innerHTML = "No results found";
    ul.appendChild(li);
  }

  results.forEach(r => {
    var li = document.createElement("li");
    var a = document.createElement("a");
    // r.doc.id is an absolute permalink (built from base_url); use just the
    // path so links resolve against the current host (dev or prod).
    try {
      a.href = new URL(r.doc.id).pathname;
    } catch (e) {
      a.href = r.doc.id;
    }

    var title = document.createElement("span");
    title.className = "result-title";
    title.textContent = (r.doc.title && r.doc.title != "") ? r.doc.title : "No title";
    a.appendChild(title);

    if (r.doc.body) {
      var snippet = document.createElement("span");
      snippet.className = "result-snippet";
      var body = r.doc.body.replace(/\s+/g, " ").trim();
      snippet.textContent = body.length > 200 ? body.slice(0, 200).trim() + "…" : body;
      a.appendChild(snippet);
    }

    li.appendChild(a);
    ul.appendChild(li);
  });

  result_div.appendChild(ul);
  result_div.style.display = "block";
  // Reveal to the actual content height so the snippet rows can't clip.
  result_div.style.height = result_div.scrollHeight + "px";
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

// --- Packed tag cloud -------------------------------------------------
// Replaces the flat tag list on the tags page with a wordle-style packed
// cloud: biggest tags are placed first along a spiral, smaller tags fill
// the holes. The original <ul> is kept (hidden) as a no-JS fallback.

function tag_cloud_hash(str) {
  let h = 2166136261;
  for (let i = 0; i < str.length; i++) {
    h ^= str.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

// Deterministic PRNG so the cloud looks the same on every visit.
function tag_cloud_rng(seed) {
  return function () {
    seed |= 0;
    seed = (seed + 0x6D2B79F5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function build_tag_cloud(ul) {
  const links = Array.from(ul.querySelectorAll("a"));
  if (links.length === 0) return;

  const rng = tag_cloud_rng(tag_cloud_hash(links.map(a => a.textContent).join(",")));

  const items = links.map(a => ({
    name: a.textContent.trim(),
    href: a.getAttribute("href"),
    weight: parseInt(a.dataset.weight || "1", 10),
  }));

  const max_weight = Math.max.apply(null, items.map(i => i.weight));
  const min_size = 10, max_size = 92;
  items.forEach(i => {
    const t = (i.weight - 1) / Math.max(max_weight - 1, 1);
    i.size = min_size + (max_size - min_size) * Math.pow(t, 0.5);
  });
  // Big words first: they claim space, the small ones backfill the holes.
  items.sort((a, b) => b.size - a.size || a.name.localeCompare(b.name));

  const width = ul.parentElement.clientWidth || 800;
  const family = getComputedStyle(document.body).fontFamily;
  const font_weight = "700";
  const cell = 4;

  // Build a per-word glyph mask (which 4px cells the letters actually
  // cover). Colliding on glyphs instead of boxes lets small words nest
  // into the gaps of big ones, which is what makes a cloud look packed.
  const scratch = document.createElement("canvas");
  const sctx = scratch.getContext("2d", { willReadFrequently: true });

  items.forEach(it => {
    const font = font_weight + " " + it.size + "px " + family;
    sctx.font = font;
    const m = sctx.measureText(it.name);
    const asc = Math.ceil(m.actualBoundingBoxAscent || it.size * 0.8);
    const desc = Math.ceil(m.actualBoundingBoxDescent || it.size * 0.25);
    const tw = Math.ceil(m.width) + 2;
    const th = asc + desc + 2;

    // How far the ink sits below the line box middle, descenders included.
    const fasc = m.fontBoundingBoxAscent || it.size * 0.8;
    const fdesc = m.fontBoundingBoxDescent || it.size * 0.2;
    const baseline = (it.size - (fasc + fdesc)) / 2 + fasc;
    it.dy = baseline + (desc - asc) / 2 - it.size / 2;

    it.cnt_size = it.size * 0.55;
    sctx.font = it.cnt_size + "px " + family;
    it.cnt_w = sctx.measureText("(" + it.weight + ")").width + it.cnt_size * 0.25;

    scratch.width = tw;
    scratch.height = th;
    sctx.font = font; // canvas resize resets state
    sctx.fillText(it.name, 1, asc + 1);
    const data = sctx.getImageData(0, 0, tw, th).data;

    let gw = Math.ceil(tw / cell), gh = Math.ceil(th / cell);
    let mask = [];
    for (let gy = 0; gy < gh; gy++) mask.push(new Uint8Array(gw));
    for (let py = 0; py < th; py++) {
      const row = mask[(py / cell) | 0];
      for (let px = 0; px < tw; px++) {
        if (data[(py * tw + px) * 4 + 3] > 40) row[(px / cell) | 0] = 1;
      }
    }
    // Dilate one cell in every direction: ~4px breathing room.
    const dil = [];
    for (let gy = 0; gy < gh; gy++) dil.push(new Uint8Array(gw));
    for (let gy = 0; gy < gh; gy++) {
      for (let gx = 0; gx < gw; gx++) {
        if (!mask[gy][gx]) continue;
        for (let dy = -1; dy <= 1; dy++) {
          const ty = gy + dy;
          if (ty < 0 || ty >= gh) continue;
          for (let dx = -1; dx <= 1; dx++) {
            const tx = gx + dx;
            if (tx >= 0 && tx < gw) dil[ty][tx] = 1;
          }
        }
      }
    }
    mask = dil;

    // Straight angles only: mostly horizontal, some vertical reading
    // bottom-up (rotate -90), never upside-down.
    if (rng() < 0.3) {
      const rot = [];
      for (let y = 0; y < gw; y++) rot.push(new Uint8Array(gh));
      for (let gy = 0; gy < gh; gy++) {
        for (let gx = 0; gx < gw; gx++) {
          if (mask[gy][gx]) rot[gw - 1 - gx][gy] = 1;
        }
      }
      mask = rot;
      it.deg = -90;
      it.bw = th;
      it.bh = tw;
      gw = mask[0].length;
      gh = mask.length;
    } else {
      it.deg = 0;
      it.bw = tw;
      it.bh = th;
    }

    // Sparse list of set cells: collision checks only touch real glyph
    // cells, and bail on the first hit.
    it.mw = gw;
    it.mh = gh;
    it.points = [];
    for (let gy = 0; gy < gh; gy++) {
      for (let gx = 0; gx < gw; gx++) {
        if (mask[gy][gx]) it.points.push([gx, gy]);
      }
    }
    it.color = Math.floor(rng() * 6);
  });

  // Global occupancy grid, indexed in cells.
  const grid_w = Math.ceil(width / cell);
  const grid = [];
  function grid_row(y) {
    if (!grid[y]) grid[y] = new Uint8Array(grid_w);
    return grid[y];
  }
  function fits(gx, gy, it) {
    if (gx < 0 || gy < 0 || gx + it.mw > grid_w) return false;
    for (let i = 0; i < it.points.length; i++) {
      const p = it.points[i];
      if (grid_row(gy + p[1])[gx + p[0]]) return false;
    }
    return true;
  }
  function occupy(gx, gy, it) {
    for (let i = 0; i < it.points.length; i++) {
      const p = it.points[i];
      grid_row(gy + p[1])[gx + p[0]] = 1;
    }
  }

  // Rough canvas height estimate from total glyph area; glyph packing
  // nests much tighter than bounding boxes.
  const area = items.reduce((s, i) => s + i.points.length, 0) * cell * cell;
  const est_h = Math.max(area * 1.15 / width, 160);
  const cx = width / 2, cy = est_h / 2;

  let max_y = 0;
  const steps = 8000;

  items.forEach(it => {
    const start = rng() * Math.PI * 2;
    // One continuous spiral: sqrt(t) spreads samples evenly over the
    // ellipse's area; past t=1 the horizontal radius is capped by the
    // page width while the vertical radius keeps growing, so once the
    // ellipse is saturated late tags pack against its edge.
    for (let s = 0; s < steps * 5; s++) {
      const a = start + s * 0.35;
      const t = Math.sqrt(s / steps);
      const x = cx + Math.cos(a) * Math.min(t, 1) * (width / 2 + 40) - it.bw / 2;
      const y = cy + Math.sin(a) * t * (est_h / 2 + 40) - it.bh / 2;
      const gx = Math.round(x / cell), gy = Math.round(y / cell);
      if (fits(gx, gy, it)) {
        occupy(gx, gy, it);
        it.x = gx * cell;
        it.y = gy * cell;
        max_y = Math.max(max_y, it.y + it.bh);
        break;
      }
    }
  });

  // Trim empty space above the cloud.
  let min_y = Infinity;
  items.forEach(it => { if (it.x !== undefined) min_y = Math.min(min_y, it.y); });
  items.forEach(it => { it.y -= min_y; });
  max_y -= min_y;

  const cloud = document.createElement("div");
  cloud.className = "tag-cloud";
  cloud.style.height = Math.ceil(max_y) + "px";

  items.forEach(it => {
    if (it.x === undefined) return; // no space found, extremely unlikely
    const a = document.createElement("a");
    a.href = it.href;
    a.textContent = it.name;
    a.dataset.weight = it.weight;
    a.className = "c" + it.color;
    a.style.fontSize = it.size + "px";
    a.style.left = (it.x + it.bw / 2) + "px";
    a.style.top = (it.y + it.bh / 2) + "px";
    // Base values mirror the CSS shorthand; dy pads the box onto the glyphs.
    const base_v = it.size * 0.12, base_h = it.size * 0.3;
    const pad_t = Math.max(base_v - it.dy, 0), pad_b = Math.max(base_v + it.dy, 0);
    const pad_l = base_h, pad_r = base_h + it.cnt_w;
    a.style.padding = pad_t + "px " + pad_r + "px " + pad_b + "px " + pad_l + "px";
    a.style.setProperty("--cnt-size", it.cnt_size + "px");
    a.style.setProperty("--cnt-right", base_h + "px");

    // Undo the box shift from the asymmetric padding, in the glyphs' frame.
    const ox = (pad_l - pad_r) / 2;
    const oy = it.dy + (pad_t - pad_b) / 2;
    a.style.setProperty(
      "--tr",
      "translate(-50%, -50%) rotate(" + it.deg + "deg) translate(" +
        (-ox).toFixed(2) + "px, " + (-oy).toFixed(2) + "px)"
    );
    cloud.appendChild(a);
  });

  ul.style.display = "none";
  ul.parentElement.appendChild(cloud);
}

function init_tag_clouds() {
  const lists = document.querySelectorAll("article.tags > ul");
  if (lists.length === 0) return;

  // Wait for the web font: text must be measured with the real face.
  document.fonts.ready.then(() => {
    lists.forEach(build_tag_cloud);
  });

  let resize_timer = null;
  window.addEventListener("resize", () => {
    clearTimeout(resize_timer);
    resize_timer = setTimeout(() => {
      document.querySelectorAll(".tag-cloud").forEach(c => c.remove());
      lists.forEach(build_tag_cloud);
    }, 200);
  });
}

function content_loaded() {
  init_search();
  init_theme();
  init_tag_clouds();
}

document.addEventListener("DOMContentLoaded", content_loaded());
