import 'package:flutter/material.dart';
import 'package:projeto/_comum/decoracao_campo_autenticacao.dart';
import 'package:projeto/servicos/autenticacao_servico.dart';

class InicioTela extends StatelessWidget {
   const InicioTela({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Inicial"),
      ),
      body: _buildListaImagens(context),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Deslogar"),
              onTap: () {
                AutenticacaoServico().deslogar();
              },
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _buildListaImagens(BuildContext context) {
    return ListView(
      children: List.generate(3, (index) {
        String imagemPath = 'assets/jogo${index + 1}.jpeg';
        return GestureDetector(
          onTap: () {
            // Adicione aqui a lógica para o que acontecerá ao clicar na imagem
            _exibirPopUp(context, index);
          },
          child: Card(
            margin: EdgeInsets.all(80.0),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset(
                imagemPath,
                width: 100.0,
                height: 400.0,
                fit: BoxFit.cover,
              
              ),
            ),
          ),
        );
      },
    )
    );
  }

  void _exibirPopUp(BuildContext context, int index) {
    TextEditingController _textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('comente sobre o jogo!'),
          children: [
            SizedBox(),
            TextFormField(
              controller: _textFieldController,
               decoration:
               getAuthenticationInputDecoration("Comment"),
               validator: (String? value) {
              if (value!.isEmpty)
                return "O comentário não pode ser vazio";

                 return null;
               }
            ),
  
            // Adicione mais widgets ao corpo do pop-up conforme necessário
            // Este exemplo inclui apenas um botão "Fechar".
            ElevatedButton(
              onPressed: () {
                String textoInserido = _textFieldController.text;
                print('Texto inserido: $textoInserido');

                // Adiciona a mensagem "Enviado" ao console ou a outro local desejado
                print('Enviado!');
                Navigator.pop(context); // Fechar o pop-up
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

 
        

  








