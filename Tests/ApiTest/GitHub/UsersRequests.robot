*** Settings ***
Documentation   https://docs.github.com/en/rest/overview/endpoints-available-for-github-apps
Resource        ${EXECDIR}/Resources/ApiTest/GitHub/Resource.robot

*** Variables ***


*** Test Cases ***
Requisitar informações do usuário
    GET: user data

Pesquisar issues da May Fernandes com o state "open" e label "bug"
    GET: issues -> state = "open"; label = "bug"

Reagir em um issue
    POST: reaction "-1" on an issue

Criar um issue
    ${labels}  Create List  robot framework  udemy  learning
    ${title}  Set Variable  Issue criada usando robot framework
    ${description}  Set Variable  Esta issue foi criada utilizando a api do GitHub e o Robot Framework
    POST: create issue  ${title}  ${description}  ${labels}