import 'package:qcm/question.dart';
import 'dart:math';

class ServerQuestion {
  int indexQuestion = 0;

  // Liste de questions
  List<Question> questions = [
    Question(
        intitule: "Quelle est la capitale de la France ?",
        options: ["Douala", "Paris", "Québec"],
        indexbonnereponse: 1),
    Question(
        intitule: "La monnaie du Japon est ?",
        options: ["Yen", "Dollar", "Euro"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la capitale du Cameroun ?",
        options: ["Douala", "Yaoundé", "Bamenda"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quelle est la monnaie utilisée en France ?",
        options: ["Euro", "Livre", "Franc"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la plus grande planète du système solaire ?",
        options: ["Terre", "Jupiter", "Mars"],
        indexbonnereponse: 1),
    Question(
        intitule: "Combien de continents y a-t-il sur Terre ?",
        options: ["5", "6", "7"],
        indexbonnereponse: 2),
    Question(
        intitule: "Quel est le plus grand océan du monde ?",
        options: ["Atlantique", "Pacifique", "Indien"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quelle est la capitale du Canada ?",
        options: ["Toronto", "Ottawa", "Vancouver"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quel est l'élément chimique représenté par 'O' ?",
        options: ["Or", "Oxygène", "Osmium"],
        indexbonnereponse: 1),
    Question(
        intitule: "En quelle année a eu lieu la Révolution française ?",
        options: ["1789", "1848", "1914"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quel est le plus grand désert du monde ?",
        options: ["Désert du Sahara", "Désert d'Atacama", "Antarctique"],
        indexbonnereponse: 2),
    Question(
        intitule: "Qui a peint la Joconde ?",
        options: ["Picasso", "Leonard de Vinci", "Michel-Ange"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quelle est la langue officielle du Brésil ?",
        options: ["Espagnol", "Français", "Portugais"],
        indexbonnereponse: 2),
    Question(
        intitule: "Quel est le symbole chimique de l'eau ?",
        options: ["H2O", "CO2", "O2"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quel pays est connu comme le Pays du Soleil Levant ?",
        options: ["Chine", "Japon", "Corée"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quelle est la capitale de l'Allemagne ?",
        options: ["Munich", "Berlin", "Francfort"],
        indexbonnereponse: 1),
    Question(
        intitule: "Qui a découvert l'Amérique en 1492 ?",
        options: ["Christophe Colomb", "Vasco de Gama", "Marco Polo"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la couleur du sang dans le corps humain ?",
        options: ["Bleu", "Rouge", "Vert"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quel est le plus grand mammifère marin ?",
        options: ["Orque", "Baleine bleue", "Requin blanc"],
        indexbonnereponse: 1),
    Question(
        intitule: "Combien de jours y a-t-il dans une année bissextile ?",
        options: ["364", "365", "366"],
        indexbonnereponse: 2),
    Question(
        intitule: "Quel est le plus petit pays du monde ?",
        options: ["Vatican", "Monaco", "Liechtenstein"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la capitale de l'Italie ?",
        options: ["Rome", "Milan", "Venise"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la durée d'une décennie ?",
        options: ["5 ans", "10 ans", "15 ans"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quel est l'animal le plus rapide sur terre ?",
        options: ["Guepard", "Antilope", "Cheval"],
        indexbonnereponse: 0),
    Question(
        intitule: "Quelle est la capitale de l'Australie ?",
        options: ["Sydney", "Melbourne", "Canberra"],
        indexbonnereponse: 2),
    Question(
        intitule: "Quelle est la valeur de Pi approximée à deux décimales ?",
        options: ["3.12", "3.14", "3.16"],
        indexbonnereponse: 1),
    Question(
        intitule: "Combien de couleurs y a-t-il dans un arc-en-ciel ?",
        options: ["6", "7", "8"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quel est le nom du premier homme à marcher sur la Lune ?",
        options: ["Buzz Aldrin", "Neil Armstrong", "Yuri Gagarin"],
        indexbonnereponse: 1),
    Question(
        intitule: "Quel est le fleuve qui traverse l'Égypte ?",
        options: ["Nil", "Amazone", "Mississippi"],
        indexbonnereponse: 0),
    Question(
        intitule: "Combien y a-t-il de planètes dans le système solaire ?",
        options: ["7", "8", "9"],
        indexbonnereponse: 1),
  ];

  // Récupérer l'intitulé de la question actuelle
  String getIntitule() {
    return questions[indexQuestion].intitule;
  }

  // Récupérer les options de la question actuelle
  List<String> getOptions() {
    return questions[indexQuestion].options;
  }

  // Vérifier si l'utilisateur a donné la bonne réponse
  bool isBonneReponse(int indexReponse) {
    return indexReponse == questions[indexQuestion].indexbonnereponse;
  }

  // Passer à la question suivante
  void prochaineQuestion() {
    if (indexQuestion < questions.length - 1) {
      indexQuestion++;
    }
  }

  // Vérifier si le quiz est terminé
  bool isQuizTermine() {
    return indexQuestion >= questions.length - 1;
  }

  // Fonction pour mélanger les questions
  void shuffleQuestions() {
    questions.shuffle(Random());
  }

  void resetQuestions() {
    shuffleQuestions(); // Remélanger les questions
    indexQuestion = 0; // Réinitialiser l'index des questions
  }
}
