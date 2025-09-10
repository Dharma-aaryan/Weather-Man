package com.example;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.net.http.*;
import com.fasterxml.jackson.databind.*;

@WebServlet("/weather")
public class WeatherServlet extends HttpServlet {

    private final HttpClient http = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String city = req.getParameter("city");
        if (city == null || city.isBlank()) {
            resp.sendError(400, "city is required");
            return;
        }

        try {
            // 1) City -> lat/lon (Open-Meteo geocoding)
            String q = URLEncoder.encode(city, StandardCharsets.UTF_8);
            URI geo = URI.create("https://geocoding-api.open-meteo.com/v1/search?count=1&name=" + q);
            HttpResponse<String> geoRes = http.send(HttpRequest.newBuilder(geo).GET().build(),
                    HttpResponse.BodyHandlers.ofString());
            JsonNode g = mapper.readTree(geoRes.body());
            if (!g.has("results") || g.get("results").isEmpty()) {
                req.setAttribute("error", "City not found");
                req.getRequestDispatcher("/result.jsp").forward(req, resp);
                return;
            }
            JsonNode first = g.get("results").get(0);
            double lat = first.get("latitude").asDouble();
            double lon = first.get("longitude").asDouble();
            String resolvedName = first.get("name").asText();

            // 2) Get current weather
            URI wx = URI.create("https://api.open-meteo.com/v1/forecast?latitude=" + lat
                    + "&longitude=" + lon + "&current=temperature_2m,weather_code");
            HttpResponse<String> wxRes = http.send(HttpRequest.newBuilder(wx).GET().build(),
                    HttpResponse.BodyHandlers.ofString());
            JsonNode w = mapper.readTree(wxRes.body()).path("current");
            Double tempC = w.path("temperature_2m").isMissingNode() ? null : w.get("temperature_2m").asDouble();
            Integer code = w.path("weather_code").isMissingNode() ? null : w.get("weather_code").asInt();

            // 3) Put data on request
            req.setAttribute("city", resolvedName);
            req.setAttribute("tempC", tempC);
            req.setAttribute("code", code);

            // 4) Show it
            req.getRequestDispatcher("/result.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Failed to fetch weather", e);
        }
    }
}
