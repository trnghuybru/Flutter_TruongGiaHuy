import 'package:dart_truonggiahuy/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:dart_truonggiahuy/models/room.dart';
import 'package:dart_truonggiahuy/widgets/room_table.dart';
import 'package:dart_truonggiahuy/pages/create_room_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HomePage extends ConsumerWidget  {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomProvider);
    String searchQuery = "";

    void onSearch(String query) {
      searchQuery = query;
    }

    void _showCreateRoomDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: CreateRoomPage(onRoomCreated: (room) {
              // Cập nhật state của RoomProvider khi phòng mới được tạo
              ref.read(roomProvider.notifier).addRoom(room);
              Navigator.pop(context);
            }),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách phòng trọ'),
        actions: [
          ElevatedButton(
            onPressed: _showCreateRoomDialog, // Mở dialog tạo phòng
            child: const Text('Tạo mới'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: onSearch,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Tìm kiếm mã phòng, tên người thuê hoặc số điện thoại",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RoomTable(
                rooms: rooms,
                searchQuery: searchQuery,
                onRoomSelect: (room, selected) {
                  // Không cần làm gì ở đây nếu không thay đổi logic chọn phòng
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Hàm xóa nhiều phòng đã chọn
        },
        label: const Text('Xóa'),
        icon: const Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}
