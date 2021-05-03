*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
### Variáveis da API
${API_URL}  https://fakerestapi.azurewebsites.net/api/v1/

### Métodos de Request
${GET_METHOD}  "GET"

### Variáveis da suite
${ALL}  "todos"

*** Keywords ***
### SETUP & TEARDOWN
Conectar à API
    Create Session  fakeApi  ${API_URL}

### AÇÕES
Realizar Request
    [Arguments]  ${REQUEST_METHOD}  ${ENDPOINT}

    ${RESPONSE}  Set Variable  ${EMPTY}

    IF  ${REQUEST_METHOD} == ${GET_METHOD}
        ${RESPONSE}  Get On Session  fakeApi  ${ENDPOINT}
    END

    [Return]  ${RESPONSE}

Conferir Status Code
    [Arguments]  ${RESPONSE}  ${EXPECTED_STATUS_CODE}
    Should Be Equal As Strings  ${RESPONSE.status_code}  ${EXPECTED_STATUS_CODE}

Conferir Reason
    [Arguments]  ${REPONSE}  ${EXPECTED_REASON}
    Should Be Equal As Strings  ${REPONSE.reason}  ${EXPECTED_REASON}

Conferir Response
    [Arguments]  ${RESPONSE}  ${EXPECTED_STATUS_CODE}=200  ${EXPECTED_REASON}=OK
    Conferir Status Code  ${RESPONSE}  ${EXPECTED_STATUS_CODE}
    Conferir Reason  ${RESPONSE}  ${EXPECTED_REASON}