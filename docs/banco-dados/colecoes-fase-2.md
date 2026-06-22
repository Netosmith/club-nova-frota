# Coleções Fase 2 - Club Nova Frota

## Objetivo

Documentar as coleções previstas para a Fase 2 do Club Nova Frota.

A Fase 2 será responsável por expandir o MVP operacional para uma plataforma completa com comunidade, pontos, ranking, benefícios, marketplace, chat e engajamento dos motoristas.

---

# Visão Geral das Coleções

Coleções previstas:

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

# pontos

Registra movimentações de pontos dos motoristas.

## Campos

```json
{
  "motoristaId": "",
  "tipo": "",
  "descricao": "",
  "pontos": 0,
  "origem": "",
  "ordemId": "",
  "criadoEm": ""
}
```

## Exemplos de tipo

- credito
- debito
- bonus
- ajuste

---

# medalhas

Registra medalhas e níveis dos motoristas.

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

## Níveis

- bronze
- prata
- ouro
- diamante
- elite_nova_frota

---

# posts

Registra publicações da comunidade.

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
  "criadoEm": ""
}
```

---

# comentarios

Registra comentários em publicações.

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

# curtidas

Registra curtidas em publicações.

## Campos

```json
{
  "postId": "",
  "usuarioId": "",
  "criadoEm": ""
}
```

---

# chat_conversas

Registra conversas entre motoristas e equipe Nova Frota.

## Campos

```json
{
  "participantes": [],
  "tipo": "operacional",
  "ultimoTexto": "",
  "ultimaMensagemEm": "",
  "ativo": true
}
```

## Tipos

- operacional
- comercial
- financeiro
- suporte

---

# chat_mensagens

Registra mensagens de uma conversa.

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

# beneficios

Registra benefícios e parceiros disponíveis.

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

## Categorias

- posto
- oficina
- borracharia
- restaurante
- brinde
- operacional

---

# resgates

Registra resgates realizados pelos motoristas.

## Campos

```json
{
  "motoristaId": "",
  "beneficioId": "",
  "pontosUtilizados": 0,
  "status": "solicitado",
  "criadoEm": ""
}
```

## Status

- solicitado
- aprovado
- recusado
- entregue

---

# marketplace

Registra anúncios do marketplace.

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
  "criadoEm": ""
}
```

## Categorias

- caminhao
- implemento
- pneu
- peca
- servico

---

# notificacoes

Registra notificações enviadas aos usuários.

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

## Tipos

- ordem
- frete
- pontos
- mensagem
- beneficio
- sistema

---

# rankings

Registra rankings por período.

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

## Períodos

- mensal
- trimestral
- anual

---

# campanhas

Registra campanhas promocionais e operacionais.

## Campos

```json
{
  "titulo": "",
  "descricao": "",
  "tipo": "",
  "pontosBonus": 0,
  "dataInicio": "",
  "dataFim": "",
  "ativo": true
}
```

## Tipos

- indicacao
- safra
- bonus
- desafio
- regional

---

# Observações Técnicas

- Todas as coleções devem registrar data de criação.
- Alterações sensíveis devem registrar usuário responsável.
- Pontos não devem ser alterados diretamente pelo motorista.
- Posts, comentários e marketplace devem possuir moderação.
- Notificações poderão ser integradas ao Firebase Cloud Messaging.

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Planejado para Fase 2
