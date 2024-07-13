import '../../domain/entities/prompt.dart';

class PromptModel extends Prompt {
  PromptModel(super.content);

  factory PromptModel.generateRecipe() {
    return PromptModel("");
  }
}
