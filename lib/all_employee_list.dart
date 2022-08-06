import 'package:ag_trunnel/employee_lists.dart';
import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';


class AllEmployeePage extends StatefulWidget {
  const AllEmployeePage({Key? key}) : super(key: key);

  @override
  _AllEmployeePageState createState() => _AllEmployeePageState();
}

class _AllEmployeePageState extends State<AllEmployeePage> {
  final Stream<QuerySnapshot> agTunnelEmployees = FirebaseFirestore.instance
      .collection("employees")
      .orderBy('firstName')
      //.where('endDate', isEqualTo: null)
      .snapshots();
  String available = "Ledig";
  String groupId = "Unknown";
  List<AgEmployeesInProject> employees = [];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ansatte'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: agTunnelEmployees,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading....");
            }
            if (snapshot.hasError || !snapshot.hasData) {
              debugPrint(snapshot.error.toString());
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("En uventet feil har oppstått.")));
              return Container();
            }
            final QuerySnapshot<Map<String, dynamic>> data =
                snapshot.requireData as QuerySnapshot<Map<String, dynamic>>;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 600,
                  color: Colors.deepPurple[100],
                  child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    itemCount: data.size,
                    itemBuilder: (BuildContext context, int index) {
                      AgEmployeesInProject employee =
                          AgEmployeesInProject.fromFirebase(
                              data.docs[index].id, data.docs[index].data());
                      if (employee.hasLeft) {
                        return Container();
                      }
                      if (employee.hasShift) {
                        available = "Opptatt";
                      } else {
                        available = "Ledig";
                      }
                      employees.add(employee);
                      return Card(
                          color: Colors.deepPurple[50],
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${employee.firstName} ${employee.lastName}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.deepPurple,
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      available,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: getColor(employee.hasShift),
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      (employee.nr)
                                              .toString(),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.deepPurple,
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      employee.address,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.deepPurple,
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Ansatt fra: " +
                                          DateFormat.yMMMMd(Intl.defaultLocale)
                                              .format(employee.startDate)
                                              .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.deepPurple,
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    const SizedBox(height: 20.0), 
                                    Row(
                                    children: <Widget>[
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 45),
                                          primary: Colors.deepPurple[100],
                                          onPrimary: Colors.deepPurple,
                                          side: const BorderSide(color: Colors.deepPurple, width: 2),
                                        ),
                                      onPressed: (){
                                         openDialog(
                                                employee.fullName,
                                                employee.address,
                                                employee.startDate,
                                                employee.yrke,
                                                employee.nr,
                                                employee.kolonne1,
                                                employee.licence,
                                                employee.language,

                                          );
                                      if (employee.groupId == 22120835) {
                                         groupId = "AGA Rapportering - prosjekt styrt";
                                      } else if (employee.groupId == 21841183) {
                                          groupId = "Montør timelønnet";
                                      } else if (employee.groupId == 21841181) {
                                          groupId = "Fastlønnet";
                                      } else {
                                          groupId = "Unknown";
                                      }
                                      }, 
                                      child: const Text('Viser detaljer',
                                      style: TextStyle(
                                        fontSize: 14,                                       
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w700,
                                      )
                                      
                                      )
                                    ),
                                    const SizedBox(width: 20.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 45),
                                          primary: Colors.deepPurple[100],
                                          onPrimary: Colors.deepPurple,
                                          side: const BorderSide(color: Colors.deepPurple, width: 2),
                                        ),
                                      onPressed: (){
                                         openDialog(
                                                employee.fullName,
                                                employee.address,
                                                employee.startDate,
                                                employee.yrke,
                                                employee.nr,
                                                employee.kolonne1,
                                                employee.licence,
                                                employee.language,

                                          );
                                      if (employee.groupId == 22120835) {
                                         groupId = "AGA Rapportering - prosjekt styrt";
                                      } else if (employee.groupId == 21841183) {
                                          groupId = "Montør timelønnet";
                                      } else if (employee.groupId == 21841181) {
                                          groupId = "Fastlønnet";
                                      } else {
                                          groupId = "Unknown";
                                      }
                                      }, 
                                      child: const Text('Legge til detaljer',
                                      style: TextStyle(
                                        fontSize: 14,                                       
                                        fontFamily: "Caveat",
                                        fontWeight: FontWeight.w700,
                                      )
                                      
                                      )
                                    ),
                                    ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                    }, // count the number of projects by calculating Project list length
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<String?> openDialog(name, address, startDate, yrke,nr, kolonne1, licence, language) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          backgroundColor: Colors.deepPurple[50],
          
          title: Text( name,
            style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)
           ),
          
          content: SizedBox(
            height: 350,
            width: 300,
            child:Column(  
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                        
                    const Text("Name:",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),
                    Text(name??"",
                    style: const TextStyle(
                                   fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                   ),),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     const Text("Address:",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),
                    FittedBox(
                    fit: BoxFit.fill,
                    child:SizedBox(
                      width: 190,
                      child:
                    Text(address??"",
                         style: const TextStyle(
                                 fontSize: 16.0,
                                 color: Colors.blue,
                                 fontFamily: "Caveat",
                                 fontWeight: FontWeight.w500,),),
                    ),
                    ),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Start Date:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),
                    Text(
                      DateFormat.yMMMMd(Intl.defaultLocale)
                          .format(startDate)
                          .toString()??"",
                          style: const TextStyle(
                                        fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),
                    ),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Yrke:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    
                    Container(width:20),
                    Text(yrke??"",
                        style: const TextStyle(
                                      fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Nr:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),
                    Text(nr.toString()??"",
                    style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Kolonne1:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,),
                   ),
                    Container(width:20),
                    Text(kolonne1??"",
                    style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Førerkort:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),     
                    Text(licence??"",
                    style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                  ]),
                  const SizedBox(height: 10.0),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Språk:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),      
                    Text(language??"",
                    style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                  ]),
                  const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Group:",
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,)),
                    Container(width:20),
                    Text(groupId.toString()??"",
                    style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                    fontFamily: "Caveat",
                                    fontWeight: FontWeight.w500,
                                      ),),
                    
                  ]),
                  const SizedBox(height: 10.0),
            ],
          ),
          ),
          
          actions: [
            TextButton(child: const Text("Cancel",
               style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontFamily: "Caveat",
                            fontWeight: FontWeight.w700,),),
                      onPressed: cancel),
            TextButton(child: const Text("Edit",
               style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontFamily: "Caveat",
                            fontWeight: FontWeight.w700,),),
                      onPressed: cancel),
            /*TextButton(child: const Text("Submit",
            style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.deepPurple,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w700,),), 
                    onPressed: submit),*/
          ],
         ),
        
      );

  /*void submit() {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }*/

  void cancel() {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}

MaterialColor getColor(check) {
  if (check) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}
