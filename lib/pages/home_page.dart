import 'package:app_lista_contatos/components/contato_tile.dart';
import 'package:app_lista_contatos/model/contatos_model.dart';
import 'package:app_lista_contatos/pages/add_edit_page.dart';
import 'package:app_lista_contatos/repository/contato_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: ContatoRepository().getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<ContatoModel> contatos = snapshot.data as List<ContatoModel>;

          if (contatos.isEmpty) {
            return const Center(
              child: Text('Nenhum contato cadastrado'),
            );
          }

          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              return ContatoTile(
                contato: contatos[index],
              );
            },
          );
        },
      ),
    );
  }
}