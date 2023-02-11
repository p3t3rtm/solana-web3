/// Imports
/// ------------------------------------------------------------------------------------------------

import 'dart:convert';

import 'package:solana_common/borsh/borsh.dart';
import 'package:solana_common/utils/types.dart';
import '../../../src/public_key.dart';


/// Authorized
/// ------------------------------------------------------------------------------------------------

class Authorized extends BorshSerializable {

  /// Stake account authority info.
  const Authorized({
    required this.staker,
    required this.withdrawer,
  });

  /// Stake authority.
  final String staker;

  /// Withdraw authority.
  final String withdrawer;
  
  /// {@macro solana_common.Serializable.fromJson}
  factory Authorized.fromJson(final Map<String, dynamic> json) => Authorized(
    staker: json['staker'],
    withdrawer: json['withdrawer'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Authorized? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? Authorized.fromJson(json) : null;

  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'staker': borsh.publicKey,
    'withdrawer': borsh.publicKey,
  });

  @override
  BorshSchema get schema => codec.schema;
  
  @override
  Map<String, dynamic> toJson() => {
    'staker': staker,
    'withdrawer': withdrawer,
  };
}


/// Stake Authorize
/// ------------------------------------------------------------------------------------------------

enum StakeAuthorize {
  staker,
  withdrawer,
}


/// Lockup
/// ------------------------------------------------------------------------------------------------

class Lockup extends BorshSerializable {

  /// Stake account lockup info.
  const Lockup({
    required this.unixTimestamp,
    required this.epoch,
    required this.custodian,
  });

  /// Unix timestamp of lockup expiration.
  final i64 unixTimestamp;

  /// Epoch of lockup expiration.
  final i64 epoch;

  /// Lockup custodian authority (base-58).
  final String custodian;
  
  /// {@macro solana_common.Serializable.fromJson}
  factory Lockup.fromJson(final Map<String, dynamic> json) => Lockup(
    unixTimestamp: json['unixTimestamp'],
    epoch: json['epoch'],
    custodian: json['custodian'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Lockup? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? Lockup.fromJson(json) : null;

  /// The default, inactive lockup value.
  static Lockup get inactive => Lockup(
    unixTimestamp: 0, 
    epoch: 0, 
    custodian: PublicKey.zero().toBase58(),
  );
  
  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'unixTimestamp': borsh.i64,
    'epoch': borsh.i64,
    'custodian': borsh.publicKey,
  });

  @override
  BorshSchema get schema => codec.schema;
  
  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
    'custodian': custodian,
  };
}


/// Lockup Args
/// ------------------------------------------------------------------------------------------------

class LockupArgs extends BorshSerializable {

  /// Stake account lockup arguments.
  const LockupArgs({
    this.unixTimestamp,
    this.epoch,
    this.custodian,
  });

  /// Unix timestamp of lockup expiration.
  final i64? unixTimestamp;

  /// Epoch of lockup expiration.
  final i64? epoch;

  /// Lockup custodian authority (base-58).
  final String? custodian;

  /// {@macro solana_common.Serializable.fromJson}
  factory LockupArgs.fromJson(final Map<String, dynamic> json) => LockupArgs(
    unixTimestamp: json['unixTimestamp'],
    epoch: json['epoch'],
    custodian: json['custodian'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LockupArgs? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? LockupArgs.fromJson(json) : null;
  
  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructCodec codec = borsh.struct({
    'unixTimestamp': borsh.i64.option(),
    'epoch': borsh.i64.option(),
    'custodian': borsh.publicKey.option(),
  });

  @override
  BorshSchema get schema => codec.schema;
  
  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
    'custodian': custodian,
  };
}


/// Lockup Checked Args
/// ------------------------------------------------------------------------------------------------

class LockupCheckedArgs extends BorshSerializable {

  /// Stake account lockup arguments.
  const LockupCheckedArgs({
    this.unixTimestamp,
    this.epoch,
  });

  /// Unix timestamp of lockup expiration.
  final i64? unixTimestamp;

  /// Epoch of lockup expiration.
  final i64? epoch;

  /// {@macro solana_common.Serializable.fromJson}
  factory LockupCheckedArgs.fromJson(final Map<String, dynamic> json) => LockupCheckedArgs(
    unixTimestamp: json['unixTimestamp'],
    epoch: json['epoch'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LockupCheckedArgs? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? LockupCheckedArgs.fromJson(json) : null;
  
  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'unixTimestamp': borsh.i64.option(),
    'epoch': borsh.i64.option(),
  });

  @override
  BorshSchema get schema => codec.schema;
  
  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
  };
}


/// Stake Account Type
/// ------------------------------------------------------------------------------------------------

enum StakeAccountType {
  uninitialized, 
  initialized, 
  delegated, 
  rewardsPool,
}


/// Stake
/// ------------------------------------------------------------------------------------------------

class Stake extends BorshSerializable {

  const Stake({
    required this.delegation,
    required this.creditsObserved,
  });

  final Delegation delegation;

  /// Credits observed is credits from vote account state when delegated or redeemed.
  final bu64 creditsObserved;

  @override
  BorshSchema get schema => codec.schema;

  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'delegation': Delegation.codec,
    'creditsObserved': borsh.u64,
  });

  /// {@macro solana_common.BorshSerializable.deserialize}
  static Stake deserialize(final Iterable<int> buffer)
    => borsh.deserialize(codec.schema, buffer, Stake.fromJson);

  /// {@macro solana_common.BorshSerializable.tryDeserialize}
  static Stake? tryDeserialize(final Iterable<int>? buffer)
    => buffer != null ? Stake.deserialize(buffer) : null;

  /// {@macro solana_common.BorshSerializable.fromBase64}
  factory Stake.fromBase64(final String encoded) 
    => Stake.deserialize(base64.decode(encoded));

  /// {@macro solana_common.BorshSerializable.tryFromBase64}
  static Stake? tryFromBase64(final String? encoded)
    => encoded != null ? Stake.fromBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory Stake.fromJson(final Map<String, dynamic> json) => Stake(
    delegation: Delegation.fromJson(json['delegation']),
    creditsObserved: json['creditsObserved'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Stake? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? Stake.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'delegation': delegation.toJson(),
    'creditsObserved': creditsObserved,
  };
}


/// Delegation
/// ------------------------------------------------------------------------------------------------

class Delegation extends BorshSerializable {

  const Delegation({
    required this.voterPubkey,
    required this.stake,
    required this.activationEpoch,
    required this.deactivationEpoch,
    required this.warmupCooldownRate,
  });

  /// To whom the stake is delegated (base-58).
  final String voterPubkey;

  /// Activated stake amount, set at delegate() time.
  final bu64 stake;
  
  /// Epoch at which this stake was activated, std::Epoch::MAX if is a bootstrap stake.
  final bu64 activationEpoch;
  
  /// Epoch the stake was deactivated, std::Epoch::MAX if not deactivated.
  final bu64 deactivationEpoch;
  
  /// How much stake we can activate per-epoch as a fraction of currently effective stake.
  final f64 warmupCooldownRate;

  @override
  BorshSchema get schema => codec.schema;

  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'voterPubkey': borsh.publicKey,
    'stake': borsh.u64,
    'activationEpoch': borsh.u64,
    'deactivationEpoch': borsh.u64,
    'warmupCooldownRate': borsh.f64,
  });

  /// {@macro solana_common.BorshSerializable.deserialize}
  static Delegation deserialize(final Iterable<int> buffer)
    => borsh.deserialize(codec.schema, buffer, Delegation.fromJson);

  /// {@macro solana_common.BorshSerializable.tryDeserialize}
  static Delegation? tryDeserialize(final Iterable<int>? buffer)
    => buffer != null ? Delegation.deserialize(buffer) : null;

  /// {@macro solana_common.BorshSerializable.fromBase64}
  factory Delegation.fromBase64(final String encoded) 
    => Delegation.deserialize(base64.decode(encoded));

  /// {@macro solana_common.BorshSerializable.tryFromBase64}
  static Delegation? tryFromBase64(final String? encoded)
    => encoded != null ? Delegation.fromBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory Delegation.fromJson(final Map<String, dynamic> json) => Delegation(
    voterPubkey: json['voterPubkey'],
    stake: json['stake'],
    activationEpoch: json['activationEpoch'],
    deactivationEpoch: json['deactivationEpoch'],
    warmupCooldownRate: json['warmupCooldownRate'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Delegation? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? Delegation.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'voterPubkey': voterPubkey,
    'stake': stake,
    'activationEpoch': activationEpoch,
    'deactivationEpoch': deactivationEpoch,
    'warmupCooldownRate': warmupCooldownRate,
  };
}


/// Meta
/// ------------------------------------------------------------------------------------------------

class StakeMeta extends BorshSerializable {

  const StakeMeta({
    required this.rentExemptReserve,
    required this.authorized,
    required this.lockup,
  });

  final bu64 rentExemptReserve;
  final Authorized authorized;
  final Lockup lockup;

  @override
  BorshSchema get schema => codec.schema;

  /// {@macro solana_common.BorshSerializable.codec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'rentExemptReserve': borsh.publicKey,
    'authorized': Authorized.codec,
    'lockup': Lockup.codec,
  });

  /// {@macro solana_common.BorshSerializable.deserialize}
  static StakeMeta deserialize(final Iterable<int> buffer)
    => borsh.deserialize(codec.schema, buffer, StakeMeta.fromJson);

  /// {@macro solana_common.BorshSerializable.tryDeserialize}
  static StakeMeta? tryDeserialize(final Iterable<int>? buffer)
    => buffer != null ? StakeMeta.deserialize(buffer) : null;

  /// {@macro solana_common.BorshSerializable.fromBase64}
  factory StakeMeta.fromBase64(final String encoded) 
    => StakeMeta.deserialize(base64.decode(encoded));

  /// {@macro solana_common.BorshSerializable.tryFromBase64}
  static StakeMeta? tryFromBase64(final String? encoded)
    => encoded != null ? StakeMeta.fromBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory StakeMeta.fromJson(final Map<String, dynamic> json) => StakeMeta(
    rentExemptReserve: json['rentExemptReserve'],
    authorized: Authorized.fromJson(json['authorized']),
    lockup: Lockup.fromJson(json['lockup']),
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Delegation? tryFromJson(final Map<String, dynamic>? json) 
    => json != null ? Delegation.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'rentExemptReserve': rentExemptReserve,
    'authorized': authorized.toJson(),
    'lockup': lockup.toJson(),
  };
}