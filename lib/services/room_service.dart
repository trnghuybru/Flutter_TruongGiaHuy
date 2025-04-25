import 'dart:convert';
import 'package:dart_truonggiahuy/models/room.dart';
import 'package:http/http.dart' as http;

class RoomService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<List<Room>> getRooms() async {
    final response = await http.get(Uri.parse('$baseUrl/rooms'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((room) => Room.fromJson(room)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  static Future<void> createRoom(Room room) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rooms'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tenant_name": room.tenantName,
        "phone_number": room.phoneNumber,
        "start_date": room.startDate,
        "payment_type": room.paymentType,
        "note": room.note,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create room');
    }
  }

  static Future<void> deleteRooms(List<int> ids) async {
    // Gửi từng ids riêng biệt
    final uri = Uri.parse('$baseUrl/rooms').replace(queryParameters: {
      for (var id in ids) 'ids': id.toString(),  // Gửi từng 'ids' riêng biệt
    });

    final response = await http.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      print('Failed to delete rooms: ${response.body}');
      throw Exception('Failed to delete rooms');
    } else {
      print('Deleted rooms successfully');
    }
  }

}
