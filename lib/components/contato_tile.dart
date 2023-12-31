import 'dart:io';

import 'package:app_lista_contatos/model/contatos_model.dart';
import 'package:app_lista_contatos/pages/add_edit_page.dart';
import 'package:app_lista_contatos/repository/contato_repository.dart';
import 'package:flutter/material.dart';

class ContatoTile extends StatefulWidget {
  final ContatoModel contato;

  const ContatoTile({super.key, required this.contato});

  @override
  State<ContatoTile> createState() => _ContatoTileState();
}

class _ContatoTileState extends State<ContatoTile> {
  bool loading = false;
  bool hasDeleted = false;

  @override
  Widget build(BuildContext context) {
    if (hasDeleted) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(
              File(
                widget.contato.foto,
              ),
            ),
          ),
          title: Text(widget.contato.nome),
          subtitle: Text(widget.contato.telefone),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddEditPage(
                        contato: widget.contato,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final deleted =
                      await ContatoRepository().deleteContato(widget.contato.id!);
                  setState(() {
                    loading = false;
                  });

                  if (deleted) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contato excluído com sucesso'),
                      ),
                    );
                    setState(() {
                      hasDeleted = true;
                    });
                  } else {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao excluir contato'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
        if (loading)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}