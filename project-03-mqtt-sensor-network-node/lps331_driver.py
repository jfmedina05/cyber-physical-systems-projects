import smbus
import sys
import numpy

class lps331:
    ''' Allows connection from Raspberry Pi to I2C connected LPS331 '''

    def __init__(self, raspberry_pi_i2c_port=1):
        self.i2c_port_number = raspberry_pi_i2c_port
        self.bus = smbus.SMBus(self.i2c_port_number)
        self.address = self.find_sensor()
        if self.address == -1:
            print("Error: could not read from sensor at I2C address 0x5d")
            sys.exit()
        self.enable_sensor()

    def find_sensor(self):
        ''' Read the whoami byte from i2c address 0x5d and confirm to be 0xbb '''
        try:
            data = self.bus.read_byte_data(0x5d, 0x0f)
            if data == 0xbb:
                print("Found Sensor")
                return 0x5d
            else:
                print("Received %d from the sensor" % data)
                return -1
        except Exception as e:
            print("Error reading from sensor:", e)
            return -1

    def i2c_address(self):
        return self.address

    def sample_once(self):
        ''' Cause the sensor to sample once '''
        ctrl_reg2 = self.bus.read_byte_data(self.address, 0x21)
        self.bus.write_byte_data(self.address, 0x21, 0x01 | ctrl_reg2)
        while self.bus.read_byte_data(self.address, 0x21) & 0x01:
            pass

    def read_temperature(self):
        ''' Sample, read temperature registers, and convert to inhg '''
        tempC = 0
        self.sample_once()
        temp_l = self.bus.read_byte_data(self.address,0x2b)
        temp_h = self.bus.read_byte_data(self.address,0x2c)
        temp_raw = (temp_h << 8) | temp_l
        if temp_raw >= 2**15:
            temp_raw -= 2**16
        tempC = 42.5 + (temp_raw / 480.0)
        return tempC

    def get_temperature(self):
        ''' Return the temperature using the read_temperature method. '''
        return self.read_temperature()

    def read_pressure(self):
        ''' Sample, read pressure registers, and convert to inHg '''
        press_inhg = 0
        self.sample_once()
        press_xl = self.bus.read_byte_data(self.address, 0x28)
        press_l = self.bus.read_byte_data(self.address, 0x29)
        press_h = self.bus.read_byte_data(self.address, 0x2a)
        press_inhg = (press_h << 16) | (press_l << 8) | press_xl
        return (press_inhg) / 4096 * 0.02953

    def enable_sensor(self):
        try:
            CTRL_REG1 = 0x20  # Address of the control register
            POWER_ON = 0x80   # Bit to enable the sensor (set PD bit)
            ctrl_reg1 = self.bus.read_byte_data(self.address, CTRL_REG1)
            self.bus.write_byte_data(self.address, CTRL_REG1, POWER_ON | ctrl_reg1)
            print("Sensor enabled.")
        except Exception as e:
            print(f"Failed to enable sensor: {e}")

    def disable_sensor(self):
        try:
            CTRL_REG1 = 0x20  # Address of the control register
            POWER_OFF = 0x7F  # Bit to disable the sensor (clear PD bit)
            ctrl_reg1 = self.bus.read_byte_data(self.address, CTRL_REG1)
            self.bus.write_byte_data(self.address, CTRL_REG1, POWER_OFF & ctrl_reg1)
            print("Sensor disabled.")
        except Exception as e:
            print(f"Failed to disable sensor: {e}")

    def close(self):
        ''' Disable the sensor and close connection to I2C port '''
        self.disable_sensor()
        self.bus.close()

if __name__ == "__main__":
    try:
        # Initialize the sensor
        sensor = lps331(1)

        # Test temperature reading
        temp = sensor.get_temperature()  # Using the new get_temperature method
        print("Temperature = %0.2f Deg C" % temp)

        # Test pressure reading
        pressure = sensor.read_pressure()
        print("Pressure = %0.2f inHg" % pressure)

        # Disable the sensor
        sensor.close()
        print("\nSensor disabled and connection closed.")
    except Exception as e:
        print("An error has occured:", e)

