# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Set the working directory
WORKDIR /app

# Copy the solution and restore dependencies
COPY WebGoat.NET.sln . 
COPY WebGoat.NET/WebGoat.NET.csproj WebGoat.NET/
RUN dotnet restore

# Copy the entire project and build it
COPY . .
RUN dotnet publish -c Release -o /app/out

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app

# Copy the published files from the builder stage
COPY --from=builder /app/out .

# Expose port 8080
EXPOSE 8080

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "WebGoat.NET.dll"]
