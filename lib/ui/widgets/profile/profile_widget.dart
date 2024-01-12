import 'package:defacto/models/profile.dart';
import 'package:defacto/ui/widgets/profile/profile_tile.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.profile,
    required this.activeProfileId,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  final Profile profile;
  final String activeProfileId;
  final Function() onTap;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      id: profile.id,
      title: profile.name,
      type: profile.type,
      isSelected: profile.id == activeProfileId,
      totalUploadTraffic: profile.totalUploadTraffic,
      uploadMeasureUnit: profile.uploadMeasureUnit,
      totalDownloadTraffic: profile.totalDownloadTraffic,
      downloadMeasureUnit: profile.downloadMeasureUnit,
      onTap: onTap,
      onDelete: onDelete,
      onEdit: onEdit,
    );
  }
}
