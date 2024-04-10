import requests

base_url = 'https://api.openweathermap.org/data/2.5/weather'

api_key = '5456118857af5d7f7484ae9cafd9ca97'

city_name = 'Depok'
full_url = f'{base_url}?q={city_name}&appid={api_key}'


response = requests.get(full_url)

if response.status_code == 200:
    data = response.json()
    
    weather_description = data['weather'][0]['description']
    temperature_kelvin = data['main']['temp']
    
    temperature_celsius = temperature_kelvin - 273.15
    
    print(f'Weather in {city_name}: {weather_description}')
    print(f'Temperature: {temperature_celsius:.2f} °C')
else:
    print('Failed to fetch weather data')
