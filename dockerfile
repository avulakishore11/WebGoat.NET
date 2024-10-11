# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Copy the .csproj file and restore dependencies
# Set the working directory
WORKDIR /app
COPY WebGoat/WebGoat.NET.csproj .
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . .

# Run test
RUN dotnet test

# Run build and publish the artifact
RUN dotnet publish -c Release -o /app/out  # **This command builds and pushes the image to /app/out directory**.

# Use the .NET official runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
COPY --from=builder /app/out .

# Set the entry point for running the app/container
# ENTRYPOINT ["dotnet", "/app/out/*.dll"]  #** Here we referenced that directory that stores the build artifact. ( my mistake: Your Dockerfile has a minor issue in the ENTRYPOINT line. The use of *.dll won't work because it doesn't resolve to a specific file. Instead, you need to specify the actual name of the DLL that was generated during the publish step.

ENTRYPOINT ["dotnet", "WebGoat.NET.dll"]

# Expose ports
EXPOSE 8080
