#!/bin/bash

# Verificar se foram passados os parâmetros corretos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <pasta> <quantidade_de_arquivos_a_manter>"
    exit 1
fi

# Pasta que contém os arquivos (passada como parâmetro)
target_folder="$1"

# Quantidade de arquivos a serem mantidos (passada como parâmetro)
files_to_keep="$2"

# Verificar se a pasta existe
if [ ! -d "$target_folder" ]; then
    echo "A pasta especificada não existe."
    exit 1
fi

# Verificar se o parâmetro quantidade_de_arquivos_a_manter é um número
if ! [[ "$files_to_keep" =~ ^[0-9]+$ ]]; then
    echo "O parâmetro quantidade_de_arquivos_a_manter deve ser um número."
    exit 1
fi

# Contar o número total de arquivos na pasta
total_files=$(ls -1q "$target_folder" | wc -l)

# Verificar se há mais arquivos do que a quantidade a ser mantida
if [ "$total_files" -le "$files_to_keep" ]; then
    echo "O número total de arquivos ($total_files) é menor ou igual à quantidade de arquivos a serem mantidos ($files_to_keep). Nenhum arquivo será apagado."
    exit 0
fi

# Calcular a quantidade de arquivos a serem apagados
files_to_delete=$((total_files - files_to_keep))

# Apagar os arquivos mais antigos, mantendo apenas os mais recentes
ls -t "$target_folder" | tail -n "$files_to_delete" | while read -r file; do
    rm "$target_folder/$file"
done

echo "Apagados $files_to_delete arquivos antigos, mantendo os $files_to_keep mais recentes."
