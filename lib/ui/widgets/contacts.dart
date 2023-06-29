import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: const Text('your.email@example.com'),
            onTap: () {
              // TODO: Handle email tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('LinkedIn'),
            subtitle: const Text('linkedin.com/in/your-profile'),
            onTap: () {
              // TODO: Handle LinkedIn tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('GitHub'),
            subtitle: const Text('github.com/your-username'),
            onTap: () {
              // TODO: Handle GitHub tap
            },
          ),
        ],
      ),
    );
  }
}
