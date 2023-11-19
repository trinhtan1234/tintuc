import 'package:flutter/material.dart';

class ThongBao extends StatelessWidget {
  const ThongBao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Thông báo'),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                height: 80,
                child: Row(
                  children: [
                    const Flexible(
                      child: Text(
                        'Quyền lực tuyệt đối của bà Trương Mỹ Lan trong hệ thống ngân hàng SCB',
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Image.asset(
                      'assets/images/tantv.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
