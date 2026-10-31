# Cadastro de Usuário — Flutter

Atividade prática da disciplina **Desenvolvimento Mobile (Flutter e Dart)** — Formulários e Validações.

## Funcionalidades

- Formulário com `Form` + `GlobalKey<FormState>` e `TextFormField`
- Campos: nome completo, e-mail, CPF, telefone, senha e confirmação de senha
- `keyboardType` e `inputFormatters` adequados (CPF e telefone aceitam só dígitos)
- Validação campo a campo com mensagens de erro abaixo de cada campo
- SnackBar verde de sucesso e SnackBar vermelho quando há campos inválidos

### Desafios implementados

- Confirmação de senha (verifica se as senhas são iguais)
- Botão para mostrar/ocultar a senha
- Validação de e-mail com `RegExp`
- SnackBar de erro em vermelho

## Como executar

```bash
flutter create .
flutter pub get
flutter run
```

## Resultado

<!-- Adicione aqui o print do app funcionando -->
