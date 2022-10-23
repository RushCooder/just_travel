import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

import 'components/my_message_side.dart';
import 'components/user_message_side.dart';

class ChattingPage extends StatelessWidget {
  static const String routeName = '/chatting_page';
  final MessageGroupModel messageGroup;
  final TextEditingController messageTextEditingController =
      TextEditingController();
  ChattingPage({required this.messageGroup, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MessageProvider>().autoRefresh(messageGroup.id!);
    return WillPopScope(
      onWillPop: () {
       return context.read<MessageProvider>().cancelAutoRefresh();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(messageGroup.groupName!),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, msgProvider, child) =>
                    msgProvider.messageList.isEmpty
                        ? const Center(
                            child: Text('Empty Message'),
                          )
                        : ListView.builder(
                            itemCount: msgProvider.messageList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyMessageSide(
                                messageModel: msgProvider.messageList[index],
                              ),
                            ),
                          ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: messageTextEditingController,
                      icon: Icons.text_fields_outlined,
                      hintText: 'Message',
                      labelText: '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        if (messageTextEditingController.text.isNotEmpty){
                         await context.read<MessageProvider>().createNewMessage(
                            messageTextEditingController.text.trim(),
                            context.read<UserProvider>().user!.id!,
                            messageGroup.id!,
                          );

                          messageTextEditingController.text = '';
                        }

                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
