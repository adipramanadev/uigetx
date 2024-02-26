part of 'pages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Demo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(userController.users[index]['users_nm']),
              subtitle: Text(userController.users[index]['users_email']),
            );
          },
        ),
      ),
    );
  }
}
