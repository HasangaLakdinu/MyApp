# Use the official .NET SDK image for build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy and restore project dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application and build it
COPY . ./
RUN dotnet publish -c Release -o /out

# Use the .NET runtime image for runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy built application from the build stage
COPY --from=build /out .

ENV ASPNETCORE_HTTP_PORTS=5001

# Expose port 5001 for the API
EXPOSE 5001

# Set the entry point for the container
ENTRYPOINT ["dotnet", "MyApp.dll"]
