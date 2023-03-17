import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

sendOTP(receipent_email) async {
 
  String username = 'proddecapp@gmail.com';
  String password = 'somm oxvu jjay pqju';

  var rndnumber = "";
  var rnd = new Random();
  for (var i = 0; i < 6; i++) {
    rndnumber = rndnumber + rnd.nextInt(9).toString();
  }

  final smtpServer = gmail(username, password);
  
  final message = Message()
    ..from = Address(username, 'V CEC')
    ..recipients.add(receipent_email)
    ..subject = 'OTP for V CEC'
    ..html =
        "<h1>OTP for V CEC ${rndnumber}</h1>\n<p>Please enter the OTP in the V CEC APP</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  
  var connection = PersistentConnection(smtpServer);
  await connection.send(message);

  await connection.close();

  return rndnumber;
}
