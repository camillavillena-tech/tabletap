import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'menu_screen.dart';

class MobileScannerScreen extends StatefulWidget {
  const MobileScannerScreen({
    super.key,
  });

  @override
  State<MobileScannerScreen> createState() =>
      _MobileScannerScreenState();
}

class _MobileScannerScreenState extends State<MobileScannerScreen> {
  static const Color orange = Color(0xFFE85D04);
  static const Color bg = Color(0xFFFFF6EE);
  static const Color dark = Color(0xFF3A2F2A);

  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [
      BarcodeFormat.qrCode,
    ],
  );

  bool _scanning = false;
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleScan() async {
    if (_scanning) {
      await _stopScanner();
      return;
    }

    _handled = false;

    setState(() {
      _scanning = true;
    });

    await WidgetsBinding.instance.endOfFrame;

    if (!mounted) {
      return;
    }

    try {
      await _controller.start();
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _scanning = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to start the camera. Please allow camera access and try again.',
          ),
        ),
      );
    }
  }

  Future<void> _stopScanner() async {
    try {
      await _controller.stop();
    } catch (_) {}

    if (!mounted) {
      return;
    }

    setState(() {
      _scanning = false;
    });
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final String? code = capture.barcodes.first.rawValue;

    if (code == null || code.isEmpty) {
      return;
    }

    final String? tableNumber = _getTableNumber(code);

    if (tableNumber == null) {
      _showInvalidQrMessage();
      return;
    }

    _handled = true;

    await _controller.stop();

    if (!mounted) {
      return;
    }

    setState(() {
      _scanning = false;
    });

    _goToMenu(tableNumber);
  }

  String? _getTableNumber(String code) {
    final RegExp tablePattern = RegExp(
      r'^TABLE-(\d+)$',
      caseSensitive: false,
    );

    final match = tablePattern.firstMatch(
      code.trim(),
    );

    if (match == null) {
      return null;
    }

    return match.group(1);
  }

  void _showInvalidQrMessage() {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Invalid TableTap QR code.',
        ),
      ),
    );
  }

  void _goToMenu(String tableNumber) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MenuScreen(
          tableNumber: tableNumber,
        ),
      ),
    );
  }

  void _goToDemoMenu() {
    _goToMenu('02');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                8,
                8,
                8,
                0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                  const Text(
                    'TableTap',
                    style: TextStyle(
                      color: orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 56,
                    ),

                    const Text(
                      'Scan to order',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Scan the QR code on your table to see\n'
                      'the menu and place your order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(
                      height: 32,
                    ),

                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 230,
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: dark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFD9C7B8),
                                width: 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (_scanning)
                                    MobileScanner(
                                      controller: _controller,
                                      onDetect: _onDetect,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    const Center(
                                      child: Icon(
                                        Icons.qr_code_scanner_rounded,
                                        size: 72,
                                        color: Colors.white70,
                                      ),
                                    ),

                                  const CustomPaint(
                                    painter: _CornerPainter(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 56,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _toggleScan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _scanning
                              ? 'Stop Scanning'
                              : 'Scan QR Code',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    Text(
                      'Unable to scan? Ask the staff member for help',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: _goToDemoMenu,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: orange,
                          side: const BorderSide(
                            color: orange,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Go to Menu (For Demonstration Purposes)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  const _CornerPainter();

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFFE85D04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const double inset = 20;
    const double len = 34;
    const double r = 12;

    final double l = inset;
    final double t = inset;
    final double rt = size.width - inset;
    final double b = size.height - inset;

    final path = Path();

    path.moveTo(l + len, t);
    path.lineTo(l + r, t);
    path.quadraticBezierTo(
      l,
      t,
      l,
      t + r,
    );
    path.lineTo(l, t + len);

    path.moveTo(rt - len, t);
    path.lineTo(rt - r, t);
    path.quadraticBezierTo(
      rt,
      t,
      rt,
      t + r,
    );
    path.lineTo(rt, t + len);

    path.moveTo(l, b - len);
    path.lineTo(l, b - r);
    path.quadraticBezierTo(
      l,
      b,
      l + r,
      b,
    );
    path.lineTo(l + len, b);

    path.moveTo(rt, b - len);
    path.lineTo(rt, b - r);
    path.quadraticBezierTo(
      rt,
      b,
      rt - r,
      b,
    );
    path.lineTo(rt - len, b);

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}