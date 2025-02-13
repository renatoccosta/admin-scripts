#!/bin/bash

# Verificar se foram passados os parâmetros corretos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <pasta_origem> <pasta_destino>"
    exit 1
fi

# Pasta de origem (passada como parâmetro)
source_folder="$1"

# Verificar se a pasta de origem existe
if [ ! -d "$source_folder" ]; then
    echo "A pasta de origem não existe."
    exit 1
fi

# Pasta de destino (passada como parâmetro)
destination_folder="$2"

# Criar a pasta de destino se ela não existir
if [ ! -d "$destination_folder" ]; then
    mkdir -p "$destination_folder"
    if [ $? -eq 0 ]; then
        echo "Pasta de destino $destination_folder criada com sucesso."
    else
        echo "Erro ao criar a pasta de destino $destination_folder."
        exit 1
    fi
fi

# Encontrar o arquivo mais recente na pasta de origem
latest_file=$(ls -t "$source_folder" | head -n 1)

# Verificar se algum arquivo foi encontrado
if [ -z "$latest_file" ]; then
    echo "Nenhum arquivo encontrado na pasta de origem."
    exit 1
fi

# Copiar o arquivo mais recente para a pasta de destino
cp "$source_folder/$latest_file" "$destination_folder"

# Verificar se a cópia foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Arquivo $latest_file copiado com sucesso para $destination_folder"
else
    echo "Erro ao copiar o arquivo."
    exit 1
fi
