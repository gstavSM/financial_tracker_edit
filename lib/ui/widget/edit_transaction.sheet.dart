import 'package:financial_tracker/common/errors/errors_classes.dart';
import 'package:financial_tracker/common/patterns/command.dart';
import 'package:financial_tracker/domain/entity/transaction_entity.dart';
import 'package:financial_tracker/ui/widget/edit_transaction_form.dart';
import 'package:flutter/material.dart';


class EditTransactionSheet extends StatelessWidget {
  final TransactionType type;
  final Command1<void, Failure, TransactionEntity> submitCommand;
  final TransactionEntity transactionToEdit;

  const EditTransactionSheet({
    super.key,
    required this.type,
    required this.submitCommand,
    required this.transactionToEdit,
  });

  static Future<void> show({
    required BuildContext context,
    required TransactionType type,
    required Command1<void, Failure, TransactionEntity> submitCommand,
    required TransactionEntity transactionToEdit,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => EditTransactionSheet(
            type: type,
            submitCommand: submitCommand,
            transactionToEdit: transactionToEdit,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Colors.grey; 
    final availableHeight = MediaQuery.of(context).size.height * 0.75;

    return Container(
      height: availableHeight,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    //color: colorScheme.onPrimary.withValues(alpha: 0.5),
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.edit_document, color: Colors.white), //***
                        // isIncome ? Icons.trending_up : Icons.trending_down,
                        // color: colorScheme.onPrimary,),
                      const SizedBox(width: 8),
                      Text(
                        'Editar ${type.nameSingular}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTransactionForm(
                  type: type,
                  color: color,
                  submitCommand: submitCommand,
                  initialTransaction: transactionToEdit
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}