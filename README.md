# 🌤️ Weather Man
**Weather Man** is a minimalist Java (Servlet + JSP) web app that shows the **current weather** for any city. It runs on **Tomcat 10**, uses **Maven** to build a WAR, and fetches live data from **Open-Meteo** (Geocoding + Forecast APIs). The UI is simple: a centered search, popular-cities shortcuts, a light/dark toggle, and a tiny °C↔°F converter.

---

## 🚀 Features
- 🔎 **Search any city** and get current temperature (°C).
- 🗺️ **Popular cities** grid for one-click queries.
- 🌓 **Light/Dark mode** toggle (persists via `localStorage`).
- 🌡️ **°C ↔ °F converter** (client-side, instant).
- 🧩 **Result card** with back button; clean, responsive layout.
- 📦 **WAR deployment** on Apache Tomcat 10.

---

## 🛠 Tech Stack
Layer | Tech
---|---
Server | Java 17+ (works great on 21), **Jakarta Servlet 6**, JSP
Build | **Maven**
Web Server | **Apache Tomcat 10.1.x**
HTTP Client | Java `HttpClient` (JDK 11+)
JSON | **Jackson Databind**
UI | HTML, CSS, tiny vanilla JS (no frameworks)

---

## 🧠 How it works (Flow)
1. User types a city on **`index.jsp`** and submits the form.
2. Browser calls **`GET /weatherapp/weather?city=...`**.
3. **`WeatherServlet`**:
   - Calls **Open-Meteo Geocoding API** → gets **lat/lon**.
   - Calls **Open-Meteo Forecast API** → gets **current temperature** (°C).
   - Puts `city`, `tempC` on the request and **forwards** to `result.jsp`.
4. **`result.jsp`** renders a centered **result card** and a **Back** button.

## 🔭 Future Additions / Scope

### 1) UX & Features
- **Favorites & Home Dashboard**: Save cities and show their current temps at a glance.
- **Search autocomplete**: City suggestions as you type (local list + API lookups).
- **7-day forecast & hourly breakdown**: Temps, precipitation, wind, humidity, sunrise/sunset.
- **Weather icons & descriptions**: Map codes → human text + icon set (clear, rain, etc.).
- **Unit & locale settings**: Persist °C/°F, wind units, language preferences.
- **Geolocate me**: Detect user location (with permission) to show local weather.
- **Shareable links**: Pre-filled city via URL (e.g., `/weather?city=Tokyo`).
- **Accessibility**: High contrast, keyboard nav, ARIA labels, reduced motion.

### 2) Accounts & Persistence (optional)
- **User auth**: Register/login (bcrypt password hashing), remember me.
- **MySQL**: Store users, favorites, preferences, recent searches.
- **Sessions or JWT**: Session-based for classic JSP; JWT if moving toward APIs.
- **Profile page**: Manage saved cities, default units, theme.

### 3) Backend & APIs
- **Service layer**: Extract `WeatherService` to encapsulate API calls & mapping.
- **Resilience**: Timeouts, retries with backoff, graceful fallbacks/caching.
- **Multiple data sources**: Add air quality, precipitation radar, alerts.
- **Rate limiting & caching**: Guava/Caffeine or Redis for API responses.
- **Scheduled refresh**: Periodically refresh popular cities (cron).

### 4) Performance & Ops
- **HTTP/2 & gzip**: Enable compression and keep-alive.
- **Edge caching/CDN**: Cache static assets; cache popular-city responses.
- **Docker**: Dockerfile + `docker-compose` (Tomcat + MySQL).
- **CI/CD**: GitHub Actions (build, test, package, deploy).
- **Observability**: Structured logs, request IDs, basic metrics/health endpoint.

### 5) Testing & Quality
- **Unit tests**: JSON parsing, code→description mapping, converters.
- **Integration tests**: Servlet tests (Mock HTTP), end-to-end smoke tests.
- **Contract tests**: Validate assumptions against API schemas.
- **Lighthouse**: Performance, accessibility, SEO checks on pages.

### 6) Security & Privacy
- **TLS everywhere** (prod).
- **Input validation** & output encoding (avoid XSS).
- **Secrets handling**: If using keyed APIs, store outside source control.
- **Robust error pages**: No stack traces to users, friendly messages.

### 7) Architecture Evolution (optional)
- **From JSP to SPA**: Keep servlet API, add a lightweight front-end (HTMX/Alpine/Vanilla).
- **Spring Boot path**: Swap Tomcat-managed WAR for Boot app (easier config, testing).
- **Modularization**: `web` (servlets/JSP), `core` (services/models), `infra` (HTTP, cache).

### Suggested Roadmap
- **MVP+**: Favorites, icons/descriptions, 7-day forecast.
- **v2**: Accounts (MySQL), settings (units/theme), caching, tests.
- **v3**: CI/CD, Docker, observability, multi-API data, SPA/Spring refactor.

---

## 🔧 Prerequisites
- **JDK 17+** (JDK 21 OK)
- **Maven 3.8+**
- **Apache Tomcat 10.1.x** (`$CATALINA_HOME` set)

---

## ▶️ Build & Run (Local Tomcat)
```bash
# from project root
mvn clean package

# deploy
cp target/weatherapp.war "$CATALINA_HOME/webapps/"

# start Tomcat
"$CATALINA_HOME/bin/startup.sh"

# open in browser
http://localhost:8080/weatherapp/
