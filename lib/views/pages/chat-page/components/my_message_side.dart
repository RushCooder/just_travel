import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/message_model.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

class MyMessageSide extends StatelessWidget {
  final MessageModel messageModel;
  const MyMessageSide({required this.messageModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          messageModel.sender!.id == context.read<UserProvider>().user!.id
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        // user side
        if (messageModel.sender!.id != context.read<UserProvider>().user!.id)
          messageModel.sender!.profileImage == null
              ? AppBarTrailing(
                  radius: 18,
                  child: Text(
                    messageModel.sender!.name!.substring(0, 2),
                  ),
                )
              : ProfileCircularImage(
                  radius: 18,
                  image:
                      '${baseUrl}uploads/${messageModel.sender!.profileImage}',
                ),
        const SizedBox(
          width: 2,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: messageModel.sender!.id ==
                          context.read<UserProvider>().user!.id
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  topRight: messageModel.sender!.id !=
                          context.read<UserProvider>().user!.id
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomRight: const Radius.circular(15),
                  bottomLeft: const Radius.circular(15),
                )),
            child: Text(messageModel.message!),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (messageModel.sender!.id == context.read<UserProvider>().user!.id)
          context.read<UserProvider>().user!.profileImage == null
              ? AppBarTrailing(
                  radius: 18,
                  child: Text(
                    messageModel.sender!.name!.substring(0, 2),
                  ),
                )
              : ProfileCircularImage(
                  radius: 18,
                  image:
                      '${baseUrl}uploads/${messageModel.sender!.profileImage}',
                ),
      ],
    );
  }
}
