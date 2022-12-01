import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool editMode = false;

  bool validUsername = true;
  bool validEmail = true;
  bool validPassword = true;
  bool validConfirmPassword = true;
  bool validFirstName = true;
  bool validLastName = true;

  String currFirstname = "First";
  String currLastName = "Last";
  String currUsername = "tom123";
  String currEmail = "123@gmail.com";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController(text: currFirstname);
    lastNameController = TextEditingController(text: currLastName);
    usernameController = TextEditingController(text: currUsername);
    emailController = TextEditingController(text: currEmail);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Icon(
                Icons.settings,
                size: 90,
                color: Color(0xff343a40)
              ),
              SizedBox(height: 10,),

              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                    color: Color(0xff343a40)
                  // color: Colors.red,
                ),
              ),

              // Edit button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        editMode = !editMode;
                      });
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)
                            )
                        ),
                      backgroundColor: MaterialStatePropertyAll<Color>((!editMode) ? Colors.white : Colors.red),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: (!editMode) ? Colors.red : Colors.white,
                          size: 14,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: (!editMode) ? Colors.red : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Render non editable fields while in non-edit mode
              if (!editMode)...[
                nonEditModeField("First Name", currFirstname),
                SizedBox(height: 20,),
                nonEditModeField("Last Name", currLastName),
                SizedBox(height: 20,),
                nonEditModeField("Username", currUsername),
                SizedBox(height: 20,),
                nonEditModeField("Email", currEmail),
                SizedBox(height: 20,),
              ]

              // Render textfields, confirm button and error messages while in edit mode
              else... [
                editModeField("First Name", currFirstname, firstNameController, validFirstName),
                SizedBox(height: 20,),
                editModeField("Last Name", currLastName, lastNameController, validLastName),
                SizedBox(height: 20,),
                editModeField("Username", currUsername, usernameController, validUsername),
                SizedBox(height: 20,),
                editModeField("Email", currEmail, emailController, validEmail),
                SizedBox(height: 20,),
                editModeField("Password", null, passwordController, validPassword),
                SizedBox(height: 20,),
                editModeField("Confirm Password", null, confirmPasswordController, validConfirmPassword),
                SizedBox(height: 20,),

                // Error Messages
                // SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!validFirstName) errorMessage("First Name cannot be empty"),
                        if (!validLastName) errorMessage("Last Name cannot be empty"),
                        if (!validUsername) errorMessage("Username already exists"),
                        if (!validEmail) errorMessage("Email already exists"),
                        if (!validPassword) errorMessage("Password must be at least 8 characters long"),
                        if (!validConfirmPassword) errorMessage("Passwords must be identical"),
                      ],
                    )
                  ),
                ),

                // Spacing for confirm button above
                (validFirstName && validLastName && validEmail && validUsername && validPassword && validConfirmPassword)
                  ? SizedBox(height: 20,)
                  : SizedBox(height: 20,),

                // Confirm Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                      onPressed: () {
                        (firstNameController.text.isNotEmpty) ? setState(() => {validFirstName = true, currFirstname = firstNameController.text} ) : setState(() => validFirstName = false );
                        (lastNameController.text.isNotEmpty) ? setState(() => {validLastName = true, currLastName = lastNameController.text}) : setState(() => validLastName = false );
                        (usernameController.text == 'username') ? setState(() => {validUsername = true, currUsername = usernameController.text}) : setState(() => validUsername = false );
                        (emailController.text.isNotEmpty) ? setState(() => {validEmail = true, currEmail = emailController.text}) : setState(() => validEmail = false );
                        (passwordController.text.length >= 8) ? setState(() => validPassword = true ) : setState(() => validPassword = false );
                        (confirmPasswordController.text == passwordController.text) ? setState(() => validConfirmPassword = true ) : setState(() => validConfirmPassword = false );
                      },
                      child: Text(
                        'Confirm Changes',
                        style: TextStyle(fontSize: 24),
                      )
                  ),
                ),
                // SizedBox(height: 90,),
              ],
              SizedBox(height: 20,),
            ],
          ),
        )
      )
    );
  }

  // Non-editable fields for non-edit mode
  Widget nonEditModeField(String fieldName, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child:
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  fieldName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,

                  ),
                )
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              )
            ],
          )
    );
  }

  // Editable Textfields for edit mode
  Widget editModeField(String? fieldName, String? initialValue, TextEditingController? controller, bool valid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        // initialValue: (fieldName == "Password" || fieldName == "Confirm Password") ? "" : initialValue,
        // initialValue: initialValue,
        controller: controller,
        obscureText: (fieldName == "Password" || fieldName == "Confirm Password"),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            size: 18,
            color: Colors.red,
          ),
          contentPadding: EdgeInsets.all(0),
          labelText: fieldName,
          labelStyle: TextStyle(
            fontSize: 18,
            color: (valid) ? Color(0xff343a40) : Colors.red,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff343a40), width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff343a40), width: 1.0),
          ),
        ),
      ),
    );
  }

  // Template for error messages
  Widget errorMessage(String message) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          size: 14.0,
        ),
        Text(
          ' ' + message,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
