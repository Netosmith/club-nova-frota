# Fluxo Operacional - Club Nova Frota

## Objetivo

Padronizar todo o processo operacional entre motorista e equipe Nova Frota utilizando o aplicativo Club Nova Frota.

---

# Fluxo Principal

## Etapa 1 - Publicação do Frete

Responsável:

* Operacional
* Comercial

Ação:

* Cadastrar frete no painel administrativo

Informações:

* Cliente
* Origem
* Destino
* Produto
* Valor
* Data de carregamento

Status:

```text
Disponível
```

---

## Etapa 2 - Visualização do Frete

Responsável:

* Motorista

Ação:

* Abrir tela de fretes
* Consultar informações
* Escolher frete disponível

Status:

```text
Visualizado
```

---

## Etapa 3 - Solicitação de Ordem

Responsável:

* Motorista

Ação:

* Solicitar ordem

Sistema registra:

* Motorista
* Data
* Hora
* Frete selecionado

Status:

```text
Solicitada
```

---

## Etapa 4 - Aprovação da Ordem

Responsável:

* Operação Nova Frota

Ação:

* Aprovar ou rejeitar solicitação

Se aprovado:

```text
Liberada
```

Se rejeitado:

```text
Negada
```

---

## Etapa 5 - Viagem

Responsável:

* Motorista

Ação:

* Executar carregamento
* Realizar transporte
* Efetuar descarga

Status:

```text
Em Viagem
```

---

## Etapa 6 - Envio de Comprovante

Responsável:

* Motorista

Documentos permitidos:

* Canhoto
* Comprovante de descarga
* Nota fiscal
* Foto

Status:

```text
Comprovante Enviado
```

---

## Etapa 7 - Validação Operacional

Responsável:

* Operação

Ação:

* Conferir documentação

Resultado:

Aprovado:

```text
Finalizada
```

Reprovado:

```text
Pendência
```

---

# Fluxo de Status

```text
Disponível
↓
Solicitada
↓
Liberada
↓
Em Viagem
↓
Comprovante Enviado
↓
Finalizada
```

---

# Regras Operacionais

## Regra 01

Um motorista pode solicitar várias ordens.

---

## Regra 02

Uma ordem pertence a apenas um motorista.

---

## Regra 03

Uma ordem só pode ser finalizada após envio do comprovante.

---

## Regra 04

Ordens negadas permanecem registradas para auditoria.

---

## Regra 05

Todas as movimentações devem registrar:

* Data
* Hora
* Usuário responsável

---

# Objetivo Futuro

Eliminar dependência operacional de:

* WhatsApp
* Ligações
* Envio manual de documentos

Centralizando todo o processo dentro do Club Nova Frota.

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Aprovado para desenvolvimento
