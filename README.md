# 📱 Safe Solutions — Plataforma de Gestão de Serviços

## 📌 Sobre o Projeto

O **Safe Solutions** é uma plataforma desenvolvida como Trabalho de Conclusão de Curso (TCC) do curso técnico em Informática, composta por um **sistema web administrativo**, **API backend** e um **aplicativo mobile**.

A solução permite que clientes acompanhem o **status dos serviços contratados**, visualizem informações da empresa e mantenham comunicação direta com o suporte.

O sistema foi projetado seguindo uma arquitetura moderna baseada em **API REST**, integrando aplicações web e mobile.

---

## 🏗️ Arquitetura do Sistema****

```text
Aplicativo Mobile (Flutter)
        │
        ▼
API REST (Spring Boot)
        │
        ▼
Banco de Dados SQL Server
        ▲
        │
Plataforma Web (React)
```

## 🌐 Frontend Web — React

O sistema web foi desenvolvido utilizando **React**, sendo responsável pela administração da plataforma e gerenciamento dos clientes.

### ✅ Funcionalidades

- Cadastro de usuários e empresas
- Cadastro e gerenciamento de serviços
- Atualização do status dos serviços
- Administração de clientes
- Controle das informações exibidas no aplicativo mobile

⚠️ O cadastro de contas é realizado exclusivamente pela plataforma web.

---

## 🔙 Backend — Spring Boot

O backend foi desenvolvido com **Spring Boot**, responsável por toda a regra de negócio e comunicação entre os sistemas.

### ✅ Responsabilidades

- Autenticação de usuários
- Controle de acesso
- Exposição de API REST
- Gerenciamento de serviços
- Persistência de dados
- Integração entre Web e Mobile
- Envio de e-mails pelo sistema

### 📡 API REST

Principais operações disponíveis:

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /login | Autenticação do usuário |
| PUT | /password | Alteração de senha |
| GET | /profile | Consulta de perfil |
| PUT | /profile | Atualização cadastral |
| GET | /services | Consulta status do serviço |
| POST | /contact | Envio de mensagem |

---

## 🗄️ Banco de Dados — SQL Server

O sistema utiliza **Microsoft SQL Server** para armazenamento das informações.

### Dados armazenados

- Usuários
- Empresas
- Serviços contratados
- Status dos serviços
- Informações cadastrais
- Registros de comunicação

---

## 📱 Aplicativo Mobile — Flutter

O aplicativo mobile foi desenvolvido utilizando **Flutter**, permitindo execução multiplataforma.

O app é voltado ao **cliente final**, permitindo o acompanhamento dos serviços contratados.

### ✅ Funcionalidades

#### 🔐 Autenticação
- Login
- Alteração de senha

#### 📊 Status do Serviço
- Visualização do serviço contratado
- Acompanhamento do andamento do serviço

#### 👤 Perfil
- Dados da empresa
- Descrição institucional
- Edição de informações cadastrais

#### 📩 Fale Conosco
- Envio de mensagens diretamente para a Safe Solutions via e-mail

#### 📄 Termos de Uso
- Visualização dos termos e políticas da plataforma

---

## 🔗 Integração entre Sistemas

O aplicativo Flutter e o sistema React consomem dados através da API desenvolvida em Spring Boot utilizando requisições HTTP.

### Fluxo da aplicação

1. Usuário realiza login no aplicativo
2. API valida credenciais
3. Dados são recuperados do SQL Server
4. Informações são exibidas em tempo real no app

---

## 🛠️ Tecnologias Utilizadas

### 📱 Mobile
- Flutter
- Dart

### 🌐 Frontend
- React
- JavaScript
- HTML5
- CSS3

### 🔙 Backend
- Java
- Spring Boot
- REST API

### 🗄️ Banco de Dados
- Microsoft SQL Server

---

## 🎯 Objetivo do Projeto

O Safe Solutions foi criado com o objetivo de:

- Centralizar o acompanhamento de serviços
- Melhorar a comunicação empresa-cliente
- Digitalizar processos administrativos
- Oferecer transparência no andamento dos serviços

---

## Integrantes do Projeto:

- Lucas Gabriel - Desenvolvimento Web e Scrum Master
- Geovanna Cunha - Documentação do projeto e Product Owner
- Bruno Magno - Desenvolvimento Mobile
- Lucas Bitencourt - Desenvolvimento Mobile
- Vinicius de Santana - Documentação do Projeto
- Bethânia Renero - Documentação do Projeto
- Fernanda Lopes - Documentação do Projeto
