class FeedbackModel {

  final int rating;
  final String comment;

  FeedbackModel({required this.rating, required this.comment});

  toJson(){
    return{

    "rating": rating,
    "comment": comment,
    };
  }
}
