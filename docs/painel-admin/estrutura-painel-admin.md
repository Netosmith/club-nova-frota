# Estrutura Oficial - Painel Administrativo Club Nova Frota

## Tecnologias

Frontend:
- Flutter Web

Backend:
- Firebase

Banco:
- Firestore

Arquivos:
- Firebase Storage

Autenticação:
- Firebase Auth

Hospedagem:
- PortalFrete.net.br

---

# Estrutura de Pastas

painel_admin/

├── lib/
│
├── core/
│   ├── constants/
│   ├── repositories/
│   ├── services/
│   ├── providers/
│   ├── routes/
│   └── theme/
│
├── features/
│   ├── dashboard/
│   ├── motoristas/
│   ├── fretes/
│   ├── ordens/
│   ├── comprovantes/
│   ├── pontos/
│   ├── ranking/
│   ├── beneficios/
│   ├── notificacoes/
│   └── configuracoes/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   └── utils/
│
├── app.dart
└── main.dart

---

# Permissões

Administrador
- acesso total

Coordenador
- fretes
- ordens
- comprovantes
- motoristas

Operacional
- fretes
- ordens
- comprovantes

Comercial
- fretes
- motoristas

Financeiro
- pontos
- benefícios

---

# Integração Principal

Painel Admin
↓
Firebase
↓
App Motorista
↓
Motorista

Toda informação deverá nascer no painel e refletir automaticamente no aplicativo.

---

# Fase 1

- Login Admin
- Dashboard
- Motoristas
- Fretes
- Ordens
- Comprovantes

# Fase 2

- Pontos
- Ranking
- Benefícios
- Notificações

# Fase 3

- BI Operacional
- Indicadores
- Integração Portal Frete
- Inteligência Artificial

---

Status: Aprovado
Versão: 1.0
Projeto: Club Nova Frota
