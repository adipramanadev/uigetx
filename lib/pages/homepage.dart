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
            var user = userController.users[index];
            return Dismissible(
              key: Key(user['users_id'].toString()),
              onDismissed: (direction) {
                //untuk fungsi delete
                // userController.deleteData(user['users_id']).toString();
                userController
                    .deleteData(user['key_code'].toString())
                    .then((_) => {
                          userController.users.removeAt(index)
                          // Get.snackbar('Success', 'User deleted successfully',
                          //     snackPosition: SnackPosition.BOTTOM)
                        });
                userController.users.removeAt(index);
              },
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete),
              ),
              child: ListTile(
                title: Text(userController.users[index]['users_nm']),
                subtitle: Text(userController.users[index]['users_email']),
              ),
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
          content: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                userController.storeData(
                  nameController.text,
                  emailController.text,
                );
                userController.getData();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
