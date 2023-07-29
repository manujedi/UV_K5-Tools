import struct
import sys
import subprocess
import os
import time
import shutil
import logging

from binary import Binary
from patch import Patch

def patchOrigFW(patch):
    data = patch.getCode()
    offset = patch.getOffset()
    f = open("fw.bin", "r+b")
    f.seek(offset)
    f.write(data)
    f.close()

def addBootloader():
    f1 = open("bootloader.bin", 'rb')
    f2 = open("fw.bin", 'rb')
    fo = open("fw_with_bl.bin", 'wb')

    fo.write(f1.read())
    fo.write(f2.read())
    fo.close()
    f1.close()
    f2.close()

if __name__ == "__main__":
    #copy default symbols
    shutil.copyfile("linker/orig_fw.ld", "linker/symbols.ld")
    #new FW
    shutil.copyfile("orig_fw.bin", "fw.bin")

    #this does not work
    #af80 = Patch("af80_func_SETUP_WRAPPER", "../CustomFW/src/af80_func_SETUP_WRAPPER/")
    #print(af80.binary.symbols())
    #af80.link(0xaf80)
    #af80.append_symbols()

    b8d0 = Patch("b8d0_func_CONFIG_PORTCON", "../CustomFW/src/b8d0_func_CONFIG_PORTCON/")
    print(b8d0.binary.symbols())
    b8d0.link(0xb8d0)
    b8d0.append_symbols()

    #but it does here TODO: add queue to try relink if dependencies where compiled (or implement cyclic dependencies correctly...)
    af80 = Patch("af80_func_SETUP_WRAPPER", "../CustomFW/src/af80_func_SETUP_WRAPPER/")
    print(af80.binary.symbols())
    af80.link(0xaf80)
    af80.append_symbols()


    patchOrigFW(b8d0)
    patchOrigFW(af80)
    addBootloader()
