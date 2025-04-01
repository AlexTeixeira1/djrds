# Desafio Técnico - Cientista de Dados Júnior

## Descrição

Bem-vindo, este repositório contém respostas ao desafio técnico para a vaga de Cientista de Dados Júnior no campo de soluções de tecnologia e de Governo Digital para área pública no Rio de Janeiro!

### Objetivo

O objetivo deste é prover técnicas em manipulação de dados, análises exploratórias, integração com APIs, consulta SQL no Big Query, análise e visualização de dados.

### Conjunto de Dados

Os conjuntos de dados que serão utilizados neste desafio são:

- **Chamados do 1746:** Dados relacionados a chamados de serviços públicos na cidade do Rio de Janeiro. O caminho da tabela é : `datario.adm_central_atendimento_1746.chamado`
- **Bairros do Rio de Janeiro:** Dados sobre os bairros da cidade do Rio de Janeiro - RJ. O caminho da tabela é: `datario.dados_mestres.bairro`
- **Ocupação Hoteleira em Grandes Eventos no Rio**: Dados contendo o período de duração de alguns grandes eventos que ocorreram no Rio de Janeiro em 2022 e 2023 e a taxa de ocupação hoteleira da cidade nesses períodos. O caminho da tabela é: `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`

### Ferramentas e Recursos

Aacesso ao Google Cloud Platform (GCP) para utilizar o BigQuery e consultar os dados públicos disponíveis no projeto `datario`. Além disso, vamos utilizar a biblioteca `basedosdados` em Python para acessar os dados do BigQuery.

- Tutorial para acessar dados no BigQuery, desde a criação da conta no GCP até consultar os dados utilizando SQL e Python: [Como acessar dados no BigQuery](https://docs.dados.rio/tutoriais/como-acessar-dados/)

Todas as APIs utilizadas no desafio são públicas e possuem documentações com exemplos.

### Perguntas do Desafio

As perguntas do desafio estão detalhadas nos arquivos `perguntas_sql.md` e `perguntas_api.md`.

## Etapas

1. Utilizar o BigQuery para consultar os dados.
2. Utilizar SQL para resolver todas as questões contidas no arquivo `perguntas_sql.md` no BigQuery. Respostas no arquivo `analise_sql.sql`.
3. Utilizar Python e pandas para resolver todas as questões contidas no arquivo `perguntas_sql.md`. Respostas no arquivo `analise_python.ipynb`.
4. Utilizar Python para resolver todas as questões contidas no arquivo `perguntas_api.md`. Respostas no arquivo `analise_api.ipynb`.
5. Criar visualizações informativas dos dados das tabelas e APIs.
6. Fazer commits incrementais e, finalmente, push para o repositório no GitHub. O repositório deve conter um README com todos os passos necessários para rodar seu código e ver a visualização de dados.

## Avaliação

Será avaliado em cada uma das categorias abaixo, com seus respectivos pesos:

- **SQL**: peso 1
- **Python**: peso 2
- **Visualização de Dados**: peso 1

Uma média ponderada será calculada e os melhores candidatos serão chamados para a etapa de entrevistas. 
