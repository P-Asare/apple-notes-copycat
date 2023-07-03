// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_proj/modules/notedata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modules/note.dart';
import 'package:flutter_quill/flutter_quill.dart';

class BlankPage extends StatefulWidget {
  final Note note;
  final bool isNew;

  const BlankPage({super.key, required this.note, required this.isNew});

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExisting();
  }

  // load existing Note
  void loadExisting() {
    final doc = Document()..insert(0, widget.note.text);

    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // add new note
  void addNewNote() {
    String text = _controller.document.toPlainText();
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // with note being new and note being typed
            if (widget.isNew && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            // Go back to home after
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            QuillToolbar.basic(
              color: Colors.white,
              controller: _controller,
              showAlignmentButtons: false,
              showBackgroundColorButton: false,
              showCenterAlignment: false,
              showColorButton: false,
              showCodeBlock: false,
              showDirection: false,
              showFontFamily: false,
              showDividers: false,
              showIndent: false,
              showHeaderStyle: false,
              showLink: false,
              showSearchButton: false,
              showInlineCode: false,
              showQuote: false,
              showListNumbers: false,
              showListBullets: false,
              showClearFormat: false,
              showBoldButton: false,
              showFontSize: false,
              showItalicButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showListCheck: false,
              showSubscript: false,
              showSuperscript: false,
            ),
            Expanded(
              child: Container(
                color: Colors.white, //CupertinoColors.systemGroupedBackground,
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
