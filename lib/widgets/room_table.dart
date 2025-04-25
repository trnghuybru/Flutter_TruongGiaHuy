import 'package:dart_truonggiahuy/models/room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomTable extends StatelessWidget {
  final List<Room> rooms;
  final String searchQuery;
  final void Function(Room room, bool selected) onRoomSelect;

  const RoomTable({
    Key? key,
    required this.rooms,
    required this.searchQuery,
    required this.onRoomSelect,
  }) : super(key: key);

  String formatDate(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRooms = rooms.where((room) {
      final lowerQuery = searchQuery.toLowerCase();
      return room.tenantName.toLowerCase().contains(lowerQuery) ||
          room.phoneNumber.contains(lowerQuery) ||
          room.id.toString().contains(lowerQuery);
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('STT')),
            DataColumn(label: Text('Mã phòng trọ')),
            DataColumn(label: Text('Tên người thuê')),
            DataColumn(label: Text('Số điện thoại')),
            DataColumn(label: Text('Ngày bắt đầu thuê')),
            DataColumn(label: Text('Hình thức thanh toán')),
            DataColumn(label: Text('Ghi chú')),
            DataColumn(label: Text('Chọn')),
          ],
          rows: List.generate(filteredRooms.length, (index) {
            final room = filteredRooms[index];
            return DataRow(
              selected: room.isSelected,
              cells: [
                DataCell(Text((index + 1).toString())),
                DataCell(Text('PT-${room.id.toString().padLeft(3, '0')}')),
                DataCell(Text(room.tenantName)),
                DataCell(Text(room.phoneNumber)),
                DataCell(Text(formatDate(room.startDate))),
                DataCell(Text(room.paymentType)),
                DataCell(Text(room.note)),
                DataCell(
                  Checkbox(
                    value: room.isSelected,
                    onChanged: (bool? value) {
                      onRoomSelect(room, value ?? false);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
