#!/bin/bash

set -e  # Interrompe o script se algum comando falhar

UUID="e233fc41-993a-4f45-ad01-63db9c1c2738"  # Substitua pelo UUID real do seu dispositivo
DEVICE="/dev/disk/by-uuid/$UUID"
MOUNTPOINT="/mnt/secure"
LUKS_NAME="secure_drive"

if [[ -z "$1" ]]; then
  echo "Uso: $0 <open|close>"
  exit 1
fi

ACTION=$1

case $ACTION in
  open)
    if sudo cryptsetup status "$LUKS_NAME" &>/dev/null; then
      echo "O volume LUKS '$LUKS_NAME' já está aberto."
    else
      echo "Abrindo o volume LUKS..."
      sudo cryptsetup luksOpen "$DEVICE" "$LUKS_NAME" || { echo "Falha ao abrir o volume LUKS."; exit 1; }
    fi

    if [[ ! -d "$MOUNTPOINT" ]]; then
      echo "Criando o ponto de montagem: $MOUNTPOINT"
      sudo mkdir -p "$MOUNTPOINT"
    fi

    echo "Montando o volume em $MOUNTPOINT..."
    sudo mount /dev/mapper/"$LUKS_NAME" "$MOUNTPOINT" || { echo "Falha ao montar o volume."; exit 1; }
    echo "Volume montado com sucesso em $MOUNTPOINT."
    ;;

  close)
    if mount | grep -q "$MOUNTPOINT"; then
      echo "Desmontando o volume..."
      sudo umount "$MOUNTPOINT" || { echo "Falha ao desmontar."; exit 1; }
    else
      echo "O volume não está montado em $MOUNTPOINT."
    fi

    if sudo cryptsetup status "$LUKS_NAME" &>/dev/null; then
      echo "Fechando o volume LUKS..."
      sudo cryptsetup luksClose "$LUKS_NAME" || { echo "Falha ao fechar o volume LUKS."; exit 1; }
      echo "Volume LUKS fechado com sucesso."
    else
      echo "O volume LUKS '$LUKS_NAME' já está fechado."
    fi
    ;;

  *)
    echo "Ação inválida. Uso: $0 <open|close>"
    exit 1
    ;;
esac
