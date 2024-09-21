import 'package:quiz_app/helper/api.dart';
import 'package:quiz_app/models/question_model.dart';

class GetQuizService {
  Future<List<QuestionModel>> getQuizService({required String category}) async {
    List<dynamic> data = await Api().get(
        url: 'https://quizapi.io/api/v1/questions',
        category: category,
        token:
            "eyJpdiI6ImFFN0NmbEJhTlBlQk5USTlvWUNcL1lRPT0iLCJ2YWx1ZSI6IkhaOU5EK3lvN1owQVFFejdVQUJkRVhaYXVhenh1K0lyZ1JZTHJNNVFwaG1udStUblJ4WTVPbm5aeUp0dmpqSTBSMUJ6TTZVOXg1Nkl2eVF2QkYyR0xybHV1MHZuQWx2NHNaVUkrQkFGZUpLaVF2UCtJZG51U2I2QmFqcEEzYWVpIiwibWFjIjoiMGVlMDBkNzBjMjI1OTg4OTY1NGRkNTFiNDdhZWNhY2M5ZmU4MTQ2YTU0MzFmZTI1NzE1NmNhOTQ3Y2Y2ZGRhYyJ9");
    List<QuestionModel> questionsList = [];

    for (var item in data) {
      questionsList.add(QuestionModel.fromJson(item));
    }
    
    return questionsList;
  }
}
