import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../common/errors/errors_classes.dart';
import '../../common/patterns/result.dart';
import '../../data/repositories/transaction_repository_contract.dart';
import '../entity/transaction_entity.dart';
import 'use_case_contract.dart';

typedef EditTransactionParams = ({@required TransactionEntity transaction});

class EditTransactionUseCaseImpl
    implements
        IUseCaseContract<
          Result<void, Failure>,
          EditTransactionParams> {
  final TransactionRepositoryContract repo;

  EditTransactionUseCaseImpl(this.repo);

  @override
  Future<Result<void, Failure>> call(EditTransactionParams params) {
    return repo.updateTransaction(params.transaction);
  }
}
