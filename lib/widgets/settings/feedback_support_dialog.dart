import 'package:flutter/material.dart';

class FeedbackSupportDialog {
  static void show(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9CC4C4), // Ανοιχτό γκρι φόντο
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 367, // Σταθερό πλάτος
                      minHeight: 200, // Ελάχιστο ύψος
                      maxHeight: 400, // Μέγιστο ύψος για αποφυγή overflow
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "FEEDBACK AND SUPPORT",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(); // Κλείσιμο του Dialog
                              },
                              child: const Icon(Icons.close, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Write your feedback (max 100 characters):",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 300, // Περιορισμός ύψους για το TextField
                              ),
                              child: TextField(
                                controller: feedbackController,
                                maxLength: 100, // Μέγιστο 100 χαρακτήρες
                                maxLines: null, // Απεριόριστες γραμμές
                                onChanged: (text) {
                                  setState(() {}); // Ανανεώνει το ύψος
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white, // Λευκό φόντο για το TextField
                                  hintText: "Type your feedback here...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  counterText: '', // Δεν εμφανίζει μετρητή χαρακτήρων
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Κλείνει το παράθυρο και εμφανίζει μήνυμα
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Thank you very much!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF50B498), // Πράσινο χρώμα κουμπιού
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "SEND",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
