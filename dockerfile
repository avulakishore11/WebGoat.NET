# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Copy the .csproj file and restore dependencies
# Set the working directory
WORKDIR /app
COPY WebGoat.NET.sln .

RUN dotnet restore

# Copy the remaining source code and build the application
COPY . .

# Run test
RUN dotnet test

# Run build and publish
RUN dotnet publish -c Release -o /app/out  # **This command builds and pushes the image to /app/out directory**.

# Expose ports
EXPOSE 8080




# Set the entry point for running the app
ENTRYPOINT ["dotnet", "/app/out/*.dll"]  #** Here we referenced that directory that stores the build artifact.
