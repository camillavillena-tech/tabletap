import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'menu_screen.dart';

class ScanToOrderScreen extends StatefulWidget {
  const ScanToOrderScreen({super.key});

  @override
  State<ScanToOrderScreen> createState() => _ScanToOrderScreenState();
}

class _ScanToOrderScreenState extends State<ScanToOrderScreen> {
  static const Color orange = Color(0xFFE85D04);
  static const Color bg = Color(0xFFFFF6EE);
  static const Color dark = Color(0xFF3A2F2A);

  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
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
      await _controller.stop();
    } else {
      _handled = false;
      await _controller.start();
    }
    setState(() => _scanning = !_scanning);
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null || code.isEmpty) return;

    _handled = true;
    _controller.stop();
    setState(() => _scanning = false);

    _goToMenu();
  }

  void _goToMenu() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.black,
                      onPressed: () => Navigator.maybePop(context),
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 56),
                    const Text(
                      'Scan to order',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Scan the QR code on your table to see\nthe menu and place your order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Scanner box
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 230),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: dark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xFFD9C7B8), width: 1.5),
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
                                    ),
                                  const CustomPaint(painter: _CornerPainter()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 56),

                    // Scan button
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
                          _scanning ? 'Stop Scanning' : 'Scan QR Code',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Unable to scan? Ask the staff member for help',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // DEMO ONLY: skip scanning and go straight to the menu.
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: _goToMenu,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: orange,
                          side: const BorderSide(color: orange, width: 1.5),
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
                    const SizedBox(height: 24),
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

/// Orange rounded corner brackets for the viewfinder.
class _CornerPainter extends CustomPainter {
  const _CornerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE85D04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const inset = 20.0; // distance from box edge
    const len = 34.0; // bracket arm length
    const r = 12.0; // corner radius

    final l = inset, t = inset, rt = size.width - inset, b = size.height - inset;

    Path corner(double x, double y, double dx, double dy) => Path()
      ..moveTo(x + dx * len, y)
      ..lineTo(x + dx * r, y)
      ..quadraticBezierTo(x, y, x, y + dy * r)
      ..lineTo(x, y + dy * len);

    canvas.drawPath(corner(l, t, 1, 1), paint); // top-left
    canvas.drawPath(corner(rt, t, -1, 1), paint); // top-right
    canvas.drawPath(corner(l, b, 1, -1), paint); // bottom-left
    canvas.drawPath(corner(rt, b, -1, -1), paint); // bottom-right
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}