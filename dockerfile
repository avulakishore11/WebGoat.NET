# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Create azureuser and set it up
RUN useradd -m azureuser

# Set the working directory
WORKDIR /app

# Set azureuser as the owner of the working directory to avoid permission issues
RUN chown -R azureuser /app

# Copy the .csproj file and restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . .

# Run test
RUN dotnet test

# Run build and publish
RUN dotnet publish -c Release -o /app/out

# Expose ports
EXPOSE 8080

# Change to azureuser for running the application
USER azureuser

# Set the entry point for running the app
ENTRYPOINT ["dotnet", "/app/out/*.dll"]
