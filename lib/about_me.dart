import 'package:developer_info/service/calls_and_messages_service.dart';
import 'package:developer_info/service/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/theme_model.dart';

class DeveloperProfile extends StatefulWidget {
  const DeveloperProfile({Key? key}) : super(key: key);

  @override
  _DeveloperProfileState createState() => _DeveloperProfileState();
}

class _DeveloperProfileState extends State<DeveloperProfile> {

  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  ThemeModel model = ThemeModel();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.moon_stars,color: Colors.cyan,),
            onPressed: () {
              Provider.of<ThemeModel>(context,listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Stack(
              children: [
                buildImage(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0,bottom: 12),
            child: buildName("Zia Uddin Khan","developer.ziakhan@gmail.com"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              contactButton("Send Email",Icons.email),
              const SizedBox(width: 20),
              contactButton("Call Me",Icons.call)
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: Center(
              child: Text(
                "Connect with me",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("Facebook", "images/facebook_round.png","https://www.facebook.com/Zia2882"),
              buildDivider(),
              buildButton("Github","images/GitHub-Mark.png","https://github.com/Zia005"),
              buildDivider(),
              buildButton("LinkedIn","images/linkedin_round.png","https://www.linkedin.com/in/zia-khan-91a37a133"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: buildAbout('Experienced Mobile Application Developer with a demonstrated history of working in the information technology and services industry. Skilled in Android Development, Cross Platform Development (Android, IOS), Dart, Java, Firebase, MySQL and API Development. Strong engineering professional with a Bachelor\'s degree focused in Computer Software Engineering from Metropolitan University.'),
          ),
        ],
      ),
    );
  }

  Widget buildName(String name, String email) => Column(
    children: [
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),
      ),
      const SizedBox(height: 4),
      Text(
        email,
        style: const TextStyle(color: Colors.grey,fontSize: 15),
      )
    ],
  );

  Widget contactButton(String text,IconData icon) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
    ),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 5,),
        Text(text)
      ],
    ),
    onPressed: (){
      if(text == "Send Email"){
        _service.sendEmail("developer.ziakhan@gmail.com");
      }else{
        _service.call("01671012729");
      }
    }
  );

  Widget buildAbout(String details) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          details,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

  Widget buildImage() {
    // final image = NetworkImage('use your image link',);
    const image = AssetImage('images/zia.jpeg',);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () async {}),
        ),
      ),
    );
  }

  Widget buildDivider() => Container(
    height: 24,
    width: 2,
    color: Colors.black,
    child: const VerticalDivider(),
  );

  Widget buildButton(String value, String icon, String link) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 12),
        onPressed: () async {
          await _service.openApps(link);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 40,
              child: Image.asset(icon,fit: BoxFit.scaleDown,),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
