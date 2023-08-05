#include <sys/cdefs.h>

#include <pico/printf.h>
#include <pico/stdlib.h>

#include "hardware/i2c.h"
#include <hardware/structs/scb.h>

#include "eeprom_dat.h"

/*
this code dumps the current contents of the eeprom.
Connect GPIO4 (SDA) and GPIO5 (SCL) with the bl24c64
As VCC i used the 3.3V from the pico and any GND
WP is already connected to GND
DO NOT CONNECT THE BATTERY OR USB POWER
*/


int main() {
    stdio_init_all();

    i2c_init(i2c_default, 10 * 1000);
    gpio_set_function(PICO_DEFAULT_I2C_SDA_PIN, GPIO_FUNC_I2C);
    gpio_set_function(PICO_DEFAULT_I2C_SCL_PIN, GPIO_FUNC_I2C);
    gpio_pull_up(PICO_DEFAULT_I2C_SDA_PIN);
    gpio_pull_up(PICO_DEFAULT_I2C_SCL_PIN);

    sleep_ms(1000);
    char buf[8192];
    //set address
    char *addr[2];
    addr[0] = 0;
    addr[1] = 0;

    i2c_write_blocking(i2c_default, 0x50, addr, 2, false);
    sleep_ms(2);

    i2c_read_blocking(i2c_default, 0x50, buf, 8192, false);
    for (int i = 0; i < 8192; ++i) {
        printf("%02x\n", buf[i]);
    }

    sleep_ms(1000);
    printf("starting write\n");

    unsigned char write_data[32 + 2];

    for (unsigned int addr = 0; addr < eeprom_dump_len; addr += 32) {

        printf("writing %05x\n", addr);

        write_data[0] = (addr >> 8);
        write_data[1] = (addr & 0xFF);
        for (int i = 0; i < 32; ++i) {
            write_data[2 + i] = eeprom_dump[addr + i];
        }

        i2c_write_blocking(i2c_default, 0x50, write_data, 2+32, false);
        sleep_ms(2);

    }

    printf("writing done\n");

    while (1) {
        tight_loop_contents();
        sleep_ms(1);
    }

}