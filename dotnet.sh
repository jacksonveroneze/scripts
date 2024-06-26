#!/bin/bash

# -----------------------------------------------------------------------
# Install .NET
# -----------------------------------------------------------------------
#wget "https://packages.microsoft.com/config/ubuntu/$(lsb_release -sr)/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
#sudo dpkg -i packages-microsoft-prod.deb
#rm packages-microsoft-prod.deb

sudo apt update && \
  sudo apt install -y dotnet-sdk-6.0 dotnet-sdk-8.0

# -----------------------------------------------------------------------
# Monitoring
# -----------------------------------------------------------------------
dotnet tool install --global dotnet-trace
dotnet tool install --global dotnet-counters
dotnet tool install --global dotnet-monitor

# -----------------------------------------------------------------------
# AWS
# -----------------------------------------------------------------------
dotnet new install Amazon.Lambda.Templates

dotnet tool install -g Amazon.Lambda.Tools
dotnet tool update -g Amazon.Lambda.Tools

