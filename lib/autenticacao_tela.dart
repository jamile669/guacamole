import 'package:flutter/material.dart';
import 'package:projeto/_comum/meu_snackbar.dart';
import 'package:projeto/_comum/minhas_cores.dart';
import 'package:projeto/_comum/decoracao_campo_autenticacao.dart';
import 'package:projeto/servicos/autenticacao_servico.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _senhaControler = TextEditingController();
  TextEditingController _nomeControler = TextEditingController();

  AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.roxoescuro,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MinhasCores.roxoTopoGradiente,
                  MinhasCores.roxoBaixoGradiente
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/icone-logou.png",
                        height: 200,
                      ),
                      SizedBox(height: 32),
                      TextFormField(
                        controller: _emailControler,
                        decoration: getAuthenticationInputDecoration("Email"),
                        validator: (String? value) {
                          if (value!.isEmpty)
                            return "O nome não pode ser vazio";

                          if (value.length < 5) return "O email é muito curto";

                          if (!value.contains("@")) return "Email inválido";
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaControler,
                        decoration: getAuthenticationInputDecoration("Senha"),
                        obscureText: true,
                      ),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: getAuthenticationInputDecoration(
                                  "Confirme a Senha"),
                              obscureText: true,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeControler,
                              decoration:
                                  getAuthenticationInputDecoration("Nome"),
                              validator: (String? value) {
                                if (value!.isEmpty)
                                  return "O nome não pode ser vazio";

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
                        child: Text((queroEntrar) ? "Entrar" : "Cadastrar"),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: Text((queroEntrar)
                            ? "Ainda não tem uma conta? Cadastre-se."
                            : "Já tem uma conta? Entre!"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String nome = _nomeControler.text;
    String email = _emailControler.text;
    String senha = _senhaControler.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        print("Entrada validada");
        _autenServico.logarUsuarios(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              mostrarSnackBar(context: context, texto: erro);
            }
          },
        );
      } else {
        print("Cadastro Validado");
        print("${_emailControler},${_senhaControler},${_nomeControler}");
        _autenServico
            .cadastrarUsuario(nome: nome, senha: senha, email: email)
            .then(
          (String? erro) {
            if (erro != null) {
              mostrarSnackBar(context: context, texto: erro);
            }
          },
        );
      }
    } else
      print("Form inválido");
  }
}
