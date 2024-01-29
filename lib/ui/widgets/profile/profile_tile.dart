import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
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
  final Function() onDelete;
  final Function() onEdit;

  String formatDouble(double value) {
    String formatted = value.toStringAsFixed(2); // Convert to string with 2 decimal places
    if (formatted.endsWith('.00')) {
      // If the string ends with '.00', remove this part
      formatted = formatted.substring(0, formatted.length - 3);
    }
    return formatted;
  }

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
            onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    const SizedBox(height: 10),
                    Text(
                      type,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 120,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.edit),
                                onPressed: onEdit,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.delete),
                                onPressed: onDelete,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      totalUploadTraffic != 0 && totalDownloadTraffic != 0 ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            formatDouble(totalUploadTraffic),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            uploadMeasureUnit,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formatDouble(totalDownloadTraffic),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            downloadMeasureUnit,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ) : const Row(
                        children: [
                          SizedBox(height: 10,)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),



          ),
        ),
      ),
    );
  }
}
