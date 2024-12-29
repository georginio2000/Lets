import 'package:flutter/material.dart';
import '../widgets/all_Lets/lets_add.dart';
import '../widgets/register/register_join_submit_create_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController numParticipantsController = TextEditingController();
  final List<String> tags = ['Example', 'Music', 'Sports', 'Art', 'Travel', 'Food'];
  final List<String> selectedTags = [];

  String? visibility;
  String? skillLevel;
  DateTime? selectedDateTime;
  String? location;

  void _submitActivity() {
    print('Title: ${titleController.text}');
    print('Visibility: $visibility');
    print('Skill Level: $skillLevel');
    print('Date & Time: $selectedDateTime');
    print('Location: $location');
    print('Number of Participants: ${numParticipantsController.text}');
    print('Description: ${descriptionController.text}');
    print('Tags: $selectedTags');
  }

  Future<void> _selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Widget _styledContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA),
        border: Border.all(color: Colors.black, width: 1), // Add black border
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }


  Widget _styledRoundContainer({required Widget child}) {
    return Container(
      height:40,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E1DA),
        border: Border.all(color: Colors.black, width: 1), // Add black border
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _chipStyle(String tag) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        color: const Color(0xFF468585),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1), // Add black border
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedTags.remove(tag);
              });
            },
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CC4C4),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: LetsAddWidget(),
              ),
              _styledContainer(
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "ADD A TITLE...",
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _styledContainer(
                      child: DropdownButtonFormField<String>(
                        value: visibility,
                        decoration: const InputDecoration(
                          hintText: "VISIBILITY",
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        items: ['Public', 'Private']
                            .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            visibility = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _styledContainer(
                      child: DropdownButtonFormField<String>(
                        value: skillLevel,
                        decoration: const InputDecoration(
                          hintText: "SKILL LEVEL",
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        items: ['Beginner', 'Intermediate', 'Advanced']
                            .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            skillLevel = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _styledRoundContainer(
                      child: ElevatedButton.icon(
                        onPressed: _selectDateTime,
                        icon: const Icon(Icons.access_time,color: Colors.black),
                        label: Text(selectedDateTime == null
                            ? "TIME/DATE"
                            : "${selectedDateTime!.toLocal()}".split(' ')[0]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _styledRoundContainer(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            location = "1234";
                          });
                        },
                        icon: SvgPicture.asset(
                          'assets/SMALL_MAP_ICON.svg', // Path to your SVG file
                          height: 15, // Set the height
                          color: Colors.black, // Set the color (if applicable)
                        ),
                        label: const Text("LOCATION"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 26),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "NUMBER OF PARTICIPANTS:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "LEAVE EMPTY IF NO PREFERENCE",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Container(
                    height: 50, // Height for the container
                    width: 60, // Fixed width for the container
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E1DA),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(2), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: numParticipantsController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "-", // Placeholder for the field
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _styledContainer(
                child: TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "DESCRIPTION...",
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _styledContainer(
                child: DropdownButtonFormField<String>(
                  hint: const Text("CHOOSE TAGS"),
                  items: tags
                      .map((tag) => DropdownMenuItem<String>(
                    value: tag,
                    child: Text(tag),
                  ))
                      .toList(),
                  onChanged: (tag) {
                    if (tag != null && !selectedTags.contains(tag)) {
                      setState(() {
                        selectedTags.add(tag);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: selectedTags.map((tag) => _chipStyle(tag)).toList(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegisterJoinSubmitCreateButton(
                    labelText: "BACK",
                    color: const Color(0xFFB47150),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 30),
                  RegisterJoinSubmitCreateButton(
                    labelText: "CREATE",
                    color: const Color(0xFF50B498),
                    onPressed: _submitActivity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
