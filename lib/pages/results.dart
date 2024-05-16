import 'package:calculatorapp/pages/about.dart';
import 'package:calculatorapp/pages/home.dart';
import 'package:calculatorapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  String quizId = await getQuizIdFromSharedPreferences();
  runApp(
    MaterialApp(
      home: Results(
        incorrect: 0,
        total: 10,
        correct: 10,
        userName:
            await loadUserName(),
        quizId: quizId,
      ),
    ),
  );
}

// Function to load user name from shared preferences
Future<String?> loadUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}

Future<String> getQuizIdFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('quizId') ?? '';
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('classme'); // Replace with your app icon

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      // Handle notification tap
    },
  );
}

class Results extends StatefulWidget {
  final int total, correct, incorrect;
  final String? userName;
  final String quizId;
  Results(
      {required this.incorrect,
      required this.total,
      required this.correct,
      this.userName,
      required this.quizId});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    super.initState();

    // Call sendNotification when the page loads
    sendNotification();
    updateQuizResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results!"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.correct}/ ${widget.total}",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "you answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Use theme color here
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Go to home",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateQuizResults() async {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Check if the user ID is not null and the quiz ID is available
    if (userId != null && widget.quizId != null) {
      // Get the current date and time in ISO 8601 format
      String currentDate = DateTime.now().toIso8601String();

      // Create a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        // Update the quiz result document in the quizResults collection
        await firestore
            .collection('quizResults')
            .where('userID', isEqualTo: userId)
            .where('quizID',
                isEqualTo: widget.quizId) // Filter by selected quiz ID
            .where('status', isEqualTo: 'in progress')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) async {
            await doc.reference.update({
              'score': widget.correct, // Update score to the correct value
              'status': 'completed', // Set status to "completed"
              'dateCompleted':
                  currentDate, // Update dateCompleted to current date
            });
          });
        });
      } catch (error) {
        print('Error updating quiz results: $error');
        // Handle error
      }
    }
  }

  Future<void> sendNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'quiz_channel', // Replace with your own channel ID
      'Quiz Notifications', // Replace with your own channel name
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final userName =
        widget.userName ?? ''; // Use userName from widget or default to 'User'

    await flutterLocalNotificationsPlugin.show(
      0,
      'Well Done! $userName',
      'Congratulations on completing the quiz!',
      platformChannelSpecifics,
    );
  }
}
