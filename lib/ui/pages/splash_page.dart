part of 'pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Tambahkan timer untuk mengarahkan ke halaman berikutnya setelah 3 detik
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                Wrapper()), // Ganti dengan halaman berikutnya setelah splash
      );
    });
  }

  Widget build(BuildContext context) {
    // Simulasi delay 3 detik untuk splash screen
    Future.delayed(Duration(seconds: 3), () {
      // Setelah selesai, simpan status pertama kali dijalankan
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('first_time', false);
      });

      // Pindah ke halaman berikutnya (misalnya, login page)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
