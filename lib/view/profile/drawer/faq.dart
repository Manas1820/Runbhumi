import 'package:Runbhumi/widget/widgets.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: buildTitle(context, "FAQ"),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            child: Text(
              'Teams',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("Who is a team manager?"),
              children: [
                ListTile(
                  title: Text(
                      "The person who creates a team is initially the captain and the manager of the team. A team manager represents the team in events and challenge matches as he is only one who gets attend to the events and team challenge chatrooms. The managers are expected to communicate with each other and then pass the information to their respective teams."),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("What all can a team manager do?"),
              children: [
                ListTile(
                  title: Text(
                      "A team manager can transfer captainship. They can apply for team to be verified. They can challenge other teams with their team. Since they are the only people who get added to the event and challenge chatrooms they are referred to as point of contact.  We recommend user to manage only one team for each sport to avoid confusion."),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            child: Text(
              'Team Verification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(" What is a verified team?"),
              children: [
                ListTile(
                  title: Text(
                      "A verified team represents a team which had been playing the sport promisingly for a good amount of time or for an institution. They consist of well recognized players such as district level and beyond and are actively looking for challenges."),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("Who can apply for verification?"),
              children: [
                ListTile(
                  title: Text(
                      "Only the team Manager can apply for his/her team's verification. "),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                  "How long will it take for the team verification process to be complete?"),
              children: [
                ListTile(
                  title: Text(
                      "We may take around 1-2 weeks to verify a valid team. Usually it is done faster, but the time might vary on other circumstances. For the status of your application please write to us on our website."),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("What does the process of verification look like?"),
              children: [
                ListTile(
                  title: Text(
                      "After the submitting a verification application, our team will be in contact with the team manager via email. We may ask the team manager to show proof of some requirements such as certificates and frequency of playing match and then verify a team if they our conditions."),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            child: Text(
              'Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("What events can we post?"),
              children: [
                ListTile(
                  title: Text(
                      "You can post events ranging from searching for a team to play with to hosting a tournament."),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text(
                  "What is the difference between individual and team events?"),
              children: [
                ListTile(
                  title: Text(
                      "Individual events are the events where you are inviting individuals to join. The event chat room will consist of individual players who joined and the event organizer." +
                          '\n' +
                          "Team events are for teams alone. Only managers with teams of the same sport can register their teams for the event. The event chatroom consist of all the teams managers and the event organizer."),
                ),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: Text("What is the difference between public and private?"),
              children: [
                ListTile(
                  title: Text(
                      "Public events work on first come first serve basis since there is no step of verification. All the people who register are directly added to the event chatroom." +
                          "\n" +
                          "Private events trigger notifications to the creator, on which the creator can chose if they want to let the person into their event or not."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
