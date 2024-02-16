#!/bin/bash

# Garantindo a remoção snap
sudo apt autoremove --purge chromium* -y
sudo apt autoremove --purge firefox* -y
sudo snap remove firefox
sudo apt autoremove --purge snapd -y

#Carregar os componentes necessários
sudo apt-get update
#Atualizando o sistema
sudo apt-get full-upgrade -y

sudo apt-get install exo-utils tigervnc-standalone-server tigervnc-common tigervnc-tools dbus-x11 --no-install-recommends -y
sudo apt-get install sudo wget nano inetutils-tools dialog software-properties-common nautilus gpg curl -y
# Configurar o teclado
sudo apt-get install keyboard-configuration -y
#Definir o fuso horário
sudo apt-get install tzdata -y

# Adicionar as PPAs de repositórios
# Caso não queira adicionar algum desses repositórios, apague a linha e o comentário (o texto que vem após o #) relacionado ao PPA do repositório 
## PPA do Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable -y
## PPA do LibreOffice
sudo add-apt-repository ppa:libreoffice/ppa -y
## PPA do Tema do ZorinOS
sudo add-apt-repository ppa:zorinos/stable -y
## PPA do Firefox
sudo add-apt-repository ppa:mozillateam/ppa -y

# Esse comando dá a prioridade de uso para a PPA ao invés do instalador snad e faz com que seja possível baixar o Firefox mais recente
echo 'Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox

# Dá a possibilidade do Firefox atualizar quando houver uma atualização
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# PPA do VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# PPA do Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list


# Se não existir, será criado
if [ ! -d "/usr/share/backgrounds/" ];then
  mkdir -p "/usr/share/backgrounds/"
fi

if [ ! -d "/usr/share/icons/" ];then
  mkdir -p "/usr/share/icons/"
fi