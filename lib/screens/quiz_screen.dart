import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentQuestion = quizProvider
            .quizData?.questions?[quizProvider.currentQuestionIndex];
        final isFirstQuestion = quizProvider.currentQuestionIndex == 0;
        final hasSelectedAnswer =
            quizProvider.selectedAnswers[quizProvider.currentQuestionIndex] !=
                -1;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9C27B0),
                Color(0xFFE91E63),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: !isFirstQuestion
                    ? Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            quizProvider.currentQuestionIndex--;
                            quizProvider.notifyListeners();
                          },
                        ),
                      )
                    : null,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Question ${quizProvider.currentQuestionIndex + 1} out of ${quizProvider.quizData?.questions?.length}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        currentQuestion?.description ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: currentQuestion?.options?.length ?? 0,
                          itemBuilder: (context, index) {
                            final option = currentQuestion?.options?[index];
                            final isSelected = quizProvider.selectedAnswers[
                                    quizProvider.currentQuestionIndex] ==
                                index;

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.black87
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      quizProvider.selectAnswer(
                                        quizProvider.currentQuestionIndex,
                                        index,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        option?.description ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: hasSelectedAnswer ? 56 : 0,
                        child: hasSelectedAnswer
                            ? Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (quizProvider.currentQuestionIndex <
                                        (quizProvider.quizData?.questions
                                                    ?.length ??
                                                0) -
                                            1) {
                                      quizProvider.currentQuestionIndex++;
                                      quizProvider.notifyListeners();
                                    } else {
                                      quizProvider.calculateScore();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    quizProvider.currentQuestionIndex ==
                                            (quizProvider.quizData?.questions
                                                        ?.length ??
                                                    0) -
                                                1
                                        ? 'Finish'
                                        : 'Next',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF9C27B0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
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
