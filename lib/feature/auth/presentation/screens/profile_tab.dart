import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = 'profile_tab';

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 38,
                        backgroundImage: AssetImage('assets/images/avatar3.png'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'John Safwat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _buildStatItem('12', 'Wish List'),
                      const SizedBox(width: 32),
                      _buildStatItem('10', 'History'),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF6BD00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Exit', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 4),
                          Icon(Icons.exit_to_app, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabHeader(Icons.format_list_bulleted, 'Watch List', true),
                  _buildTabHeader(Icons.folder_open, 'History', false),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 0.5),
              const Spacer(),
              Image.asset(
                'assets/images/empty_list.png',
                height: 120,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildTabHeader(IconData icon, String title, bool isSelected) {
    return Column(
      children: [
        Icon(icon, color: isSelected ? const Color(0xFFF6BD00) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFF6BD00) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}