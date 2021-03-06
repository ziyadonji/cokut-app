import 'package:cokut/infrastructure/auth.dart';
import 'package:cokut/infrastructure/repositories/user_repo.dart';
import 'package:cokut/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  const Settings();
  @override
  Widget build(BuildContext context) {
    var user = context.repository<UserRepository>().user ??
        User(name: "Name", email: "email", phone: "7034320441");
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.green,
                size: 60,
              ),
              title: Text(
                user.name ?? "Name",
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(user.email ?? "mail"),
              trailing: IconButton(
                onPressed: authService.signOut,
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.red,
                ),
              ),
            ),
            buildSettingsItemTile("Address", Icons.home),
            buildSettingsItemTile("Payments", Icons.payment),
            buildSettingsItemTile("Orders", Icons.event_note),
            buildSettingsItemTile("Refferals", Icons.card_giftcard),
            buildSettingsItemTile("Settings", Icons.settings),
            Container(
              color: Colors.grey[100],
              height: 30,
            ),
            buildSettingsItemTile("Terms of Service", Icons.import_contacts),
            buildSettingsItemTile("Rate the app", Icons.star),
            buildSettingsItemTile("About", Icons.subject),
          ],
        ),
      ),
    );
  }

  ListTile buildSettingsItemTile(String content, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        content,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
