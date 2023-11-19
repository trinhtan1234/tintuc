import 'package:flutter/material.dart';

class ThongBao extends StatelessWidget {
  const ThongBao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Tin hot - 1 giờ trước'),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            'Doanh nghiệp kêu lãi suất cao, ngân hàng than không có lãi trong 2 tháng cuối năm'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
