import 'package:flutter/material.dart';


import '../../../constants/strings.dart';
import '../../constants/icons.dart';
import '../../services/cache/shared_manager.dart';

class ProjectAppBar extends StatelessWidget with ProjectIcons, ProjectStrings implements PreferredSizeWidget {
  ProjectAppBar({
    super.key,
    this.manager, required this.onExitClick,
  });

  final SharedManager? manager;
  final void Function() onExitClick;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Weight Tracker'),
      centerTitle: true,
      actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: IconButton(icon: Icon(Icons.exit_to_app), onPressed: onExitClick,),
         )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
