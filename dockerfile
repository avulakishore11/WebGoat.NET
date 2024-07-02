# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Set the working directory
WORKDIR /app

# Copy the .csproj file and restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . .

# Run test
RUN dotnet test

# Run build and publish
RUN dotnet publish -c Release -o /app/out

