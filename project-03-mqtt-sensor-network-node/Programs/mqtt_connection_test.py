import paho.mqtt.client as mqtt

# Define the MQTT broker and port
broker = "pivot.iuiot.org"
port = 1883  # Default port for MQTT

# Define the callback for connection (just to confirm the connection)
def on_connect(client, userdata, flags, rc):
    print(f"Connected with result code {rc}")
    # Once connected, send a message
    client.publish("test/hello", "Hello World")

# Create an MQTT client instance
client = mqtt.Client()

# Set the on_connect callback function
client.on_connect = on_connect

# Connect to the MQTT broker
client.connect(broker, port, 60)

# Start the MQTT client loop
client.loop_start()

# Wait a bit for the message to be sent
client.loop_forever()

