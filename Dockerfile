# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project and restore as distinct layers
COPY *.sln .
COPY contactbook/*.csproj ./contactbook/
RUN dotnet restore ./contactbook/contactbook.csproj

# Copy the rest of the source code
COPY . .

# Build and publish
WORKDIR /src/contactbook
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "contactbook.dll"]
