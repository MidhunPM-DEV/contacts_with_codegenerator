import 'package:contact_codegeneration/features/model/contactmodel.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_provider.g.dart';

@riverpod
class ContactProvider extends _$ContactProvider {
  @override
  List<ContactModel> build() {
    return [];
  }

  void additem(ContactModel contact) {
    state = [contact, ...state];
  }

  void delete(index) {
    final contacts = state;
    contacts.removeAt(index);
    state = List.from(contacts);
  }

  void edit(newContact, index) {
    final contact = state;
    contact[index] = newContact;
    state = List.from(contact);
  }
}
