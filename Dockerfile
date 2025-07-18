# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY *.sln ./
COPY contactbook/*.csproj ./contactbook/
RUN dotnet restore ./contactbook/contactbook.csproj

COPY . .
WORKDIR /src/contactbook
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "contactbook.dll"]
