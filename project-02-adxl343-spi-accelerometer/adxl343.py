import spidev
import time
import numpy as np

class adxl343:
    ''' Enables communication between the Raspberry Pi and the ADXL343 board from SparkFun '''

    def __init__(self, spi_device=0, ce_pin=0, speed=1000000):
        """
        spi_device: There are two SPI ports. It is most common to use port 0. 
        ce_pin: There are two CE pins that are automatically controlled by the Pi. 
        speed: The speed for the SPI clock is specified here. Used to limit SPI speed. 
        """
        self.spi = spidev.SpiDev()
        self.spi.open(spi_device, ce_pin)
        self.spi.max_speed_hz = speed   # Sets the maximum speed of the SPI link 
        self.spi.mode = 0b11            # Sets the SPI clock phase and polarity to mode 3
        time.sleep(0.5)

        if self.get_device_id() == '0xe5':
            self.enable()
            print("Found ADXL343")
        else:
            print("Device ID Incorrect")

    def read_register(self, address):
        address = address | 0x80  # Set the read mode 
        read_bytes = self.spi.xfer2([address, 0x00])  # Send the register address and a dummy byte to clock back data
        return read_bytes[1]

    def write_register(self, address, data):
        self.spi.xfer2([address, data])
        return 0

    def enable(self):
        """ Set the measure bit in the POWER_CTL Register to enable sensor """
        power_control_register = 0x2D
        measure_bit = 0x08

        #reads the current value stored in the pwr_ctrl_regstr
        current_value = self.read_register(power_control_register)
        
        #sets the measure bit to 1, without changing other values
        new_value = current_value | measure_bit

        #writes the new value back to the power control register, which enables the sensor
        self.write_register(power_control_register, new_value)

        #prints if sensor is correctly enabled
        if self.read_register(power_control_register) & measure_bit:
            print("Sensor enabled")
        else:
            print("Error in enabling sensor")

    def get_device_id(self):
        """ Read the DEVID register to get back the value of the register"""
        """ Function should return a string that is the output of running the hex function on returned byte"""
        #defining register    
        device_id_register = 0x00

        #reading ID register & defining it to device_id
        device_id = self.read_register(device_id_register)
        
        return hex(device_id)

    def read_x_axis(self):
        """ Read the two bytes for the axis, return a floating point g value on a +/-2g scale. """
        #lsb & msb are lower/upper half of the 16 bit integer
        lsb = self.read_register(0x32)
        msb = self.read_register(0x33)

        #combine the two values into a "value" variable
        value = (msb << 8) | lsb

        #convert the value to a signed integer
        if value & 0x8000:  # Convert to signed
            value = -((value ^ 0xFFFF) + 1)

        #converts LSB into mg
        value =  value * 3.9

        #converts mg into g
        value = value / 1000
        return value   # Convert to g

    def read_y_axis(self):
        """ Read the two bytes for the axis, return a floating point g value on a +/-2g scale. """
        lsb = self.read_register(0x34)
        msb = self.read_register(0x35)
        value = (msb << 8) | lsb
        if value & 0x8000:  # Convert to signed
            value = -((value ^ 0xFFFF) + 1)
       
        #converts LSB into mg
        value =  value * 3.9

        #converts mg into g
        value = value / 1000
        return value

    def read_z_axis(self):
        """ Read the two bytes for the axis, return a floating point g value on a +/-2g scale. """
        lsb = self.read_register(0x36)
        msb = self.read_register(0x37) 
        value = (msb << 8) | lsb
        if value & 0x8000:  # Convert to signed
            value = -((value ^ 0xFFFF) + 1)
        
        #converts LSB into mg
        value =  value * 3.9

        #converts mg into g
        value = value / 1000
        return value  # Convert to g


if __name__ == "__main__":
    sensor = adxl343()
    while 1:
        print(sensor.read_x_axis(), sensor.read_y_axis(), sensor.read_z_axis())
        time.sleep(1)
