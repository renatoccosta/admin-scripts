#!/bin/bash

# Verificar se foram passados os parâmetros corretos
if [ $# -lt 2 ]; then
    echo "Uso: $0 <pasta_origem> <nome_backup> [<usuario_dono>]"
    exit 1
fi

# Pasta que será feito o backup (passada como parâmetro)
source_folder="$1"

# Verificar se a pasta de origem existe
if [ ! -d "$source_folder" ]; then
    echo "A pasta de origem não existe."
    exit 1
fi

# Nome do arquivo de backup (passado como parâmetro, concatenado com data e hora)
backup_name="$2_$(date +"%Y%m%d_%H%M%S").tar.gz"

# Pasta raiz de destino do backup
backup_root="/home/renato/backups"

# Pasta onde será armazenado o backup
backup_folder="$backup_root/$2"

# Criar a pasta de backup se ela não existir
mkdir -p $backup_folder

# Compactar o conteúdo da pasta de origem e salvar no backup_folder
echo "Iniciando compactação..."
tar -cvzf "$backup_folder/$backup_name" "$source_folder"
echo "Compactação concluída."

# Verificar se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Backup realizado com sucesso: $backup_folder/$backup_name"
else
    echo "Erro ao realizar backup."
    exit 1
fi

# Definir o usuário dono do arquivo de backup
if [ $# -eq 3 ]; then
    chown $3:$3 "$backup_folder/$backup_name"
    echo "O arquivo de backup agora pertence ao usuário: $3"
fi
