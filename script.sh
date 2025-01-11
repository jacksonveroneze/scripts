#!/bin/bash

# --------------------------------------------------------------------
# Script de Setup de Projeto .NET (Arquitetura Limpa)
# --------------------------------------------------------------------
# 1) Cria Solution
# 2) Cria Projetos (App, Application, Domain, Infrastructure)
# 3) Adiciona referências entre os projetos
# 4) Cria estrutura de pastas e arquivos "" (vazios)
#
# Requer:
#   - .NET SDK instalado (dotnet CLI)
#   - Bash Shell (Linux/Ubuntu ou WSL)
# Uso:
#   chmod +x script.sh
#   ./script.sh
# --------------------------------------------------------------------

# -----------------------------
# CONFIGURAÇÕES DO PROJETO
# -----------------------------
SOLUTION_NAME="DocSignService"

WEB_PROJ="DocSignService.Web"
APPLICATION_PROJ="DocSignService.Application"
DOMAIN_PROJ="DocSignService.Domain"
INFRASTRUCTURE_PROJ="DocSignService.Infrastructure"

# Diretórios (raiz) de cada projeto
PROJECT_DIR="DocSignService"
WEB_DIR="Web"
APPLICATION_DIR="Application"
DOMAIN_DIR="Domain"
INFRASTRUCTURE_DIR="Infrastructure"

# -----------------------------
# 1) PREPARE
# -----------------------------
mkdir $PROJECT_DIR && cd $PROJECT_DIR

# -----------------------------
# 2) CREATE BASIC FILES
# -----------------------------

mkdir src tests infra
mkdir -p infra/docker

touch LICENSE.md
touch tests/.gitkeep
touch infra/docker/docker-compose.yml

dotnet new gitignore

cd src
mkdir main test
touch test/.gitkeep

dotnet new globaljson
dotnet new nugetconfig
dotnet new editorconfig

# -----------------------------
# 3) CRIAR SOLUTION
# -----------------------------
echo "==> Criando Solution '$SOLUTION_NAME.sln' ..."
dotnet new sln -n $SOLUTION_NAME

# -----------------------------
# 4) CRIAR PROJETOS
# -----------------------------
cd main

echo "==> Criando projetos .NET ..."

# Web (Minimal API - .NET 7/8)
dotnet new webapi -n $WEB_PROJ -o $WEB_DIR

# Application (Class Library)
dotnet new classlib -n $APPLICATION_PROJ -o $APPLICATION_DIR

# Core (Class Library)
dotnet new classlib -n $DOMAIN_PROJ -o $DOMAIN_DIR

# Adapters (Class Library)
dotnet new classlib -n $INFRASTRUCTURE_PROJ -o $INFRASTRUCTURE_DIR

# -----------------------------
# 5) CONFIGURAR REFERÊNCIAS ENTRE PROJETOS
# -----------------------------
echo "==> Configurando referências entre projetos ..."

dotnet add $APPLICATION_DIR/$APPLICATION_PROJ.csproj reference $DOMAIN_DIR/$DOMAIN_PROJ.csproj
dotnet add $INFRASTRUCTURE_DIR/$INFRASTRUCTURE_PROJ.csproj reference $APPLICATION_DIR/$APPLICATION_PROJ.csproj
dotnet add $INFRASTRUCTURE_DIR/$INFRASTRUCTURE_PROJ.csproj reference $DOMAIN_DIR/$DOMAIN_PROJ.csproj
dotnet add $WEB_DIR/$WEB_PROJ.csproj reference $APPLICATION_DIR/$APPLICATION_PROJ.csproj
dotnet add $WEB_DIR/$WEB_PROJ.csproj reference $INFRASTRUCTURE_DIR/$INFRASTRUCTURE_PROJ.csproj

# Remove Class1.cs files
rm $APPLICATION_DIR/Class1.cs
rm $DOMAIN_DIR/Class1.cs
rm $INFRASTRUCTURE_DIR/Class1.cs

cd $APPLICATION_DIR
mkdir Extensions Mappers Models Queries Utils Validators Interfaces v1
cd v1
mkdir Commands Events Extensions Mappers Models Queries Validators Handlers Interfaces
mkdir Handlers/CommandHandler
mkdir Handlers/EventHandler
mkdir Handlers/QueryHandler
mkdir Interfaces/Repositories
cd ../..

cd $DOMAIN_DIR
mkdir Entities Filters Models Parameters Enums
cd ..

cd $INFRASTRUCTURE_DIR
mkdir Configurations DataProviders Extensions
cd ../..

# -----------------------------
# 3) ADICIONAR PROJETOS NA SOLUTION
# -----------------------------
echo "==> Adicionando projetos à Solution ..."
dotnet sln $SOLUTION_NAME.sln add ./main/$WEB_DIR/$WEB_PROJ.csproj  --solution-folder src/Web
dotnet sln $SOLUTION_NAME.sln add ./main/$APPLICATION_DIR/$APPLICATION_PROJ.csproj  --solution-folder src/Core
dotnet sln $SOLUTION_NAME.sln add ./main/$DOMAIN_DIR/$DOMAIN_PROJ.csproj  --solution-folder src/Core
dotnet sln $SOLUTION_NAME.sln add ./main/$INFRASTRUCTURE_DIR/$INFRASTRUCTURE_PROJ.csproj  --solution-folder src/Infrastructure


touch AssemblyInfo.cs BannedSymbols.txt Directory.Build.props Directory.Packages.props Dockerfile

echo "==> Script concluído! Estrutura criada."
echo "==> Para compilar e rodar, utilize:"
echo "       dotnet build $SOLUTION_NAME.sln"
echo "       dotnet run --project src/Web/$WEB_PROJ.csproj"