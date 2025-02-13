#!/bin/sh

# Diretório de backups
BACKUP_DIR="/tmp/backups"

# Nome do arquivo de backup com data e hostname
BACKUP_FILE="$BACKUP_DIR/backup-$(uname -n)-$(date +%F).tar.gz"

# Apagar todos os arquivos do diretório de backups
rm -rf "$BACKUP_DIR"/*

# Verificar se o diretório de backups existe, se não, criar
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Definir permissões de criação de arquivos
umask go=

# Criar um novo backup
sysupgrade -b "$BACKUP_FILE"

# Verificar se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
  echo "Backup criado com sucesso: $BACKUP_FILE"
else
  echo "Falha ao criar o backup"
  exit 1
fi
