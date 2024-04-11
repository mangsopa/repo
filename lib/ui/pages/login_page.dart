part of 'pages.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                AuthServices.signIn(email, password).then((result) {
                  if (result.User_Model != null) {
                    // Navigate to main page if login successful
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            DashboardPage(), // Jika login berhasil, tampilkan dashboard
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result.message),
                      ),
                    );
                  }
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                // Panggil method signInWithGoogle dari AuthServices
                SignInSignUpResult result =
                    await AuthServices.signInWithGoogle();
                if (result.User_Model != null) {
                  // Sign in berhasil, navigasikan ke halaman Dashboard
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                } else {
                  // Sign in gagal, tampilkan pesan kesalahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.message),
                    ),
                  );
                }
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
