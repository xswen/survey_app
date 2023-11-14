import 'package:survey_app/barrels/page_imports_barrel.dart';


class DeleteCheckPage extends StatelessWidget {
  const DeleteCheckPage(
      {super.key,
      required this.object,
      required this.content,
      required this.contOnPress});
  final String object;
  final String content;
  final VoidCallback contOnPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("Delete $object"),
      endDrawer: const DrawerMenu(),
      body: Column(
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 24),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            children: [
              ElevatedButton(
                  onPressed: () => context.pop(), child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: contOnPress, child: const Text("Continue")),
            ],

          )
        ],
      ),
    );
  }
}
