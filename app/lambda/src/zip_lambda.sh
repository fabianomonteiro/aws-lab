#!/bin/bash

# Verificar se .zipignore existe
if [ ! -f .zipignore ]; then
  echo ".zipignore não encontrado!"
  exit 1
fi

# Ler o arquivo .zipignore e criar as exclusões no formato correto
EXCLUDES=$(cat .zipignore | xargs -I {} echo "--exclude={}")

# Criar o ZIP com exclusões
eval zip -r ../lambda.zip . $EXCLUDES
