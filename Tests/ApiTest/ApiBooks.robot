### Para rodar essa suite execute no terminal o comando abaixo:
### robot -d .\Results\ApiTest .\Tests\ApiTest\ApiBooks.robot

*** Settings ***
Documentation  Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource  ../../Resources/ApiTest/BooksGetOps.robot
Resource  ../../Resources/ApiTest/BooksPostOps.robot

Suite Setup  Conectar à API
#Suite Teardown  Desconectar da API

*** Variables ***
&{BOOK_15}  id=15
...         title=Book 15
...         description=Praesent nonumy ea lorem justo ex consetetur rebum et lorem et vero. Velit nisl suscipit sed ut kasd sed. Vulputate odio dolor justo enim quis. Aliquyam eos elitr feugait sadipscing in clita labore invidunt labore tempor at. Invidunt ut minim. Vero sadipscing eirmod stet lorem sed aliquam sed sanctus dolor facilisis. Amet accusam dolore laoreet tempor duo dolore eos eirmod lorem blandit duo ut diam autem kasd eos diam. Justo sit ipsum nonumy ea eirmod sed accusam est at vero et eirmod sea diam ea. Minim augue ut lorem.\n
...         pageCount=1500
...         excerpt=Liber voluptua doming sadipscing nihil et duis tempor elitr aliquyam. Invidunt nihil et sadipscing consetetur magna sea ex. Amet ea nibh accumsan tempor nostrud eirmod voluptua vel takimata sed blandit dolore. Gubergren et duo magna duis dignissim lorem et praesent in accusam doming amet stet at. Kasd consetetur kasd lorem clita elitr duo clita consectetuer. Amet mazim sit et clita velit aliquam consetetur sed. Sadipscing ea erat eros dolor. Eirmod consetetur illum eos duo clita soluta ea ipsum adipiscing eirmod gubergren diam ipsum. Eu sed clita consequat rebum sadipscing justo elitr diam enim. Erat consetetur diam elitr ipsum labore est et dolor sea placerat in consequat placerat labore. Ipsum eos et et rebum tempor.\nClita est diam ullamcorper tempor dolor kasd vero gubergren nostrud soluta dolor dolore dolor. Ea amet clita ea ut erat voluptua at justo rebum magna eos. Possim sanctus dolor eu erat no molestie duis eu ipsum takimata dolores. Dolore dolor eirmod at eos magna ut consetetur sit rebum elitr iriure. Diam diam kasd nonummy elitr amet ullamcorper vero. Et et at lorem tempor augue at duo luptatum et at nihil magna dolore duo nobis dolores. Et kasd no in sed sed adipiscing. Suscipit praesent elitr est zzril nonumy dolor vero et. Aliquip justo ea amet dolor elitr dolor accusam sanctus liber clita magna delenit invidunt. Eos consetetur et labore sit ipsum eirmod gubergren stet justo ipsum et sed sadipscing dolor dolor consectetuer.\nEnim in vero delenit no et vel voluptua erat sadipscing sit sanctus hendrerit qui sea est dolor est nulla. Duis dolore kasd gubergren invidunt elitr kasd sanctus gubergren aliquyam. Dolor erat tation sea odio rebum ipsum imperdiet dolore vero veniam. Nonumy autem dolore elitr dolor est consequat ipsum augue tempor. Eos zzril labore aliquyam kasd erat volutpat sanctus ipsum vel tincidunt dolores amet dolor.\nIpsum magna stet facilisis veniam consequat et nostrud sed. Aliquyam et hendrerit te sit ut amet sea nulla et erat est et dolore tempor et tempor vero. Id dolor duis ea nonumy sed delenit esse veniam ut no sit amet ipsum magna in gubergren lorem. Magna et rebum duis ullamcorper.\nNo labore aliquyam luptatum et diam consetetur eirmod erat tempor labore sit. Dolore duo dolor eu nam consetetur vero. Sanctus dolor quis justo feugiat sadipscing eos sanctus nonumy et invidunt voluptua at gubergren gubergren. Labore at eos euismod luptatum liber. Sadipscing accusam facilisi. Lorem consequat facilisis consequat minim duo nulla justo. Rebum ut et consequat no at sea no invidunt sadipscing kasd et sadipscing accumsan et congue.\n
...         publishDate=2021-04-19T19:21:43.5474299+00:00

&{NEW_BOOK}  id=${100}
...          title=Test Title
...          description=Test Description
...          pageCount=${300}
...          excerpt=Test excerpt
...          publishDate=2021-05-05T12:27:27.103Z

*** Test Cases ***
Listagem de todos os livros (GET em todos os livros)
    Requisitar livro  ID=${ALL}  BOOKS_LIST_SIZE=200

Buscar livro específico (GET em um livro especificado)
    Requisitar livro  ID=15  EXPECTED_BOOK_CONTENT=&{BOOK_15}

Adicionar novo livro
    Adicionar livro  &{NEW_BOOK}
