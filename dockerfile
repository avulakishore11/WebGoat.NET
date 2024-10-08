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
RUN dotnet publish -c Dev -o /app/out

# Expose ports
EXPOSE 8080




# Set the entry point for running the app
ENTRYPOINT ["dotnet", "/app/out/*.dll"]
