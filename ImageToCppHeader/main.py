from PIL import Image
import numpy as np

# size 128 in x, 56 in y. If smaller the image starts at the top left corner
image = Image.open("pika_low.png")

array = np.asarray(image)
array = np.fliplr(array)
array = np.rot90(array)

data = []

for row in range(0, 7):
    for colmn in range(0, 128):

        chunk = []
        if len(array) > colmn:
            chunk = array[colmn]

        byte = []
        for bit in range(0, 8):
            if len(chunk) > row * 8 + bit:
                byte.append(False if chunk[row * 8 + bit] else True)
            else:
                byte.append(False)
        data.append(sum(map(lambda x: x[1] << x[0], enumerate(byte))))

count = 0
print("unsigned char image[] = {")
for d in data:
    print(str(hex(d)) + ",");
    count += 1
print("};")
print("unsigned int image_len =", count, ";")
