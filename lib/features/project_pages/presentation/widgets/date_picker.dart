import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDatePickerWidget extends StatelessWidget {
  const MyDatePickerWidget({
    super.key,
    required this.datePicked,
    required this.function,
  });
  //e folosita asa:

  /* DateTime datePicked = DateTime.now();
  
   MyDatePickerWidget(

        datePicked: datePicked,

        function: (newValue) {
            setState(() {
              datePicked = newValue;
            });
          },
    ), */
  final DateTime datePicked;
  final ValueChanged<DateTime> function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.date_range),
      onPressed: () async {
        final DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: datePicked,
          firstDate: DateTime(DateTime.now().year - 2),
          lastDate: DateTime(DateTime.now().year + 2),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimaryContainer,
                  onSurface: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (newDate == null) {
          return;
        }
        function(newDate);
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<DateTime>('datePicked', datePicked))
      ..add(
        ObjectFlagProperty<ValueChanged<DateTime>>.has('function', function),
      );
  }
}
