import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
static const String routeName = 'forget_password';

const ForgetPasswordScreen({super.key});

@override
State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
final TextEditingController emailController = TextEditingController();

@override
void dispose() {
emailController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return BlocProvider(
create: (_) => ForgetPasswordCubit(),
child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
listener: (context, state) {
if (state is ForgetPasswordSuccess) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Password reset email sent successfully.',
),
),
);
}

if (state is ForgetPasswordError) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(state.message),
),
);
}
},
child: Scaffold(
appBar: AppBar(
title: const Text(
'Forget Password',
style: TextStyle(
color: Color(0xFFF6BD00),
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
centerTitle: true,
leading: IconButton(
icon: const Icon(
Icons.arrow_back,
color: Color(0xFFF6BD00),
),
onPressed: () {
Navigator.pop(context);
},
),
backgroundColor: Colors.transparent,
elevation: 0,
),
body: SafeArea(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
const SizedBox(height: 20),
Center(
child: Image.asset(
'assets/images/forget_password_img.png',
height: 320,
width: double.infinity,
fit: BoxFit.contain,
),
),
const SizedBox(height: 32),
TextField(
controller: emailController,
keyboardType: TextInputType.emailAddress,
style: const TextStyle(
color: Colors.white,
),
decoration: InputDecoration(
hintText: 'Email',
hintStyle: const TextStyle(
color: Colors.grey,
),
prefixIcon: const Icon(
Icons.email,
color: Colors.white,
),
filled: true,
fillColor: const Color(0xFF282A28),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
borderSide: BorderSide.none,
),
),
),
const SizedBox(height: 24),
SizedBox(
height: 55,
child: BlocBuilder<ForgetPasswordCubit,
ForgetPasswordState>(
builder: (context, state) {
final bool isLoading =
state is ForgetPasswordLoading;

return ElevatedButton(
onPressed: isLoading
? null
    : () {
context
    .read<ForgetPasswordCubit>()
    .sendPasswordResetEmail(
emailController.text,
);
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFF6BD00),
disabledBackgroundColor: Colors.grey,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
),
),
child: isLoading
? const SizedBox(
width: 24,
height: 24,
child: CircularProgressIndicator(
strokeWidth: 2,
color: Colors.black,
),
)
    : const Text(
'Verify Email',
style: TextStyle(
color: Colors.black,
fontSize: 20,
fontWeight: FontWeight.w600,
),
),
);
},
),
),
],
),
),
),
),
),
);
}
}