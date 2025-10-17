public with sharing class apitestingfinal {
     // Inner classes to map the JSON response
    public class WeatherResponse {
        public Decimal latitude;
        public Decimal longitude;
        public String timezone;
        public Decimal elevation;
        public CurrentWeather current_weather;
    }
    
    public class CurrentWeather {
        public String  times;
        public Integer interval;
        public Decimal temperature;
        public Decimal windspeed;
        public Integer winddirection;
        public Integer is_day;
        public Integer weathercode;
    }
    
    // Main method to call the API and print weather info
       @AuraEnabled(cacheable=true)
    public static void getWeatherData() {
        // Prepare the HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true');
        request.setMethod('GET');
        
        try {
            // Send the request
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                // Parse JSON
                WeatherResponse weather = (WeatherResponse) JSON.deserialize(response.getBody(), WeatherResponse.class);
                
                // Print results
                System.debug('✅ Weather Report');
                System.debug('🌍 Latitude: ' + weather.latitude);
                System.debug('🌍 Longitude: ' + weather.longitude);
                System.debug('🕒 Time: ' + weather.current_weather.times);
                System.debug('🌡️ Temperature: ' + weather.current_weather.temperature + ' °C');
                System.debug('💨 Windspeed: ' + weather.current_weather.windspeed + ' km/h');
                System.debug('🧭 Wind Direction: ' + weather.current_weather.winddirection + '°');
                System.debug('🌦️ Weather Code: ' + weather.current_weather.weathercode);
                System.debug('☀️ Is Daytime: ' + weather.current_weather.is_day);
            } else {
                System.debug('❌ API Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('⚠️ Exception: ' + e.getMessage());
        }
    }
}
