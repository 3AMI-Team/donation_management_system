import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_donor_dialog.dart';

class AddNewDonor extends StatelessWidget {
  const AddNewDonor({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Donor",
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return const AddDonorDialog();
          },
        );
      },
    );
  }
}
