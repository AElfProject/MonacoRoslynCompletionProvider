FROM node:18 AS npm-installer
WORKDIR /App
COPY ./MonacoRoslynCompletionProvider/Sample/wwwroot/package.json ./
COPY ./MonacoRoslynCompletionProvider/Sample/wwwroot/package-lock.json ./
RUN npm install

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

COPY . ./
WORKDIR /App/MonacoRoslynCompletionProvider/Sample
RUN dotnet restore
RUN dotnet publish -c Release -o /App/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
COPY --from=npm-installer /App/node_modules ./wwwroot/node_modules
ENTRYPOINT ["dotnet", "Sample.dll"]
EXPOSE 8080