# Use the official .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /app

# Copy everything and publish
COPY . . 
RUN dotnet publish -c Release -o out

# Use the official ASP.NET runtime image for deployment
FROM mcr.microsoft.com/dotnet/aspnet:9.0

WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "contactbook.dll"]
