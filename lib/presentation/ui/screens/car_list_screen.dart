import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ws_cars/presentation/controllers/car_list_controller.dart';
import 'package:ws_cars/presentation/controllers/send_leads_controller.dart';
import 'package:ws_cars/presentation/ui/screens/input_email_bottom_sheet.dart';
import 'package:ws_cars/core/utils/currency_converter.dart';

import '../../../models/car.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({
    super.key,
  });

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late CarListController carListController;

  late SendLeadController sendLeadController;
  @override
  initState() {
    carListController = GetIt.I.get<CarListController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controllerInitializition();
    });

    super.initState();
  }

  Future controllerInitializition() async {
    carListController.isError.addListener(() {
      if (carListController.isError.value) {
        showSnackBarForError(
            context, "Erro ao buscar carros. Tente novamente mais tarde");
      }
    });
    carListController.fetchCars();
    sendLeadController = GetIt.I.get<SendLeadController>();
  }

  @override
  dispose() {
    sendLeadController.dispose();
    super.dispose();
  }

  showSnackBarForError(BuildContext context, String text) {
    if (mounted) {
      final snackBar = SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Carros",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const Divider()
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
            valueListenable: carListController.isError,
            builder: (context, errorFetching, _) {
              return RefreshIndicator(
                onRefresh: () async => await carListController.fetchCars(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ValueListenableBuilder(
                      valueListenable: carListController.cars,
                      builder: (context, carsFetched, _) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: carsFetched.length,
                            itemBuilder: (context, index) {
                              return CarDisplayCard(
                                  onShowInterest: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: SingleChildScrollView(
                                              child: InputEmailBottomSheet(
                                                  selectedCar:
                                                      carsFetched[index],
                                                  showErrorFunction: () {
                                                    showSnackBarForError(
                                                        context,
                                                        "Erro ao salvar interesse. Tente novamente mais tarde");
                                                  }),
                                            ),
                                          );
                                        });
                                  },
                                  carToDisplay: carsFetched[index]);
                            });
                      }),
                ),
              );
            }),
      ),
    );
  }
}

class CarDisplayCard extends StatelessWidget {
  final Car carToDisplay;
  final Function() onShowInterest;
  const CarDisplayCard(
      {super.key, required this.carToDisplay, required this.onShowInterest});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: theme.disabledColor.withOpacity(0.4), width: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade100,
                    ),
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Image.asset("assets/png/lateralcaricon.png")),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: onShowInterest,
                      icon: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Icon(Icons.favorite_border_outlined)))),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(carToDisplay.year.toString(),
                              style: theme.textTheme.displaySmall!
                                  .copyWith(color: theme.primaryColor)),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      carToDisplay.modelName,
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(formatDoubleToBRL(carToDisplay.price),
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.primaryColor, fontWeight: FontWeight.w800))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CarInfoWidget(info: carToDisplay.color, icon: Icons.color_lens),
                CarInfoWidget(
                    info: carToDisplay.fuel, icon: Icons.local_gas_station),
                CarInfoWidget(
                    info: "${carToDisplay.doorsQuantity} LUGARES",
                    icon: Icons.people),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CarInfoWidget extends StatelessWidget {
  final String info;
  final IconData icon;
  const CarInfoWidget({super.key, required this.info, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          info,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
