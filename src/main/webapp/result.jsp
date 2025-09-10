<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String city = (String) request.getAttribute("city");
    Double tempC = (Double) request.getAttribute("tempC");
    String error = (String) request.getAttribute("error");
    String unit = request.getParameter("unit");
    if (unit == null) unit = "c";

    String unitSymbol = "°C";
    String displayTemp = "N/A";
    if (tempC != null) {
        double t = tempC.doubleValue();
        if ("f".equalsIgnoreCase(unit)) {
            t = (t * 9/5.0) + 32.0;
            unitSymbol = "°F";
        }
        displayTemp = String.format("%.1f %s", t, unitSymbol);
    }
%>
<!doctype html>
<html lang="en" data-theme="light">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Weather Man · Result</title>
  <style>
    :root {
      --bg: #0b0c10;
      --card: #111318;
      --text: #e8eaed;
      --muted: #a9b1bd;
      --accent: #4dabf7;
      --accent-2: #82c91e;
      --border: #2a2f3a;
      --input: #0f1115;
    }
    [data-theme="light"] {
      --bg: #f6f7fb;
      --card: #ffffff;
      --text: #111318;
      --muted: #5a6573;
      --accent: #1f6feb;
      --accent-2: #2fb344;
      --border: #e5e7eb;
      --input: #ffffff;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0; background: var(--bg); color: var(--text);
      font: 16px/1.5 system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
    }
    .wrap { max-width: 860px; margin: 0 auto; padding: 24px; }

    .bar {
      display: flex; align-items: baseline; justify-content: space-between; gap: 16px; margin-bottom: 20px;
    }
    .title { font-size: 24px; font-weight: 700; letter-spacing: .2px; }
    .subtitle { font-size: 14px; color: var(--muted); margin-top: 4px; }
    .right { display: flex; gap: 10px; align-items: center; }

    .btn, button {
      appearance: none; border: 1px solid var(--border); background: var(--card);
      color: var(--text); padding: 8px 12px; border-radius: 8px; cursor: pointer;
    }
    .btn:hover, button:hover { filter:brightness(2.05); }
    .btn-accent { background: var(--accent); color: white; border-color: var(--accent); }
    .btn-ghost { background: transparent; }

    .card {
      background: var(--card); border: 1px solid var(--border);
      border-radius: 14px; padding: 20px; box-shadow: 0 8px 24px rgba(0,0,0,.18);
      margin-bottom: 16px;
    }
    .center {
      display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;
    }
    .city { font-size: 22px; font-weight: 700; margin: 6px 0 2px; }
    .temp { font-size: 42px; font-weight: 800; margin: 8px 0; letter-spacing: .5px; }
    .err { color: #ff6b6b; font-weight: 600; }

    .grid { display: grid; gap: 16px; }
    .form-row { display: flex; gap: 10px; flex-wrap: wrap; }
    label { font-size: 14px; color: var(--muted); margin-bottom: 6px; display: inline-block; }
    input[type="text"] {
      width: 280px; padding: 10px 12px; background: var(--input);
      color: var(--text); border: 1px solid var(--border); border-radius: 8px;
    }
    .muted { color: var(--muted); font-size: 13px; }

    @media (max-width: 520px) {
      .title { font-size: 20px; }
      .temp { font-size: 34px; }
      input[type="text"] { width: 100%; }
    }

    .back-btn{
        display:inline-block; padding:8px 12px; border:1px solid #ccc;
        border-radius:6px; text-decoration:none; font-weight:600;
    }

  </style>
</head>
<body>
  <div class="wrap">
    <header class="bar">
      <div>
        <div class="title">Weather Man</div>
        <div class="subtitle">Check weather around the globe</div>
      </div>
      <div class="right">
        <!-- Unit switch (re-requests weather for the same city if known) -->
        <form method="get" action="weather" style="display:inline;">
          <input type="hidden" name="city" value="<%= city == null ? "" : city %>"/>
          <input type="hidden" name="unit" value="c"/>
          <button class="btn">°C</button>
        </form>
        <form method="get" action="weather" style="display:inline;">
          <input type="hidden" name="city" value="<%= city == null ? "" : city %>"/>
          <input type="hidden" name="unit" value="f"/>
          <button class="btn">°F</button>
        </form>

        <!-- Theme toggle -->
        <button id="themeBtn" class="btn btn-ghost" title="Toggle theme">🌓</button>
      </div>
    </header>

    <div class="grid">
      <!-- Result card (centered content) -->
      <section class="card center">
        <h2 style="margin:0;">Weather Result</h2>
        <div style="height:8px;"></div>

        <% if (error != null) { %>
          <p class="err"><%= error %></p>
        <% } else { %>
          <div class="city"><%= (city == null || city.isBlank()) ? "—" : city %></div>
          <div class="temp"><%= displayTemp %></div>
          <div class="muted">Showing in <%= "f".equalsIgnoreCase(unit) ? "Fahrenheit (°F)" : "Celsius (°C)" %></div>
        <% } %>
      </section>


      <!-- Search-again card -->
      <section class="card">
        <form method="get" action="weather">
          <input type="hidden" name="unit" value="<%= unit %>"/>
          <label for="city">Check weather of a city</label>
          <div class="form-row">
            <input id="city" name="city" type="text" placeholder="e.g., Tokyo" required />
            <button class="btn btn-accent" type="submit">Get Weather</button>
          </div>
          <p class="muted" style="margin-top:10px;">Try: New York, London, Tokyo, Mumbai, Sydney…</p>
        </form>
      </section>

       

        <a href="index.jsp" class="button"> ← Go back to the main page to explore other cities</a>
     
    </div>
  </div>

  <script>
    // Theme toggle persists in localStorage
    (function () {
      const root = document.documentElement;
      const key = "weather-theme";
      const saved = localStorage.getItem(key);
      if (saved === "dark") root.setAttribute("data-theme","dark");
      const btn = document.getElementById("themeBtn");
      btn.addEventListener("click", () => {
        const isDark = root.getAttribute("data-theme") === "dark";
        root.setAttribute("data-theme", isDark ? "light" : "dark");
        localStorage.setItem(key, isDark ? "light" : "dark");
      });
    })();
  </script>
</body>
</html>
