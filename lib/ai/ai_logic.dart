import 'dart:developer';

import 'package:mistralai_dart/mistralai_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyAquationAiLogic {
  String? prompt;
  List<double> sensorValues;

  MyAquationAiLogic({this.prompt, required this.sensorValues});

  // Initialize the Mistral client using your secure key
  late final _client = MistralClient(
    config: MistralConfig(
      authProvider: ApiKeyProvider(dotenv.env['MISTRAL_API_KEY'] ?? ''),
    ),
  );

  String get appendOnPrompt =>
      """ 
    Act as a friendly, helpful aquaculture expert having a casual, one-on-one chat with a local crayfish farmer. 
    Here are the current water sensor readings from my pond: $sensorValues.
    
    In a natural, everyday conversational tone, please tell me:
    1. What do these readings mean, and what is likely happening in my pond right now?
    2. What easy, step-by-step actions should I take immediately to keep my crayfish healthy and prevent any from dying?
    3. What are some simple things I can do to grow more crayfish and make a better profit down the line?

    Strict Rules for this conversation:
    - Summarize everything.
    - Highlight the actual and necessary suggestion you want the farmer to make base on the serson values.
    - Limit your response to only few senteces, but make it more relevant.
    - If the sensor value seems just a normal value (not dangerous or a potential threat to crayfishes just ignore it). And provide a 
      desclaimer that you are excluding the sensors with a normal value.
    - Speak directly to me like we are standing next to the pond chatting face-to-face.
    - Keep it very simple and easy to comprehend. Avoid complicated scientific jargon, complex charts, or rigid markdown tables. 
    - Keep your advice highly practical for a non-technical person.
    - Do NOT ask any follow-up questions at the end of your response.
  """;

  // String get appendOnPrompt => "What problem does the crayfish farm have?";

  Future<String> getResponse() async {
    final finalPrompt = prompt ?? appendOnPrompt;

    try {
      final response = await _client.chat.create(
        request: ChatCompletionRequest(
          model: 'mistral-small-latest',
          messages: [ChatMessage.user(finalPrompt)],
        ),
      );

      // Mistral's response structure is slightly deeper than Gemini's
      // return response.choices.first.message.content ?? "No response received.";
      String finalizedResponse =
          response.choices.first.message?.content.toString() ??
          "No response received.";
      return finalizedResponse
          .substring(0, finalizedResponse.length - 1)
          .replaceFirst("MessageTextContent(", "");
    } catch (e) {
      log("Error generating response: $e");
      return "Error generating response: $e";
    }
  }
}
