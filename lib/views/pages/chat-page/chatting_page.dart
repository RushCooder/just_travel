import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/models/db-models/message_model.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/urls.dart';
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
      onWillPop: () => context.read<MessageProvider>().cancelAutoRefresh(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(messageGroup.groupName!),
        ),
        body: Column(
          children: [
            // Expanded(
            //   child: Consumer<MessageProvider>(
            //     builder: (context, msgProvider, child) =>
            //         msgProvider.messageList.isEmpty
            //             ? const Center(
            //                 child: Text('Empty Message'),
            //               )
            //             : ListView.builder(
            //                 itemCount: msgProvider.messageList.length,
            //                 itemBuilder: (context, index) => Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: MyMessageSide(
            //                     messageModel: msgProvider.messageList[index],
            //                   ),
            //                 ),
            //               ),
            //   ),
            // ),
            // message reading part
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, msgProvider, child) {
                  return GroupedListView<MessageModel, DateTime>(
                    padding: const EdgeInsets.all(8.0),
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    reverse: true,
                    order: GroupedListOrder.DESC,

                    elements: msgProvider.messageList,
                    groupBy: (message) => DateTime.fromMillisecondsSinceEpoch(
                      message.sendDateTime!.toInt(),
                    ),
                    groupHeaderBuilder: (MessageModel message) => const SizedBox(
                        // height: 40,
                        // child: Center(
                        //   child: Card(
                        //     color: Theme.of(context).primaryColor,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Text(
                        //         DateFormat.yMMMd().format(
                        //           DateTime.fromMillisecondsSinceEpoch(
                        //             message.sendDateTime!.toInt(),
                        //           ),
                        //         ),
                        //         style: Theme.of(context).textTheme.caption!.copyWith(
                        //           color: Colors.white,
                        //         )
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ),
                    // optio
                    itemBuilder: (context, MessageModel message) => Align(
                      alignment: message.sender!.id ==
                              context.read<UserProvider>().user!.id
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyMessageSide(
                          messageModel: message,
                        ),
                      ),
                    ), // nal
                  );
                },
              ),
            ),

            // message sending part
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: messageTextEditingController,
                      decoration: InputDecoration(
                          hintText: 'Type your message here...',
                          contentPadding: const EdgeInsets.all(12.0),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          )),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 22,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            if (messageTextEditingController.text.isNotEmpty) {
                              await context
                                  .read<MessageProvider>()
                                  .createNewMessage(
                                    messageTextEditingController.text.trim(),
                                    context.read<UserProvider>().user!.id!,
                                    messageGroup.id!,
                                  );

                              messageTextEditingController.text = '';
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
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
