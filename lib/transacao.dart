import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class transacao extends StatefulWidget {
  const transacao({super.key});

  @override
  State<transacao> createState() => _transacaoState();
}

class _transacaoState extends State<transacao> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adicionando Transação'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Row(
            children: [
              const Icon(Icons.attach_money),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Valor'),
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}
