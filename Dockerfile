# For Heroku
FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build-env
WORKDIR /app

# Copy csproj 
COPY ["WeatherApi.csproj", "./"]
# restore dependicies
RUN dotnet restore "WeatherApi.csproj"

# Copy everything else and build
COPY . .
RUN dotnet publish "WeatherApi.csproj" -c Release -o /app/publish

# Build Run time image
FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
COPY --from=build-env /app/publish .
ENTRYPOINT ["dotnet", "WeatherApi.dll"]
