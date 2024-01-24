import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';

import '../controllers/aboutus_controller.dart';

class AboutusView extends GetView<AboutusController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(about.tr),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/bannerinfo.jpg',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .1,
                      child: Container(
                        padding: EdgeInsets.all(borderRadius / 3),
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(.8)),
                        child: Text(
                          'Developer Name: Subash Khatri.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.contact_phone,
                  ),
                ),
                title: Text('Contact'),
                subtitle: Text('9861231323/9860272128'),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.email,
                  ),
                ),
                title: Text('Email'),
                subtitle: Text('subashkhatri36@gmail.com'),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.web),
                ),
                title: Text('GitHub'),
                subtitle: Text('www.github.com/subashkhatri36'),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.facebook),
                ),
                title: Text('Facebook'),
                subtitle: Text('www.facebook.com/subash.kchettri'),
              ),
               
              
            ],
          ),
        ));
  }
}
