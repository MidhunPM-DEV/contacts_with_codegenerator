import 'package:contact_codegeneration/features/providers/contact_provider.dart';
import 'package:contact_codegeneration/features/view/widgets/contactfield.dart';
import 'package:contact_codegeneration/features/view/widgets/header_widger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  final name = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HeaderWidget(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: ContactField(
                        namecontroller: name,
                        phonecontroller: phone,
                        isEdit: false,
                      ),
                    ),
                  ));
        },
      ),
      body: ListView.builder(
          itemCount: ref.watch(contactProviderProvider).length,
          itemBuilder: (context, index) => Card(
                child: GestureDetector(
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => popUp(ref, index, context),
                  ),
                  child: ListTile(
                    title: Text(ref.watch(contactProviderProvider)[index].name),
                    subtitle:
                        Text(ref.watch(contactProviderProvider)[index].phone),
                  ),
                ),
              )),
    );
  }

  AlertDialog popUp(WidgetRef ref, int index, context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                name.text = ref.watch(contactProviderProvider)[index].name;
                phone.text = ref.watch(contactProviderProvider)[index].phone;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: ContactField(
                        namecontroller: name,
                        phonecontroller: phone,
                        isEdit: true,
                        index: index,
                      ),
                    ),
                  ),
                );
              },
              child: const Text("Edit")),
          TextButton(
              onPressed: () {
                ref.watch(contactProviderProvider.notifier).delete(index);
                Navigator.pop(context);
              },
              child: const Text("Delete"))
        ],
      ),
    );
  }
}
