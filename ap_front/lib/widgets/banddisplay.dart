import 'package:ap_front/models/member.dart';
import 'package:flutter/material.dart';

class BandMembersList extends StatefulWidget {
  final String bandName;
  final List<Member> members;

  const BandMembersList({
    super.key,
    required this.bandName,
    required this.members,
  });

  @override
  State<BandMembersList> createState() => _BandMembersListState();
}

class _BandMembersListState extends State<BandMembersList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: TextButton(
            child: Text(
              widget.bandName != ""
                  ? "${widget.bandName}\u2002${!isExpanded ? "\u21E9" : "\u21E7"}"
                  : "",
              style: theme.headlineLarge,
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.members
                  .map(
                    (member) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${member.firstName} ${member.lastName}",
                          textAlign: TextAlign.left,
                          style: theme.bodyMedium?.copyWith(
                              fontFamily: "Gill Sans MT Bold",
                              color: scheme.primary),
                        ),
                        Text(
                          member.instrument,
                          style: theme.bodyMedium,
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
