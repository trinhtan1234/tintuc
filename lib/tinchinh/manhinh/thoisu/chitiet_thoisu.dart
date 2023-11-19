import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class ChiTietThoiSu extends StatelessWidget {
  final ModelNews news;

  Widget buildNewsImage(BuildContext context, ModelNews news) {
    if (news.imagetieude != null && news.imagetieude!.isNotEmpty) {
      String? imageUrl = news.imagetieude;
      if (!imageUrl!.startsWith('http:') && !imageUrl.startsWith('https:')) {
        imageUrl = 'https:$imageUrl';
      }
      return ClipRect(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width - 20,
          ),
        ),
      );
    } else {
      // Trong trường hợp không có ảnh, bạn có thể trả về một widget khác hoặc null tùy theo yêu cầu của bạn.
      return const Text(''); // Ví dụ trả về một Container trống.
    }
  }

  const ChiTietThoiSu({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(news.loaitinbai ?? ''),
            const Icon(Icons.chevron_right),
            Flexible(
              child: Text(
                news.tieude ?? 'No Title',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${news.ngaytao ?? 'Unknown data'}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      news.tieude ?? 'No Title',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
              buildNewsImage(context, news),
              const SizedBox(height: 10),
              Text(
                news.noidung ?? 'No Description',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      news.noiDungChiTietDoan1 ?? 'No content',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' ${news.tacgia ?? ''}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mail_outline_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.telegram_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.linked_camera_outlined,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  filled: true,
                  // fillColor: Colors.grey,
                  hintText: 'Your idea...',
                  // prefixIcon: Icon(Icons.voice_chat_sharp),

                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
                onChanged: (text) {},
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //             onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      //         label: ''),
      //     // icon: Expanded(child: Icon(Icons.arrow_back)), label: ''),
      //     BottomNavigationBarItem(
      //         icon: Expanded(
      //           child: Row(
      //             children: [
      //               TextButton(
      //                 onPressed: () {},
      //                 child: const Text('Aa'),
      //               ),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.chat_bubble_outline_outlined)),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.watch_later_outlined))
      //             ],
      //           ),
      //         ),
      //         label: ''),
      //   ],
      // ),
    );
  }
}
