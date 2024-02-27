import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbuilder/widgets_builder_provider.dart';

class WidgetsBuilderView extends ConsumerWidget {
  const WidgetsBuilderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Widget Builder'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder(
            future: ref.read(widgetBuilderProvider).loadJson(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                String f1 = ref.watch(widgetBuilderProvider).f1;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ref
                            .watch(widgetBuilderProvider)
                            .dropdownItems
                            .length,
                        itemBuilder: (context, index) {
                          return ref
                                  .watch(widgetBuilderProvider)
                                  .dropdownItems
                                  .isEmpty
                              ? const Center(
                                  child: Text("No data found"),
                                )
                              : DropdownButton(
                                  value: f1,
                                  items: ref
                                      .watch(widgetBuilderProvider)
                                      .dropdownItems[index]
                                      .validValues
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    ref
                                        .read(widgetBuilderProvider)
                                        .setF1(value ?? "");
                                  },
                                );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            ref.watch(widgetBuilderProvider).textFields.length,
                        itemBuilder: (context, index) {
                          return ref
                                  .watch(widgetBuilderProvider)
                                  .textFields
                                  .isEmpty
                              ? const Center(
                                  child: Text("No data found"),
                                )
                              : Visibility(
                                  visible: ref
                                          .watch(widgetBuilderProvider)
                                          .textFields[index]
                                          .visibility
                                          .split("==")[1] ==
                                      "'$f1'",
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: ref
                                          .watch(widgetBuilderProvider)
                                          .textFields[index]
                                          .visibility
                                          .split("==")[1],
                                      labelText: ref
                                          .watch(widgetBuilderProvider)
                                          .textFields[index]
                                          .fieldName,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
