import 'package:admin/Api/Users.dart';
import 'package:admin/models/UserModel.dart';
import 'package:flutter/material.dart';

class DeleteAccounts extends StatefulWidget {
  const DeleteAccounts({super.key});

  @override
  State<DeleteAccounts> createState() => _DeleteAccountsState();
}

class _DeleteAccountsState extends State<DeleteAccounts> {
  final _formKey = GlobalKey<FormState>();
  String? selectedUser;

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Accounts"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth < 600
              ? constraints.maxWidth * 0.9
              : constraints.maxWidth / 2;
          double height = constraints.maxHeight / 1.5;

          return Center(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Select Account to Delete",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      FutureBuilder<List<User>>(
                        future: Users().getUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            List<User> usersData = snapshot.data!;

                            return DropdownButtonFormField<String>(
                              value: selectedUser,
                              hint: const Text("Select Account to delete"),
                              items: usersData
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.user_id,
                                        child: Text(
                                            "${e.username}" "............" +
                                                e.user_id),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedUser = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Car';
                                }
                                return null;
                              },
                            );
                          } else {
                            return const Text("No products available");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isloading = true;
                            });
                            final isValid = _formKey.currentState!.validate();

                            if (!isValid) {
                              return;
                            }

                            final response =
                                await Users().deleteUser(selectedUser!);

                            print(response);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response)));

                            setState(() {
                              isloading = false;
                              selectedUser = null;
                            });
                          },
                          child: const Text("Delete User"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
