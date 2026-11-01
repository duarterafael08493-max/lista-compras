import 'package:flutter/material.dart';
import 'produto.dart';

class ListaComprasScreen extends StatefulWidget {
  const ListaComprasScreen({super.key});

  @override
  State<ListaComprasScreen> createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Produto> produtos = [];

  void adicionarProduto() {
    final nome = controller.text.trim();
    if (nome.isEmpty) return;
    setState(() {
      produtos.add(Produto(nome: nome));
      controller.clear();
    });
  }

  void removerProduto(int index) {
    setState(() => produtos.removeAt(index));
  }

  void marcarComprado(int index, bool? valor) {
    setState(() => produtos[index].comprado = valor ?? false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comprados = produtos.where((p) => p.comprado).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Text(
          'Minha Lista de Compras',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organize suas compras!',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Adicione os produtos que você precisa.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Nome do produto',
                prefixIcon: const Icon(Icons.shopping_bag),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => adicionarProduto(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: adicionarProduto,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar produto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Card(
              color: Colors.white,
              child: ListTile(
                title: const Text(
                  'Progresso da compra',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  '$comprados / ${produtos.length}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Meus produtos',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: produtos.isEmpty
                  ? const Center(
                      child: Text(
                        'Sua lista está vazia!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Checkbox(
                              value: produto.comprado,
                              onChanged: (valor) =>
                                  marcarComprado(index, valor),
                            ),
                            title: Text(
                              produto.nome,
                              style: TextStyle(
                                decoration: produto.comprado
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removerProduto(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
