# Coleções Firestore - Painel Admin, Portal Frete e App Motorista

## Objetivo

Definir a estrutura oficial das coleções do Firestore que serão usadas em conjunto por:

- Portal Frete
- Painel Administrativo
- App Motorista

Essa estrutura será a base para cadastro de motoristas, fretes, ordens, comprovantes, pontos, ranking, benefícios e notificações.

---

# Visão Geral

```text
usuarios
motoristas
fretes
ordens
comprovantes
pontos
ranking
beneficios
resgates
notificacoes
logs
configuracoes
```

---

# 01 - usuarios

## Objetivo

Controlar usuários que acessam o app e o painel administrativo.

## Campos

```text
id
nome
email
perfil
ativo
criadoEm
atualizadoEm
```

## Perfis

```text
admin
coordenador
operacional
comercial
financeiro
motorista
```

---

# 02 - motoristas

## Objetivo

Armazenar dados operacionais dos motoristas.

## Campos

```text
id
usuarioId
nome
cpf
telefone
email
placa
categoria
cidade
uf
ativo
pontos
medalha
criadoEm
atualizadoEm
```

## Status

```text
ativo
bloqueado
pendente
inativo
```

---

# 03 - fretes

## Objetivo

Armazenar fretes disponíveis para o app motorista.

## Campos

```text
id
cliente
origem
destino
produto
valor
pesoEstimado
dataCarregamento
observacoes
status
criadoPor
criadoEm
atualizadoEm
```

## Status

```text
disponivel
encerrado
cancelado
rascunho
```

---

# 04 - ordens

## Objetivo

Controlar solicitações e viagens dos motoristas.

## Campos

```text
id
motoristaId
freteId
status
comprovanteUrl
observacoes
solicitadaEm
aprovadaEm
rejeitadaEm
finalizadaEm
criadoEm
atualizadoEm
```

## Status

```text
solicitada
liberada
negada
em_viagem
comprovante_enviado
finalizada
pendencia
cancelada
```

---

# 05 - comprovantes

## Objetivo

Registrar arquivos enviados pelos motoristas.

## Campos

```text
id
ordemId
motoristaId
arquivoUrl
tipoArquivo
status
observacoes
analisadoPor
enviadoEm
analisadoEm
criadoEm
atualizadoEm
```

## Status

```text
enviado
aprovado
rejeitado
reenviar
```

---

# 06 - pontos

## Objetivo

Registrar movimentações de pontos dos motoristas.

## Campos

```text
id
motoristaId
tipo
pontos
descricao
origem
referenciaId
criadoPor
criadoEm
```

## Tipos

```text
credito
debito
ajuste
resgate
bonus
indicacao
```

---

# 07 - ranking

## Objetivo

Controlar posição dos motoristas por período.

## Campos

```text
id
motoristaId
periodo
ano
mes
pontos
viagens
posicao
medalha
atualizadoEm
```

---

# 08 - beneficios

## Objetivo

Controlar benefícios disponíveis para troca por pontos.

## Campos

```text
id
titulo
descricao
categoria
parceiro
pontosNecessarios
estoque
imagemUrl
ativo
criadoEm
atualizadoEm
```

---

# 09 - resgates

## Objetivo

Registrar resgates feitos pelos motoristas.

## Campos

```text
id
motoristaId
beneficioId
pontosUtilizados
status
solicitadoEm
aprovadoEm
rejeitadoEm
entregueEm
observacoes
```

## Status

```text
solicitado
aprovado
rejeitado
entregue
cancelado
```

---

# 10 - notificacoes

## Objetivo

Controlar avisos enviados aos motoristas.

## Campos

```text
id
titulo
mensagem
tipo
publico
motoristaId
uf
cidade
enviadoPor
enviadoEm
lido
```

## Tipos

```text
geral
frete
ordem
pendencia
beneficio
campanha
```

---

# 11 - logs

## Objetivo

Registrar ações importantes feitas no painel administrativo.

## Campos

```text
id
usuarioId
acao
colecao
documentoId
dadosAntes
dadosDepois
criadoEm
```

---

# 12 - configuracoes

## Objetivo

Armazenar parâmetros gerais do sistema.

## Campos

```text
id
chave
valor
descricao
atualizadoPor
atualizadoEm
```

---

# Regras de Integração

## Fretes

Fretes criados no painel com status `disponivel` devem aparecer no app motorista.

## Ordens

Ordens criadas pelo app com status `solicitada` devem aparecer no painel para aprovação.

## Comprovantes

Comprovantes enviados pelo app devem alterar a ordem para `comprovante_enviado`.

## Pontos

Pontos só podem ser alterados pelo painel ou por regra automática do sistema.

## Ranking

Ranking será recalculado com base nas movimentações de pontos e viagens finalizadas.

---

# Coleções Prioritárias do MVP

## Fase 1

```text
usuarios
motoristas
fretes
ordens
comprovantes
```

## Fase 2

```text
pontos
ranking
beneficios
resgates
notificacoes
```

## Fase 3

```text
logs
configuracoes
integrações externas
```

---

Versão: 1.0

Projeto: Club Nova Frota

Status: Estrutura Firestore oficial para painel, portal e app
