import 'package:flutter/material.dart';

class GoogleBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Set the background color to white
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ), // Adjust padding as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            14.0,
          ), // Optional: Add rounded corners
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // To keep the button content compact
        children: [
          Image.asset(
            'assets/icons/google.png', // The path to your Google logo asset
            height: 24.0, // Adjust the size of the logo as needed
          ),
          const SizedBox(
            width: 12.0,
          ), // Add some spacing between the logo and text
          const Text(
            'Continue with Google',
            style: TextStyle(
              color: Colors.black54, // Adjust text color as needed
              fontSize: 16.0, // Adjust text size as needed
            ),
          ),
        ],
      ),
    );
  }
}
