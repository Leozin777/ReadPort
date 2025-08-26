import 'package:flutter/material.dart';
import 'package:read_port/core/widgets/text_field_widget.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            TextFieldWidget(
              labelText: "Nome do documento",
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
