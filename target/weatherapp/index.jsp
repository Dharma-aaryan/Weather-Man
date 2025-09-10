<!doctype html>
<html lang="en" data-theme="">
<head>
  <meta charset="utf-8" />
  <title>Weather Man</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <style>
    /* ---------- Theme tokens (light by default) ---------- */
    :root{
      --bg:#f7f7f8;
      --card:#ffffff;
      --text:#0f172a;
      --muted:#6b7280;
      --accent:#2563eb;
      --border:#e5e7eb;
      --shadow:0 1px 2px rgba(0,0,0,.06), 0 4px 12px rgba(0,0,0,.04);
      --radius:14px;

      /* API box variables (light) */
      --api-bg:#fafafa;
      --api-border:rgba(0,0,0,.12);
      --api-shadow:0 1px 4px rgba(0,0,0,.06);
    }
    /* DARK when <html data-theme="dark">  */
    html[data-theme="dark"]{
      --bg:#0b1220;
      --card:#0f172a;
      --text:#e5e7eb;
      --muted:#9aa3b2;
      --accent:#2563eb;
      --border:#1f2937;

      /* API box (dark) */
      --api-bg:#0f172a;
      --api-border:#1f2937;
      --api-shadow:0 1px 6px rgba(0,0,0,.4);
    }

    /* ---------- Base ---------- */
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);color:var(--text);
         font:16px/1.45 system-ui,-apple-system,Segoe UI,Roboto,Helvetica,Arial}
    a{color:var(--accent);text-decoration:none}

    .container{max-width:1100px;margin:28px auto;padding:0 16px}
    header{display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:18px}
    .brand{display:flex;flex-direction:column}
    .brand .t1{font-weight:800;font-size:22px}
    .brand .t2{font-size:14px;color:var(--muted);margin-top:2px}

    .toolbar{display:flex;gap:10px;align-items:center}
    .btn,button{
      padding:8px 12px;border-radius:10px;border:1px solid var(--border);
      background:var(--card);color:var(--text);cursor:pointer;transition:.15s ease
    }
    .btn:hover, button:hover{filter:brightness(2.05)}
    .btn-accent{background:var(--accent);border-color:var(--accent);color:#fff;}
    input[type="text"],input[type="number"]{
      width:100%;padding:12px 14px;border:1px solid var(--border);
      border-radius:10px;background:var(--card);color:var(--text);outline:none
    }
    .card{background:var(--card);border:1px solid var(--border);border-radius:var(--radius);box-shadow:var(--shadow)}
    .pad{padding:16px}
    .section-title{margin:0 0 10px;font-weight:700;text-align:center}

    /* Centered search */
    .center-wrap{display:grid;place-items:center;margin:12px 0}
    .search-card{width:min(700px,95%)}

    /* Popular cities grid */
    .grid{display:grid;gap:10px}
    @media(min-width:700px){.grid{grid-template-columns:repeat(3,1fr)}}
    @media(min-width:1000px){.grid{grid-template-columns:repeat(4,1fr)}}
    .city{display:flex;align-items:center;justify-content:space-between}
    .city form{margin:0}

    /* Converter */
    .two{display:grid;grid-template-columns:1fr 1fr;gap:10px}
    .stack{display:grid;gap:10px}

    /* API Used card */
    .api-box{
      max-width:500px;margin:24px auto;padding:16px 20px;
      border:1px solid var(--api-border);border-radius:12px;
      background:var(--api-bg);box-shadow:var(--api-shadow);
      font:14px/1.5 system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
    }
    .api-box h4{margin:0 0 6px}
  </style>
</head>

<body>
  <div class="container">
    <header>
      <div class="brand">
        <div class="t1">Weather Man</div>
        <div class="t2">Check weather around the globe</div>
      </div>
      <div class="toolbar">
        <button id="themeToggle" class="btn" type="button">Dark</button>
      </div>
    </header>

    <!-- Centered search -->
    <div class="center-wrap">
      <div class="card search-card">
        <div class="pad">
          <h3 class="section-title">Check weather of any city in the world</h3>
          <form action="weather" method="get" class="stack" style="max-width:520px;margin:0 auto">
            <input type="text" name="city" placeholder="Type a city (e.g., Tampa)" required>
            <button class="btn-accent" type="submit">Get weather</button>
          </form>
        </div>
      </div>
    </div>

    <!-- Popular cities -->
    <div class="card" style="margin-top:16px">
      <div class="pad">
        <h3 class="section-title" style="text-align:left">Popular cities</h3>
        <div class="grid">
          <!-- Americas -->
          <div class="card"><div class="pad city"><strong>New York</strong><form action="weather" method="get"><input type="hidden" name="city" value="New York"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Los Angeles</strong><form action="weather" method="get"><input type="hidden" name="city" value="Los Angeles"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Chicago</strong><form action="weather" method="get"><input type="hidden" name="city" value="Chicago"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Toronto</strong><form action="weather" method="get"><input type="hidden" name="city" value="Toronto"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Dallas</strong><form action="weather" method="get"><input type="hidden" name="city" value="Dallas"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>San Francisco</strong><form action="weather" method="get"><input type="hidden" name="city" value="San Francisco"><button class="btn">View</button></form></div></div>
          <!-- Europe -->
          <div class="card"><div class="pad city"><strong>London</strong><form action="weather" method="get"><input type="hidden" name="city" value="London"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Paris</strong><form action="weather" method="get"><input type="hidden" name="city" value="Paris"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Berlin</strong><form action="weather" method="get"><input type="hidden" name="city" value="Berlin"><button class="btn">View</button></form></div></div>
          <!-- Asia -->
          <div class="card"><div class="pad city"><strong>Tokyo</strong><form action="weather" method="get"><input type="hidden" name="city" value="Tokyo"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Mumbai</strong><form action="weather" method="get"><input type="hidden" name="city" value="Mumbai"><button class="btn">View</button></form></div></div>
          <div class="card"><div class="pad city"><strong>Delhi</strong><form action="weather" method="get"><input type="hidden" name="city" value="Delhi"><button class="btn">View</button></form></div></div>
        </div>
      </div>
    </div>

    <!-- °C ↔ °F converter -->
    <div class="card" style="margin-top:16px">
      <div class="pad">
        <h3 class="section-title" style="text-align:left">Temperature converter</h3>
        <div class="two">
          <div class="stack">
            <label for="cIn">Celsius</label>
            <input id="cIn" type="number" step="any" placeholder="e.g., 25">
          </div>
          <div class="stack">
            <label for="fIn">Fahrenheit</label>
            <input id="fIn" type="number" step="any" placeholder="e.g., 77">
          </div>
        </div>
        <div class="stack" style="margin-top:10px">
          <button id="clearConv" class="btn-accent" type="button" style="width:max-content">Clear</button>
        </div>
      </div>
    </div>

    <!-- API used -->
    <div class="api-box">
      <h4>API used</h4>
      Open-Meteo: Geocoding API and Forecast API for current weather.
    </div>
  </div>

  <script>
    // ---- Theme toggle: set data-theme on <html> and persist ----
    (function(){
      const key='theme';
      const root=document.documentElement; // <html>
      const saved=localStorage.getItem(key);
      if(saved==='dark') root.setAttribute('data-theme','dark');

      const btn=document.getElementById('themeToggle');
      function sync(){
        const dark=root.getAttribute('data-theme')==='dark';
        btn.textContent = dark ? 'Light' : 'Dark';
      }
      sync();

      btn.addEventListener('click',()=>{
        const dark=root.getAttribute('data-theme')==='dark';
        if(dark){ root.removeAttribute('data-theme'); localStorage.setItem(key,'light'); }
        else    { root.setAttribute('data-theme','dark'); localStorage.setItem(key,'dark'); }
        sync();
      });
    })();

    // ---- Simple °C ↔ °F converter ----
    (function(){
      const c=document.getElementById('cIn'),
            f=document.getElementById('fIn'),
            clr=document.getElementById('clearConv');
      let lock=false;
      const round=x=>Math.round(x*10)/10;

      c.addEventListener('input',()=>{
        if(lock) return; lock=true;
        const v=parseFloat(c.value);
        f.value=Number.isFinite(v)? round(v*9/5+32):'';
        lock=false;
      });

      f.addEventListener('input',()=>{
        if(lock) return; lock=true;
        const v=parseFloat(f.value);
        c.value=Number.isFinite(v)? round((v-32)*5/9):'';
        lock=false;
      });

      clr.addEventListener('click',()=>{c.value='';f.value='';});
    })();
  </script>
</body>
</html>
