*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${URL}          http://automationpractice.com/index.php
${BROWSER}      chrome

### Home - Page Objects
${SEARCH_BAR}  id:search_query_top
${SEARCH_BTN}  name:submit_search

### Search Page - Page Objects
${SEARCH_MSG}           css:#center_column > h1
${ERROR_ALERT}          xpath://*[@id="center_column"]/p
${PRODUCT_IMAGE_SRC}    http://automationpractice.com/img/p/7/7-home_default.jpg
${PRODUCT_IMAGE}        xpath://*[@id="center_column"]//*[@src="${PRODUCT_IMAGE_SRC}"]

*** Keywords ***
Abrir navegador
    Open Browser  url=about:blank  browser=${BROWSER}

Fechar navegador
    Close Browser