import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/memory_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final memoryProvider =
        Provider.of<MemoryProvider>(context);

    final memories = memoryProvider.memories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário de Memórias'),
        centerTitle: true,
      ),

      body: memories.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma memória adicionada ainda.\n'
                'Clique no botão abaixo para começar!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),

              itemCount: memories.length,

              itemBuilder: (context, index) {
                final item = memories[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          imagePath: item.imagePath,
                        ),
                      ),
                    );
                  },

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0),

                    child: Image.file(
                      File(item.imagePath),
                      fit: BoxFit.cover,

                      // Limita o buffer do cache
                      cacheWidth: 300,

                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () => memoryProvider.pickImages(),
        icon: const Icon(Icons.add_a_photo),
        label: const Text('Adicionar fotos'),
      ),
    );
  }
}