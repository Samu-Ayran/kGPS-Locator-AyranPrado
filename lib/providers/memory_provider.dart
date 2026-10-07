import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../models/memory_item.dart';

class MemoryProvider extends ChangeNotifier {
  final List _memories = [];
  final ImagePicker _picker = ImagePicker();

  List get memories => List.unmodifiable(_memories);

  Future pickImages() async {
    try {
      // Permite selecionar múltiplas imagens
      final List pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      // Tratamento para seleção cancelada:
      // se o usuário voltar sem escolher,
      // a lista retorna vazia.
      if (pickedFiles.isEmpty) return;

      for (var file in pickedFiles) {
        _memories.add(
          MemoryItem(
            id: DateTime.now()
                .microsecondsSinceEpoch
                .toString(),
            imagePath: file.path,
            dateAdded: DateTime.now(),
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao selecionar imagens: $e');
    }
  }

  void removeMemory(String id) {
    _memories.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}