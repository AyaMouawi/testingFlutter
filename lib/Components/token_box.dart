import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushnotificationupdate1/Style/my_colors.dart';
import 'package:pushnotificationupdate1/Style/text_style.dart';

class TokenBox extends StatefulWidget {
  final String firebaseToken;
  final bool isLoading;

  const TokenBox({
    Key? key,
    required this.firebaseToken,
    required this.isLoading,
  }) : super(key: key);

  @override
  _TokenBoxState createState() => _TokenBoxState();
}

class _TokenBoxState extends State<TokenBox> {
  bool isCopied = false;

  void copyToClipboard(String token) {
    Clipboard.setData(ClipboardData(text: token));
    setState(() {
      isCopied = true;
    });
    // Revert the "Copied Successfully" message after a short delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: MyColors.boxShadowColor,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : isCopied
              ?  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Token copied successfully',
                      style: AppTextStyles.responseMessageSuccess,
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Firebase Token',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.firebaseToken,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.tokenStyle,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: MyColors.white,
                          backgroundColor: MyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => copyToClipboard(widget.firebaseToken),
                        child: const Text('Copy Token'),
                      ),
                    ),
                  ],
                ),
    );
  }
}
