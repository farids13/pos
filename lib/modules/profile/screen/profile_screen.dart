import 'package:cashier_app/data/api/google/google_sign_in_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lainnya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all()),
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bengkel Cashier"),
                      Text("someone@example.com"),
                      Text("+62895358496255"),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              )),
          const ListTile(
            title: Text('Akun'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('Informasi Usaha'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('API Key Xendit'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ExpansionTile(
            title: Text('Perangkat Tambahan'),
            children: [
              ListTile(
                title: Text('Printer'),
                subtitle: Text('Belum Terhubung'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Atur Struk'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          const ListTile(
            title: Text('Info Lainnya'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('Kebijakan Privasi'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const ListTile(
            title: Text('Beri Rating'),
            subtitle: Text('v1.0.0'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: const Text(
              'Keluar',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              GoogleSignInAPI.handleSignOut();
              context.pushReplacement('/login');
            },
          ),
        ],
      ),
    );
  }
}
