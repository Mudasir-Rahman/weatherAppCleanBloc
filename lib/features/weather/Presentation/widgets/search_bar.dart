import 'package:flutter/material.dart';

class WeatherSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const WeatherSearchBar({super.key, required this.onSearch});

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Search city...',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white54 : Colors.grey.shade500,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onSearch(value);
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSearch(_controller.text);
              _controller.clear();
              FocusScope.of(context).unfocus();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B4F8A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: const Text('Search'),
        ),
      ],
    );
  }
}