import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.id,
    required this.type,
    required this.totalUploadTraffic,
    required this.uploadMeasureUnit,
    required this.totalDownloadTraffic,
    required this.downloadMeasureUnit,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  final bool isSelected;
  final String title;
  final String id;
  final String type;
  final double totalUploadTraffic;
  final String uploadMeasureUnit;
  final double totalDownloadTraffic;
  final String downloadMeasureUnit;
  final Function() onTap;
  final Function(String) onDelete;
  final Function(String) onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.onPrimary,
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Ink(
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
        child: InkWell(
          child: ListTile(
            onTap: onTap,
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onDelete(id);
                    },
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
