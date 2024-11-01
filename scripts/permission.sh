#!/bin/bash

# Saída no caso de qualquer comando falhar
set -e

# Define a variável do ambiente
USER=$(whoami)

# Define o diretório do projeto dinamicamente com base no diretório do script
PROJECT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

# Mensagens informativas
echo "Adjusting ownership and permissions for the project at $PROJECT_DIR..."

# Ajusta as permissões de propriedade
sudo chown -R "$USER":"$USER" "$PROJECT_DIR"

# Ajusta as permissões de gravação
sudo chmod -R u+w "$PROJECT_DIR"

# Ajusta as permissões de execução para scripts
sudo find "$PROJECT_DIR/scripts" -type f -name "*.sh" -exec chmod +x {} \;

echo "Permissions have been fixed for $PROJECT_DIR."
