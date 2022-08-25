class QuestionModel {
  String? question;
  Map<String, int>? answers;
  //int? groupValue


  QuestionModel({required this.question, required this.answers ,});
}

List<QuestionModel> questions = [
  QuestionModel(
    question: "A well-known shrubby plant that many take as a hot drink, but few know that this plant contains a large amount of vitamin C, up to 1.3 grams per hundred grams of it. What is this plant",
    answers: {
      "Roselle" : 1,
      "buckthorn" : 2,
      "parsley" : 3,
    },
    
  ),
  QuestionModel(
    question: "90% of the foods that people eat come from : ",
    answers: {
      "50" : 3,
      "40" : 2,
      "30" : 1,
    },
  ),
  QuestionModel(
    question: "A plant that contains a natural chemical that can make people feel happy. What is it?",
    answers: {
      "apple" : 2,
      "banana" : 1,
      "Strawberry" : 3,
    },
  ),
  QuestionModel(
    question: "What forests produce half of the world's oxygen supply ? ",
    answers: {
      "Amazon forest" : 1,
      "second forest" : 2,
      "thire forest" : 3,
    },
  ),
  QuestionModel(
    question: "What is the only fruit that bears its seeds on the outside ? ",
    answers: {
      "apple" : 3,
      "banana" : 2,
      "Strawberry" : 1,
    },
  ),
  QuestionModel(
    question: "A well-known shrubby plant that many take as a hot drink, but few know that this plant contains a large amount of vitamin C, up to 1.3 grams per hundred grams of it. What is this plant",
    answers: {
      "Roselle" : 1,
      "buckthorn" : 2,
      "parsley" : 3,
    },
  ),
  QuestionModel(
    question: "90% of the foods that people eat come from : ",
    answers: {
      "50" : 3,
      "40" : 2,
      "30" : 1,
    },
  ),
  QuestionModel(
    question: "A plant that contains a natural chemical that can make people feel happy. What is it?",
    answers: {
      "apple" : 2,
      "banana" : 1,
      "Strawberry" : 3,
    },
  ),
  QuestionModel(
    question: "What forests produce half of the world's oxygen supply ? ",
    answers: {
      "Amazon forest" : 1,
      "second forest" : 2,
      "thire forest" : 3,
    },
  ),
  QuestionModel(
    question: "What is the only fruit that bears its seeds on the outside ? ",
    answers: {
      "apple" : 3,
      "banana" : 2,
      "Strawberry" : 1,
    },
  ),
];
