*** Settings ***
Documentation  Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource  ../../Resources/ApiTest/Resource.robot

Suite Setup  Conectar à API
#Suite Teardown  Desconectar da API

*** Variables ***

*** Test Cases ***
Listagem de todos os livros (GET em todos os livros)
    Requisitar livro: ${ALL}

Buscar livro específico (GET em um livro especificado)
    Requisitar livro: 15
