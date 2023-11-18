import 'package:flutter/material.dart';

class ScreenSign extends StatelessWidget {
  const ScreenSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SIGN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 80)),
              const Divider(),
              const Center(
                child: Text(
                  'Login with email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              // ignore: sized_box_for_whitespace
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              // ignore: sized_box_for_whitespace
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                        child: Text(
                      'Forgot password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
