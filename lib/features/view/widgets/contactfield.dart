import 'package:contact_codegeneration/features/model/contactmodel.dart';
import 'package:contact_codegeneration/features/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactField extends ConsumerWidget {
  const ContactField(
      {super.key,
      required this.namecontroller,
      required this.phonecontroller,
      required this.isEdit,
      this.index});
  final TextEditingController namecontroller;
  final TextEditingController phonecontroller;
  final bool isEdit;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: isEdit
                ? const Text(
                    "Edit Contact",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  )
                : const Text(
                    "Add Contact",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: namecontroller,
            decoration: const InputDecoration(
              hintText: "Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: phonecontroller,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone_android_outlined),
              hintText: "Phone",
              border: OutlineInputBorder(),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (isEdit) {
                    ref.read(contactProviderProvider.notifier).edit(
                        ContactModel(
                            name: namecontroller.text,
                            phone: phonecontroller.text),
                        index);
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  } else {
                    if (namecontroller.text.isNotEmpty &&
                        phonecontroller.text.isNotEmpty) {
                      ref.read(contactProviderProvider.notifier).additem(
                          ContactModel(
                              name: namecontroller.text,
                              phone: phonecontroller.text));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Name and phone cannotbe empty")));
                    }

                    namecontroller.clear();
                    phonecontroller.clear();
                  }
                },
                child: isEdit ? const Text("Edit") : const Text("Add")),
          ),
        ],
      ),
    );
  }
}
