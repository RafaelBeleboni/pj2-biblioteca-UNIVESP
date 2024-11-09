# Usar a imagem base oficial do .NET para build e runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
EXPOSE 10000

# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "BookManagementBackend.csproj"
RUN dotnet publish "BookManagementBackend.csproj" -c Release -o /app/publish

# Configurar o container final com o runtime
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BookManagementBackend.dll"]
