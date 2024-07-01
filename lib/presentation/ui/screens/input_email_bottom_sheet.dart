// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ws_cars/presentation/controllers/save_leads_controller.dart';
import 'package:ws_cars/repositories/save_lead/save_lead_repository.dart';
import 'package:ws_cars/core/utils/email_validation_util.dart';

import '../../../models/car.dart';

class InputEmailBottomSheet extends StatefulWidget {
  final Car selectedCar;
  final Function() showErrorFunction;
  const InputEmailBottomSheet({
    super.key,
    required this.selectedCar,
    required this.showErrorFunction,
  });

  @override
  State<InputEmailBottomSheet> createState() => _InputEmailBottomSheetState();
}

class _InputEmailBottomSheetState extends State<InputEmailBottomSheet> {
  final saveLeadRepository = GetIt.instance<SaveLeadRepository>();
  late SaveLeadsController saveLeadsController;
  final formKey = GlobalKey<FormState>();
  final fieldValueController = TextEditingController(text: "");
  @override
  void initState() {
    saveLeadsController =
        SaveLeadsController(saveLeadRepository: saveLeadRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(30), topEnd: Radius.circular(30))),
      child: ValueListenableBuilder(
          valueListenable: saveLeadsController.errorSaving,
          builder: (context, errorSaving, _) {
            if (errorSaving) {
              widget.showErrorFunction();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Text(
                        "Demonstrar interesse",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                        iconSize: 16,
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fieldValueController,
                            validator: mailValidation,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(CupertinoIcons.mail),
                              labelText: "E-mail",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                              hintText: "Insira seu e-mail",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context).disabledColor,
                                    height: 1.9,
                                    fontWeight: FontWeight.w400,
                                  ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          ValueListenableBuilder(
                              valueListenable: saveLeadsController.isSaving,
                              builder: (context, isLoading, _) {
                                return ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context).primaryColor),
                                      foregroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white),
                                      overlayColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (mounted) {
                                        if (formKey.currentState!.validate()) {
                                          await saveLeadsController.saveLead(
                                              widget.selectedCar,
                                              fieldValueController.value.text);
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    },
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: !isLoading
                                            ? const Center(
                                                child: Text("SALVAR"))
                                            : const CircularProgressIndicator()));
                              })
                        ],
                      )),
                )
              ],
            );
          }),
    );
  }
}
