import 'package:flutter/material.dart';

class AbaoutPage extends StatelessWidget {
  const AbaoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
              image: NetworkImage('https://www.kibrispdr.org/data/212/foto-nisan-kuburan-8.png'),
              ),
            Positioned(
              child: CircleAvatar(
                radius: 80, 
                backgroundColor: Color.fromARGB(255, 114, 27, 27), 
                backgroundImage: NetworkImage('https://cdn.idntimes.com/content-images/post/20221104/download-65049cac42b21fd08b36c35ae6eca9ce_600x400.jpeg') 
              ,),),
            ],
        ),
        SizedBox(
          height: 20,
          ),
          
        ListTile(
          title: Text('NAMA PENGGUNA'),
          subtitle: Text('Saya merupakan admin aplikasi ini '),
          ), 
        IconButton(onPressed: (){}, icon: Icon(Icons.mail), color: Color.fromARGB(255, 61, 61, 61),
        ),
        ListTile(
          title: Text('About Me'),
          subtitle: Text('Performing hot reload... Reloaded 1 of 908 libraries in 331ms (compile: 24 ms, reload: 164 ms,reassemble: 130 ms).'),
        )
        
      ],
    );
  }
}
