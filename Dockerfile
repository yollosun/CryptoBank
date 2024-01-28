FROM zenika/terraform-azure-cli:latest

WORKDIR /src

COPY /infra /src

ENTRYPOINT ["sh"]