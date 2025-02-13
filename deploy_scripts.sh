#!/bin/bash

# Pasta de origem dos arquivos .sh
origem=$(pwd)

# Pasta de destino
destino="$HOME/.local/bin"

# Copiar todos os arquivos .sh para a pasta de destino e conceder permissão de execução
cp -f *.sh "$destino"
chmod +x "$destino"/*.sh

echo "Arquivos .sh foram copiados para $destino e permissão de execução concedida."
