import 'package:food_app/Services/database.dart';
import 'package:food_app/Models/foodname.dart';

class ContactOperations {
  ContactOperations contactOperations;

  final dbProvider = DatabaseRepository.instance;

  createContact(Contact contact) async {
    final db = await dbProvider.database;
    db.insert('contact', contact.toMap());
    print('contact inserted');
  }

  updateContact(Contact contact) async {
    final db = await dbProvider.database;
    db.update('contact', contact.toMap(),
        where: "contactId=?", whereArgs: [contact.id]);
  }

  deleteContact(Contact contact) async {
    final db = await dbProvider.database;
    await db.delete('contact', where: 'contactId=?', whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query('contact');
    List<Contact> contacts =
        allRows.map((contact) => Contact.fromMap(contact)).toList();
    return contacts;
  }

  // Future<List<Contact>> getAllContactsByCategory(Category category) async {
  //   final db = await dbProvider.database;
  //   List<Map<String, dynamic>> allRows = await db.rawQuery('''
  //   SELECT * FROM contact
  //   WHERE contact.FK_contact_category = ${category.id}
  //   ''');
  //   List<Contact> contacts =
  //   allRows.map((contact) => Contact.fromMap(contact)).toList();
  //   return contacts;
  // }

  Future<List<Contact>> searchContacts(String keyword) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query('contact',
        where: 'contactName LIKE ?', whereArgs: ['%$keyword%']);
    List<Contact> contacts =
        allRows.map((contact) => Contact.fromMap(contact)).toList();
    return contacts;
  }
}
