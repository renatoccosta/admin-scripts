#!/bin/bash

# Verifica se o número de argumentos é igual a 1
if [ "$#" -ne 1 ]; then
  echo "Uso: $0 <arquivo_de_saida>"
  exit 1
fi

# Recebe o argumento
arquivo_saida=$1

# Extrai o diretório do arquivo de saída
diretorio=$(dirname "$arquivo_saida")

# Verifica se o diretório existe, se não existir, cria o diretório
if [ ! -d "$diretorio" ]; then
  mkdir -p "$diretorio"
fi

# Lê a entrada padrão e adiciona timestamp a cada linha, gravando no arquivo de saída
awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0; fflush(); }' >> "$arquivo_saida"
