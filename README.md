<a name="topo-readme"></a>
# Kobana project

[![Ruby on Rails CI](https://github.com/PhilipeeX/kobana_project/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/PhilipeeX/kobana_project/actions/workflows/rubyonrails.yml) ![GitHub Tag](https://img.shields.io/github/v/tag/PhilipeeX/kobana_project?style=flat) ![Static Badge](https://img.shields.io/badge/rubocop-codestyle?style=flat&logo=rubocop&logoColor=white&label=code%20style&link=https%3A%2F%2Fgithub.com%2Frubocop%2Frubocop) ![Static Badge](https://img.shields.io/badge/passing-tests?style=flat&logo=github&logoColor=white&label=tests&link=https%3A%2F%2Fgithub.com%2FPhilipeeX%2Fkobana_project%2Factions)  ![GitHub repo size](https://img.shields.io/github/repo-size/PhilipeeX/kobana_project?style=flat&label=Tamanho&color=green) ![GitHub issues](https://img.shields.io/github/issues/PhilipeeX/kobana_project?style=flat) ![GitHub closed issues](https://img.shields.io/github/issues-closed/Philipeex/kobana_project?style=flat) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/PhilipeeX/kobana_project?style=flat&label=Pull%20requests%20mergeados&color=purple)


## Screenshots ou  GIFs
![Image](https://github.com/PhilipeeX/jedis-project/assets/85847179/0f6b6b45-b4c7-4634-aab6-41f6dfddb29e)
> O projeto consiste em uma aplicação Ruby on Rails que realiza a integração direta com rotas de API da Kobana em um ambiente de Sandbox, para a gestão de boletos, abrangendo funcionalidades como criação, listagem atualização e cancelamento.
## Stack utilizada

**Front-end:** TailwindCSS

**Back-end:** Ruby 3.2.2, Rails 7.1.3.2

**Database:** Não utilizado

## Rodando localmente

1) Clone o projeto

```bash
  git clone https://github.com/PhilipeeX/kobana_project
```

2) Entre no diretório do projeto

```bash
  cd kobana_project
```
3) Instale as dependencias

```bash
  bundle install
  npm install flowbite
```
4) Configure sua credencial em um arquivo .env na raiz do projeto:

```bash
  KOBANA_ACCESS_TOKEN=
```
5) Execute a aplicação através do foreman

```bash
  ./bin/dev
```

Acesse a aplicação em localhost porta 3000


## Rodando os testes

![image](https://github.com/PhilipeeX/kobana_project/assets/85847179/50faf2c5-1d33-4b04-84d6-e5e92aaf2c6f)
<br>
#### Pipeline de ci/cd no link abaixo <br>
<a href="https://github.com/PhilipeeX/kobana_project/actions/workflows/rubyonrails.yml" target="_blank">GithubActions</a>

## Setups e deploys

[Rubyonrails.yml](https://github.com/PhilipeeX/kobana_project/blob/release/v0.1.0/.github/workflows/rubyonrails.yml)

- Verifica a qualidade do código usando linters como rubocop.

# Atribuições

> [!TIP]
> - [x] Não é necessário ter sistema de login/autenticação.
> - [x] O form de criação poderá ter somente os campos obrigatórios da API
> - [x] A integração entre o projeto e a API pode ser feita tanto usando a gem oficial publicada, quanto códigos novos feitos por você.<br>
    > <a href="https://github.com/PhilipeeX/kobana_project/pull/12">Pull Request</a>
#
> [!TIP]
> - [x] Deverá ter algum CSS/JavaScript deixando as telas bonitinhas.<br>
    > <a href="https://github.com/PhilipeeX/kobana_project/pull/16" target="_blank">Pull Request</a>
#
> [!TIP]
> #### Essas seriam as próximas tarefas:
> - [ ] Responder ao webhook da rota de atualização de boleto com status referente.
> - [ ] Implementar as requisições da API via gem boleto_simples.
> - [ ] Configurar cache para não atingir limite das requisições.
> - [ ] Implementar funcionalidade que permite exibir o boleto para o usuário.
> - [ ] Implementar os teste no pipeline de CI/CD.
> - [ ] Executar a aplicação em um contêiner Docker com docker-compose.
> - <a href="https://github.com/users/PhilipeeX/projects/41/views/1" target="_blank">Board das tarefas</a>
> 
## Observações e destaques

- Minha principal dificuldade tem sido ajustar a resposta ao webhook de atualização de boleto. Num primeiro momento, consegui receber o webhook com o "ping", mas, por alguma razão, não estou mais recebendo. Idealmente, se houvesse mais tempo, me dedicaria mais pra melhorar meu entendimento na documentação da API.
- Acredito que seja importante informar que tentei utilizar a gem boleto_simples, porém enfrentei alguns erros e na documentação da API versão 1 a requisição exemplo é: `BoletoSimples::Extra.userinfo` ao tentar realizar a requisição recebo `uninitialized constant BoletoSimples::Extra` então pra não perder mt tempo decidi não seguir por esse caminho, com certeza com mais tempo iria tentar implementar a gem e também configurar o cache para não atingir o limite de requisições.

## Github Workflow
O fluxo de trabalho e como as tarefas foram desenvolvidas pode ser acessado em: <br> 
<a href="https://github.com/users/PhilipeeX/projects/41/views/1" target="_blank">Board das tarefas</a>

## Apêndice
Author: <strong>Philipe Rodrigues (dev.philipe@outlook.com)</strong>

<p align="right"><a href="#topo-readme">Voltar ao topo</a></p>
