import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 2 Exercise 1',
      debugShowCheckedModeBanner: false,
      home: Practice02(),
    );
  }
}

class Practice02 extends StatefulWidget {
  const Practice02({super.key});

  @override
  State<Practice02> createState() => _Practice02State();
}

class _Practice02State extends State<Practice02> {
  final TextEditingController _controller = TextEditingController();
  String? errorMessage;
  List<int> numbers = [];


  void _createList() {
    setState(() {
      final input = int.tryParse(_controller.text);

      if (input == null || input <= 0) {
        errorMessage = 'Dữ liệu bạn nhập không hợp lệ.';
        numbers = [];
      } else {
        errorMessage = null;
        numbers = List<int>.generate(input, (index) => index + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Thực hành 02",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Row(children: [Expanded(child: TextField(controller: _controller,keyboardType: TextInputType.number,decoration: const InputDecoration(hintText: "Nhập vào số lượng",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
            ),),),),
            const SizedBox(width: 12),
            ElevatedButton(onPressed: _createList, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
            ),),
            child: const Text("Tạo"),
            ),
            ],),

            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(errorMessage!, style: const TextStyle(color: Colors.red),),
            ],

            const SizedBox(height: 20),

            Expanded(child: ListView.builder(itemCount: numbers.length, itemBuilder: (context, index) {
              return Container(margin: const EdgeInsets.symmetric(vertical: 6),child: ElevatedButton(onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),
              ),padding: const EdgeInsets.symmetric(vertical: 14),),
              child: Text(numbers[index].toString(),style: const TextStyle(fontSize: 18),
               ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}