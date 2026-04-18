import paho.mqtt.client as mqtt
import time
from lps331ap import lps331  
from adxl343 import adxl343    #
from led_driver import Led_Driver  

#num on our raspberry pi
sensor_id = 999498 

#initialize  objects
temp_pressure_sensor = lps331()  
accel_sensor = adxl343()  
led = Led_Driver(18)

#callback function when a message is received
def on_message(client, userdata, message):
    payload = message.payload.decode('UTF-8')
    print("message:", payload)
    
    if message.topic == f"sensors/{sensor_id}/led/duty":
        led.on(int(payload))  # Set LED brightness (0-100)
    elif message.topic == f"sensors/{sensor_id}/led/frequency":
        led.change_frequency(int(payload))  # Change LED frequency


#callback function for successful connection
def on_connect(client, userdata, flags, rc):
    print("file_connect", "Connected with result code", rc)
    topics = [(f"sensors/{sensor_id}/led/duty", 0), (f"sensors/{sensor_id}/led/frequency", 0)]
    client.subscribe(topics)



#set up MQTT client
client = mqtt.Client()
client.on_message = on_message
client.on_connect = on_connect
client.connect("pivot.iuiot.org")
client.loop_start()

while True:
    # Get live sensor data
    temp_pressure_sensor.sample_once()
        

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

    
    client.publish(f"sensors/{sensor_id}/led/status", f"duty:{led.duty},frequency:{led.frequency}")
 
    # Sleep for 5 seconds before publishing again
    time.sleep(5)
