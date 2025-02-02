#!/usr/bin/env python3
from time import sleep
import RPi.GPIO as GPIO
import datetime
import requests

GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
#GPIO.setup(11, GPIO.IN, pull_up_down=GPIO.PUD_DOWN) # Set pin to be an input pin and set initial value to be pulled low (off)
GPIO.setup(11, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin to be an input pin and set initial value to be pulled high

print("Service starting")

status = ""
new_status = ""
url = "{{ pillar['floatswitch']['url'] }}"

while True: # Run forever
    if GPIO.input(11) == GPIO.HIGH:
        new_status = 1
    else:
        new_status = 0

    data = {"sensor": "floatswitch1", "value": new_status}
    r = requests.post(url, json=data)
    print(r.status_code)
    #print(r.json())

    if status != new_status:
        now = datetime.datetime.now()
        print(f"{now} {new_status}")
        status = new_status

    sleep(60)
