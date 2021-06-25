### Para rodar essa suite execute no terminal o comando abaixo:
### robot -d results/Loops/UsingFor Tests/Loops/UsingFor.robot

*** Settings ***
Documentation   Usando o loop for
...             Nesta aula será visto como utilizar o loop "For"
...             dentro do robot framework.

*** Variables ***
@{LISTA_DE_FRUTAS}  maçã  abacaxi  banana  morango  laranja  uva

*** Test Cases ***
Teste de REPEAT KEYWORD
    [Documentation]  Chama uma mesma keyword várias vezes
    Usando Repeat Keyword

Teste de FOR do tipo IN RANGE
    [Documentation]  Faz um loop dentro de um intervalo informado
    Usando FOR IN RANGE

Teste de FOR do tipo IN
    [Documentation]  Faz um loop percorrendo a lista informada
    Usando FOR IN

Teste de FOR do tipo IN ENUMERATE
    [Documentation]  Faz um loop percorrendo a lista informada e seus índices
    Usando FOR IN ENUMERATE

Teste de sair do FOR
    [Documentation]  Possibilita controlar quando o FOR deve encerrar
    Usando FOR IN ENUMERATE com EXIT FOR LOOP IF

*** Keywords ***
Usando Repeat Keyword
    Log To Console  ${\n}   # Pulando uma linha para facilitar a visualização no console
    Repeat Keyword  4x  Log To Console  Minha repetição da keyword!!!

Usando FOR IN RANGE
    Log To Console  ${\n}
    FOR  ${COUNTER}  IN RANGE  0  5
        Log To Console  Minha posição atual é: ${COUNTER}
        Log  Minha posição atual é: ${COUNTER}
    END

Usando FOR IN
    Log To Console  ${\n}
    FOR  ${FRUTA}  IN  @{LISTA_DE_FRUTAS}
        Log To Console  Minha fruta é: ${FRUTA}!
    END

Usando FOR IN ENUMERATE
    Log To Console  ${\n}
    FOR  ${INDEX}  ${FRUTA}  IN ENUMERATE  @{LISTA_DE_FRUTAS}
        Log To Console  Minha fruta [${INDEX}] é: ${FRUTA}!
    END

Usando FOR IN ENUMERATE com EXIT FOR LOOP IF
    Log To Console  ${\n}
    FOR  ${INDEX}  ${FRUTA}  IN ENUMERATE  @{LISTA_DE_FRUTAS}
        Log To Console  Minha fruta [${INDEX}] é: ${FRUTA}!
        Exit For Loop If  '${FRUTA}' == 'banana'
    END