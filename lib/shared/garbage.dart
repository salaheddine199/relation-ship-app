/*


PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (String value) =>
                    actionPopUpItemSelected(value, listOfMedications[index]["id"], index),

                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'more',
                      child: Text('More Info'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                  ];
                },
              ),

// check what choice the user press
  void actionPopUpItemSelected(String value, int id, int index) async{
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Navigator.pop(context); // just trying to sestory the old bottomSheet
    // or just add a bool value that tells you if one of these bottomsheets is open:
    // then close it by pop(context) when it's true

    //String message ="";


    if (value == 'more') {}
    else if (value == 'delete') {}
    else if (value == 'update') {}
    else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not implemented")));


    //ScaffoldMessenger.of(thisContext).showSnackBar(SnackBar(content: Text("")));
  }


 */


/*  more
_scaffoldkey.currentState.showBodyScrim(true,0.4);

      // here we will display this medication's info
      _scaffoldkey.currentState.showBottomSheet(
            (context) => SingleChildScrollView(
          child: Container(
            color: Colors.blue.withOpacity(0.05),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(text: " ${listOfMedications[index]["id"]}"),
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(22.0),
                    labelText: "Id: ",
                    //labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    prefixIcon: Icon(
                      Icons.text_snippet_outlined,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(text: " ${listOfMedications[index]["name"]}"),
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(22.0),
                    labelText: "Name:",
                    //labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    prefixIcon: Icon(
                      Icons.text_snippet_outlined,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(text: " ${listOfMedications[index]["laboratory"]}"),
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(22.0),
                    labelText: "laboratory: ",
                    //labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    prefixIcon: Icon(
                      Icons.text_snippet_outlined,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        elevation: 35,
      ).closed
          .then((value) {   reset(); _scaffoldkey.currentState.showBodyScrim(false,0.4);   });
 */

/* delete


      // show an alert if he choose OK then do delete

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: ()  async{
                Navigator.pop(context);
                // here we delete our item
                dbHelper.deleteMedication(id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "This medication is deleted with id = $id"
                  )));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "This medication is NOT deleted !!!"
                  )));
                });

                // update our list so we update our list view:
                listOfMedications = await dbHelper.queryAllMedications();
                setState(() {});

              },
              child: Icon(Icons.delete_forever_rounded, color: Colors.red,), // Text("Ok"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text("No"),
            )
          ],
          content: Text("Are you sure you wanna delete this medication"),
        ),
      );


 */

/*  update


      // here we will update this medication's info
      _scaffoldkey.currentState.showBodyScrim(true,0.4);
      _laboratoryController.text = "${listOfMedications[index]["laboratory"]}";
      _nameController.text = "${listOfMedications[index]["name"]}";

      _scaffoldkey.currentState.showBottomSheet(
            (context) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.blue.withOpacity(0.05),
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    controller: TextEditingController(text: " ${listOfMedications[index]["id"]}"),
                    style: TextStyle(color: Colors.grey),
                    readOnly: true,
                    onTap: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("This field is read only"))),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(22.0),
                      labelText: "Id: ",
                      //labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                      prefixIcon: Icon(
                        Icons.text_snippet_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty)
                        return "name must not be null";
                      return null;
                    },
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(22.0),
                      labelText: "Name: ",
                      //hintText: "${listOfMedications[index]["name"]}",
                      prefixIcon: Icon(
                        Icons.text_snippet_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty)
                        return "laboratory must not be null";
                      return null;
                    },
                    controller: _laboratoryController ,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(22.0),
                      labelText: "laboratory: ",
                      //hintText: "${listOfMedications[index]["age"]}",
                      prefixIcon: Icon(
                        Icons.text_snippet_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 35),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(2.0),
                    margin: EdgeInsets.symmetric(horizontal: 100.0),
                    child: MaterialButton(
                      onPressed: () async{
                        if(_formKey.currentState.validate()){

                          var newMedication = MedicationModel(
                            name: _nameController.text,
                            laboratory: _laboratoryController.text,
                          );
                          //listOfMedications.add(newMedication);

                          int id = listOfMedications[index]["id"];
                          dbHelper.updateMedication(id, newMedication)
                              .then((value) {
                            //message = "This person is updated with id = $id";
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                "This medication is updated with id = $id"
                            )));
                          })
                              .catchError((error) {
                            //message = "This person is NOT updated !!!";
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                "This medication is NOT updated !!!"
                            )));
                          });


                          // update our list so we update our list view:
                          listOfMedications = await dbHelper.queryAllMedications();
                          setState(() {});
                          Navigator.pop(context);

                        }
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        elevation: 35,
      ).closed
          .then((value) {   reset(); _scaffoldkey.currentState.showBodyScrim(false,0.4);   });

 */