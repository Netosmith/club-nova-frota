# Regras de Segurança Firebase

## Objetivo

Definir as diretrizes de segurança para acesso ao banco de dados, armazenamento de arquivos e autenticação do Club Nova Frota.

---

# Princípios Gerais

## Regra 01

Nenhum usuário poderá acessar dados sem autenticação.

Obrigatório:

```text
Firebase Authentication
```

---

## Regra 02

Todo acesso deverá estar vinculado a um usuário válido.

Campos obrigatórios:

```json
{
  "uid": "",
  "email": "",
  "perfil": ""
}
```

---

## Regra 03

Toda ação crítica deverá registrar:

* Usuário
* Data
* Hora
* Operação executada

---

# Perfis de Usuário

## admin

Permissões:

* Acesso total
* Configurações
* Usuários
* Fretes
* Ordens
* Pontos

---

## operacional

Permissões:

* Fretes
* Ordens
* Comprovantes

Sem acesso:

* Configurações globais

---

## comercial

Permissões:

* Fretes
* Clientes
* Indicadores comerciais

Sem acesso:

* Financeiro

---

## financeiro

Permissões:

* Pagamentos
* Comprovantes financeiros

Sem acesso:

* Configurações administrativas

---

## motorista

Permissões:

* Próprios dados
* Próprias ordens
* Próprios comprovantes
* Própria pontuação

Sem acesso:

* Dados de outros motoristas

---

# Firestore

## Coleção usuarios

Leitura:

```text
Admin
```

Escrita:

```text
Admin
```

---

## Coleção motoristas

Leitura:

```text
Admin
Operacional
Próprio motorista
```

Escrita:

```text
Admin
Operacional
```

---

## Coleção fretes

Leitura:

```text
Usuários autenticados
```

Escrita:

```text
Admin
Operacional
Comercial
```

---

## Coleção ordens

Leitura:

```text
Admin
Operacional
Motorista proprietário
```

Escrita:

```text
Admin
Operacional
```

---

## Coleção pontos

Leitura:

```text
Admin
Motorista proprietário
```

Escrita:

```text
Sistema
Admin
```

---

## Coleção medalhas

Leitura:

```text
Usuários autenticados
```

Escrita:

```text
Sistema
Admin
```

---

## Coleção posts

Leitura:

```text
Usuários autenticados
```

Escrita:

```text
Autor
Admin
```

---

# Firebase Storage

## Comprovantes

Permissões:

```text
Upload:
Motorista proprietário

Leitura:
Operacional
Admin
```

---

## Fotos da Comunidade

Permissões:

```text
Upload:
Usuário autenticado

Leitura:
Usuário autenticado
```

---

## Documentos Administrativos

Permissões:

```text
Admin apenas
```

---

# Logs e Auditoria

Registrar:

* Login
* Logout
* Criação de fretes
* Aprovação de ordens
* Aprovação de comprovantes
* Alteração de pontuação

---

# Dados Sensíveis

Nunca armazenar:

* Senhas
* Tokens de acesso
* Dados bancários sem criptografia

---

# Backup

Política inicial:

* Backup diário
* Retenção de 30 dias

---

# Ambiente de Produção

Antes do lançamento:

* Revisar todas as regras Firestore
* Revisar regras Storage
* Validar permissões por perfil
* Realizar testes de invasão e acesso indevido

---

# Objetivo

Garantir que o Club Nova Frota opere com segurança, rastreabilidade e controle de acesso adequado para motoristas e equipe administrativa.

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Aprovado para implementação futura
