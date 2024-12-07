# lab11: platform device driver into
## By: Kenneth Vincent

## Overveiw
This lab is to teach me what it take to control the ARM chip through a device tree and kernel 
module to basically accomplish the most complicated way to turn on LEDs.

## Questuons?
1. What is the purpose of the platform bus?
the purpose of the platform bus is to represent and manage the the devices that are in the drivers
and registers in the soc enviroment.


2. Why is the device driver’s compatible property important?
I would say that it is important to have compatible property for the drivers so the kernel can 
accuratly match the firmware of the device to the device tree. which allows the chip to give the 
correct response.

3. What is the probe function’s purpose?
It is to setup and initialize the device when the kernel detects it.


4. How does your driver know what memory addresses are associated with your device?
my driver knows what memory addresses are associated with my devices due to the device tree that I have created.

5. What are the two ways we can write to our device’s registers? In other words, what subsystems do we use to write to our registers?
the two subsystems I use is the platform bus and the Miscdev subsystem.

6. What is the purpose of our struct led_patterns_dev state container?
to create the led patterns and hold the values for the registers and offsets for the leds.

