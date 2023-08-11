#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .
RUN dotnet build "Api.ExemploCi/Api.ExemploCi.csproj" -c Release -o /app/build
RUN dotnet publish "Api.ExemploCi/Api.ExemploCi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443 
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Api.ExemploCi.dll"]