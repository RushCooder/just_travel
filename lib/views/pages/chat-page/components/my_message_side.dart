import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/message_model.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

class MyMessageSide extends StatelessWidget {
  final MessageModel messageModel;
  const MyMessageSide({required this.messageModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messageModel.sender!.id != context.read<UserProvider>().user!.id) {
      print(messageModel.sender!.profileImage);
    }
    return Row(
      mainAxisAlignment:
          messageModel.sender!.id == context.read<UserProvider>().user!.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        // user side
        if (messageModel.sender!.id != context.read<UserProvider>().user!.id)
          messageModel.sender!.profileImage == null
              ? CircleAvatar(
                  radius: 22,
                  child: Text(
                    messageModel.sender!.name!.substring(0, 2),
                  ),
                )
              : ProfileCircularImage(
                  radius: 22,
                  image:
                      '${baseUrl}uploads/${messageModel.sender!.profileImage}',
                ),
        const SizedBox(
          width: 10,
        ),
        Container(
          // width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(messageModel.message!),
        ),
        const SizedBox(
          width: 10,
        ),
        if (messageModel.sender!.id == context.read<UserProvider>().user!.id)
          context.read<UserProvider>().user!.profileImage == null
              ? CircleAvatar(
                  radius: 22,
                  child: Text(
                    context.read<UserProvider>().user!.name!.substring(0, 2),
                  ),
                )
              : ProfileCircularImage(
                  radius: 22,
                  image:
                      '${baseUrl}uploads/${context.read<UserProvider>().user!.profileImage}',
                ),
      ],
    );
  }
}
