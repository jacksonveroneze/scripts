#!/bin/bash

echo -n "Enter fullname: "
read fullname

mkdir src tests infra
touch LICENSE.md
touch tests/.gitkeep
touch infra/.gitkeep
dotnet new gitignore

cd src
mkdir main test
touch test/.gitkeep
dotnet new editorconfig
dotnet new globaljson

dotnet new sln -n $fullname
dotnet new webapi -o ./main/$fullname.App
dotnet new classlib -o ./main/$fullname.Application
dotnet new classlib -o ./main/$fullname.Domain
dotnet new classlib -o ./main/$fullname.Infrastructure

dotnet sln add main/$fullname.App/$fullname.App.csproj
dotnet sln add main/$fullname.Application/$fullname.Application.csproj
dotnet sln add main/$fullname.Domain/$fullname.Domain.csproj
dotnet sln add main/$fullname.Infrastructure/$fullname.Infrastructure.csproj

rm -rf main/$fullname.Application/Class1.cs
rm -rf main/$fullname.Domain/Class1.cs
rm -rf main/$fullname.Infrastructure/Class1.cs

cd main/$fullname.Application
mkdir Commands Events Extensions Mappers Models Queries Utils Validators Handlers Interfaces
mkdir Handlers/CommandHandler
mkdir Handlers/EventHandler
mkdir Handlers/QueryHandler
mkdir Interfaces/Repositories
cd ../..


cd main/$fullname.Domain
mkdir Entities Filters Models Parameters Queries Results
cd ../..

cd main/$fullname.Infrastructure
mkdir Configurations DataProviders Extensions
cd ../..
