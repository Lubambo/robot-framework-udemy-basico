### Para rodar essa suite execute no terminal o comando abaixo:
### robot -d results/AutomationPractice/ResultBDD Tests/AutomationPractice/Section03Lesson15BDD.robot

*** Settings ***
Resource  ../../Resources/Section03Lesson15/ResourceBDD.robot

### SETUP -> roda keywords antes de uma suite ou antes de um teste
# Suite Setup
Test Setup  Abrir navegador

### TEARDOWN -> roda keywords depois de uma suite ou de um teste
# Suite Teardown
Test Teardown  Fechar navegador

*** Test Case ***
CT 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

CT 02: Pesquisar produto inexistente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "ItemNãoExistente"
    Então a página deve exibir a mensagem de erro "No results were found for your search "ItemNãoExistente""


