import 'package:flutter/material.dart';

class LanguageDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 367,
                      height: 75,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CC4C4),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "LANGUAGE",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "ONLY ENGLISH CURRENTLY SUPPORTED",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Το κουμπί X
                Positioned(
                  top: 306,
                  right: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 25,
                      ),

                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
