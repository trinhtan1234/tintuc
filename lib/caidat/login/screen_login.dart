import 'package:flutter/material.dart';
import 'package:tintuc/caidat/login/screen_sign.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN',
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
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 40)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.apple,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Apple'),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.facebook,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Facebook'),
                      ],
                    ),
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
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.mail,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Google'),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
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
              const Padding(padding: EdgeInsets.only(top: 40)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account ?',
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScreenSign()));
                      },
                      child: const Text('Create acount'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
