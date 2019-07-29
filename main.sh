#!/usr/bin/env bash


sudo apt-get update &&\
sudo apt-get install -y software-properties-common &&\
sudo add-apt-repository ppa:deadsnakes/ppa &&\
sudo apt-get install -y python3.7 &&\
sudo apt-get install -y python3-pip python3-testresources &&\
sudo -H python3 -m pip install --upgrade setuptools pip &&\
git clone https://github.com/akhavr/electrum-dash.git &&\
cp ./base/make_apk ./electrum-dash/contrib/make_apk &&\
cp ./base/buildozer.spec ./electrum-dash/electrum_dash/gui/kivy/tools/buildozer.spec &&\
sudo docker build -t electrum-android-builder-img ./base/ &&\
./electrum-dash/contrib/make_locale &&\
./electrum-dash/contrib/make_packages &&\
cd electrum-dash &&\
sudo docker run -it --rm \
    --name electrum-android-builder-cont \
    -v $PWD:/home/user/wspace/electrum \
    -v ~/.keystore:/home/user/.keystore \
    --workdir /home/user/wspace/electrum \
    electrum-android-builder-img \
    ./contrib/make_apk