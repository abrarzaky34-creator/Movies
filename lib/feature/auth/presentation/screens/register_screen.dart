
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
const RegisterScreen({super.key});

@override
State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController =
TextEditingController();
final TextEditingController phoneController = TextEditingController();

bool _obscurePassword = true;
bool _obscureConfirmPassword = true;
bool _isLoading = false;

final List<String> _avatars = [
'assets/images/avatar1.png',
'assets/images/avatar2.png',
'assets/images/avatar3.png',
];

int _selectedAvatar = 1;

@override
void dispose() {
nameController.dispose();
emailController.dispose();
passwordController.dispose();
confirmPasswordController.dispose();
phoneController.dispose();
super.dispose();
}

Future<void> _createAccount() async {
final String name = nameController.text.trim();
final String email = emailController.text.trim();
final String password = passwordController.text;
final String confirmPassword = confirmPasswordController.text;

if (name.isEmpty ||
email.isEmpty ||
password.isEmpty ||
confirmPassword.isEmpty) {
_showMessage('Please fill in all required fields.');
return;
}

if (password != confirmPassword) {
_showMessage('Passwords do not match.');
return;
}

if (password.length < 6) {
_showMessage('Password must be at least 6 characters.');
return;
}

setState(() {
_isLoading = true;
});

try {
final UserCredential credential =
await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: email,
password: password,
);

await credential.user?.updateDisplayName(name);

if (!mounted) return;

_showMessage('Account created successfully.');

Navigator.pop(context);
} on FirebaseAuthException catch (e) {
String message;

switch (e.code) {
case 'email-already-in-use':
message = 'This email is already registered.';
break;

case 'invalid-email':
message = 'Please enter a valid email address.';
break;

case 'weak-password':
message = 'The password is too weak.';
break;

case 'network-request-failed':
message = 'Please check your internet connection.';
break;

default:
message = e.message ?? 'Failed to create account.';
}

if (mounted) {
_showMessage(message);
}
} catch (e) {
if (mounted) {
_showMessage('Something went wrong. Please try again.');
}
} finally {
if (mounted) {
setState(() {
_isLoading = false;
});
}
}
}

void _showMessage(String message) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(message),
),
);
}

Widget _buildTextField({
required String hintText,
required TextEditingController controller,
bool obscureText = false,
Widget? suffixIcon,
TextInputType? keyboardType,
}) {
return TextField(
controller: controller,
obscureText: obscureText,
keyboardType: keyboardType,
style: const TextStyle(
color: Colors.white,
),
decoration: InputDecoration(
hintText: hintText,
hintStyle: const TextStyle(
color: Colors.grey,
),
filled: true,
fillColor: const Color(0xFF1C1C1C),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: BorderSide.none,
),
suffixIcon: suffixIcon,
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF121312),
appBar: AppBar(
backgroundColor: const Color(0xFF121312),
elevation: 0,
leading: IconButton(
icon: const Icon(
Icons.arrow_back,
color: Colors.white,
),
onPressed: () {
Navigator.pop(context);
},
),
title: const Text(
'Create Account',
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(
horizontal: 24,
vertical: 16,
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Create your account',
style: TextStyle(
color: Colors.white,
fontSize: 28,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
const Text(
'Sign up to continue',
style: TextStyle(
color: Colors.grey,
fontSize: 15,
),
),
const SizedBox(height: 30),

Center(
child: Column(
children: [
CircleAvatar(
radius: 48,
backgroundColor: const Color(0xFF2A2A2A),
backgroundImage: AssetImage(
_avatars[_selectedAvatar],
),
),
const SizedBox(height: 16),
const Text(
'Choose your avatar',
style: TextStyle(
color: Colors.white,
fontSize: 15,
),
),
const SizedBox(height: 12),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(
_avatars.length,
(index) {
return GestureDetector(
onTap: () {
setState(() {
_selectedAvatar = index;
});
},
child: Container(
margin:
const EdgeInsets.symmetric(horizontal: 6),
padding: const EdgeInsets.all(2),
decoration: BoxDecoration(
shape: BoxShape.circle,
border: Border.all(
color: _selectedAvatar == index
? const Color(0xFFF6BD00)
    : Colors.transparent,
width: 2,
),
),
child: CircleAvatar(
radius: 25,
backgroundImage: AssetImage(
_avatars[index],
),
),
),
);
},
),
),
],
),
),

const SizedBox(height: 30),

_buildTextField(
hintText: 'Full Name',
controller: nameController,
),

const SizedBox(height: 16),

_buildTextField(
hintText: 'Email',
controller: emailController,
keyboardType: TextInputType.emailAddress,
),

const SizedBox(height: 16),

_buildTextField(
hintText: 'Phone Number',
controller: phoneController,
keyboardType: TextInputType.phone,
),

const SizedBox(height: 16),

_buildTextField(
hintText: 'Password',
controller: passwordController,
obscureText: _obscurePassword,
suffixIcon: IconButton(
icon: Icon(
_obscurePassword
? Icons.visibility_off
    : Icons.visibility,
color: Colors.grey,
),
onPressed: () {
setState(() {
_obscurePassword = !_obscurePassword;
});
},
),
),

const SizedBox(height: 16),

_buildTextField(
hintText: 'Confirm Password',
controller: confirmPasswordController,
obscureText: _obscureConfirmPassword,
suffixIcon: IconButton(
icon: Icon(
_obscureConfirmPassword
? Icons.visibility_off
    : Icons.visibility,
color: Colors.grey,
),
onPressed: () {
setState(() {
_obscureConfirmPassword = !_obscureConfirmPassword;
});
},
),
),

const SizedBox(height: 30),

SizedBox(
width: double.infinity,
height: 55,
child: ElevatedButton(
onPressed: _isLoading ? null : _createAccount,
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFF6BD00),
disabledBackgroundColor:
const Color(0xFFF6BD00).withValues(alpha: 0.5),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
),
),
child: _isLoading
? const SizedBox(
width: 24,
height: 24,
child: CircularProgressIndicator(
strokeWidth: 2.5,
color: Colors.black,
),
)
    : const Text(
'Create Account',
style: TextStyle(
color: Colors.black,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),

const SizedBox(height: 24),

Center(
child: GestureDetector(
onTap: () {
Navigator.pop(context);
},
child: RichText(
text: const TextSpan(
children: [
TextSpan(
text: 'Already have an account? ',
style: TextStyle(
color: Colors.grey,
fontSize: 14,
),
),
TextSpan(
text: 'Login',
style: TextStyle(
color: Color(0xFFF6BD00),
fontSize: 14,
fontWeight: FontWeight.bold,
),
),
],
),
),
),
),

const SizedBox(height: 30),
],
),
),
),
);
}
}
