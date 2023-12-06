import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/caidat/login/dangnhaptaikhoan.dart';
import 'package:tintuc/caidat/thietlapungdung.dart';
import 'package:tintuc/components/textbuttom.dart';

class CaiDat extends StatelessWidget {
  const CaiDat({Key? key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    Future<String> getUser() async {
      final currentUser = await _auth.currentUser;
      return currentUser?.displayName ?? "Chưa đăng nhập";
    }

    return FutureBuilder<String>(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final userName = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(
                Icons.fiber_new,
                size: 40,
              ),
              title: const Text(
                'Cài đặt',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () {},
                    icon: ClipOval(
                      child: Image.asset(
                        'assets/images/tantv.jpg',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextButtom(
                    iconLeft: const Icon(Icons.person),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: userName,
                    onPressed: () {
                      if (userName != "Chưa đăng nhập") {
                        _auth.signOut();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManHinhDangNhap(),
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.settings),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Cài đặt',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThietLapUngDung(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.timeline),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Watch it later',
                    onPressed: () {},
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.widgets),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Widgets',
                    onPressed: () {},
                  ),
                  const Divider(),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'News by region',
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.location_on),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Viet Nam',
                    onPressed: () {},
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.location_on),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'World',
                    onPressed: () {},
                  ),
                  const Divider(),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Categories',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.fiber_new),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Home',
                    onPressed: () {},
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.fiber_new),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Finance',
                    onPressed: () {},
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.fiber_new),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'Business',
                    onPressed: () {},
                  ),
                  const Divider(),
                  AppTextButtom(
                    iconLeft: const Icon(Icons.fiber_new),
                    iconRight: const Icon(Icons.arrow_forward_ios),
                    labelTitle: 'World',
                    onPressed: () {},
                  ),
                  const Divider(),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Follow'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.tiktok),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.cast_for_education),
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(108, 111, 66, 192),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.message,
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              'Respond to news',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        } else {
          // Trường hợp không có dữ liệu, bạn có thể trả về một widget trống hoặc loading tùy thuộc vào yêu cầu của bạn.
          return CircularProgressIndicator();
        }
      },
    );
  }
}
