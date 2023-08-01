# init submodules
git submodule init
git submodule update
# for python to find the files, not actually needed
pip install pyserial
#install dev environment
cd /opt/
wget "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2"
tar -jxf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
printf '\nexport PATH="/opt/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"\n' >> ~/.bashrc
sync
gh codespace stop

