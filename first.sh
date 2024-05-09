#!/bin/bash
sudo apt upgrade && sudo apt update -y

# https://minhng.info/tips/unikey-ubuntu-2204.html
# Voi Ubuntu 24: Settings => System => Region Language => System::Manage Installed Language => Cai tieng viet
sudo apt install ibus-unikey -y
# Sau khi cai xong vao Setting => Keyboard => Add Input Source => Vietnamese(unikey)

# Cai git
sudo apt install git -y
git config --global user.name "VoHoang"
git config --global user.email "vohoang.w2002@gmail.com"
git config --global init.defaultBranch "main"

# Cai barrier để remote host
# Nhớ vào Change setting tắt Enable SSH đi mới kết nối được
sudo apt install barrier -y

# Cài lọc ánh sáng xạnh
# Chỉnh bằng lệnh redshift -O 2700 (đưa về bình thường redshift -O x)
sudo apt install redshift -y
redshift -O 2700
