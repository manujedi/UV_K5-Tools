import os
import shutil
import subprocess

from binary import Binary


class Patch:
    def __init__(self, name, path, offset=None):
        self.name = name
        self.offset = offset  # add dynamic functions later...
        self.path = path
        self.compile()
        self.binary = Binary(self.path, 'func.o', name)

    def memory_usage(self):
        return self.binary.size()

    def __str__(self):
        return f'#{self.id:x} ({self.path})'

    def compile(self) -> bool:
        cc = subprocess.run(
            [
                shutil.which('arm-none-eabi-gcc'),
                '--specs=nosys.specs',
                '-Wall',
                '-g0',
                '-g',
                '-mlittle-endian',
                '-mthumb',
                '-mgeneral-regs-only',  # only of c code is compiled
                '-march=armv6-m',
                '-mtune=cortex-m0',
                '-o', os.path.join(self.path, 'func.o'),
                '-c', os.path.join(self.path + self.name + '.s'),  # TODO: add support for c files
            ]
        )

        return True

    def link(self, flash_offset, ram_offset=0):
        self.offset = flash_offset
        self.binary = self.binary.link(flash_offset, ram_offset)

    def append_symbols(self):
        self.binary.append_symbols()

    def getCode(self):
        return self.binary.code()

    def getOffset(self):
        return self.offset

