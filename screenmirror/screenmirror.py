import subprocess
import time
from telnetlib import Telnet
import numpy as np
import pygame

# if oocd is not already running, start it (use exec to keep the pid, so kill works)
oocd = subprocess.Popen('exec openocd -f dp32g030.cfg', stdout=subprocess.PIPE, shell=True)
time.sleep(2)

tn = Telnet('localhost', 4444)


def getImage():
    tn.read_until(b">")
    tn.write(b"read_memory 0x20000704 8 896" + b"\n")
    tn.read_until(b"\r\n")  # echo of command
    mem = tn.read_until(b"\r\n").decode("ascii").replace("\r\n", "")  # data

    string_arr = mem.split(" ")
    bytes_arr = []
    for elem in string_arr:
        bytes_arr.append(int(elem, 16))
    byte_cnt = 0
    image = np.empty([128, 56], dtype=int)
    for row in range(7):
        for colmn in range(128):
            for bit in range(8):
                image[colmn][8 * row + bit] = 1 if (bytes_arr[byte_cnt] >> bit) & 0x1 == 1 else 0
            byte_cnt += 1

    # return np.fliplr(np.rot90(image, 3))   # use this if you use matplotlib to show the array
    return image


pygame.init()
display = pygame.display.set_mode((128 * 4, 56 * 4))
Z = np.empty([128, 56], dtype=int)
Z = 255 * Z / Z.max()
surf = pygame.surfarray.make_surface(Z)

running = True
clock = pygame.time.Clock()

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    bitmap = getImage()
    grayscalebitmap = 255 * bitmap / bitmap.max()
    surf = pygame.surfarray.make_surface(grayscalebitmap)
    surf = pygame.transform.scale(surf, [128 * 4, 56 * 4])
    display.blit(surf, (0, 0))
    pygame.display.update()
    clock.tick()
    print(clock.get_fps())
pygame.quit()

oocd.kill()
