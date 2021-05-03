### Para rodar essa suite execute no terminal o comando abaixo:
### robot -d results/AutomationPractice/Result Tests/AutomationPractice/Section03Lesson15.robot

*** Settings ***
Resource  ../../Resources/Section03Lesson15/Resource.robot

### SETUP -> roda keywords antes de uma suite ou antes de um teste
# Suite Setup
Test Setup  Abrir navegador

### TEARDOWN -> roda keywords depois de uma suite ou de um teste
# Suite Teardown
Test Teardown  Fechar navegador

*** Test Case ***
CT 01: Pesquisar produto existente
    Acessar a página home do site
    Digitar no campo de pesquisa o produto "Blouse"
    Clicar no botão pesquisar
    Conferir se o produto "Blouse" foi listado

CT 02: Pesquisar produto inexistente
    Acessar a página home do site
    Digitar no campo de pesquisa o produto "ItemNãoExistente"
    Clicar no botão pesquisar
    Conferir mensagem de erro "No results were found for your search "ItemNãoExistente""

