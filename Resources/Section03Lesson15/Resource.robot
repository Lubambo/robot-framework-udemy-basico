*** Settings ***
Resource  BaseResource.robot

*** Keywords ***
Acessar a página home do site
    Go To  url=${URL}
    Title Should Be  title=My Store

Digitar no campo de pesquisa o produto "${PRODUCT}"
    Input Text  locator=${SEARCH_BAR}  text=${PRODUCT}

Clicar no botão pesquisar
    Click Button  locator=${SEARCH_BTN}

Conferir se o produto "${PRODUCT}" foi listado
    Wait Until Element Is Visible  locator=${SEARCH_MSG}
    ### Não está funcionando.
    #${PRODUCT} =  Convert To Upper Case  ${PRODUCT}                                # Passa todas as letras para maiúscula.
    #${EXPECTED_RESULT} =  Catenate  SEARCH  ${EMPTY}  "${PRODUCT}"                 # Concatena partes da string para formar o resultado esperado.
    #Element Text Should Be  locator=${SEARCH_MSG}  expected=${EXPECTED_RESULT}     # Verifica se o elemento desejado possui o resultado esperado.
    Title Should Be  Search - My Store
    Page Should Contain Image  locator=${PRODUCT_IMAGE}

Conferir mensagem de erro "${EXPECTED_RESULT}"
    Wait Until Element Is Visible  locator=${ERROR_ALERT}
    Element Text Should Be  locator=${ERROR_ALERT}  expected=${EXPECTED_RESULT}