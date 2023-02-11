/// Imports
/// ------------------------------------------------------------------------------------------------

import 'package:solana_common/exceptions/solana_exception.dart';
import '../src/mixins/data_serializable_mixin.dart';


/// Data Serializable Exception
/// ------------------------------------------------------------------------------------------------

class DataSerializableException extends SolanaException {

  /// Creates an exception for invalid [DataSerializableMixin] objects.
  const DataSerializableException(
    super.message, {
    super.code,
  });
  
  /// {@macro solana_common.SolanaException.fromJson}
  factory DataSerializableException.fromJson(final Map<String, dynamic> json) 
    => DataSerializableException(
      json['message'],
      code: json['code'],
    );
}