import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/views/pages/chat-page/chat_page.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  static const String routeName = '/inbox';
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Consumer<MessageProvider>(
        builder: (context, msgProvider, child) {
          return msgProvider.messageGroupList.isEmpty
              ? const Center(
                  child: Text('Empty Message Groups'),
                )
              : ListView.builder(
                  itemCount: msgProvider.messageGroupList.length,
                  itemBuilder: (context, index) {
                    MessageGroupModel messageGroup =
                        msgProvider.messageGroupList[index];
                    return ListTile(
                      onTap: () {
                        context
                            .read<MessageProvider>()
                            .getAllMessagesByGroupId(messageGroup.id!);
                        Navigator.pushNamed(context, ChattingPage.routeName,
                            arguments: messageGroup);
                      },
                      title: Text(messageGroup.groupName!),
                      trailing: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  messageGroup.messages!.length.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
