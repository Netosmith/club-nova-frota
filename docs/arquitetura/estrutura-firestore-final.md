# Estrutura Firestore Final - Club Nova Frota

## Objetivo

Consolidar a estrutura completa do Cloud Firestore para o Club Nova Frota, separando as coleções do MVP e da Fase 2.

Este documento serve como base oficial para desenvolvimento do aplicativo, painel administrativo e futuras integrações.

---

# Visão Geral

O Firestore será organizado em coleções principais.

## MVP Operacional

- usuarios
- motoristas
- fretes
- ordens

## Fase 2

- pontos
- medalhas
- posts
- comentarios
- curtidas
- chat_conversas
- chat_mensagens
- beneficios
- resgates
- marketplace
- notificacoes
- rankings
- campanhas

---

# Coleção: usuarios

## Objetivo

Controlar todos os usuários que acessam o sistema.

## Perfis

- admin
- operacional
- comercial
- financeiro
- motorista

## Campos

```json
{
  "nome": "",
  "email": "",
  "perfil": "admin",
  "ativo": true,
  "uidFirebase": "",
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: motoristas

## Objetivo

Registrar motoristas parceiros da Nova Frota.

## Campos

```json
{
  "nome": "",
  "cpf": "",
  "telefone": "",
  "email": "",
  "placa": "",
  "categoria": "",
  "cidade": "",
  "uf": "",
  "ativo": true,
  "pontos": 0,
  "medalha": "bronze",
  "fotoUrl": "",
  "uidFirebase": "",
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: fretes

## Objetivo

Registrar fretes disponíveis para os motoristas.

## Status

- disponivel
- solicitado
- encerrado
- cancelado

## Campos

```json
{
  "cliente": "",
  "origem": "",
  "destino": "",
  "produto": "",
  "valor": 0,
  "status": "disponivel",
  "dataCarga": "",
  "observacoes": "",
  "criadoPor": "",
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: ordens

## Objetivo

Controlar ordens solicitadas, liberadas e finalizadas.

## Status

- solicitada
- liberada
- negada
- em_viagem
- comprovante_enviado
- finalizada
- pendencia
- cancelada

## Campos

```json
{
  "motoristaId": "",
  "freteId": "",
  "status": "solicitada",
  "comprovanteUrl": "",
  "observacoes": "",
  "solicitadaEm": "",
  "liberadaEm": "",
  "finalizadaEm": "",
  "aprovadaPor": "",
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: pontos

## Objetivo

Registrar movimentações de pontos.

## Campos

```json
{
  "motoristaId": "",
  "tipo": "credito",
  "descricao": "",
  "pontos": 0,
  "origem": "",
  "ordemId": "",
  "criadoEm": "",
  "criadoPor": ""
}
```

---

# Coleção: medalhas

## Objetivo

Registrar evolução dos motoristas.

## Campos

```json
{
  "motoristaId": "",
  "nivel": "bronze",
  "pontosMinimos": 0,
  "descricao": "",
  "criadoEm": ""
}
```

---

# Coleção: posts

## Objetivo

Registrar publicações da comunidade.

## Campos

```json
{
  "autorId": "",
  "autorNome": "",
  "texto": "",
  "imagemUrl": "",
  "tipo": "foto",
  "ativo": true,
  "totalCurtidas": 0,
  "totalComentarios": 0,
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: comentarios

## Objetivo

Registrar comentários nas publicações.

## Campos

```json
{
  "postId": "",
  "autorId": "",
  "autorNome": "",
  "texto": "",
  "ativo": true,
  "criadoEm": ""
}
```

---

# Coleção: curtidas

## Objetivo

Registrar curtidas em publicações.

## Campos

```json
{
  "postId": "",
  "usuarioId": "",
  "criadoEm": ""
}
```

---

# Coleção: chat_conversas

## Objetivo

Registrar conversas entre motoristas e equipe Nova Frota.

## Campos

```json
{
  "participantes": [],
  "tipo": "operacional",
  "ultimoTexto": "",
  "ultimaMensagemEm": "",
  "ativo": true,
  "criadoEm": ""
}
```

---

# Coleção: chat_mensagens

## Objetivo

Registrar mensagens enviadas nas conversas.

## Campos

```json
{
  "conversaId": "",
  "remetenteId": "",
  "texto": "",
  "imagemUrl": "",
  "arquivoUrl": "",
  "lida": false,
  "criadoEm": ""
}
```

---

# Coleção: beneficios

## Objetivo

Registrar benefícios e parceiros.

## Campos

```json
{
  "titulo": "",
  "descricao": "",
  "categoria": "",
  "parceiro": "",
  "pontosNecessarios": 0,
  "imagemUrl": "",
  "ativo": true,
  "criadoEm": ""
}
```

---

# Coleção: resgates

## Objetivo

Registrar resgates de benefícios.

## Campos

```json
{
  "motoristaId": "",
  "beneficioId": "",
  "pontosUtilizados": 0,
  "status": "solicitado",
  "criadoEm": "",
  "aprovadoPor": ""
}
```

---

# Coleção: marketplace

## Objetivo

Registrar anúncios do marketplace.

## Campos

```json
{
  "autorId": "",
  "titulo": "",
  "descricao": "",
  "categoria": "",
  "valor": 0,
  "cidade": "",
  "uf": "",
  "imagemUrl": "",
  "status": "ativo",
  "criadoEm": "",
  "atualizadoEm": ""
}
```

---

# Coleção: notificacoes

## Objetivo

Registrar notificações enviadas aos usuários.

## Campos

```json
{
  "usuarioId": "",
  "titulo": "",
  "mensagem": "",
  "tipo": "",
  "lida": false,
  "criadoEm": ""
}
```

---

# Coleção: rankings

## Objetivo

Registrar rankings por período.

## Campos

```json
{
  "motoristaId": "",
  "periodo": "mensal",
  "ano": 2026,
  "mes": 1,
  "pontos": 0,
  "viagens": 0,
  "posicao": 0,
  "atualizadoEm": ""
}
```

---

# Coleção: campanhas

## Objetivo

Registrar campanhas promocionais e operacionais.

## Campos

```json
{
  "titulo": "",
  "descricao": "",
  "tipo": "",
  "pontosBonus": 0,
  "dataInicio": "",
  "dataFim": "",
  "ativo": true,
  "criadoEm": ""
}
```

---

# Regras Gerais

- Toda coleção deve possuir campo de criação.
- Sempre que possível, registrar campo de atualização.
- Ações críticas devem registrar usuário responsável.
- Pontos não devem ser alterados diretamente pelo motorista.
- Comprovantes e imagens devem ser armazenados no Firebase Storage.
- Firestore deve ser protegido por regras de segurança antes do lançamento.

---

# Status

MVP: definido para desenvolvimento.

Fase 2: planejada para evolução após validação operacional.

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Base oficial do banco de dados
