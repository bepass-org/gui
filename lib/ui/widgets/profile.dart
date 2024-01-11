import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.type,
    required this.totalUploadTraffic,
    required this.uploadMeasureUnit,
    required this.totalDownloadTraffic,
    required this.downloadMeasureUnit,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String type;
  final double totalUploadTraffic;
  final String uploadMeasureUnit;
  final double totalDownloadTraffic;
  final String downloadMeasureUnit;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.onPrimary,

      /// Example: Many items have their own colors inside of the ThemData
      /// You can overwrite them in [config/theme.dart].
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.015, 0.015],
            colors: [
              isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.onPrimaryContainer,
              Theme.of(context).colorScheme.onPrimaryContainer,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: ListTile(
          onTap: () => onTap(title),
          title: Row(
            children: <Widget>[
              Icon(Ionicons.apps, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(fontWeightDelta: 2),
                  ),
                  Text(
                    type,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              )
            ],
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit),
              SizedBox(width: 10),
              Icon(Icons.share),
              SizedBox(width: 10),
              Icon(Icons.delete),
            ],
          ),
        ),
      ),
    );
  }
}
