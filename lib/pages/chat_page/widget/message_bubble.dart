import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.username,
    required this.timestamp,
    required this.previousTimestamp,
    required this.isMe,
  }) : super(key: key);

  final String message;
  final String username;
  final int timestamp;
  final int previousTimestamp;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime previousTime =
        DateTime.fromMillisecondsSinceEpoch(previousTimestamp);
    DateTime timeNow = DateTime.now();
    var formats = DateFormat();

    var visibleMessageDate = false;

    // wyświetla date nad wiadomością tylko gdy poprzednia była ponad 15 min wcześniej
    if (time.isAfter(previousTime.add(const Duration(minutes: 15)))) {
      visibleMessageDate = true;
    }

    // dekorator daty
    if (time.year == timeNow.year &&
        time.month == timeNow.month &&
        time.day == timeNow.day) {
      formats = DateFormat("HH:mm");
    } else if (time.isAfter(timeNow.subtract(const Duration(days: 7)))) {
      formats = DateFormat("EEEE • HH:mm");
    } else if (time.year == timeNow.year) {
      formats = DateFormat("EE d MMM • HH:mm");
    } else {
      formats = DateFormat("EE d MMM yyyy • HH:mm");
    }
    var dateString = formats.format(time);

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        visibleMessageDate
            ? Center(
                child: Text(dateString),
              )
            : const SizedBox(),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: isImage()
                    ? null
                    : isMe
                        ? Theme.of(context).primaryColor
                        : Colors.grey[350],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              padding: isImage()
                  ? null
                  : const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  isImage()
                      ? GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Material(
                                  type: MaterialType.transparency,
                                  child: Center(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                      ),
                                      child: Image.network(
                                        message,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 200,
                              maxHeight: 200,
                            ),
                            child: Image.network(
                              message,
                            ),
                          ),
                        )
                      : Text(
                          message,
                          style: TextStyle(
                            fontSize: 16,
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isImage() {
    if (message.length < 76) {
      return false;
    } else {
      if (message.substring(0, 77) ==
          'https://firebasestorage.googleapis.com/v0/b/serwis-rowerowy-17a8b.appspot.com') {
        return true;
      }
    }
    return false;
  }
}
