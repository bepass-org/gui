import 'dart:io';

import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/screens/main/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../skeleton/skeleton_screen.dart';

class LogsScreen extends ConsumerStatefulWidget {
  const LogsScreen({super.key});

  @override
  ConsumerState<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends ConsumerState<LogsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List to store log entries
  final List<LogEntry> logEntries = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else {
          ref.read(globalStateProvider.notifier).setActivePage(AppPage.configuration);
        }
      },
      child: BasePage(
        scaffoldKey: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: Platform.isAndroid,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Platform.isAndroid
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          title: const Text("Logs", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () {
                // Implement logic to refresh logs
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                // Implement logic to send logs
              },
              icon: const Icon(Icons.send),
            ),
            IconButton(
              onPressed: () {
                // Implement logic to delete logs
              },
              icon: const Icon(Icons.delete_sweep),
            ),
          ],
        ),
        // drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            reverse: true, // Scrolls to the bottom on updates
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: logEntries,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Adding sample log entries on initialization
    addLogEntry("2024-01-10 08:00:00", "DEBUG", "Debug log message 1");
    addLogEntry("2024-01-10 08:05:00", "ERROR", "Error log message 1");
    addLogEntry("2024-01-10 08:10:00", "INFO", "Info log message 1");
  }

  // Method to add a new log entry
  void addLogEntry(String timestamp, String logType, String message) {
    setState(() {
      logEntries.add(LogEntry(timestamp, logType, message));
    });
  }
}

// Widget representing a log entry
class LogEntry extends StatelessWidget {
  final String timestamp;
  final String logType;
  final String message;

  const LogEntry(this.timestamp, this.logType, this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the color based on log type
    Color logColor = Colors.black;

    if (logType == "ERROR") {
      logColor = Colors.red;
    } else if (logType == "DEBUG") {
      logColor = Colors.blue;
    }

    // Return a column containing timestamp, log type, and message
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$timestamp - $logType",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: logColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16), // Adjust the spacing as needed
      ],
    );
  }
}
