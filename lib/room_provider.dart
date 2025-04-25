
import 'package:dart_truonggiahuy/models/room.dart';
import 'package:dart_truonggiahuy/services/room_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomNotifier extends StateNotifier<List<Room>> {
  RoomNotifier() : super([]);

  Future<void> fetchRooms() async {
    final rooms = await RoomService.getRooms();
    state = rooms;
  }

  void addRoom(Room room) {
    state = [...state, room];
  }

  Future<void> deleteRooms(List<int> ids) async {
    await RoomService.deleteRooms(ids);
    state = state.where((room) => !ids.contains(room.id)).toList();
  }
}

// Provider để quản lý danh sách phòng
final roomProvider = StateNotifierProvider<RoomNotifier, List<Room>>((ref) {
  return RoomNotifier();
});
