part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String _userName = ''; // Variabel untuk menyimpan nama pengguna
  late String _emailName = ''; // Variabel untuk menyimpan email penggunas
  final AuthServices _authService = AuthServices();

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Panggil metode untuk memuat nama pengguna saat initState
  }

  Future<void> _loadUserName() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      UserData? userData = await UserServices.getUserData(uid);
      if (userData != null) {
        setState(() {
          _userName =
              userData.name ?? ''; // Set nama pengguna ke dalam variabel lokal
          _emailName = userData.email ??
              ''; // Set email pengguna ke dalam variabel lokal
        });
      } else {
        // Handle jika data tidak ditemukan atau terjadi kesalahan
        print('Error loading user data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      // Di dalam build method
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $_userName'), // Tampilkan nama pengguna di sini
            Text('Email: $_emailName'), // Tampilkan email pengguna di sini
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
