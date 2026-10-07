```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

enum Visibilidade {
  publico,
  privado,
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento de Evento',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const AgendamentoEventoTela(),
    );
  }
}

class AgendamentoEventoTela extends StatefulWidget {
  const AgendamentoEventoTela({super.key});

  @override
  State<AgendamentoEventoTela> createState() =>
      _AgendamentoEventoTelaState();
}

class _AgendamentoEventoTelaState
    extends State<AgendamentoEventoTela> {
  static final DateTime _dataPadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao =
      TimeOfDay(hour: 19, minute: 0);
  static const String _tipoPadrao = 'Aniversario';
  static const double _convidadosPadrao = 50.0;
  static const Visibilidade _visibilidadePadrao =
      Visibilidade.privado;

  static const Map<String, bool> _servicosPadrao = {
    'Buffet': false,
    'Fotografo': false,
    'Decoração': false,
    'DJ': false,
  };

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  late double _quantidadeConvidados;
  late Visibilidade _visibilidadeSelecionada;
  late Map<String, bool> _servicosSelecionados;

  @override
  void initState() {
    super.initState();
    _resetarValores();
  }

  void _resetarValores() {
    _dataSelecionada = _dataPadrao;
    _horarioSelecionado = _horarioPadrao;
    _tipoEventoSelecionado = _tipoPadrao;
    _quantidadeConvidados = _convidadosPadrao;
    _visibilidadeSelecionada = _visibilidadePadrao;
    _servicosSelecionados =
        Map<String, bool>.from(_servicosPadrao);
  }

  void _salvarFormulario() {
    print('=================================');
    print('RESUMO DO AGENDAMENTO');
    print('=================================');

    print(
      'Data: ${_dataSelecionada.day}/'
      '${_dataSelecionada.month}/'
      '${_dataSelecionada.year}',
    );

    print('Horário: ${_horarioSelecionado.format(context)}');
    print('Tipo de Evento: $_tipoEventoSelecionado');
    print('Quantidade de Convidados: $_quantidadeConvidados');
    print('Visibilidade: $_visibilidadeSelecionada');
    print('Serviços Selecionados: $_servicosSelecionados');
    print('=================================');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Evento salvo com sucesso! Veja os logs no console.',
        ),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (data != null) {
      setState(() {
        _dataSelecionada = data;
      });
    }
  }

  Future<void> _selecionarHorario(BuildContext context) async {
    final TimeOfDay? horario = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );

    if (horario != null) {
      setState(() {
        _horarioSelecionado = horario;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Evento Social'),
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data e Horário',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      '${_dataSelecionada.day}/'
                      '${_dataSelecionada.month}/'
                      '${_dataSelecionada.year}',
                    ),
                    onPressed: () => _selecionarData(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      _horarioSelecionado.format(context),
                    ),
                    onPressed: () => _selecionarHorario(context),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              'Serviços Adicionais',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Column(
              children: _servicosSelecionados.keys.map((servico) {
                return CheckboxListTile(
                  dense: true,
                  title: Text(servico),
                  value: _servicosSelecionados[servico],
                  onChanged: (bool? marcado) {
                    setState(() {
                      _servicosSelecionados[servico] =
                          marcado ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            const Divider(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Salvar Evento'),
                onPressed: _salvarFormulario,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Resetar'),
                onPressed: () {
                  setState(() {
                    _resetarValores();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}