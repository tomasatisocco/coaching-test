import 'package:coaching/app/widgets/coaching_drawer.dart';
import 'package:coaching/authentication/login/view/login_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static const name = 'StartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CoachingDrawer(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ).createShader(
                Rect.fromLTRB(0, -140, rect.width, rect.height - 20),
              );
            },
            blendMode: BlendMode.darken,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/cover.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/live_as_coach_icon.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 200),
                const Text(
                  'GPS VCC',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 400,
                  child: Text(
                    context.l10n.localizeYourself,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => const LoginPage(),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        context.l10n.getStarted,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              return Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
