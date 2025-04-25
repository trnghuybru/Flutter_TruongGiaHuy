import 'package:flutter/material.dart';
import 'package:dart_truonggiahuy/models/room.dart';
import 'package:dart_truonggiahuy/services/room_service.dart';

class CreateRoomPage extends StatefulWidget {
  final Function(Room) onRoomCreated; // Callback để truyền room mới về

  const CreateRoomPage({Key? key, required this.onRoomCreated}) : super(key: key);

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final _formKey = GlobalKey<FormState>();
  String tenantName = '';
  String phoneNumber = '';
  String startDate = '';
  String paymentType = 'Theo tháng';
  String note = '';

  final paymentTypes = ['Theo tháng', 'Theo quý', 'Theo năm'];

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newRoom = Room(
        id: 0, // ID sẽ tự sinh từ backend
        tenantName: tenantName,
        phoneNumber: phoneNumber,
        startDate: startDate,
        paymentType: paymentType,
        note: note,
      );

      await RoomService.createRoom(newRoom);
      widget.onRoomCreated(newRoom); // Gọi callback để thông báo phòng mới được tạo
      Navigator.pop(context); // Đóng dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tạo mới phòng trọ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tên người thuê trọ'),
                validator: (value) => value!.isEmpty ? 'Không được để trống' : null,
                onSaved: (value) => tenantName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                validator: (value) => value!.isEmpty ? 'Không được để trống' : null,
                onSaved: (value) => phoneNumber = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ngày bắt đầu thuê (yyyy-mm-dd)'),
                validator: (value) => value!.isEmpty ? 'Không được để trống' : null,
                onSaved: (value) => startDate = value!,
              ),
              DropdownButtonFormField(
                value: paymentType,
                items: paymentTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => paymentType = value as String),
                decoration: const InputDecoration(labelText: 'Hình thức thanh toán'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ghi chú'),
                onSaved: (value) => note = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
