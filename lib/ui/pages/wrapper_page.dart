part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = FirebaseAuth.instance.currentUser;

    if (users != null) {
      return DashboardPage(); // User sudah login, tampilkan MainPage
    } else {
      return LoginPage(); // User belum login, tampilkan LoginPage
    }
  }
}
