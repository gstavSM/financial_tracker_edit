import 'dart:convert';

import 'package:financial_tracker/helper/transaction_fake_repository.dart';

import '../../common/errors/errors_classes.dart';
import '../../common/patterns/result.dart';
import '../../domain/entity/transaction_entity.dart';
import 'transaction_storage_contract.dart';

class TransactionFakeServiceImpl implements TransactionStorageContract {
  final TransactionFakeRepository _api = TransactionFakeRepository();

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchAllTransacions() async {
    try {
      var result = await _api.getData();

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions =
          jsonList
              .map(
                (item) =>
                    TransactionEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList();
      return Success(transactions); // Retorna um exemplo.
    } on DatasourceResultEmpty catch (e) {
      // Retorna erro em caso de falha.
      return Error(DatasourceResultEmpty(e.toString()));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<TransactionEntity, Failure>> fetchTransacion(String id) {
    // TODO: implement fetchTransacion
    throw UnimplementedError();
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByTipe(
    TransactionType type,
  ) {
    // TODO: implement fetchTransacionsByTipe
    throw UnimplementedError();
  }

  @override
  Future<Result<void, Failure>> removeTransacion(String id) async {
    try {
      await _api.deleteData(id);

      return Success(null);
    } on RecordNotFound catch (e) {
      // Retorna erro em caso de falha.
      return Error(RecordNotFound('Na Exclusão: ${e.toString()}'));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void, Failure>> storeTransacion(
    TransactionEntity transaction,
  ) async {
    try {
      await _api.addData(transaction.toJson());

      return Success(null);
    } on InvalidData catch (e) {
      // Retorna erro em caso de falha.
      return Error(InvalidData('Na Inclusão: ${e.toString()}'));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByDate(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      var result = await _api.getDataByDateRange(startDate, endDate);

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions =
          jsonList
              .map(
                (item) =>
                    TransactionEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList();
      return Success(transactions); // Retorna um exemplo.
    } on DatasourceResultEmpty catch (e) {
      // Retorna erro em caso de falha.
      return Error(DatasourceResultEmpty(e.toString()));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao Transações: ${e.toString()}'));
    }
  }
  
  // @override
  // Future<Result<void, Failure>> updateTransaction(
  //   TransactionEntity transaction,
  // ) async {
  //   try {
  //     await _api.updateData(transaction.toJson());
  //     return Success(null);
  //   } on RecordNotFound catch (e) {
  //     return Error(RecordNotFound('Na Atualização: ${e.toString()}'));
  //   } on InvalidData catch (e) {
  //     return Error(InvalidData('Dados Inválidos: ${e.toString()}'));
  //   } on APIFailure catch (e) {
  //     return Error(APIFailure(e.toString()));
  //   } on Exception catch (e) {
  //     return Error(DefaultError('Erro ao atualizar transação: ${e.toString()}'));
  //   }
  // }

@override
Future<Result<void, Failure>> updateTransaction(
  TransactionEntity transaction,
) async {
  try {
    final transactionJson = transaction.
    toJson();
    
    print('Atualizando transação: $transactionJson');
    
    await _api.updateData(transactionJson);
    
    print('Transação ${transaction.id} atualizada com sucesso');
    
    return Success(null);
  } on RecordNotFound catch (e) {
    print('Erro RecordNotFound: $e');
    return Error(RecordNotFound('Na Atualização: ${e.toString()}'));
  } on InvalidData catch (e) {
    print('Erro InvalidData: $e');
    return Error(InvalidData('Dados Inválidos: ${e.toString()}'));
  } on APIFailure catch (e) {
    print('Erro APIFailure: $e');
    return Error(APIFailure(e.toString()));
  } on Exception catch (e) {
    print('Erro desconhecido: $e');
    return Error(DefaultError('Erro ao atualizar transação: ${e.toString()}'));
  }
}
}