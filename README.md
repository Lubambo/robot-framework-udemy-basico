# DNE
Projeto de testes automáticos do serviço `DNE`, para verificar o retornos obtidos dos endpoints `GET` do serviço.

Os testes estão divididos em categorias de acordo com o resultado esperado dos endpoints, são elas:
* [Bairro](#bairro)
* [Cidade](#cidade)
* [Estado](#estado)
* [Grande Usuário](#grande-usuário)
* [Localidade](#localidade)
* [Logradouro](#logradouro)

---

## Execução dos testes
Antes de ser iniciar cada teste, é solicitado ao banco de dados as informações necessárias para validar os dados retornados na response de cada requisição. Estas informações são armazenadas em um arquivo `.csv` no formato esperado pela biblioteca [DataDriver](https://github.com/Snooz82/robotframework-datadriver) do Robot Framework. Esse processo é executado através da *keyword* `Atualizar DataDriver`.

Este arquivo `.csv` tem seu nome e local padronizados nas propriedades de projeto `TESTDATA_NAME` e `TESTDATA_PATH`, respectivamente, localizadas no arquivo `./resources/project.properties`.

O número de vezes que cada teste é executado depende da quantidade de registros que o arquivo `.csv` possui, esse valor é predeterminado na propriedade de projeto `TESTDATA_SIZE`.

### Distribuição dos testes
Variáveis padrão para requisições:
| Variável | Valor | Description |
| -------- | ----- | ----------- |
| `${base_url}` | `https://esb-teste.tjpb.jus.br/dne` | URL padrão para requisições |
| `${v1}` | `v1` | Versão `1` da api |
| `${v1_1}` | `v1.1` | Versão `1.1` da api |
| `${v1_2}` | `v1.2` | Versão `1.2` da api |


### Bairro
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-bairro` |
| Docker | `ftsa docker-report -i dne-bairro` |

**1. CT1_GET_Request (`[TAG]: dne-bairro-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de bairros de acordo com a `ID` da localidade informada.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/localidades/${id}/bairros
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID da localidade |


### Cidade
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-cidade` |
| Docker | `ftsa docker-report -i dne-cidade` |

**1. CT1_GET_Request (`[TAG]: dne-cidade-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de cidade de acordo com o `CEP` informado.

**Endpoint testado:**
```http
  ${base_url}/${v1}/cidades/${cep}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${cep}` | `integer` | Valor do CEP |


### Estado
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-estado` |
| Docker | `ftsa docker-report -i dne-estado` |

**1. CT1_GET_Request (`[TAG]: dne-estado-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de todos os estados brasileiros.

**Endpoint testado:**
```http
  ${base_url}/${v1}/estados
```


### Grande Usuário
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-grande_usuario` |
| Docker | `ftsa docker-report -i dne-grande_usuario` |

**1. CT1_GET_Request (`[TAG]: dne-grande_usuario-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de grande usuário de acordo com o `CEP` informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/grandesusuarios/${cep}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${cep}` | `integer` | Valor do CEP |

**2. CT2_GET_Request (`[TAG]: dne-grande_usuario-ct02`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de grande usuário de acordo com a `ID` do bairro informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/grandesusuarios?idBairro=${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID do bairro |

**3. CT3_GET_Request (`[TAG]: dne-grande_usuario-ct03`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de grande usuário de acordo com a `ID` da localidade informada.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/grandesusuarios?idLocalidade=${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID da localidade |

**4. CT4_GET_Request (`[TAG]: dne-grande_usuario-ct04`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de grande usuário de acordo com a `ID` do logradouro informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/grandesusuarios?idLogradouro=${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID do logradouro |


### Localidade
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-localidade` |
| Docker | `ftsa docker-report -i dne-localidade` |

**1. CT1_GET_Request (`[TAG]: dne-localidade-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de localidade de acordo com o `CEP` informado.

**Endpoint testado:**
```http
  ${base_url}/${v1}/localidades?cep=${cep}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${cep}` | `integer` | Valor do CEP |

**2. CT2_GET_Request (`[TAG]: dne-localidade-ct02`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de localidade de acordo com a `ID` da localidade informada.

**Endpoint testado:**
```http
  ${base_url}/${v1}/localidades/${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID da localidade |

**3. CT3_GET_Request (`[TAG]: dne-localidade-ct03`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de localidade de acordo com a `ID` do estado informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/estados/${id}/localidades
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID do estado |


### Logradouro
| Local de execução | Comando |
| --------- | ---- |
| Localmente | `ftsa report -i dne-logradouro` |
| Docker | `ftsa docker-report -i dne-logradouro` |

**1. CT1_GET_Request (`[TAG]: dne-logradouro-ct01`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de logradouro de acordo com a `ID` do logradouro informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_2}/logradouros/${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID do logradouro |

**2. CT2_GET_Request (`[TAG]: dne-logradouro-ct02`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de logradouro de acordo com o `CEP` informado.

**Endpoint testado:**
```http
  ${base_url}/${v1}/logradouros/${cep}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${cep}` | `integer` | Valor do CEP |

**3. CT3_GET_Request (`[TAG]: dne-logradouro-ct03`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de logradouro de acordo com a `ID` do bairro informado.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/logradouros?idBairro=${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID do bairro |

**4. CT4_GET_Request (`[TAG]: dne-logradouro-ct04`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de logradouro de acordo com a `ID` da localidade informada.

**Endpoint testado:**
```http
  ${base_url}/${v1_1}/logradouros?idLocalidade=${id}
```

| Parâmetro | Tipo | Descrição |
| --------- | ---- | --------- |
| `${id}` | `integer` | Valor da ID da localidade |

**5. CT5_GET_Request (`[TAG]: dne-logradouro-ct05`)**
> **Objetivo:** verificar o retorno da requisição para obtenção de tipos de logradouro.

**Endpoint testado:**
```http
  ${base_url}/logradouros/tipos
```
