import 'package:flutter/material.dart';

class FAQDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 367,
                decoration: BoxDecoration(
                  color: const Color(0xFF9CC4C4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FREQUENTLY ASKED QUESTIONS",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const FAQItem(
                      question: "1. Τι είναι το LET'S;",
                      answer: "Το LET'S είναι μια εφαρμογή για την οργάνωση και την ανακάλυψη δραστηριοτήτων με άλλους χρήστες.",
                    ),
                    const SizedBox(height: 10),
                    const FAQItem(
                      question: "2. Πώς μπορώ να δημιουργήσω ένα activity;",
                      answer: "Μπορείς να πατήσεις το κουμπί 'Create Activity' στη σελίδα δραστηριοτήτων και να συμπληρώσεις τις πληροφορίες.",
                    ),
                    const SizedBox(height: 10),
                    const FAQItem(
                      question: "3. Πώς μπορώ να δω τις δραστηριότητες μου;",
                      answer: "Στη σελίδα 'My Activities', θα δεις όλες τις δραστηριότητες που έχεις δημιουργήσει ή συμμετέχεις.",
                    ),
                    const SizedBox(height: 10),
                    const FAQItem(
                      question: "4. Μπορώ να προσθέσω φίλους στην εφαρμογή;",
                      answer: "Ναι, μπορείς να προσθέσεις φίλους χρησιμοποιώντας το email τους ή το username τους.",
                    ),
                    const SizedBox(height: 10),
                    const FAQItem(
                      question: "5. Είναι ασφαλή τα δεδομένα μου;",
                      answer: "Ναι, όλα τα δεδομένα αποθηκεύονται με ασφάλεια στο Firebase και είναι προσβάσιμα μόνο από εσένα.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          answer,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
