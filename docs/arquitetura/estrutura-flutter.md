# Estrutura Flutter - Club Nova Frota

Este documento define a arquitetura inicial do aplicativo do motorista.

## Local do app

```text
app_motorista/
```

## Estrutura futura

```text
app_motorista/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── theme/
│   │   ├── routes/
│   │   ├── constants/
│   │   └── services/
│   ├── features/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── fretes/
│   │   ├── ordens/
│   │   ├── comprovantes/
│   │   └── perfil/
│   └── shared/
│       ├── widgets/
│       └── models/
├── pubspec.yaml
└── README.md
```

## MVP inicial

O primeiro MVP terá apenas:

1. Login
2. Tela Inicial
3. Fretes Disponíveis
4. Minhas Ordens
5. Anexar Comprovante
6. Perfil

## Padrão visual

- Fundo branco predominante
- Azul Nova Frota para cabeçalhos e menus
- Verde para botões, status positivos e pontuação
- Componentes reutilizáveis para cards, botões e navegação
