# MVP - Painel Administrativo Club Nova Frota

## Objetivo

Permitir que a equipe Nova Frota controle toda a operação do aplicativo Club Nova Frota em um painel administrativo simples, rápido e seguro.

O painel será responsável por alimentar o aplicativo do motorista com fretes, ordens, status, comprovantes, pontos, ranking, benefícios e notificações.

---

# Usuários do Painel

- Administrador
- Coordenador
- Operacional
- Comercial
- Financeiro

---

# Fluxo Geral

```text
Portal Frete / Painel Admin
        ↓
Firebase
        ↓
App Motorista
```

O painel administrativo será o centro de comando da operação.

Tudo que for lançado ou aprovado no painel deverá refletir no aplicativo do motorista.

---

# TELA 01 - DASHBOARD

## Objetivo

Exibir uma visão geral da operação.

## Indicadores

- Motoristas cadastrados
- Motoristas ativos
- Fretes liberados
- Ordens pendentes
- Ordens aprovadas
- Comprovantes aguardando análise
- Pontos distribuídos
- Ranking do mês

## Ações rápidas

- Cadastrar frete
- Cadastrar motorista
- Ver ordens pendentes
- Ver comprovantes pendentes

---

# TELA 02 - MOTORISTAS

## Objetivo

Gerenciar motoristas cadastrados no Club Nova Frota.

## Funções

- Cadastrar motorista
- Editar motorista
- Ativar motorista
- Bloquear motorista
- Consultar dados do veículo
- Consultar telefone
- Consultar cidade e UF
- Consultar pontuação
- Consultar medalha

## Campos principais

- Nome
- CPF
- Telefone
- E-mail
- Placa
- Categoria
- Cidade
- UF
- Status
- Pontos
- Medalha

---

# TELA 03 - FRETES

## Objetivo

Cadastrar e controlar fretes disponíveis no aplicativo.

## Funções

- Criar frete
- Editar frete
- Encerrar frete
- Cancelar frete
- Duplicar frete
- Filtrar por cliente
- Filtrar por origem
- Filtrar por destino
- Filtrar por produto

## Campos principais

- Cliente
- Origem
- Destino
- Produto
- Valor
- Data de carga
- Observações
- Status

---

# TELA 04 - ORDENS

## Objetivo

Controlar solicitações de ordens feitas pelos motoristas.

## Funções

- Visualizar ordens solicitadas
- Aprovar ordem
- Rejeitar ordem
- Alterar status
- Consultar motorista
- Consultar frete
- Consultar histórico

## Status

- Solicitada
- Liberada
- Negada
- Em viagem
- Comprovante enviado
- Finalizada
- Pendência
- Cancelada

---

# TELA 05 - COMPROVANTES

## Objetivo

Analisar comprovantes enviados pelos motoristas.

## Funções

- Visualizar comprovante
- Aprovar comprovante
- Rejeitar comprovante
- Solicitar reenvio
- Consultar ordem vinculada
- Consultar motorista vinculado

## Regras

- Comprovante aprovado poderá gerar pontos.
- Comprovante rejeitado deverá gerar pendência na ordem.
- Toda análise deve registrar usuário responsável.

---

# TELA 06 - PONTOS

## Objetivo

Controlar pontos dos motoristas.

## Funções

- Adicionar pontos
- Remover pontos
- Consultar histórico
- Vincular pontos a uma ordem
- Vincular pontos a uma campanha
- Vincular pontos a uma indicação

## Regras

- Motorista não pode alterar os próprios pontos.
- Toda movimentação precisa ter descrição.
- Toda movimentação precisa registrar usuário responsável.

---

# TELA 07 - RANKING

## Objetivo

Exibir classificação dos motoristas por desempenho.

## Funções

- Ranking mensal
- Ranking anual
- Ranking por região
- Ranking por pontos
- Ranking por viagens
- Controle de medalhas

---

# TELA 08 - BENEFÍCIOS

## Objetivo

Gerenciar benefícios disponíveis para troca por pontos.

## Funções

- Criar benefício
- Editar benefício
- Ativar benefício
- Inativar benefício
- Controlar estoque
- Aprovar resgates
- Rejeitar resgates

## Campos principais

- Título
- Descrição
- Categoria
- Parceiro
- Pontos necessários
- Imagem
- Status

---

# TELA 09 - NOTIFICAÇÕES

## Objetivo

Enviar avisos aos motoristas.

## Funções

- Enviar aviso geral
- Enviar aviso por região
- Enviar aviso para motorista específico
- Enviar aviso de novo frete
- Enviar aviso de ordem liberada
- Enviar aviso de pendência

---

# TELA 10 - CONFIGURAÇÕES

## Objetivo

Controlar usuários, permissões e parâmetros do sistema.

## Funções

- Cadastrar usuários do painel
- Definir permissões
- Alterar status de usuário
- Consultar logs
- Configurar integrações futuras

## Perfis

- Admin
- Coordenador
- Operacional
- Comercial
- Financeiro

---

# MVP do Painel Admin

## Primeira entrega

- Login administrativo
- Dashboard
- Motoristas
- Fretes
- Ordens
- Comprovantes

## Segunda entrega

- Pontos
- Ranking
- Benefícios
- Notificações
- Configurações

---

# Critério de Sucesso

O MVP do painel será considerado funcional quando a equipe conseguir:

- Cadastrar motoristas
- Cadastrar fretes
- Visualizar fretes no app do motorista
- Aprovar ou rejeitar ordens
- Analisar comprovantes
- Atualizar status das viagens

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Base oficial do painel administrativo
