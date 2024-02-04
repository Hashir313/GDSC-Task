import 'package:flutter/material.dart';
import 'dart:math';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  List<String> carsList = [
    'Toyota Camry',
    'Honda Civic',
    'Ford Mustang',
    'Chevrolet Corvette',
    'BMW 3 Series',
    'Mercedes-Benz C-Class',
    'Audi A4',
    'Lexus ES',
    'Volkswagen Golf',
    'Tesla Model S',
    'Nissan Altima',
    'Hyundai Elantra',
    'Kia Optima',
    'Mazda3',
    'Subaru Impreza',
    'Volvo S60',
    'Jaguar XE',
    'Porsche 911',
    'Ferrari 488',
    'Lamborghini Huracan'
  ];
  List<String> filteredList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    filteredList = carsList;
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredList = carsList
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Custom ListView',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30.0,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                cursorColor: Colors.blue,
                onChanged: (value) {
                  filterSearchResults(value);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    // Generate random color with opacity
                    final random = Random();
                    final color = Color.fromRGBO(
                      random.nextInt(256),
                      random.nextInt(256),
                      random.nextInt(256),
                      0.5, // Set the opacity value here
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5.0,
                      ),
                      child: ListTile(
                        tileColor: color.withOpacity(
                          0.5,
                        ),
                        title: Row(
                          children: [
                            Text(
                              '${index + 1}.',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(filteredList[index]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
