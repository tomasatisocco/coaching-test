import 'package:coaching/admin_panel/admin_page/widgets/status_icon.dart';
import 'package:flutter/material.dart';

class UserStatusRow extends StatelessWidget {
  const UserStatusRow({
    super.key,
    required this.userStatus,
  });

  final int userStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Progreso del usuario',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusIcon(
                icon: Icons.person,
                title: 'Registrado',
                isDone: userStatus >= 0,
              ),
              StatusIcon(
                icon: Icons.person,
                title: 'Info Personal',
                isDone: userStatus >= 1,
              ),
              StatusIcon(
                icon: Icons.payment_rounded,
                title: 'Pago',
                isDone: userStatus >= 2,
              ),
              StatusIcon(
                icon: Icons.file_open_rounded,
                title: 'Test Comenzado',
                isDone: userStatus >= 3,
              ),
              StatusIcon(
                icon: Icons.file_download_done_rounded,
                title: 'Test Finalizado',
                isDone: userStatus >= 4,
              ),
              StatusIcon(
                icon: Icons.send_rounded,
                title: 'Enviando Resultados',
                isDone: userStatus >= 5,
              ),
              StatusIcon(
                icon: Icons.mark_email_read_rounded,
                title: 'Resultado enviado',
                isDone: userStatus >= 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
