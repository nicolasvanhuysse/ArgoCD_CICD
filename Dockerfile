#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
#USER app
#WORKDIR /app
#EXPOSE 8080
#EXPOSE 8081
#EXPOSE 80

#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#ARG BUILD_CONFIGURATION=Release
#WORKDIR /src
#COPY ["ArgoCDTest.csproj", "."]
#RUN dotnet restore "./ArgoCDTest.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "./ArgoCDTest.csproj" -c $BUILD_CONFIGURATION -o /app/build
#
#FROM build AS publish
#ARG BUILD_CONFIGURATION=Release
#RUN dotnet publish "./ArgoCDTest.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "ArgoCDTest.dll"]



FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build 
WORKDIR /app 
COPY . . 
RUN dotnet restore 
RUN dotnet publish -c Release -o bin 

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/bin . 
CMD ["dotnet", "ArgoCDTest.dll"] 
