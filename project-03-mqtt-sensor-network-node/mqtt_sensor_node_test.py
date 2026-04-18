import paho.mqtt.client as mqtt
import time
from lps331ap import lps331 
from adxl343 import adxl343  

# White Bar Code Label Number on Each Raspberry Pi
sensor_id = 999498  # Pi Serial Number

# Initialize sensor objects
temp_pressure_sensor = lps331()
accel_sensor = adxl343() 

# Callback function when a message is received
def on_message(client, userdata, message):
    # Print out the received message (optional)
    print("message:", message.payload.decode('UTF-8'))

# Callback function for successful connection
def on_connect(client, userdata, flags, rc):
    print("file_connect", "Connected with result code", rc)



# Set up MQTT client
client = mqtt.Client()
client.on_message = on_message
client.on_connect = on_connect
client.connect("pivot.iuiot.org")
client.loop_start()

while True:
    # Get live sensor data
    temperature = temp_pressure_sensor.get_temperature()  
    pressure = temp_pressure_sensor.read_pressure()  
    x_acceleration, y_acceleration, z_acceleration = accel_sensor.get_acceleration() 
    
    # Publish the sensor data to the MQTT broker
    print("Publishing Temperature, Pressure, and Accelerometer Data")
    client.publish(f"sensors/{sensor_id}/temperature", f"{temperature}")
    client.publish(f"sensors/{sensor_id}/pressure", f"{pressure}")
    client.publish(f"sensors/{sensor_id}/accel/x", f"{x_acceleration}")
    client.publish(f"sensors/{sensor_id}/accel/y", f"{y_acceleration}")
    client.publish(f"sensors/{sensor_id}/accel/z", f"{z_acceleration}")
    
    # Sleep for 5 seconds before publishing again
    time.sleep(5)
