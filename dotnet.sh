#!/bin/bash

# -----------------------------------------------------------------------
# Install .NET
# -----------------------------------------------------------------------
sudo apt update && \
  sudo apt install -y dotnet-sdk-6.0 dotnet-sdk-8.0

# -----------------------------------------------------------------------
# Monitoring
# -----------------------------------------------------------------------
dotnet tool install --global dotnet-trace
dotnet tool install --global dotnet-counters
dotnet tool install --global dotnet-monitor
dotnet tool install --global dotnet-stack
dotnet tool install --global dotnet-dump


# -----------------------------------------------------------------------
# AWS
# -----------------------------------------------------------------------
dotnet new install Amazon.Lambda.Templates

dotnet tool install -g Amazon.Lambda.Tools
dotnet tool update -g Amazon.Lambda.Tools
