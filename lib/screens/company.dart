import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Details"),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Name"),
              subtitle: Text("Geeksynergy Technologies Pvt Ltd"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text("Company Email:NA"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: Text("Company Phone:XXXXXXXX09"),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text("Address"),
              subtitle: Text("Company Address:Sanjaynagar, Bengaluru-56"),
            ),
            
            ListTile(
              leading: Icon(Icons.description),
              title: Text("Description"),
              subtitle: Text("Company Description-NA"),
            ),
          ],
        ),
      ),
    );
  }
}
