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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
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

  //widget for dialog
  void _showDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add User'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                userController.storeData(
                  nameController.text,
                  emailController.text,
                );
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
