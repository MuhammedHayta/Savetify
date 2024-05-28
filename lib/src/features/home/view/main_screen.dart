import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:savetify/src/features/data/data.dart';
import 'package:savetify/src/features/expense/model/ExpenseRepository.dart';
import 'package:savetify/src/features/expense/view/add_expense.dart';
import 'package:savetify/src/features/home/view/account_cards.dart';
import 'package:savetify/src/features/profile/model/user.dart';
import 'package:savetify/src/features/profile/view/profile_view.dart';
import 'package:savetify/src/theme/theme.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel? userModel;

  ExpenseRepository? expenseRepository;
  initPage() async {
    userModel = await const ProfileView().getUser();
    expenseRepository = ExpenseRepository();
    await expenseRepository!.getExpensesFromFirebase();
  }

  double calculateTotalExpense() {
    double total = 0;
    for (var i = 0; i < expenseRepository!.getExpenses().length; i++) {
      total += expenseRepository!.getExpenses()[i].amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: initPage(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const ProfileView();
                                        }));
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.lightBlue[100],
                                            ),
                                          ),
                                          const Icon(
                                            CupertinoIcons.person_fill,
                                            color: Colors.black,
                                            size: 35,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Welcome,',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: SavetifyTheme.lightTheme
                                                .secondaryHeaderColor)),
                                    Text(
                                      userModel!.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: SavetifyTheme
                                              .lightTheme.primaryColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 193, 145, 0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 96, 91, 255),
                                const Color.fromARGB(239, 108, 247, 247),
                                SavetifyTheme.lightTheme.primaryColor,
                              ],
                              transform: const GradientRotation(pi / 4),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12),
                              const Text("Total Balance",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const SizedBox(height: 12),
                              Text("₺ ${-calculateTotalExpense()}",
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            color: Colors.white30,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            CupertinoIcons.arrow_up,
                                            color:
                                                Color.fromARGB(255, 2, 141, 35),
                                            size: 15,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Income",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                            Text("₺ 2500.00",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            color: Colors.white30,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            CupertinoIcons.arrow_down,
                                            color:
                                                Color.fromARGB(255, 189, 1, 1),
                                            size: 15,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Expense",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                            Text("₺ ${calculateTotalExpense()}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Recent Transactions",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: SavetifyTheme.lightTheme
                                                .secondaryHeaderColor)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Text("Refresh List",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: SavetifyTheme.lightTheme
                                                .secondaryHeaderColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: expenseRepository!.getExpenses().isEmpty
                                    ? const Center(
                                        child: Text('No expenses found'))
                                    : ListView.builder(
                                        itemCount: expenseRepository!
                                            .getExpenses()
                                            .length,
                                        itemBuilder: (context, int i) {
                                          return ExpenseCard(i);
                                        }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  Widget ExpenseCard(int i) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(77, 255, 255, 255),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'lib/src/assets/${expenseRepository!.getExpenses()[i].category}.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      expenseRepository!.getExpenses()[i].category,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expenseRepository!.getExpenses()[i].amount.toString(),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      expenseRepository!.getExpenses()[i].date.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
