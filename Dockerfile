FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY ./MonacoRoslynCompletionProvider/Sample/out .
ENTRYPOINT ["dotnet", "Sample.dll"]
EXPOSE 8080