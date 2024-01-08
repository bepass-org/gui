import 'package:defacto/ui/screens/configuration.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// TODO: need to make more beautiful

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ConfigurationScreen(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("About", style: TextStyle(color: Colors.white)),
        ),
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Material(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Defacto Proxy App Card
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Defacto Proxy App",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Bypassing the Great Firewall (GFW)",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Divider(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Versions Card
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Versions",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          2,
                          (index) => Row(
                            children: [
                              Icon(
                                index == 0
                                    ? Icons.android
                                    : Icons.system_security_update,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  index == 0
                                      ? "Current Version: 1.0.0"
                                      : "ABI Version: 2.0.0",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Links Card
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              launchUrlString("https://github.com/bepass-org");
                            },
                            icon: const Icon(Icons.code),
                            label: const Text("View Source Code"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Licenses Card
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Licenses",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.book_rounded,
                              size: 24,
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          2,
                          (index) => Row(
                            children: [
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  index == 0 ? "MIT License" : "GNU License",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
