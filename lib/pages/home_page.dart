import 'package:ai_eng_tutor/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController promprController = TextEditingController();
  static const apiKey = "AIzaSyAFfUpo8F1l60rV_ZaSBZRBaBGXcz3It50";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  ScrollController controller = ScrollController();

  final List<ModelMessage> prompt = [];

  Future<void> sendMessage() async {
    final message = promprController.text;
    // for prompt
    setState(() {
      promprController.clear();
      prompt.add(
        ModelMessage(
          isPrompt: true,
          message: message,
          time: DateTime.now(),
        ),
      );
    });_scrollToBottom();
    // for respond
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(
        ModelMessage(
          isPrompt: false,
          message: response.text ?? "",
          time: DateTime.now(),
        ),
      );
     _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text("AI Tutor",style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.w600
        ),),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                controller: controller,
                  itemCount: prompt.length,
                  itemBuilder: (context, index) {
                    final message = prompt[index];
                    return UserPrompt(
                      isPrompt: message.isPrompt,
                      message: message.message,
                      date: DateFormat('hh:mm a').format(
                        message.time,
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(width: 5,),
                Icon(Icons.image_outlined),
                SizedBox(width: 5,),
                Icon(Icons.file_copy_outlined),
                SizedBox(width: 5,),
                Expanded(
                  flex: 20,
                  child: TextField(
                    controller: promprController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Ask anything"),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: const CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container UserPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isPrompt ?const Radius.circular(20):Radius.zero,
          bottomRight: isPrompt? Radius.zero:const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // for prompt and respond
          Text(
            message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
          // for prompt and respond time
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
