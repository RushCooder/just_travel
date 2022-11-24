import 'package:flutter/material.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/views/widgets/circular_image_layout.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/urls.dart';

class UserInfoPage extends StatelessWidget {
  static const String routeName = '/users-info';
  final String groupId;
  const UserInfoPage({required this.groupId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<MessageProvider>().fetchUsersByGroupId(groupId);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Members'),
      ),
      body: Consumer<MessageProvider>(
        builder: (context, msgProvider, child) => msgProvider.userList.isEmpty
            ? const Center(child: Text('No members'))
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: msgProvider.userList.length,
                  itemBuilder: (context, index) {
                    final user = msgProvider.userList[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // todo: need to replace ListTile with other widget to fix render error

                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 100,
                          child: user.profileImage != null &&
                                  user.profileImage!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 60,
                                  child: ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(60),
                                    child: CircularImageLayout(
                                      radius: 60,
                                      width: 50,
                                      height: 50,
                                      image:
                                          '${baseUrl}uploads/${user.profileImage}',
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  child: Text(
                                    user.name!.substring(0, 2),
                                  ),
                                ),
                        ),
                        title: Text(user.name!),
                        subtitle: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.7),
                          child: Text('${user.email!.emailId}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
