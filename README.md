# UV_K5-Tools

some small tools for the Quansheng UV-K5 that some devs may find usefull

## ImageToCppHeader

converts a png (should also work with other formats) to a cpp header.
The screen buffer format is (where [x][y] are the coordinates on the screen):
- Byte 0 [0][0] to [0][7], 
- Byte 1 [1][0] to [1][7]
- ... 
- Byte 127 [127][0] to [127][7], 
- Byte 128 [0][8] to [0][15], 

## Screenmirror

copies the frame buffer using openocd and displays it using pygame. Reaches about 10fps, so more than enough

![screenmirror_demo.mp4](media/screenmirror_demo.gif)