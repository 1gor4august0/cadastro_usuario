import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1E3A8A),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmaSenhaCtrl = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  // Hífen no fim da classe para não ser interpretado como intervalo;
  // TLD com 2 ou mais letras (aceita .com, .br, .online etc.).
  static final _emailRegex = RegExp(r'^[\w.+-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _cpfCtrl.dispose();
    _telefoneCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmaSenhaCtrl.dispose();
    super.dispose();
  }

  // ---------- Validators ----------

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu nome completo';
    }
    if (value.trim().split(RegExp(r'\s+')).length < 2) {
      return 'Informe nome e sobrenome';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu e-mail';
    }
    if (!value.contains('@')) {
      return 'O e-mail deve conter @';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validarCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu CPF';
    }
    if (value.length != 11) {
      return 'O CPF deve ter 11 dígitos';
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu telefone';
    }
    if (value.length < 10 || value.length > 11) {
      return 'Informe DDD + número (10 ou 11 dígitos)';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validarConfirmacao(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }
    if (value != _senhaCtrl.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  // ---------- Ações ----------

  void _cadastrar() {
    FocusScope.of(context).unfocus();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Cadastro realizado com sucesso! Bem-vindo(a), '
            '${_nomeCtrl.text.trim().split(' ').first}.',
          ),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
      _limparFormulario();
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Corrija os campos destacados em vermelho.'),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _limparFormulario() {
    _formKey.currentState!.reset();
    _nomeCtrl.clear();
    _emailCtrl.clear();
    _cpfCtrl.clear();
    _telefoneCtrl.clear();
    _senhaCtrl.clear();
    _confirmaSenhaCtrl.clear();
  }

  // ---------- Interface ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeCtrl,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: _validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'nome@exemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cpfCtrl,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Somente números',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: _validarCpf,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneCtrl,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'DDD + número, somente dígitos',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: _validarTelefone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaCtrl,
                obscureText: _ocultarSenha,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  helperText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                    icon: Icon(
                      _ocultarSenha ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _ocultarSenha = !_ocultarSenha),
                  ),
                ),
                validator: _validarSenha,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmaSenhaCtrl,
                obscureText: _ocultarConfirmacao,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _cadastrar(),
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: _ocultarConfirmacao
                        ? 'Mostrar senha'
                        : 'Ocultar senha',
                    icon: Icon(
                      _ocultarConfirmacao
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                        () => _ocultarConfirmacao = !_ocultarConfirmacao),
                  ),
                ),
                validator: _validarConfirmacao,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('CADASTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
