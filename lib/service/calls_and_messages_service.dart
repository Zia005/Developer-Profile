import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  void call(String number) => launch("tel://$number");

  void sendSms(String number) => launch("sms:$number");

  void sendEmail(String email) => launch("mailto:$email");

  Future<void> sendWhatsappMessage(String number) async {
    var whatsappUrl ="whatsapp://send?phone=$number";
    await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  Future<void> openApps(String link) async {

    try {
      bool launched = await launch(link, forceSafariVC: false);

      if (!launched) {
        await launch(link, forceSafariVC: false);
      }
    } catch (e) {
      await launch(link, forceSafariVC: false);
    }

  }

}