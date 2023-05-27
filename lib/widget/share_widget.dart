import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

shareBottomSheet(BuildContext context, String text) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: text)).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Link copied to clipboard")));
                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 24),
                      const Icon(Icons.link),
                      const SizedBox(height: 12),
                      const Text(
                        "Copy link",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 24),
                      const Icon(Icons.messenger),
                      const SizedBox(height: 12),
                      const Text(
                        "Messenger",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
