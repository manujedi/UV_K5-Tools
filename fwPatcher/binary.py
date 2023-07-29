import sys
import struct
import os
import subprocess
import shutil
import tempfile
import logging

from typing import Dict

from elftools.elf.elffile import ELFFile


class Binary:
    def __init__(self, path, file, name):
        self.path = path
        self.file = file
        self.name = name
        
        self.flash_offset = 0
        self.ram_offset = 0
        
        self.stream = open(self.path + file, 'rb')
        self.elf = ELFFile(self.stream)  # This is not the final elf
        self.text_section = self.elf.get_section_by_name('.text')

    def close(self):
        self.stream.close()
        self.elf = None

    def code(self) -> bytes:
        code = bytes()

        # TODO add other sections (bss, data...)
        if self.text_section:
            code += self.text_section.data()

        return code

    def code_size(self):
        return len(self.code())

    def symbols(self) -> Dict[str, str]:
        symbols_map = {}
        section = self.elf.get_section_by_name(".symtab")
        for symbol in section.iter_symbols():

            if (
                    not symbol.name
                    or symbol["st_info"]["type"] in ("STT_NOTYPE", "STT_FILE")
                    or symbol.name.startswith("__")
                    or symbol["st_other"]["visibility"] == "STV_HIDDEN"
            ):
                continue

            symbols_map[symbol.name] = symbol["st_value"]

        return symbols_map

    def append_symbols(self):
        with open("linker/symbols.ld", 'a') as file:
            for symbol, offset in self.symbols().items():
                print(symbol,offset)
                file.write(str(symbol) + " = " + hex(offset) + ";\n")


    def function_address(self, name):
        symbols = self._elf.get_section_by_name('.symtab')

        func = symbols.get_symbol_by_name(name)[0]
        func_start = func['st_value']

        return func_start

    def link(self, flash_offset, ram_offset = 0):   #TODO ram_offset
        self.flash_offset = flash_offset
        self.ram_offset = ram_offset

        ld = subprocess.run(
            [
                shutil.which('arm-none-eabi-ld'),
                '-L',                       #linker dir
                os.path.abspath('linker'),
                '-T',                       #symbols
                'symbols.ld',
                '--entry', hex(flash_offset),
                '--section-start=.text=' + hex(flash_offset),
                '-o', os.path.join(self.path, 'func.elf'),
                os.path.join(self.path, 'func.o'),
            ]
        )

        new_binary = Binary(self.path, 'func.elf', self.name)
        return new_binary
