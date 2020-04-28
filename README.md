# [esp-homekit](https://github.com/maximkulkin/esp-homekit) 在 ESP8266 的移植

<details>
<summary><strong>中文版本</strong></summary>
<div>

[esp-homekit](https://github.com/maximkulkin/esp-homekit) 是 `Apple HomeKit` 配件服务器库，可以在 `esp8266` 和 `esp32` 上使用，以下是 [esp-homekit](https://github.com/maximkulkin/esp-homekit)  是基于 [ESP8266_RTOS_SDK](https://github.com/espressif/ESP8266_RTOS_SDK) 在 `esp8266` 上的移植步骤。

## 组件

- [esp-homekit](https://github.com/maximkulkin/esp-homekit)
- [esp-wolfssl](https://github.com/maximkulkin/esp-wolfssl)
- [esp-http-parser](https://github.com/maximkulkin/esp-http-parser)

## 步骤

- 下载这些库到 `compnents`，并重命名文件夹

  ```shell
  1. git clone --recursive https://github.com/maximkulkin/esp-homekit homekit
  2. git clone --recursive https://github.com/maximkulkin/esp-http-parser http-parser
  3. git clone --recursive https://github.com/maximkulkin/esp-wolfssl wolfssl
  ```

  

- 修改`makefile`文件

  ```shell
  PROJECT_NAME = esp8266-homekit-led
  
  CFLAGS += -DHOMEKIT_SHORT_APPLE_UUIDS
  
  include $(IDF_PATH)/make/project.mk
  ```

  

- 修改 `main` 文件下的 `component.mk`

  ```shell
  COMPONENT_DEPENDS := homekit
  ```

  

- 把项目的 `wifi.h.sample` 移到 `main` 文件夹下，然后修改为 `wifi.h`，最后写入自己的 `WiFi` 的 `SSID` 和 密码

  ```c
  #define WIFI_SSID "mywifi"
  #define WIFI_PASSWORD "mypassword"
  ```

  

- 修改`led demo`，详细见目录下的 `led.c`

  ```c
  ...
  
  #include <homekit/homekit.h>
  #include <homekit/characteristics.h>
  ...
      
  homekit_accessory_t *accessories[] = {
      HOMEKIT_ACCESSORY(.id=1, .category=homekit_accessory_category_lightbulb, .services=(homekit_service_t*[]){
          HOMEKIT_SERVICE(ACCESSORY_INFORMATION, .characteristics=(homekit_characteristic_t*[]){
              HOMEKIT_CHARACTERISTIC(NAME, "Sample LED"),
              HOMEKIT_CHARACTERISTIC(MANUFACTURER, "PYHOME"),
              HOMEKIT_CHARACTERISTIC(SERIAL_NUMBER, "025A2BABF19D"),
              HOMEKIT_CHARACTERISTIC(MODEL, "MyLED"),
              HOMEKIT_CHARACTERISTIC(FIRMWARE_REVISION, "0.1"),
              HOMEKIT_CHARACTERISTIC(IDENTIFY, led_identify),
              NULL
          }),
          HOMEKIT_SERVICE(LIGHTBULB, .primary=true, .characteristics=(homekit_characteristic_t*[]){
              HOMEKIT_CHARACTERISTIC(NAME, "Sample LED"),
              HOMEKIT_CHARACTERISTIC(
                  ON, false,
                  .getter=led_on_get,
                  .setter=led_on_set
              ),
              NULL
          }),
          NULL
      }),
      NULL
  };
  
  homekit_server_config_t config = {
      .accessories = accessories,
      .password = "111-11-111",
      .setupId="1SP0",
  };
  
  void on_wifi_ready() {
      homekit_server_init(&config);
  }
  
  ...
  ```




- 注意，需要在 `menuconfig` 中使能 `MDNS` 和 `IPV6` 

  ```shell
  # mDNs
  CONFIG_ENABLE_MDNS=y
  
  # IPV6
  CONFIG_LWIP_IPV6=y
  ```

  

## 声明

该项目参考 [esp32-homekit-led](https://github.com/Shaopus/esp32-homekit-led) 中的 `makefile` 和 项目目录

Although already forbidden by the sources and subsequent licensing, it is not allowed to use or distribute this software for a commercial purpose.

<img src="https://freepngimg.com/thumb/apple_logo/25366-7-apple-logo-file.png" width="20"/> 

###### HomeKit Accessory Protocol (HAP) is Apple’s proprietary protocol that enables third-party accessories in the home (e.g., lights, thermostats and door locks) and Apple products to communicate with each other. HAP supports two transports, IP and Bluetooth LE. The information provided in the HomeKit Accessory Protocol Specification (Non-Commercial Version) describes how to implement HAP in an accessory that you create for non-commercial use and that will not be distributed or sold.

###### The HomeKit Accessory Protocol Specification (Non-Commercial Version) can be downloaded from the [HomeKit Apple Developer page.](https://developer.apple.com/homekit/)

###### Copyright © 2019 Apple Inc. All rights reserved.



</div>
</details>



[esp-homekit](https://github.com/maximkulkin/esp-homekit) is `Apple HomeKit` accessory server library, which can be used on esp8266 and esp32, the following is [esp-homekit](https://github.com/maximkulkin/esp-homekit) based on  [ESP8266_RTOS_SDK](https://github.com/espressif/ESP8266_RTOS_SDK) migration steps on esp8266.

## Components

- [esp-homekit](https://github.com/maximkulkin/esp-homekit)
- [esp-wolfssl](https://github.com/maximkulkin/esp-wolfssl)
- [esp-http-parser](https://github.com/maximkulkin/esp-http-parser)

## Steps

- download these libraries to components and rename folder

  ```shell
  1. git clone --recursive https://github.com/maximkulkin/esp-homekit homekit
  2. git clone --recursive https://github.com/maximkulkin/esp-http-parser http-parser
  3. git clone --recursive https://github.com/maximkulkin/esp-wolfssl wolfssl
  ```

  

- modify the makefile

  ```shell
  PROJECT_NAME = esp8266-homekit-led
  
  CFLAGS += -DHOMEKIT_SHORT_APPLE_UUIDS
  
  include $(IDF_PATH)/make/project.mk
  ```

  

- modify the `component.mk` under main 

  ```shell
  COMPONENT_DEPENDS := homekit
  ```




- move the project's `wifi.h.sample` to main folder, then modify it to `wifi.h`, finally write your WiFi SSID and password

  ```c
  #define WIFI_SSID "mywifi"
  #define WIFI_PASSWORD "mypassword"
  ```

  

- modify led demo, see the `led.c` for details

  ```c
  ...
  
  #include <homekit/homekit.h>
  #include <homekit/characteristics.h>
  ...
      
  homekit_accessory_t *accessories[] = {
      HOMEKIT_ACCESSORY(.id=1, .category=homekit_accessory_category_lightbulb, .services=(homekit_service_t*[]){
          HOMEKIT_SERVICE(ACCESSORY_INFORMATION, .characteristics=(homekit_characteristic_t*[]){
              HOMEKIT_CHARACTERISTIC(NAME, "Sample LED"),
              HOMEKIT_CHARACTERISTIC(MANUFACTURER, "PYHOME"),
              HOMEKIT_CHARACTERISTIC(SERIAL_NUMBER, "025A2BABF19D"),
              HOMEKIT_CHARACTERISTIC(MODEL, "MyLED"),
              HOMEKIT_CHARACTERISTIC(FIRMWARE_REVISION, "0.1"),
              HOMEKIT_CHARACTERISTIC(IDENTIFY, led_identify),
              NULL
          }),
          HOMEKIT_SERVICE(LIGHTBULB, .primary=true, .characteristics=(homekit_characteristic_t*[]){
              HOMEKIT_CHARACTERISTIC(NAME, "Sample LED"),
              HOMEKIT_CHARACTERISTIC(
                  ON, false,
                  .getter=led_on_get,
                  .setter=led_on_set
              ),
              NULL
          }),
          NULL
      }),
      NULL
  };
  
  homekit_server_config_t config = {
      .accessories = accessories,
      .password = "111-11-111",
      .setupId="1SP0",
  };
  
  void on_wifi_ready() {
      homekit_server_init(&config);
  }
  
  ...
  ```



- note! you need to enable MDNS and IPV6 in menuconfig

  ```shell
  # mDNs
  CONFIG_ENABLE_MDNS=y
  
  # IPV6
  CONFIG_LWIP_IPV6=y
  ```

## Statement:

This project refers to the makefile and project directory from [esp32-homekit-led](https://github.com/Shaopus/esp32-homekit-led)

Although already forbidden by the sources and subsequent licensing, it is not allowed to use or distribute this software for a commercial purpose.

<img src="https://freepngimg.com/thumb/apple_logo/25366-7-apple-logo-file.png" width="20"/> 

###### HomeKit Accessory Protocol (HAP) is Apple’s proprietary protocol that enables third-party accessories in the home (e.g., lights, thermostats and door locks) and Apple products to communicate with each other. HAP supports two transports, IP and Bluetooth LE. The information provided in the HomeKit Accessory Protocol Specification (Non-Commercial Version) describes how to implement HAP in an accessory that you create for non-commercial use and that will not be distributed or sold.

###### The HomeKit Accessory Protocol Specification (Non-Commercial Version) can be downloaded from the [HomeKit Apple Developer page.](https://developer.apple.com/homekit/)

###### Copyright © 2019 Apple Inc. All rights reserved.