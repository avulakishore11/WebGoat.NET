# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder

# Copy the .csproj file and restore dependencies
# Set the working directory

WORKDIR /app
COPY WebGoat.NET.sln ./

RUN dotnet restore


# Run test
RUN dotnet test

# Check Build Output: Ensure that the dotnet publish command generates the output in the /app/out directory.
# To verify the output, You can add a RUN ls /app/out command after the dotnet publish command in the builder stage.
# to verify the output.


RUN dotnet publish -c Release -o /app   # **This command builds and pushes the image to /app/out directory**.

Stage: 2


# Debugging: Check the contents of /app
 # RUN ls /app  # Add this line to verify the contents
 
# Use the .NET official runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS runtime

WORKDIR /app/src

COPY --from=builder /app ./

# Set the entry point for running the app/container
# ENTRYPOINT ["dotnet", "/app/out/*.dll"]  #** Here we referenced that directory that stores the build artifact. ( my mistake: Your Dockerfile has a minor issue in the ENTRYPOINT line. The use of *.dll won't work because it doesn't resolve to a specific file. Instead, you need to specify the actual name of the DLL that was generated during the publish step.

EXPOSE 8080


ENTRYPOINT ["dotnet", "WebGoat.NET.dll"]
