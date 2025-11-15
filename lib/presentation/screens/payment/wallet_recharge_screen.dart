import 'package:flutter/material.dart';

import 'package:tochegando_driver_app/core/utils/translate.dart';
import 'package:tochegando_driver_app/presentation/screens/payment/payment_gateway_screen.dart';
import '../../../core/extensions/workspace.dart';
import '../../../core/services/config.dart';
import '../../../core/utils/common_widget.dart';
import '../../../core/utils/theme/project_color.dart';
import '../../../core/utils/theme/theme_style.dart';


class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key});

  @override
  State<WalletRechargeScreen> createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  final List<Map<String, String>> preçoOptions = [
    {"preço": "100"},
    {"preço": "200"},
    {"preço": "500"},
    {"preço": "1000"},
    {"preço": "1500"},
    {"preço": "2000"},
  ];

  int selectedIndex = -1;
  final TextEditingController preçoController = TextEditingController();

  void navigateToUrl({
    required String endpoint,
    required Map<String, String> queryParams,
    required Widget Function(String url) pageBuilder,
  }) {
    String baseUrl = Config.baseUrl.replaceAll("/api/v1/", "");
    String queryString = queryParams.entries
        .map((e) =>
    "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}")
        .join("&");

    String finalUrl = "$baseUrl$endpoint?$queryString";
    debugPrint("url is $finalUrl");

    if (queryParams.values.any((value) => value.isEmpty)) {
      showErrorToastMessage("Por favor, forneça todos os parâmetros necessários.");
    } else {
      goTo(pageBuilder(finalUrl));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: notifires.getbgcolor,
      appBar: CustomAppBar(
        title: "Adicionar dinheiro".translate(context),

        titleColor: notifires.getwhiteblackColor,
        backgroundColor: notifires.getbgcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [themeColor.withValues(alpha: 0.2), themeColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: themeColor.withValues(alpha:0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.account_balance_wallet_rounded,
                        color: Colors.black, size: 35),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 💵 Compact Amount Input
              Text(
                "Insira o valor".translate(context),
                style: heading3Grey1(context),
              ),
              const SizedBox(height: 8),
              // Option 2 - More Modern Design
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      notifires.getbgcolor,
                      notifires.getbgcolor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: themeColor.withValues(alpha: 0.7),
                    width: 1.5,
                  ),

                ),
                child: Row(
                  children: [
                    // Currency Badge
                    Container(
                      margin: const EdgeInsets.only(left: 16,right: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currency,
                        style:   heading3Grey1(context).copyWith(color: blackColor),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Text Field
                    Expanded(
                      child: TextField(
                        controller: preçoController,
                        keyboardType: TextInputType.number,
                        cursorColor: themeColor,
                        onChanged: (v) => setState(() => selectedIndex = -1),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: notifires.getwhiteblackColor,
                          letterSpacing: 0.5,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insira o valor...".translate(context),
                          hintStyle: TextStyle(
                            color: notifires.getGrey3whiteColor.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    // Clear Button (Optional)
                    if (preçoController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: notifires.getGrey3whiteColor, size: 18),
                        onPressed: () {
                          setState(() {
                            preçoController.clear();
                            selectedIndex = -1;
                          });
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Seleção rápida".translate(context),
                style: heading3Grey1(context),
              ),
              const SizedBox(height: 12),

              GridView.builder(
                itemCount: preçoOptions.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 44,
                ),
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? themeColor : notifires.getBoxColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? themeColor
                            : notifires.getwhiteblackColor.withOpacity(0.1),
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: themeColor.withValues(alpha:0.3),
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            preçoController.text = preçoOptions[index]["preço"]!;
                          });
                        },
                        child: Center(
                          child: Text(
                            "$currency ${preçoOptions[index]["preço"]}",
                            style: heading3Grey1(context).copyWith(color: grey1 ,fontSize: 13,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),


              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomsButtons(text: "Proceder ao pagamento", backgroundColor: themeColor,  onPressed: () {
                  if (preçoController.text.isEmpty) {
                    showErrorToastMessage(
                        "Insira o valor".translate(context));
                    return;
                  }
                  navigateToUrl(
                    endpoint: "/carteira_recarga",
                    queryParams: {
                      "token": token,
                      "amount": preçoController.text,
                      "currency": currency,
                    },
                    pageBuilder: (url) => PaymentGatewayScreen(
                      url: url,
                      fromBooking: false,
                    ),
                  );
                },),
              ),

              const SizedBox(height: 16),

              // ℹ️ Compact Info Note
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security,size: 12,color: grey4,),
                    const SizedBox(width: 10,),
                    Text(
                      "Pagamento seguro com tecnologia To Chegando Delivery".translate(context),
                      style: regular(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}