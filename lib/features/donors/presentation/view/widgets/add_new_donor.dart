import 'package:donation_management_system/core/widgets/widgets.dart';

class AddNewDonor extends StatefulWidget {
  const AddNewDonor({super.key});

  @override
  State<AddNewDonor> createState() => _AddNewDonorState();
}

class _AddNewDonorState extends State<AddNewDonor> {
  String? selectedDonorType = "Individual"; // للقائمة المنسدلة

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Donor',
                    style: AppTypography.h2.copyWith(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              content: SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.5, // لضبط العرض مثل الويب/التابلت
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Email
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              "Full Name",
                              "Enter full name",
                            ),
                          ),
                          Gap(20.w),
                          Expanded(
                            child: _buildInputField(
                              "Email Address",
                              "example@email.com",
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      // Phone & Type
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              "Phone Number",
                              "+20 120 000 0000",
                            ),
                          ),
                          Gap(20.w),
                          Expanded(child: _buildDropdownField("Donor Type")),
                        ],
                      ),
                      Gap(20.h),
                      // Address
                      _buildInputField(
                        "Address",
                        "Enter full mailing address",
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              actionsPadding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D7D6D),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add Donor",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        CustomTextField(hint: hint, maxLines: maxLines),
      ],
    );
  }

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDonorType,
              isExpanded: true,
              items: ["Individual", "Organization"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedDonorType = val),
            ),
          ),
        ),
      ],
    );
  }
}
