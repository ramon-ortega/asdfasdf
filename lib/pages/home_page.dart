import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_app/db/app_theme.dart';
import 'package:sembast_app/db/users_store.dart';
import 'package:sembast_app/models/user.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<User> _users=[];
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final Finder? finder = Finder(
      sortOrders: [
        SortOrder('age', false),
        SortOrder('name')
      ],
      // filter: Filter.greaterThanOrEquals('age', 37), // Sirve para filtrar datos
    );
    _users = await UsersStore.instance.find(finder: finder);
    setState(() {});
  }

  _add() async {
    final User user = User.fakeUser();
    await UsersStore.instance.add(user);
    _users.add(user);
    setState(() {});
  }

  _delete() async {
    final Finder? finder = Finder(
      // filter: Filter.greaterThan("age", 55) // Elimina los elementos mayores a 55
      // Filter.equals("edad", 55) Elimina un elemento en Especifico
      // Filter.lessThan("age", 55) // Los usuarios inferiores a 55 años
      // Filter.matches('name', '^Mr.'), // Elimina los nombres segun la expresion regular Mr.
      // Filter.and([
      //    Filter.greaterThan('age', 70),
      //    Filter.matches('name', '^Mr.'),        
      // ]); Elimina si cumple estas dos condiciones
    );
    final int count = await UsersStore.instance.delete();
    final SnackBar snackBar = SnackBar(
      content: Text("$count items deleted")
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar
    );
    _load();
  }

  _deleteUser(User user) async {
    final Finder finder = Finder(filter: Filter.byKey(user.id));
    final int count = await UsersStore.instance.delete(finder: finder);
    final SnackBar snackBar = SnackBar(content: Text("User Deleter"));
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Switch(
            value: MyAppTheme.instance.darkEnabled, 
            onChanged: (bool enabled){
              MyAppTheme.instance.change(enabled);
            }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (_, index){
          final User user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text("autos: ${user.autos.ferrari}, ${user.autos.toyota}"),
            // subtitle: Text("age: ${user.age}, email: ${user.email}"),
            trailing: IconButton(
              onPressed:()async {
                await _deleteUser(user);
              }, 
              icon: const Icon(Icons.tram_sharp)
            ),
          );
        }
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.sort, color: Colors.white,),
            heroTag: 'add',
            onPressed: _load,
            backgroundColor: Colors.green,
          ),
          const SizedBox(width: 15,),
          FloatingActionButton(
            child: const Icon(Icons.clear_all, color: Colors.white,),
            heroTag: 'add',
            onPressed: _delete,
            backgroundColor: Colors.redAccent,
          ),
          const SizedBox(width: 15,),
          FloatingActionButton(
            child: const Icon(Icons.person_add, color: Colors.white),
            heroTag: 'add',
            onPressed: _add,
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}