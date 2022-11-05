import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/divisions_model.dart';
import 'package:just_travel/providers/districts_provider.dart';
import 'package:provider/provider.dart';

class DivisionDropDown extends StatelessWidget {
  const DivisionDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Select Division'),
        const SizedBox(
          width: 30,
        ),
        Consumer<DistrictsProvider>(
          builder: (context, divisionProvider, child) {
            return divisionProvider.divisionsList.isEmpty
                ? const Text('Loading')
                : DropdownButton<DivisionsModel>(
                    hint: const Text('Tap To Select'),
                    value: divisionProvider.division,
                    items: divisionProvider.divisionsList
                        .map(
                          (e) => DropdownMenuItem<DivisionsModel>(
                            value: e,
                            child: Text('${e.division}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      divisionProvider.setDivisionFromDropDown(value);
                    },
                  );
          },
        ),
      ],
    );
  }
}
