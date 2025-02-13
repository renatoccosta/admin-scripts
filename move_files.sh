#!/bin/bash

# Verifica se foram fornecidos dois argumentos (origem e destino)
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <diretório_origem> <diretório_destino>"
  exit 1
fi

# Diretórios de origem e destino recebidos como parâmetros
ORIGEM="$1"
DESTINO="$2"

# Verifica se os diretórios de origem e destino existem
if [ ! -d "$ORIGEM" ]; then
  echo "Erro: O diretório de origem $ORIGEM não existe."
  exit 1
fi

if [ ! -d "$DESTINO" ]; then
  echo "Erro: O diretório de destino $DESTINO não existe."
  exit 1
fi

# Executa o rsync para mover os arquivos
echo "Iniciando a transferência de arquivos..."
rsync -aHv --remove-source-files --progress "$ORIGEM" "$DESTINO"

# Verifica se o rsync foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Arquivos transferidos com sucesso."

  # Remove diretórios vazios da origem
  echo "Removendo diretórios vazios..."
  find "$ORIGEM" -type d -empty -delete

  echo "Transferência concluída e diretórios vazios removidos."
else
  echo "Erro durante a transferência de arquivos. Verifique a saída do rsync para detalhes."
  exit 1
fi
