import 'package:flutter/material.dart';
import 'ServerQuestion.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ServerQuestion serverQuestion = ServerQuestion();
  int? selectedOptionIndex;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int ignoredAnswers = 0;

  @override
  void initState() {
    super.initState();
    serverQuestion.shuffleQuestions();
  }

  void resetQuiz() {
    setState(() {
      correctAnswers = 0;
      wrongAnswers = 0;
      ignoredAnswers = 0;
      selectedOptionIndex = null;
      serverQuestion.resetQuestions();
    });
  }

  void showSummary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          correctAnswers: correctAnswers,
          wrongAnswers: wrongAnswers,
          ignoredAnswers: ignoredAnswers,
        ),
      ),
    ).then((_) => resetQuiz());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Junior Quiz"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serverQuestion.getIntitule(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (38 * 2), // Rapport largeur/hauteur
                ),
                itemCount: serverQuestion.getOptions().length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedOptionIndex == index
                            ? Colors.blueAccent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: selectedOptionIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          serverQuestion.getOptions()[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedOptionIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ignoredAnswers++;
                      serverQuestion.prochaineQuestion();
                      selectedOptionIndex = null;
                    });
                  },
                  child: const Text("Ignoré"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedOptionIndex != null) {
                      bool isCorrect =
                          serverQuestion.isBonneReponse(selectedOptionIndex!);
                      setState(() {
                        if (isCorrect) {
                          correctAnswers++;
                        } else {
                          wrongAnswers++;
                        }
                        serverQuestion.prochaineQuestion();
                        selectedOptionIndex = null;
                      });

                      if (serverQuestion.isQuizTermine()) {
                        showSummary(context);
                      }
                    }
                  },
                  child: const Text("Valider"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => showSummary(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text("Terminer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int ignoredAnswers;

  const SummaryScreen({
    Key? key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.ignoredAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résumé du Quiz"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Score Final",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildSummaryTile("Correct", correctAnswers, Colors.green),
                  _buildSummaryTile("Incorrect", wrongAnswers, Colors.red),
                  _buildSummaryTile("Ignoré", ignoredAnswers, Colors.orange),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Recommencer"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, int count, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
