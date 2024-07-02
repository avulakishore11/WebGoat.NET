# use the official .NET core SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder
WORKDIR /app

# copy the .csproj & .sln files and restore
COPY . .
RUN dotnet restore

# Run test
RUN dotnet test

# run build and publish the artifact

RUN dotnet publish -c Dev -o out

# Use the official .NET runtime image to run the application

FROM mcr.microsoft.com/dotnet/sdk:6.0
COPY --from=builder /app/out .

# define the entrypoint for the container 

ENTRYPOINT ["dotnet", "WebGoat.NET.dll"]
