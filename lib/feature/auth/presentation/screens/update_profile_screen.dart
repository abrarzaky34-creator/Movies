import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/update_profile_cubit.dart';
import '../../../../core/routes/app_routes.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = 'update_profile';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  String selectedAvatar = 'assets/images/avatar3.png';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'John Safwat');
    phoneController = TextEditingController(text: '01200000000');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282A28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final String avatarPath =
                      'assets/images/avatar${index + 1}.png';

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = avatarPath;
                      });
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(avatarPath),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateProfileCubit(),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Operation completed successfully.'),
              ),
            );
          }

          if (state is UpdateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF121312),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFF6BD00),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Update Profile',
              style: TextStyle(
                color: Color(0xFFF6BD00),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _showAvatarBottomSheet(context),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(selectedAvatar),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Pick Avatar',
                            style: TextStyle(
                              color: Color(0xFFF6BD00),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF282A28),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF282A28),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgetPassword,
                          );
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE52424),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BlocBuilder<UpdateProfileCubit,
                          UpdateProfileState>(
                        builder: (context, state) {
                          final bool isLoading =
                          state is UpdateProfileLoading;

                          return ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                              context
                                  .read<UpdateProfileCubit>()
                                  .updateProfile(
                                name: nameController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF6BD00),
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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
                              'Update Data',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}