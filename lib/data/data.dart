import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:kindainternship/screens/home_screen.dart';
import 'package:kindainternship/screens/login_screen.dart';
import 'package:kindainternship/screens/my_subjects.dart';

dynamic user = '';
String tokenString;
String refreshTokenString;
Function logOutInData = () => print('Log Out In Data');
Function addTokenInData = () => print('Add Token In Data');

Map<String, String> subjectMap = {};
List<String> subjectNameList = [];

class Subjects {
  Future getData() async {
    http.Response response =
        await http.get("http://api.study-share.info//api/v1/all-subject/");
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
//      print('subjects success');
      return jsonDecode(data);
    } else {
      print('subjects ' + response.statusCode.toString());
    }
  }
}

class MySubjectsData {
  BuildContext context;
  MySubjectsData({this.context});
  Future getData() async {
    http.Response response = await http
        .get("http://api.study-share.info/api/v1/subject/follow/all", headers: {
      'Authorization': 'Bearer $tokenString',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
//      print('subjects success');
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response = await http.get(
          "http://api.study-share.info/api/v1/subject/follow/all",
          headers: {
            'Authorization': 'Bearer $tokenString',
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
//      print('subjects success');
        return jsonDecode(data);
      }
//      logOutInData();
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print('MySubjectsData ' + response.statusCode.toString());
    }
  }
}

Future<List<Subject>> fetchSubject(BuildContext context) async {
  final response = await http
      .get("http://api.study-share.info/api/v1/subject/follow/all", headers: {
    'Authorization': 'Bearer $tokenString',
  });

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    var jsonData = jsonDecode(response.body);
    List subjectsList = jsonData['data'];
    List<Subject> subjects = [];
    for (var subject in subjectsList) {
      Subject s = Subject(
          id: subject['id'],
          name: subject['name'],
          userFollowed: subject['user_followed']);
      subjects.add(s);
    }
    return subjects;
  } else if (response.statusCode == 401) {
//    logOutInData();
    await Refresh().refresh();
    final response = await http
        .get("http://api.study-share.info/api/v1/subject/follow/all", headers: {
      'Authorization': 'Bearer $tokenString',
    });

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      var jsonData = jsonDecode(response.body);
      List subjectsList = jsonData['data'];
      List<Subject> subjects = [];
      for (var subject in subjectsList) {
        Subject s = Subject(
            id: subject['id'],
            name: subject['name'],
            userFollowed: subject['user_followed']);
        subjects.add(s);
      }
      return subjects;
    }
//    Navigator.pushReplacementNamed(context, LoginScreen.id);
    throw Exception('MySubjectsData ' + response.statusCode.toString());
  } else {
    throw Exception('MySubjectsData ' + response.statusCode.toString());
  }
}

class SubjectFollow {
  BuildContext context;
  String subject;
  SubjectFollow({this.context, this.subject});
  Future getData() async {
    http.Response response = await http.post(
        "http://api.study-share.info/api/v1/subject/follow/",
        headers: {'Authorization': 'Bearer $tokenString'},
        body: {'subject': subjectMap[subject]});
    if (response.statusCode == 446 || response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.post(
          "http://api.study-share.info/api/v1/subject/follow/",
          headers: {'Authorization': 'Bearer $tokenString'},
          body: {'subject': subjectMap[subject]});
      if (response.statusCode == 446 || response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print('SubjectFollow ' + response.statusCode.toString());
    }
  }
}

class SubjectUnfollow {
  BuildContext context;
  String subject;
  SubjectUnfollow({this.context, this.subject});
  Future getData() async {
    http.Response response = await http.delete(
        "http://api.study-share.info/api/v1/subject/unfollow/${subjectMap[subject]}",
        headers: {'Authorization': 'Bearer $tokenString'});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.delete(
          "http://api.study-share.info/api/v1/subject/unfollow/${subjectMap[subject]}",
          headers: {'Authorization': 'Bearer $tokenString'});
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print('SubjectUnfollow ' + response.statusCode.toString());
    }
  }
}

class LeadersData {
  BuildContext context;
  LeadersData({this.context});
  Future getData() async {
    http.Response response =
        await http.get("http://api.study-share.info/api/v1/leaders/", headers: {
      'Authorization': 'Bearer $tokenString',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http
          .get("http://api.study-share.info/api/v1/leaders/", headers: {
        'Authorization': 'Bearer $tokenString',
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class Leader {
  BuildContext context;
  Leader({this.context});
  Future getData() async {
    http.Response response =
        await http.get("http://api.study-share.info//api/v1/userqa/", headers: {
      'Authorization': 'Bearer $tokenString',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http
          .get("http://api.study-share.info//api/v1/userqa/", headers: {
        'Authorization': 'Bearer $tokenString',
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class Like {
  int id;
  String value;
  BuildContext context;
  Like({@required this.id, @required this.value, this.context});
  Future like() async {
    http.Response response = await http.post(
        "http://api.study-share.info//api/v1/question/vote/$id",
        headers: {
          'Authorization': 'Bearer $tokenString',
        },
        body: {
          'value': value,
        });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      return jsonDecode(response.body);
      return response;
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.post(
          "http://api.study-share.info//api/v1/question/vote/$id",
          headers: {
            'Authorization': 'Bearer $tokenString',
          },
          body: {
            'value': value,
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
//      return jsonDecode(response.body);
        return response;
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class AnswerLike {
  int id;
  String value;
  String isAuthor;
  BuildContext context;
  AnswerLike(
      {@required this.id, @required this.value, this.isAuthor, this.context});
  Future like() async {
    http.Response response = await http
        .post("http://api.study-share.info//api/v1/answer/vote/$id", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'value': value,
      'is_author': isAuthor,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      return jsonDecode(response.body);
      return response;
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.post(
          "http://api.study-share.info//api/v1/answer/vote/$id",
          headers: {
            'Authorization': 'Bearer $tokenString',
          },
          body: {
            'value': value,
            'is_author': isAuthor,
          });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
//      return jsonDecode(response.body);
        return response;
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class POSTQuestion {
  String title;
  String subject;
  String description;
  String image;
  BuildContext context;
  POSTQuestion(
      {this.title, this.subject, this.description, this.image, this.context});
  Future postQuestion() async {
//    var jsonString = {
////      'id': 7777.toString(),
//      'title': title,
//      //      'username': loginData['data']['username'],
////      "subject": {
////        "id": 5.toString(),
////        "author": 4.toString(),
////        "name": "Chemistry",
////        "rating": 3.toString()
////      },
//      "subject": 2.toString(),
//      'description': description.toString(),
//      'Files': image,
////      "user": {
////        "id": loginData['data']['id'].toString(),
////        "email": loginData['data']['email'],
////        "username": loginData['data']['username']
////      },
////      "image": [
////        {
////          "path":
////              "/media/images/72115aaf75979cb573fe58517481cd43--facebook-instagram-tour-eiffel_5MMx6Mv.jpg"
////        }
////      ],
////      "answers": [],
//    };

    try {
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl =
          'http://api.study-share.info//api/v1/question/create/';

      if (tokenString != null) {
        dioRequest.options.headers = {
          'Authorization': 'Bearer $tokenString',
//      'Content-Type': 'application/x-www-form-urlencoded'
        };
      } else if (user['access'] != null) {
        dioRequest.options.headers = {
          'Authorization': 'Bearer ${user['access']}',
//      'Content-Type': 'application/x-www-form-urlencoded'
        };
      }

      var formData = new dio.FormData.fromMap({
        'title': title,
        'subject': subjectMap[subject],
        'description': description.toString(),
      });

      if (image != null) {
        var file = await dio.MultipartFile.fromFile(image,
            filename: 'FILENAME', contentType: MediaType("image", 'FILENAME'));
        formData.files.add(MapEntry('photo', file));
      }

      var response = await dioRequest.post(
        'http://api.study-share.info//api/v1/question/create/',
        data: formData,
      );
//      final result = json.decode(response.toString());
//      print(result);
      return response;
    } catch (err) {
      await Refresh().refresh();
      try {
        var dioRequest = dio.Dio();
        dioRequest.options.baseUrl =
            'http://api.study-share.info//api/v1/question/create/';

        if (tokenString != null) {
          dioRequest.options.headers = {
            'Authorization': 'Bearer $tokenString',
//      'Content-Type': 'application/x-www-form-urlencoded'
          };
        } else if (user['access'] != null) {
          dioRequest.options.headers = {
            'Authorization': 'Bearer ${user['access']}',
//      'Content-Type': 'application/x-www-form-urlencoded'
          };
        }

        var formData = new dio.FormData.fromMap({
          'title': title,
          'subject': subjectMap[subject],
          'description': description.toString(),
        });

        if (image != null) {
          var file = await dio.MultipartFile.fromFile(image,
              filename: 'FILENAME',
              contentType: MediaType("image", 'FILENAME'));
          formData.files.add(MapEntry('photo', file));
        }

        var response = await dioRequest.post(
          'http://api.study-share.info//api/v1/question/create/',
          data: formData,
        );
//      final result = json.decode(response.toString());
//      print(result);
        return response;
      } catch (err) {
        print('ERROR  $err');
      }
//      logOutInData();
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print('ERROR  $err');
    }

//    http.Response response = await http
//        .post("http://api.study-share.info//api/v1/question/create/", headers: {
//      'Authorization': 'Bearer ${user['access']}',
//    }, body: {
//      'title': title,
//      'subject': 5.toString(),
//      'description': description.toString(),
//      //      'id': 7777.toString(),
////      'pub_date': DateTime.now().toString(),
////      "positive_votes": 0.toString(),
////      "negative_votes": 0.toString(),
////      "total_points": 0.toString(),
////      "is_author": true.toString(),
////      "likes": 0.toString(),
////      "dislikes": 0.toString(),
////      'subject': jsonEncode({
////        "id": 5.toString(),
////        "author": 4.toString(),
////        "name": "Chemistry",
////        "rating": 3.toString()
////      }),
////      'user': jsonEncode({
////        "id": user['data']['id'].toString(),
////        "email": user['data']['email'],
////        "username": user['data']['username']
////      }),
////      "image": jsonEncode([
////        jsonEncode({
////          "path":
////              "/media/images/72115aaf75979cb573fe58517481cd43--facebook-instagram-tour-eiffel_5MMx6Mv.jpg"
////        })
////      ]),
////      "answers": jsonEncode([]),
//    });

//    if (response.statusCode == 200 ||
//        response.statusCode == 201 ||
//        response.statusCode == 202) {
//      String data = response.body;
//      return response;
//    } else {
//      print(response.statusCode);
//    }
  }
}

class Login {
  String email;
  String password;
  Login({this.email, @required this.password});
  Future login() async {
    http.Response response =
        await http.post("http://api.study-share.info//user/login/", body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      user = jsonDecode(data);
//      token = user['access'];
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Refresh {
  Future refresh() async {
    http.Response response = await http.post(
        "http://api.study-share.info/user/token/refresh/",
        body: {'refresh': refreshTokenString});
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      tokenString = jsonDecode(response.body)['access'];
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class Registration {
  String email;
  String username;
  String password1;
  String password2;
  Registration(
      {@required this.email,
      @required this.username,
      @required this.password1,
      @required this.password2});
  Future register() async {
    http.Response response = await http
        .post("http://api.study-share.info//user/registration/", body: {
      'email': email,
      'username': username,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      String data = response.body;
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailValidate {
  String email;
  EmailValidate({@required this.email});
  Future validate() async {
    http.Response response = await http
        .post("http://api.study-share.info/user/validate_user_email/", body: {
      'email': email,
      'save': 'True',
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      String data = response.body;
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class ForgotPasswordData {
  String email;
  String newPass;
  String confPass;
  ForgotPasswordData(
      {@required this.email, @required this.newPass, @required this.confPass});
  Future validate() async {
    http.Response response = await http
        .post("http://api.study-share.info/user/forgot_password/", body: {
      'email': email,
      'password1': newPass,
      'password2': confPass,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      String data = response.body;
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class EmailConfirm {
  String email;
  String code;
  EmailConfirm({@required this.email, @required this.code});
  Future confirm() async {
    http.Response response = await http
        .put("http://api.study-share.info//user/validate_user_email/", body: {
      'email': email,
      'otp': code,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      String data = response.body;
      return response;
    } else {
      print(response.statusCode);
      return response;
    }
  }
}

class AllQuestions {
  BuildContext context;
  int page;
  AllQuestions({this.context, this.page = 1});
  Future getData() async {
    print('AllQuestions is called');
    http.Response response;
    response = await http.get(
      "http://api.study-share.info//api/v1/question/main/${page.toString()}",
      headers: {
        'Authorization': 'Bearer $tokenString',
      },
    );
//    } else if (user['access'] != null) {
//      response = await http.get(
//        "http://api.study-share.info//api/v1/question/main/",
//        headers: {
//          'Authorization': 'Bearer ${user['access']}',
//        },
//      );
//    }
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      print('AllQuestions is called');
      http.Response response;
      response = await http.get(
        "http://api.study-share.info//api/v1/question/main/${page.toString()}",
        headers: {
          'Authorization': 'Bearer $tokenString',
        },
      );
//    } else if (user['access'] != null) {
//      response = await http.get(
//        "http://api.study-share.info//api/v1/question/main/",
//        headers: {
//          'Authorization': 'Bearer ${user['access']}',
//        },
//      );
//    }
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      print('all questions ' + response.statusCode.toString());
    }
  }
}

Future<List<Question>> fetchQuestion(BuildContext context, int page) async {
  print('fetchQuestion is called');
  final response = await http.get(
    "http://api.study-share.info//api/v1/question/main/${page.toString()}",
    headers: {
      'Authorization': 'Bearer $tokenString',
    },
  );

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    var jsonData = jsonDecode(response.body);
    List questionsList = jsonData['data']['questions'];
    List<Question> questions = [];
    for (var quest in questionsList) {
      if (quest['image'].length > 0) {
        imageUrl = 'http://api.study-share.info' + quest['image'][0]['path'];
      }
      Question s = Question(
          description: quest['description'],
          imageUrl: imageUrl,
          pubDate: DateTime.parse(
              quest['pub_date_original'].toString().substring(0, 19)),
          answerCount: quest['answer_count'],
          id: quest['id'].toInt(),
          title: quest['title'],
          likes: quest['likes'],
          dislikes: quest['dislikes'],
          userVote: quest['user_vote'],
          nextPage: jsonData['data']['next']);
      questions.add(s);
      imageUrl = null;
    }
    return questions;
  } else if (response.statusCode == 401) {
//    logOutInData();
    await Refresh().refresh();
    print('fetchQuestion is called');
    final response = await http.get(
      "http://api.study-share.info//api/v1/question/main/${page.toString()}",
      headers: {
        'Authorization': 'Bearer $tokenString',
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      var jsonData = jsonDecode(response.body);
      List questionsList = jsonData['data']['questions'];
      List<Question> questions = [];
      for (var quest in questionsList) {
        if (quest['image'].length > 0) {
          imageUrl = 'http://api.study-share.info' + quest['image'][0]['path'];
        }
        Question s = Question(
            description: quest['description'],
            imageUrl: imageUrl,
            pubDate: DateTime.parse(
                quest['pub_date_original'].toString().substring(0, 19)),
            answerCount: quest['answer_count'],
            id: quest['id'].toInt(),
            title: quest['title'],
            likes: quest['likes'],
            dislikes: quest['dislikes'],
            userVote: quest['user_vote'],
            nextPage: jsonData['data']['next']);
        questions.add(s);
        imageUrl = null;
      }
      return questions;
    }
//    Navigator.pushReplacementNamed(context, LoginScreen.id);
    throw Exception('all questions ' + response.statusCode.toString());
  } else {
    throw Exception('all questions ' + response.statusCode.toString());
  }
}

class QuestionById {
  final int id;
  BuildContext context;
  QuestionById({this.id = 2, this.context});
  String imageLink = '';
  Future getData() async {
    http.Response response = await http.get(
      "http://api.study-share.info//api/v1/question/$id",
      headers: {
        'Authorization': 'Bearer $tokenString',
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.get(
        "http://api.study-share.info//api/v1/question/$id",
        headers: {
          'Authorization': 'Bearer $tokenString',
        },
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class MyQuestions {
  BuildContext context;
  MyQuestions({this.context});
  String imageLink = '';
  Future getData() async {
    http.Response response = await http.get(
      "http://api.study-share.info//api/v1/question/user/1",
      headers: {
        'Authorization': 'Bearer $tokenString',
      },
    );
    print('response ' + response.body.toString());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http.get(
        "http://api.study-share.info//api/v1/question/user/",
        headers: {
          'Authorization': 'Bearer $tokenString',
        },
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response.statusCode);
        String data = response.body;
        return jsonDecode(data);
      }
//      print(response.statusCode);
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      print(response.statusCode);
      String data = response.body;
      return jsonDecode(data);
    }
  }
}

class MyAnswers {
  BuildContext context;
  MyAnswers({this.context});
  String imageLink = '';
  Future getData() async {
    http.Response response = await http.get(
      "http://api.study-share.info//api/v1/answer/user/",
      headers: {
        'Authorization': 'Bearer $tokenString',
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response = await http.get(
        "http://api.study-share.info//api/v1/answer/user/",
        headers: {
          'Authorization': 'Bearer $tokenString',
        },
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      logOutInData();
      print(response.statusCode);
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      print(response.statusCode);
    }
  }
}

class ChangePassword {
  final String password;
  final String password1;
  final String password2;
  BuildContext context;
  ChangePassword({this.password, this.password1, this.password2, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://api.study-share.info//user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'password': password,
      'password1': password1,
      'password2': password2,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response = await http
          .put("http://api.study-share.info//user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'password': password,
        'password1': password1,
        'password2': password2,
      });
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      logOutInData();
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class ChangeProfile {
  final String username;
  final String password;
  BuildContext context;
  ChangeProfile({this.username, this.password, this.context});
  Future putData() async {
    http.Response response =
        await http.put("http://api.study-share.info//user/profile/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response = await http
          .put("http://api.study-share.info//user/profile/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
      print(response.statusCode);
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      print(response.statusCode);
    }
  }
}

class CreateAnswer {
  final int questionId;
  final String answerText;
  BuildContext context;
  CreateAnswer({this.questionId, this.answerText, this.context});
  Future putData() async {
    http.Response response = await http
        .post("http://api.study-share.info//api/v1/answer/create/", headers: {
      'Authorization': 'Bearer $tokenString',
    }, body: {
      'question': questionId.toString(),
      'answer_text': answerText,
    });

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      String data = response.body;
      return jsonDecode(data);
    } else if (response.statusCode == 401) {
      await Refresh().refresh();
      http.Response response = await http
          .post("http://api.study-share.info//api/v1/answer/create/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'question': questionId.toString(),
        'answer_text': answerText,
      });

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        String data = response.body;
        return jsonDecode(data);
      }
//      logOutInData();
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}

class SearchFilter {
  String subject;
  String word;
  BuildContext context;
  SearchFilter({this.subject, this.word = '', this.context});

  Future getData() async {
    http.Response response;
    if (tokenString != null) {
//      final queryParameters = {
//        'date': 'des',
//      };
//      final uri =
//          Uri.http('api.study-share.info', '//api/v1/search/', queryParameters);
//      final headers = {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        'Authorization': 'Bearer $tokenString'
//      };
//      response = await http.get(uri, headers: headers);
//      print(jsonDecode(response.body));
      response = await http
          .post("http://api.study-share.info//api/v1/search/", headers: {
        'Authorization': 'Bearer $tokenString',
      }, body: {
        'subject': subjectMap[subject],
        'word': word,
      });
//      print(jsonDecode(response.body));
    } else if (user['access'] != null) {
//      final queryParameters = {
//        'date': 'des',
//      };
//      final uri = Uri.http(
//          'http://api.study-share.info/', '/api/v1/search/', queryParameters);
//      final headers = {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        'Authorization': 'Bearer ${user['access']}'
//      };
//      response = await http.get(uri, headers: headers);

      response = await http
          .post("http://api.study-share.info//api/v1/search/", headers: {
        'Authorization': 'Bearer ${user['access']}',
      }, body: {
        'subject': subjectMap[subject],
        'word': word,
      });
    }
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
//      return jsonDecode(response.body);
      return response;
    } else if (response.statusCode == 401) {
//      logOutInData();
      await Refresh().refresh();
      http.Response response;
      if (tokenString != null) {
//      final queryParameters = {
//        'date': 'des',
//      };
//      final uri =
//          Uri.http('api.study-share.info', '//api/v1/search/', queryParameters);
//      final headers = {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        'Authorization': 'Bearer $tokenString'
//      };
//      response = await http.get(uri, headers: headers);
//      print(jsonDecode(response.body));
        response = await http
            .post("http://api.study-share.info//api/v1/search/", headers: {
          'Authorization': 'Bearer $tokenString',
        }, body: {
          'subject': subjectMap[subject],
          'word': word,
        });
//      print(jsonDecode(response.body));
      } else if (user['access'] != null) {
//      final queryParameters = {
//        'date': 'des',
//      };
//      final uri = Uri.http(
//          'http://api.study-share.info/', '/api/v1/search/', queryParameters);
//      final headers = {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        'Authorization': 'Bearer ${user['access']}'
//      };
//      response = await http.get(uri, headers: headers);

        response = await http
            .post("http://api.study-share.info//api/v1/search/", headers: {
          'Authorization': 'Bearer ${user['access']}',
        }, body: {
          'subject': subjectMap[subject],
          'word': word,
        });
      }
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
//      return jsonDecode(response.body);
        return response;
      }
//      Navigator.pushReplacementNamed(context, LoginScreen.id);
      print(response.statusCode);
    } else {
      print('search and filter ' + response.statusCode.toString());
      return response;
    }
  }
}
