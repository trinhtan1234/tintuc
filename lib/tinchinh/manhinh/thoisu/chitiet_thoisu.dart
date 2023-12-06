import 'package:flutter/material.dart';
import 'package:tintuc/tinchinh/manhinh/thoisu/thoisu.dart';
import 'package:tintuc/tinchinh/networking/models/model_news.dart';

class ChiTietThoiSu extends StatelessWidget {
  final ModelNews news;

  Widget buildNewsImage1(BuildContext context, ModelNews news) {
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

  Widget buildNewsImage2(BuildContext context, ModelNews news) {
    if (news.imagechitiet1 != null && news.imagechitiet1!.isNotEmpty) {
      String? imageUrl = news.imagechitiet1;
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
              buildNewsImage1(context, news),
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
              buildNewsImage2(context, news),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' ${news.tacgia ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
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
                  fillColor: Colors.grey,
                  hintText: 'Your idea...',
                ),
                onChanged: (text) {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Expanded(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThoiSu(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Aa'),
                    ),
                    IconButton(
                      onPressed: () {
                        showModeBottomSheet(context);
                      },
                      icon: const Row(
                        children: [
                          Icon(Icons.chat_bubble_outline_outlined),
                          Text('22'),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.watch_later_outlined))
                  ],
                ),
              ),
              label: ''),
        ],
      ),
    );
  }

  Future<dynamic> showModeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                news.tieude ?? '',
              ),
            ),
            body: const SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Divider(),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                                'Không ai rảnh đi sát hạch 50cc lúc 16 tuổi rồi đến 18 tuổi lại đi sát hạch >50cc. Nếu thay đổi thì Cho phép sát hạch A1 lúc 16 tuổi nhưng chỉ được phép điều khiển xe 50cc, không nên "đẻ" ra thêm một loại sát hạch không cần thiết, hiện nay các em đều được tiếp cận văn hoá giao thông, luật giao thông từ trong trường học.'),
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
      },
    );
  }
}
