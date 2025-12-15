import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Practice03(),
    );
  }
}

enum Op { add, sub, mul, div }

class Practice03 extends StatefulWidget {
  const Practice03({super.key});

  @override
  State<Practice03> createState() => _Practice03State();
}

class _Practice03State extends State<Practice03> {
  final aCtrl = TextEditingController();
  final bCtrl = TextEditingController();

  Op? selected;
  String resultText = ""; // để y như hình: "Kết quả: 8" hoặc trống

  double? _parse(String s) => double.tryParse(s.trim());

  void _recalc() {
    final a = _parse(aCtrl.text);
    final b = _parse(bCtrl.text);

    if (a == null || b == null || selected == null) {
      setState(() => resultText = "");
      return;
    }

    double res;
    switch (selected!) {
      case Op.add:
        res = a + b;
        break;
      case Op.sub:
        res = a - b;
        break;
      case Op.mul:
        res = a * b;
        break;
      case Op.div:
        if (b == 0) {
          setState(() => resultText = "Lỗi: chia cho 0");
          return;
        }
        res = a / b;
        break;
    }

    // nếu ra số nguyên thì hiển thị như 8, không phải 8.0
    final isInt = res % 1 == 0;
    setState(() => resultText = isInt ? res.toInt().toString() : res.toString());
  }

  Widget _opButton({
    required String label,
    required Color color,
    required Op op,
  }) {
    final bool isSelected = selected == op;

    return GestureDetector(
      onTap: () {
        setState(() => selected = op);
        _recalc();
      },
      child: Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    aCtrl.dispose();
    bCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Thực hành 03",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 22),

            // ô nhập số 1
            TextField(
              controller: aCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _recalc(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // hàng phép toán
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _opButton(label: "+", color: const Color(0xFFE74C3C), op: Op.add),
                _opButton(label: "-", color: const Color(0xFFF4B63D), op: Op.sub),
                _opButton(label: "*", color: const Color(0xFF6C5CE7), op: Op.mul),
                _opButton(label: "/", color: const Color(0xFF2D3436), op: Op.div),
              ],
            ),
            const SizedBox(height: 16),

            // ô nhập số 2
            TextField(
              controller: bCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _recalc(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                resultText.isEmpty ? "Kết quả:" : "Kết quả: $resultText",
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 120), // để trống phía dưới giống hình
          ],
        ),
      ),
    );
  }
}
