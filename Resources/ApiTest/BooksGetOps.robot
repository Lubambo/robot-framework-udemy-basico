*** Settings ***
Resource  BaseResource.robot

*** Variables ***
### GET
${ENDPOINT_GET_BOOKS}  Books

*** Keywords ***
Requisitar livro 
    [Arguments]  ${ID}=1  ${BOOKS_LIST_SIZE}=0  ${EXPECTED_BOOK_CONTENT}=${NONE}

    IF  ${ID} == ${ALL}
        ${ENDPOINT}  Set Variable  ${ENDPOINT_GET_BOOKS}
    ELSE
        ${ENDPOINT}  Set Variable  ${ENDPOINT_GET_BOOKS}/${ID}
    END

    ${RESPONSE}  Realizar Request  ${GET_METHOD}  ${ENDPOINT}
    Conferir Response  ${RESPONSE}
    Log  ${EXPECTED_BOOK_CONTENT}
    Log  ${RESPONSE.text}

    IF  ${ID} == ${ALL}
        Length Should Be  ${RESPONSE.json()}  ${BOOKS_LIST_SIZE}
    ELSE
        Conferir Body   ${RESPONSE}  id  ${ID}

        IF  ${EXPECTED_BOOK_CONTENT} != ${NONE}
            Conferir Body   ${RESPONSE}  title  ${EXPECTED_BOOK_CONTENT.title}
            ### As conferências abaixo foram comentadas pois a API retorna valores aleatórios,
            ### portanto é impossível prever seus valores.
            ### Contudo, a título de estudo, mantiveram-se no código
            # Conferir Body   ${RESPONSE}  description  ${EXPECTED_BOOK_CONTENT.description}
            # Conferir Body   ${RESPONSE}  pageCount  ${EXPECTED_BOOK_CONTENT.pageCount}
            # Conferir Body   ${RESPONSE}  excerpt  ${EXPECTED_BOOK_CONTENT.excerpt}
            # Conferir Body   ${RESPONSE}  publishDate  ${EXPECTED_BOOK_CONTENT.publishDate}
            
            ### Comparando os valores de uma vez
            # Dictionaries Should Be Equal  ${RESPONSE}  ${EXPECTED_BOOK_CONTENT}
        END
    END
    