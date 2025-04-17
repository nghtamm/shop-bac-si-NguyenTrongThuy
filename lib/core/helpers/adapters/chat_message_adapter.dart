import 'package:hive/hive.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 3;

  @override
  ChatMessage read(BinaryReader reader) {
    final userId = reader.readString();
    final userFirstName = reader.readString();
    final userLastName = reader.readString();
    final userProfileImage = reader.readString();

    return ChatMessage(
      user: ChatUser(
        id: userId,
        firstName: userFirstName,
        lastName: userLastName,
        profileImage: userProfileImage.isEmpty ? null : userProfileImage,
      ),
      createdAt: DateTime.parse(reader.readString()),
      text: reader.readString(),
      isMarkdown: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer.writeString(obj.user.id);
    writer.writeString(obj.user.firstName ?? '');
    writer.writeString(obj.user.lastName ?? '');
    writer.writeString(obj.user.profileImage ?? '');
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.text);
    writer.writeBool(obj.isMarkdown);
  }
}
