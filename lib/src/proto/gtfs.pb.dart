//
//  Generated code. Do not modify.
//  source: gtfs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'gtfs.pbenum.dart';

export 'gtfs.pbenum.dart';

class GtfsHeader extends $pb.GeneratedMessage {
  factory GtfsHeader({
    $core.int? version,
    $core.int? date,
    $core.String? originalUrl,
    $core.bool? compressed,
    $core.Iterable<$core.int>? blocks,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (date != null) {
      $result.date = date;
    }
    if (originalUrl != null) {
      $result.originalUrl = originalUrl;
    }
    if (compressed != null) {
      $result.compressed = compressed;
    }
    if (blocks != null) {
      $result.blocks.addAll(blocks);
    }
    return $result;
  }
  GtfsHeader._() : super();
  factory GtfsHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GtfsHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GtfsHeader', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'date', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'originalUrl')
    ..aOB(4, _omitFieldNames ? '' : 'compressed')
    ..p<$core.int>(5, _omitFieldNames ? '' : 'blocks', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GtfsHeader clone() => GtfsHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GtfsHeader copyWith(void Function(GtfsHeader) updates) => super.copyWith((message) => updates(message as GtfsHeader)) as GtfsHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GtfsHeader create() => GtfsHeader._();
  GtfsHeader createEmptyInstance() => create();
  static $pb.PbList<GtfsHeader> createRepeated() => $pb.PbList<GtfsHeader>();
  @$core.pragma('dart2js:noInline')
  static GtfsHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GtfsHeader>(create);
  static GtfsHeader? _defaultInstance;

  /// Versions are incremental. When generating a feed for the next day,
  /// we're using the previous one for reference, and incrementing the version.
  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  /// Date when the original GTFS feed was built, in YYYYMMDD format (20240319).
  @$pb.TagNumber(2)
  $core.int get date => $_getIZ(1);
  @$pb.TagNumber(2)
  set date($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => clearField(2);

  /// In case of errors, this would be the reference GTFS feed, zip file itself.
  /// Please link to specific builds if possible, e.g. "20240319", not "latest".
  @$pb.TagNumber(3)
  $core.String get originalUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set originalUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOriginalUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearOriginalUrl() => clearField(3);

  /// If true, all blocks are compressed with Zstandard.
  /// https://facebook.github.io/zstd/
  /// TODO: maybe leave the compression to external tools, on a file level?
  @$pb.TagNumber(4)
  $core.bool get compressed => $_getBF(3);
  @$pb.TagNumber(4)
  set compressed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompressed() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompressed() => clearField(4);

  /// Array in order and matching the Blocks enum. Sizes of blocks, not offsets.
  /// Only refers entries between 1 (inclusive) and B_END (not inclusive).
  /// May be cut off earlier, meaning the rest of the block are empty.
  @$pb.TagNumber(5)
  $core.List<$core.int> get blocks => $_getList(4);
}

class Agencies extends $pb.GeneratedMessage {
  factory Agencies({
    $core.Iterable<Agency>? agencies,
  }) {
    final $result = create();
    if (agencies != null) {
      $result.agencies.addAll(agencies);
    }
    return $result;
  }
  Agencies._() : super();
  factory Agencies.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Agencies.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Agencies', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Agency>(1, _omitFieldNames ? '' : 'agencies', $pb.PbFieldType.PM, subBuilder: Agency.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Agencies clone() => Agencies()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Agencies copyWith(void Function(Agencies) updates) => super.copyWith((message) => updates(message as Agencies)) as Agencies;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Agencies create() => Agencies._();
  Agencies createEmptyInstance() => create();
  static $pb.PbList<Agencies> createRepeated() => $pb.PbList<Agencies>();
  @$core.pragma('dart2js:noInline')
  static Agencies getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Agencies>(create);
  static Agencies? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Agency> get agencies => $_getList(0);
}

class Agency extends $pb.GeneratedMessage {
  factory Agency({
    $core.int? agencyId,
    $core.String? name,
    $core.String? url,
    $core.String? timezone,
    $core.String? lang,
    $core.String? phone,
    $core.String? fareUrl,
    $core.String? email,
  }) {
    final $result = create();
    if (agencyId != null) {
      $result.agencyId = agencyId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (url != null) {
      $result.url = url;
    }
    if (timezone != null) {
      $result.timezone = timezone;
    }
    if (lang != null) {
      $result.lang = lang;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (fareUrl != null) {
      $result.fareUrl = fareUrl;
    }
    if (email != null) {
      $result.email = email;
    }
    return $result;
  }
  Agency._() : super();
  factory Agency.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Agency.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Agency', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'agencyId', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'timezone')
    ..aOS(5, _omitFieldNames ? '' : 'lang')
    ..aOS(6, _omitFieldNames ? '' : 'phone')
    ..aOS(7, _omitFieldNames ? '' : 'fareUrl')
    ..aOS(8, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Agency clone() => Agency()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Agency copyWith(void Function(Agency) updates) => super.copyWith((message) => updates(message as Agency)) as Agency;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Agency create() => Agency._();
  Agency createEmptyInstance() => create();
  static $pb.PbList<Agency> createRepeated() => $pb.PbList<Agency>();
  @$core.pragma('dart2js:noInline')
  static Agency getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Agency>(create);
  static Agency? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get agencyId => $_getIZ(0);
  @$pb.TagNumber(1)
  set agencyId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAgencyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAgencyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get timezone => $_getSZ(3);
  @$pb.TagNumber(4)
  set timezone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimezone() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimezone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get lang => $_getSZ(4);
  @$pb.TagNumber(5)
  set lang($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLang() => $_has(4);
  @$pb.TagNumber(5)
  void clearLang() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fareUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set fareUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFareUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearFareUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get email => $_getSZ(7);
  @$pb.TagNumber(8)
  set email($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmail() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmail() => clearField(8);
}

class Services extends $pb.GeneratedMessage {
  factory Services({
    $core.int? baseDate,
    $core.Iterable<Service>? services,
  }) {
    final $result = create();
    if (baseDate != null) {
      $result.baseDate = baseDate;
    }
    if (services != null) {
      $result.services.addAll(services);
    }
    return $result;
  }
  Services._() : super();
  factory Services.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Services.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Services', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'baseDate', $pb.PbFieldType.OU3)
    ..pc<Service>(2, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM, subBuilder: Service.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Services clone() => Services()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Services copyWith(void Function(Services) updates) => super.copyWith((message) => updates(message as Services)) as Services;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Services create() => Services._();
  Services createEmptyInstance() => create();
  static $pb.PbList<Services> createRepeated() => $pb.PbList<Services>();
  @$core.pragma('dart2js:noInline')
  static Services getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Services>(create);
  static Services? _defaultInstance;

  /// A number just like in GTFS: e.g. 20240821.
  /// All service dates use offsets in days from it.
  @$pb.TagNumber(1)
  $core.int get baseDate => $_getIZ(0);
  @$pb.TagNumber(1)
  set baseDate($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Service> get services => $_getList(1);
}

class Service extends $pb.GeneratedMessage {
  factory Service({
    $core.int? serviceId,
    $core.int? startDate,
    $core.int? endDate,
    $core.int? weekdays,
    $core.Iterable<$core.int>? addedDays,
    $core.Iterable<$core.int>? removedDays,
    $core.bool? delete,
  }) {
    final $result = create();
    if (serviceId != null) {
      $result.serviceId = serviceId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (weekdays != null) {
      $result.weekdays = weekdays;
    }
    if (addedDays != null) {
      $result.addedDays.addAll(addedDays);
    }
    if (removedDays != null) {
      $result.removedDays.addAll(removedDays);
    }
    if (delete != null) {
      $result.delete = delete;
    }
    return $result;
  }
  Service._() : super();
  factory Service.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Service.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Service', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'serviceId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'startDate', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'endDate', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'weekdays', $pb.PbFieldType.OU3)
    ..p<$core.int>(5, _omitFieldNames ? '' : 'addedDays', $pb.PbFieldType.KU3)
    ..p<$core.int>(6, _omitFieldNames ? '' : 'removedDays', $pb.PbFieldType.KU3)
    ..aOB(7, _omitFieldNames ? '' : 'delete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Service clone() => Service()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Service copyWith(void Function(Service) updates) => super.copyWith((message) => updates(message as Service)) as Service;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Service create() => Service._();
  Service createEmptyInstance() => create();
  static $pb.PbList<Service> createRepeated() => $pb.PbList<Service>();
  @$core.pragma('dart2js:noInline')
  static Service getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Service>(create);
  static Service? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get serviceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set serviceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get startDate => $_getIZ(1);
  @$pb.TagNumber(2)
  set startDate($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get endDate => $_getIZ(2);
  @$pb.TagNumber(3)
  set endDate($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get weekdays => $_getIZ(3);
  @$pb.TagNumber(4)
  set weekdays($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWeekdays() => $_has(3);
  @$pb.TagNumber(4)
  void clearWeekdays() => clearField(4);

  /// These fields come from calendar_days.txt.
  /// The first value is offset from base_date, each consequtive
  /// is stored as an offset to previous.
  @$pb.TagNumber(5)
  $core.List<$core.int> get addedDays => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.int> get removedDays => $_getList(5);

  @$pb.TagNumber(7)
  $core.bool get delete => $_getBF(6);
  @$pb.TagNumber(7)
  set delete($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDelete() => $_has(6);
  @$pb.TagNumber(7)
  void clearDelete() => clearField(7);
}

class Shapes extends $pb.GeneratedMessage {
  factory Shapes({
    $core.Iterable<Shape>? shapes,
  }) {
    final $result = create();
    if (shapes != null) {
      $result.shapes.addAll(shapes);
    }
    return $result;
  }
  Shapes._() : super();
  factory Shapes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Shapes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Shapes', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Shape>(1, _omitFieldNames ? '' : 'shapes', $pb.PbFieldType.PM, subBuilder: Shape.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Shapes clone() => Shapes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Shapes copyWith(void Function(Shapes) updates) => super.copyWith((message) => updates(message as Shapes)) as Shapes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Shapes create() => Shapes._();
  Shapes createEmptyInstance() => create();
  static $pb.PbList<Shapes> createRepeated() => $pb.PbList<Shapes>();
  @$core.pragma('dart2js:noInline')
  static Shapes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shapes>(create);
  static Shapes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Shape> get shapes => $_getList(0);
}

class Shape extends $pb.GeneratedMessage {
  factory Shape({
    $core.int? shapeId,
    $core.Iterable<$core.int>? longitudes,
    $core.Iterable<$core.int>? latitudes,
  }) {
    final $result = create();
    if (shapeId != null) {
      $result.shapeId = shapeId;
    }
    if (longitudes != null) {
      $result.longitudes.addAll(longitudes);
    }
    if (latitudes != null) {
      $result.latitudes.addAll(latitudes);
    }
    return $result;
  }
  Shape._() : super();
  factory Shape.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Shape.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Shape', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'shapeId', $pb.PbFieldType.OU3)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'longitudes', $pb.PbFieldType.KS3)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'latitudes', $pb.PbFieldType.KS3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Shape clone() => Shape()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Shape copyWith(void Function(Shape) updates) => super.copyWith((message) => updates(message as Shape)) as Shape;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Shape create() => Shape._();
  Shape createEmptyInstance() => create();
  static $pb.PbList<Shape> createRepeated() => $pb.PbList<Shape>();
  @$core.pragma('dart2js:noInline')
  static Shape getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shape>(create);
  static Shape? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get shapeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set shapeId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeId() => clearField(1);

  /// Numbers multiplied by 100000 (1e5) and rounded.
  /// Mind the accumulated rounding error!
  /// Each number is the difference with the last.
  /// First is difference with 0 or the last from the last non-empty shape.
  @$pb.TagNumber(2)
  $core.List<$core.int> get longitudes => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get latitudes => $_getList(2);
}

class Networks extends $pb.GeneratedMessage {
  factory Networks({
    $core.Map<$core.int, $core.String>? networks,
  }) {
    final $result = create();
    if (networks != null) {
      $result.networks.addAll(networks);
    }
    return $result;
  }
  Networks._() : super();
  factory Networks.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Networks.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Networks', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..m<$core.int, $core.String>(1, _omitFieldNames ? '' : 'networks', entryClassName: 'Networks.NetworksEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('gtfs'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Networks clone() => Networks()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Networks copyWith(void Function(Networks) updates) => super.copyWith((message) => updates(message as Networks)) as Networks;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Networks create() => Networks._();
  Networks createEmptyInstance() => create();
  static $pb.PbList<Networks> createRepeated() => $pb.PbList<Networks>();
  @$core.pragma('dart2js:noInline')
  static Networks getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Networks>(create);
  static Networks? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, $core.String> get networks => $_getMap(0);
}

class Areas extends $pb.GeneratedMessage {
  factory Areas({
    $core.Map<$core.int, $core.String>? areas,
  }) {
    final $result = create();
    if (areas != null) {
      $result.areas.addAll(areas);
    }
    return $result;
  }
  Areas._() : super();
  factory Areas.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Areas.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Areas', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..m<$core.int, $core.String>(1, _omitFieldNames ? '' : 'areas', entryClassName: 'Areas.AreasEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('gtfs'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Areas clone() => Areas()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Areas copyWith(void Function(Areas) updates) => super.copyWith((message) => updates(message as Areas)) as Areas;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Areas create() => Areas._();
  Areas createEmptyInstance() => create();
  static $pb.PbList<Areas> createRepeated() => $pb.PbList<Areas>();
  @$core.pragma('dart2js:noInline')
  static Areas getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Areas>(create);
  static Areas? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, $core.String> get areas => $_getMap(0);
}

class StringTable extends $pb.GeneratedMessage {
  factory StringTable({
    $core.Iterable<$core.String>? strings,
  }) {
    final $result = create();
    if (strings != null) {
      $result.strings.addAll(strings);
    }
    return $result;
  }
  StringTable._() : super();
  factory StringTable.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StringTable.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StringTable', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'strings')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StringTable clone() => StringTable()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StringTable copyWith(void Function(StringTable) updates) => super.copyWith((message) => updates(message as StringTable)) as StringTable;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StringTable create() => StringTable._();
  StringTable createEmptyInstance() => create();
  static $pb.PbList<StringTable> createRepeated() => $pb.PbList<StringTable>();
  @$core.pragma('dart2js:noInline')
  static StringTable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StringTable>(create);
  static StringTable? _defaultInstance;

  /// First string is always empty.
  @$pb.TagNumber(1)
  $core.List<$core.String> get strings => $_getList(0);
}

class Stops extends $pb.GeneratedMessage {
  factory Stops({
    $core.Iterable<Stop>? stops,
  }) {
    final $result = create();
    if (stops != null) {
      $result.stops.addAll(stops);
    }
    return $result;
  }
  Stops._() : super();
  factory Stops.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Stops.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Stops', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Stop>(1, _omitFieldNames ? '' : 'stops', $pb.PbFieldType.PM, subBuilder: Stop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Stops clone() => Stops()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Stops copyWith(void Function(Stops) updates) => super.copyWith((message) => updates(message as Stops)) as Stops;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Stops create() => Stops._();
  Stops createEmptyInstance() => create();
  static $pb.PbList<Stops> createRepeated() => $pb.PbList<Stops>();
  @$core.pragma('dart2js:noInline')
  static Stops getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Stops>(create);
  static Stops? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Stop> get stops => $_getList(0);
}

/// Lat and lon are differences from the last non-empty stop position
/// (non-empty means, which has non-zero lon or lat).
class Stop extends $pb.GeneratedMessage {
  factory Stop({
    $core.int? stopId,
    $core.String? code,
    $core.int? name,
    $core.String? desc,
    $core.int? lat,
    $core.int? lon,
    LocationType? type,
    $core.int? parentId,
    Accessibility? wheelchair,
    $core.String? platformCode,
    $core.int? zone,
    $core.Iterable<$core.int>? areas,
    $core.bool? delete,
  }) {
    final $result = create();
    if (stopId != null) {
      $result.stopId = stopId;
    }
    if (code != null) {
      $result.code = code;
    }
    if (name != null) {
      $result.name = name;
    }
    if (desc != null) {
      $result.desc = desc;
    }
    if (lat != null) {
      $result.lat = lat;
    }
    if (lon != null) {
      $result.lon = lon;
    }
    if (type != null) {
      $result.type = type;
    }
    if (parentId != null) {
      $result.parentId = parentId;
    }
    if (wheelchair != null) {
      $result.wheelchair = wheelchair;
    }
    if (platformCode != null) {
      $result.platformCode = platformCode;
    }
    if (zone != null) {
      $result.zone = zone;
    }
    if (areas != null) {
      $result.areas.addAll(areas);
    }
    if (delete != null) {
      $result.delete = delete;
    }
    return $result;
  }
  Stop._() : super();
  factory Stop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Stop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Stop', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'stopId', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'name', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'desc')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'lat', $pb.PbFieldType.OS3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'lon', $pb.PbFieldType.OS3)
    ..e<LocationType>(7, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: LocationType.L_STOP, valueOf: LocationType.valueOf, enumValues: LocationType.values)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'parentId', $pb.PbFieldType.OU3)
    ..e<Accessibility>(9, _omitFieldNames ? '' : 'wheelchair', $pb.PbFieldType.OE, defaultOrMaker: Accessibility.A_UNKNOWN, valueOf: Accessibility.valueOf, enumValues: Accessibility.values)
    ..aOS(10, _omitFieldNames ? '' : 'platformCode')
    ..a<$core.int>(11, _omitFieldNames ? '' : 'zone', $pb.PbFieldType.OU3)
    ..p<$core.int>(12, _omitFieldNames ? '' : 'areas', $pb.PbFieldType.KU3)
    ..aOB(13, _omitFieldNames ? '' : 'delete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Stop clone() => Stop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Stop copyWith(void Function(Stop) updates) => super.copyWith((message) => updates(message as Stop)) as Stop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Stop create() => Stop._();
  Stop createEmptyInstance() => create();
  static $pb.PbList<Stop> createRepeated() => $pb.PbList<Stop>();
  @$core.pragma('dart2js:noInline')
  static Stop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Stop>(create);
  static Stop? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get stopId => $_getIZ(0);
  @$pb.TagNumber(1)
  set stopId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStopId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get name => $_getIZ(2);
  @$pb.TagNumber(3)
  set name($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get desc => $_getSZ(3);
  @$pb.TagNumber(4)
  set desc($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDesc() => $_has(3);
  @$pb.TagNumber(4)
  void clearDesc() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get lat => $_getIZ(4);
  @$pb.TagNumber(5)
  set lat($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLat() => $_has(4);
  @$pb.TagNumber(5)
  void clearLat() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get lon => $_getIZ(5);
  @$pb.TagNumber(6)
  set lon($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLon() => $_has(5);
  @$pb.TagNumber(6)
  void clearLon() => clearField(6);

  @$pb.TagNumber(7)
  LocationType get type => $_getN(6);
  @$pb.TagNumber(7)
  set type(LocationType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(6);
  @$pb.TagNumber(7)
  void clearType() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get parentId => $_getIZ(7);
  @$pb.TagNumber(8)
  set parentId($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasParentId() => $_has(7);
  @$pb.TagNumber(8)
  void clearParentId() => clearField(8);

  @$pb.TagNumber(9)
  Accessibility get wheelchair => $_getN(8);
  @$pb.TagNumber(9)
  set wheelchair(Accessibility v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasWheelchair() => $_has(8);
  @$pb.TagNumber(9)
  void clearWheelchair() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get platformCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set platformCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPlatformCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearPlatformCode() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get zone => $_getIZ(10);
  @$pb.TagNumber(11)
  set zone($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasZone() => $_has(10);
  @$pb.TagNumber(11)
  void clearZone() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.int> get areas => $_getList(11);

  @$pb.TagNumber(13)
  $core.bool get delete => $_getBF(12);
  @$pb.TagNumber(13)
  set delete($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDelete() => $_has(12);
  @$pb.TagNumber(13)
  void clearDelete() => clearField(13);
}

class Routes extends $pb.GeneratedMessage {
  factory Routes({
    $core.Iterable<Route>? routes,
  }) {
    final $result = create();
    if (routes != null) {
      $result.routes.addAll(routes);
    }
    return $result;
  }
  Routes._() : super();
  factory Routes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Routes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Routes', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Route>(1, _omitFieldNames ? '' : 'routes', $pb.PbFieldType.PM, subBuilder: Route.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Routes clone() => Routes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Routes copyWith(void Function(Routes) updates) => super.copyWith((message) => updates(message as Routes)) as Routes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Routes create() => Routes._();
  Routes createEmptyInstance() => create();
  static $pb.PbList<Routes> createRepeated() => $pb.PbList<Routes>();
  @$core.pragma('dart2js:noInline')
  static Routes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Routes>(create);
  static Routes? _defaultInstance;

  /// Sorted in sort_order if present, and in the source order otherwise.
  @$pb.TagNumber(1)
  $core.List<Route> get routes => $_getList(0);
}

class Route extends $pb.GeneratedMessage {
  factory Route({
    $core.int? routeId,
    $core.int? agencyId,
    $core.String? shortName,
    $core.Iterable<$core.int>? longName,
    $core.String? desc,
    RouteType? type,
    $core.int? color,
    $core.int? textColor,
    PickupDropoff? continuousPickup,
    PickupDropoff? continuousDropoff,
    $core.int? network,
    $core.bool? delete,
  }) {
    final $result = create();
    if (routeId != null) {
      $result.routeId = routeId;
    }
    if (agencyId != null) {
      $result.agencyId = agencyId;
    }
    if (shortName != null) {
      $result.shortName = shortName;
    }
    if (longName != null) {
      $result.longName.addAll(longName);
    }
    if (desc != null) {
      $result.desc = desc;
    }
    if (type != null) {
      $result.type = type;
    }
    if (color != null) {
      $result.color = color;
    }
    if (textColor != null) {
      $result.textColor = textColor;
    }
    if (continuousPickup != null) {
      $result.continuousPickup = continuousPickup;
    }
    if (continuousDropoff != null) {
      $result.continuousDropoff = continuousDropoff;
    }
    if (network != null) {
      $result.network = network;
    }
    if (delete != null) {
      $result.delete = delete;
    }
    return $result;
  }
  Route._() : super();
  factory Route.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Route.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Route', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'routeId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'agencyId', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'shortName')
    ..p<$core.int>(4, _omitFieldNames ? '' : 'longName', $pb.PbFieldType.KU3)
    ..aOS(5, _omitFieldNames ? '' : 'desc')
    ..e<RouteType>(6, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: RouteType.T_BUS, valueOf: RouteType.valueOf, enumValues: RouteType.values)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'color', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'textColor', $pb.PbFieldType.OU3)
    ..e<PickupDropoff>(9, _omitFieldNames ? '' : 'continuousPickup', $pb.PbFieldType.OE, defaultOrMaker: PickupDropoff.PD_YES, valueOf: PickupDropoff.valueOf, enumValues: PickupDropoff.values)
    ..e<PickupDropoff>(10, _omitFieldNames ? '' : 'continuousDropoff', $pb.PbFieldType.OE, defaultOrMaker: PickupDropoff.PD_YES, valueOf: PickupDropoff.valueOf, enumValues: PickupDropoff.values)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'network', $pb.PbFieldType.OU3)
    ..aOB(12, _omitFieldNames ? '' : 'delete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Route clone() => Route()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Route copyWith(void Function(Route) updates) => super.copyWith((message) => updates(message as Route)) as Route;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Route create() => Route._();
  Route createEmptyInstance() => create();
  static $pb.PbList<Route> createRepeated() => $pb.PbList<Route>();
  @$core.pragma('dart2js:noInline')
  static Route getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Route>(create);
  static Route? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get routeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set routeId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRouteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRouteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get agencyId => $_getIZ(1);
  @$pb.TagNumber(2)
  set agencyId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAgencyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAgencyId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get shortName => $_getSZ(2);
  @$pb.TagNumber(3)
  set shortName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasShortName() => $_has(2);
  @$pb.TagNumber(3)
  void clearShortName() => clearField(3);

  /// Long name is assumed to be in format "Stop 1 - Stop 2 - Stop 3".
  /// Each part is a strings reference.
  /// If names are not in this format, just putting all long names verbatim there.
  @$pb.TagNumber(4)
  $core.List<$core.int> get longName => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get desc => $_getSZ(4);
  @$pb.TagNumber(5)
  set desc($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDesc() => $_has(4);
  @$pb.TagNumber(5)
  void clearDesc() => clearField(5);

  @$pb.TagNumber(6)
  RouteType get type => $_getN(5);
  @$pb.TagNumber(6)
  set type(RouteType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get color => $_getIZ(6);
  @$pb.TagNumber(7)
  set color($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasColor() => $_has(6);
  @$pb.TagNumber(7)
  void clearColor() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get textColor => $_getIZ(7);
  @$pb.TagNumber(8)
  set textColor($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTextColor() => $_has(7);
  @$pb.TagNumber(8)
  void clearTextColor() => clearField(8);

  @$pb.TagNumber(9)
  PickupDropoff get continuousPickup => $_getN(8);
  @$pb.TagNumber(9)
  set continuousPickup(PickupDropoff v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasContinuousPickup() => $_has(8);
  @$pb.TagNumber(9)
  void clearContinuousPickup() => clearField(9);

  @$pb.TagNumber(10)
  PickupDropoff get continuousDropoff => $_getN(9);
  @$pb.TagNumber(10)
  set continuousDropoff(PickupDropoff v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasContinuousDropoff() => $_has(9);
  @$pb.TagNumber(10)
  void clearContinuousDropoff() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get network => $_getIZ(10);
  @$pb.TagNumber(11)
  set network($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNetwork() => $_has(10);
  @$pb.TagNumber(11)
  void clearNetwork() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get delete => $_getBF(11);
  @$pb.TagNumber(12)
  set delete($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDelete() => $_has(11);
  @$pb.TagNumber(12)
  void clearDelete() => clearField(12);
}

class Itineraries extends $pb.GeneratedMessage {
  factory Itineraries({
    $core.Iterable<Itinerary>? itineraries,
  }) {
    final $result = create();
    if (itineraries != null) {
      $result.itineraries.addAll(itineraries);
    }
    return $result;
  }
  Itineraries._() : super();
  factory Itineraries.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Itineraries.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Itineraries', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Itinerary>(1, _omitFieldNames ? '' : 'itineraries', $pb.PbFieldType.PM, subBuilder: Itinerary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Itineraries clone() => Itineraries()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Itineraries copyWith(void Function(Itineraries) updates) => super.copyWith((message) => updates(message as Itineraries)) as Itineraries;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Itineraries create() => Itineraries._();
  Itineraries createEmptyInstance() => create();
  static $pb.PbList<Itineraries> createRepeated() => $pb.PbList<Itineraries>();
  @$core.pragma('dart2js:noInline')
  static Itineraries getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Itineraries>(create);
  static Itineraries? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Itinerary> get itineraries => $_getList(0);
}

///  A sequence of bus stops for a trip is an Itinerary.
/// Often there are multiple trips during the day through the same stops,
/// so this helps save the bytes.
class Itinerary extends $pb.GeneratedMessage {
  factory Itinerary({
    $core.int? itineraryId,
    $core.int? routeId,
    $core.Iterable<$core.int>? stops,
    $core.bool? oppositeDirection,
    $core.int? shapeId,
    $core.Iterable<$core.int>? headsigns,
    $core.Iterable<PickupDropoff>? pickupTypes,
    $core.Iterable<PickupDropoff>? dropoffTypes,
  }) {
    final $result = create();
    if (itineraryId != null) {
      $result.itineraryId = itineraryId;
    }
    if (routeId != null) {
      $result.routeId = routeId;
    }
    if (stops != null) {
      $result.stops.addAll(stops);
    }
    if (oppositeDirection != null) {
      $result.oppositeDirection = oppositeDirection;
    }
    if (shapeId != null) {
      $result.shapeId = shapeId;
    }
    if (headsigns != null) {
      $result.headsigns.addAll(headsigns);
    }
    if (pickupTypes != null) {
      $result.pickupTypes.addAll(pickupTypes);
    }
    if (dropoffTypes != null) {
      $result.dropoffTypes.addAll(dropoffTypes);
    }
    return $result;
  }
  Itinerary._() : super();
  factory Itinerary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Itinerary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Itinerary', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'itineraryId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'routeId', $pb.PbFieldType.OU3)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'stops', $pb.PbFieldType.KU3)
    ..aOB(4, _omitFieldNames ? '' : 'oppositeDirection')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'shapeId', $pb.PbFieldType.OU3)
    ..p<$core.int>(6, _omitFieldNames ? '' : 'headsigns', $pb.PbFieldType.KU3)
    ..pc<PickupDropoff>(7, _omitFieldNames ? '' : 'pickupTypes', $pb.PbFieldType.KE, valueOf: PickupDropoff.valueOf, enumValues: PickupDropoff.values, defaultEnumValue: PickupDropoff.PD_YES)
    ..pc<PickupDropoff>(8, _omitFieldNames ? '' : 'dropoffTypes', $pb.PbFieldType.KE, valueOf: PickupDropoff.valueOf, enumValues: PickupDropoff.values, defaultEnumValue: PickupDropoff.PD_YES)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Itinerary clone() => Itinerary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Itinerary copyWith(void Function(Itinerary) updates) => super.copyWith((message) => updates(message as Itinerary)) as Itinerary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Itinerary create() => Itinerary._();
  Itinerary createEmptyInstance() => create();
  static $pb.PbList<Itinerary> createRepeated() => $pb.PbList<Itinerary>();
  @$core.pragma('dart2js:noInline')
  static Itinerary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Itinerary>(create);
  static Itinerary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get itineraryId => $_getIZ(0);
  @$pb.TagNumber(1)
  set itineraryId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItineraryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItineraryId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get routeId => $_getIZ(1);
  @$pb.TagNumber(2)
  set routeId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRouteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRouteId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get stops => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get oppositeDirection => $_getBF(3);
  @$pb.TagNumber(4)
  set oppositeDirection($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOppositeDirection() => $_has(3);
  @$pb.TagNumber(4)
  void clearOppositeDirection() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get shapeId => $_getIZ(4);
  @$pb.TagNumber(5)
  set shapeId($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasShapeId() => $_has(4);
  @$pb.TagNumber(5)
  void clearShapeId() => clearField(5);

  /// List of headsigns for every stop. Those are string references.
  /// Zero when the same as the last. Trimmed at the last non-zero value.
  @$pb.TagNumber(6)
  $core.List<$core.int> get headsigns => $_getList(5);

  /// If shorter than stops, repeat the last value.
  @$pb.TagNumber(7)
  $core.List<PickupDropoff> get pickupTypes => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<PickupDropoff> get dropoffTypes => $_getList(7);
}

class Trips extends $pb.GeneratedMessage {
  factory Trips({
    $core.Iterable<Trip>? trips,
  }) {
    final $result = create();
    if (trips != null) {
      $result.trips.addAll(trips);
    }
    return $result;
  }
  Trips._() : super();
  factory Trips.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Trips.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Trips', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Trip>(1, _omitFieldNames ? '' : 'trips', $pb.PbFieldType.PM, subBuilder: Trip.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Trips clone() => Trips()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Trips copyWith(void Function(Trips) updates) => super.copyWith((message) => updates(message as Trips)) as Trips;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trips create() => Trips._();
  Trips createEmptyInstance() => create();
  static $pb.PbList<Trips> createRepeated() => $pb.PbList<Trips>();
  @$core.pragma('dart2js:noInline')
  static Trips getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trips>(create);
  static Trips? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Trip> get trips => $_getList(0);
}

/// This message encapsulates both trips and stop_times.
class Trip extends $pb.GeneratedMessage {
  factory Trip({
    $core.int? tripId,
    $core.int? itineraryId,
    $core.int? serviceId,
    $core.String? shortName,
    Accessibility? wheelchair,
    Accessibility? bikes,
    $core.bool? approximate,
    $core.Iterable<$core.int>? departures,
    $core.Iterable<$core.int>? arrivals,
    $core.int? startTime,
    $core.int? endTime,
    $core.int? interval,
  }) {
    final $result = create();
    if (tripId != null) {
      $result.tripId = tripId;
    }
    if (itineraryId != null) {
      $result.itineraryId = itineraryId;
    }
    if (serviceId != null) {
      $result.serviceId = serviceId;
    }
    if (shortName != null) {
      $result.shortName = shortName;
    }
    if (wheelchair != null) {
      $result.wheelchair = wheelchair;
    }
    if (bikes != null) {
      $result.bikes = bikes;
    }
    if (approximate != null) {
      $result.approximate = approximate;
    }
    if (departures != null) {
      $result.departures.addAll(departures);
    }
    if (arrivals != null) {
      $result.arrivals.addAll(arrivals);
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (interval != null) {
      $result.interval = interval;
    }
    return $result;
  }
  Trip._() : super();
  factory Trip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Trip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Trip', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'tripId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'itineraryId', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'serviceId', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'shortName')
    ..e<Accessibility>(5, _omitFieldNames ? '' : 'wheelchair', $pb.PbFieldType.OE, defaultOrMaker: Accessibility.A_UNKNOWN, valueOf: Accessibility.valueOf, enumValues: Accessibility.values)
    ..e<Accessibility>(6, _omitFieldNames ? '' : 'bikes', $pb.PbFieldType.OE, defaultOrMaker: Accessibility.A_UNKNOWN, valueOf: Accessibility.valueOf, enumValues: Accessibility.values)
    ..aOB(7, _omitFieldNames ? '' : 'approximate')
    ..p<$core.int>(8, _omitFieldNames ? '' : 'departures', $pb.PbFieldType.KU3)
    ..p<$core.int>(9, _omitFieldNames ? '' : 'arrivals', $pb.PbFieldType.KU3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'startTime', $pb.PbFieldType.OU3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'endTime', $pb.PbFieldType.OU3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'interval', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Trip clone() => Trip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Trip copyWith(void Function(Trip) updates) => super.copyWith((message) => updates(message as Trip)) as Trip;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trip create() => Trip._();
  Trip createEmptyInstance() => create();
  static $pb.PbList<Trip> createRepeated() => $pb.PbList<Trip>();
  @$core.pragma('dart2js:noInline')
  static Trip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trip>(create);
  static Trip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tripId => $_getIZ(0);
  @$pb.TagNumber(1)
  set tripId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get itineraryId => $_getIZ(1);
  @$pb.TagNumber(2)
  set itineraryId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItineraryId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItineraryId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get serviceId => $_getIZ(2);
  @$pb.TagNumber(3)
  set serviceId($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get shortName => $_getSZ(3);
  @$pb.TagNumber(4)
  set shortName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasShortName() => $_has(3);
  @$pb.TagNumber(4)
  void clearShortName() => clearField(4);

  @$pb.TagNumber(5)
  Accessibility get wheelchair => $_getN(4);
  @$pb.TagNumber(5)
  set wheelchair(Accessibility v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasWheelchair() => $_has(4);
  @$pb.TagNumber(5)
  void clearWheelchair() => clearField(5);

  @$pb.TagNumber(6)
  Accessibility get bikes => $_getN(5);
  @$pb.TagNumber(6)
  set bikes(Accessibility v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBikes() => $_has(5);
  @$pb.TagNumber(6)
  void clearBikes() => clearField(6);

  /// schedule-based: whether we can trust every timestamp for departures/arrivals.
  /// frequency-based: whether the intervals are exact.
  @$pb.TagNumber(7)
  $core.bool get approximate => $_getBF(6);
  @$pb.TagNumber(7)
  set approximate($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasApproximate() => $_has(6);
  @$pb.TagNumber(7)
  void clearApproximate() => clearField(7);

  /// Granularity is 5 seconds.
  /// First number is (hours * 720) + (minutes * 12) + (seconds / 5), rounded down.
  /// After that, differences from previous time.
  /// Mind the accumulated rounding error!
  /// Zero (0) for a departure means an absent value.
  @$pb.TagNumber(8)
  $core.List<$core.int> get departures => $_getList(7);

  /// Counted from same departures (backwards), truncated to the last non-zero value.
  @$pb.TagNumber(9)
  $core.List<$core.int> get arrivals => $_getList(8);

  /// For frequency-based trips, those three are present.
  /// Granularity is 10 seconds. Values are, hours * 360 + minutes * 6 + seconds / 10.
  /// Rounding down for start and up for end.
  @$pb.TagNumber(10)
  $core.int get startTime => $_getIZ(9);
  @$pb.TagNumber(10)
  set startTime($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStartTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearStartTime() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get endTime => $_getIZ(10);
  @$pb.TagNumber(11)
  set endTime($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasEndTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearEndTime() => clearField(11);

  /// Here, granularity is 1 second, like in GTFS. No point in saving a byte.
  @$pb.TagNumber(12)
  $core.int get interval => $_getIZ(11);
  @$pb.TagNumber(12)
  set interval($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasInterval() => $_has(11);
  @$pb.TagNumber(12)
  void clearInterval() => clearField(12);
}

class Transfers extends $pb.GeneratedMessage {
  factory Transfers({
    $core.Iterable<Transfer>? transfers,
  }) {
    final $result = create();
    if (transfers != null) {
      $result.transfers.addAll(transfers);
    }
    return $result;
  }
  Transfers._() : super();
  factory Transfers.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transfers.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transfers', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<Transfer>(1, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM, subBuilder: Transfer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transfers clone() => Transfers()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transfers copyWith(void Function(Transfers) updates) => super.copyWith((message) => updates(message as Transfers)) as Transfers;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transfers create() => Transfers._();
  Transfers createEmptyInstance() => create();
  static $pb.PbList<Transfers> createRepeated() => $pb.PbList<Transfers>();
  @$core.pragma('dart2js:noInline')
  static Transfers getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfers>(create);
  static Transfers? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Transfer> get transfers => $_getList(0);
}

class Transfer extends $pb.GeneratedMessage {
  factory Transfer({
    $core.int? fromStop,
    $core.int? toStop,
    $core.int? fromRoute,
    $core.int? toRoute,
    $core.int? fromTrip,
    $core.int? toTrip,
    TransferType? type,
    $core.int? minTransferTime,
    $core.bool? delete,
  }) {
    final $result = create();
    if (fromStop != null) {
      $result.fromStop = fromStop;
    }
    if (toStop != null) {
      $result.toStop = toStop;
    }
    if (fromRoute != null) {
      $result.fromRoute = fromRoute;
    }
    if (toRoute != null) {
      $result.toRoute = toRoute;
    }
    if (fromTrip != null) {
      $result.fromTrip = fromTrip;
    }
    if (toTrip != null) {
      $result.toTrip = toTrip;
    }
    if (type != null) {
      $result.type = type;
    }
    if (minTransferTime != null) {
      $result.minTransferTime = minTransferTime;
    }
    if (delete != null) {
      $result.delete = delete;
    }
    return $result;
  }
  Transfer._() : super();
  factory Transfer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transfer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transfer', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'fromStop', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'toStop', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'fromRoute', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'toRoute', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'fromTrip', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'toTrip', $pb.PbFieldType.OU3)
    ..e<TransferType>(7, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TransferType.TR_POSSIBLE, valueOf: TransferType.valueOf, enumValues: TransferType.values)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'minTransferTime', $pb.PbFieldType.OU3)
    ..aOB(9, _omitFieldNames ? '' : 'delete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transfer clone() => Transfer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transfer copyWith(void Function(Transfer) updates) => super.copyWith((message) => updates(message as Transfer)) as Transfer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transfer create() => Transfer._();
  Transfer createEmptyInstance() => create();
  static $pb.PbList<Transfer> createRepeated() => $pb.PbList<Transfer>();
  @$core.pragma('dart2js:noInline')
  static Transfer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfer>(create);
  static Transfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get fromStop => $_getIZ(0);
  @$pb.TagNumber(1)
  set fromStop($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromStop() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get toStop => $_getIZ(1);
  @$pb.TagNumber(2)
  set toStop($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToStop() => $_has(1);
  @$pb.TagNumber(2)
  void clearToStop() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get fromRoute => $_getIZ(2);
  @$pb.TagNumber(3)
  set fromRoute($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFromRoute() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromRoute() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get toRoute => $_getIZ(3);
  @$pb.TagNumber(4)
  set toRoute($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToRoute() => $_has(3);
  @$pb.TagNumber(4)
  void clearToRoute() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get fromTrip => $_getIZ(4);
  @$pb.TagNumber(5)
  set fromTrip($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFromTrip() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromTrip() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get toTrip => $_getIZ(5);
  @$pb.TagNumber(6)
  set toTrip($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasToTrip() => $_has(5);
  @$pb.TagNumber(6)
  void clearToTrip() => clearField(6);

  @$pb.TagNumber(7)
  TransferType get type => $_getN(6);
  @$pb.TagNumber(7)
  set type(TransferType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(6);
  @$pb.TagNumber(7)
  void clearType() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get minTransferTime => $_getIZ(7);
  @$pb.TagNumber(8)
  set minTransferTime($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinTransferTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinTransferTime() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get delete => $_getBF(8);
  @$pb.TagNumber(9)
  set delete($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDelete() => $_has(8);
  @$pb.TagNumber(9)
  void clearDelete() => clearField(9);
}

class IdStore extends $pb.GeneratedMessage {
  factory IdStore({
    $core.Iterable<IdReference>? refs,
  }) {
    final $result = create();
    if (refs != null) {
      $result.refs.addAll(refs);
    }
    return $result;
  }
  IdStore._() : super();
  factory IdStore.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdStore.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IdStore', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..pc<IdReference>(1, _omitFieldNames ? '' : 'refs', $pb.PbFieldType.PM, subBuilder: IdReference.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdStore clone() => IdStore()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdStore copyWith(void Function(IdStore) updates) => super.copyWith((message) => updates(message as IdStore)) as IdStore;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdStore create() => IdStore._();
  IdStore createEmptyInstance() => create();
  static $pb.PbList<IdStore> createRepeated() => $pb.PbList<IdStore>();
  @$core.pragma('dart2js:noInline')
  static IdStore getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdStore>(create);
  static IdStore? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IdReference> get refs => $_getList(0);
}

class IdReference extends $pb.GeneratedMessage {
  factory IdReference({
    Block? block,
    $core.Iterable<$core.String>? ids,
    $core.int? deltaSkip,
  }) {
    final $result = create();
    if (block != null) {
      $result.block = block;
    }
    if (ids != null) {
      $result.ids.addAll(ids);
    }
    if (deltaSkip != null) {
      $result.deltaSkip = deltaSkip;
    }
    return $result;
  }
  IdReference._() : super();
  factory IdReference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdReference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IdReference', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..e<Block>(1, _omitFieldNames ? '' : 'block', $pb.PbFieldType.OE, defaultOrMaker: Block.B_HEADER, valueOf: Block.valueOf, enumValues: Block.values)
    ..pPS(2, _omitFieldNames ? '' : 'ids')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'deltaSkip', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdReference clone() => IdReference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdReference copyWith(void Function(IdReference) updates) => super.copyWith((message) => updates(message as IdReference)) as IdReference;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdReference create() => IdReference._();
  IdReference createEmptyInstance() => create();
  static $pb.PbList<IdReference> createRepeated() => $pb.PbList<IdReference>();
  @$core.pragma('dart2js:noInline')
  static IdReference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdReference>(create);
  static IdReference? _defaultInstance;

  @$pb.TagNumber(1)
  Block get block => $_getN(0);
  @$pb.TagNumber(1)
  set block(Block v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlock() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlock() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get ids => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get deltaSkip => $_getIZ(2);
  @$pb.TagNumber(3)
  set deltaSkip($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeltaSkip() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeltaSkip() => clearField(3);
}

class GtfsDeltaHeader extends $pb.GeneratedMessage {
  factory GtfsDeltaHeader({
    $core.int? oldVersion,
    $core.int? version,
    $core.int? date,
    $core.bool? compressed,
    $core.Iterable<$core.int>? blocks,
  }) {
    final $result = create();
    if (oldVersion != null) {
      $result.oldVersion = oldVersion;
    }
    if (version != null) {
      $result.version = version;
    }
    if (date != null) {
      $result.date = date;
    }
    if (compressed != null) {
      $result.compressed = compressed;
    }
    if (blocks != null) {
      $result.blocks.addAll(blocks);
    }
    return $result;
  }
  GtfsDeltaHeader._() : super();
  factory GtfsDeltaHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GtfsDeltaHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GtfsDeltaHeader', package: const $pb.PackageName(_omitMessageNames ? '' : 'gtfs'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'oldVersion', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'date', $pb.PbFieldType.OU3)
    ..aOB(4, _omitFieldNames ? '' : 'compressed')
    ..p<$core.int>(5, _omitFieldNames ? '' : 'blocks', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GtfsDeltaHeader clone() => GtfsDeltaHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GtfsDeltaHeader copyWith(void Function(GtfsDeltaHeader) updates) => super.copyWith((message) => updates(message as GtfsDeltaHeader)) as GtfsDeltaHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GtfsDeltaHeader create() => GtfsDeltaHeader._();
  GtfsDeltaHeader createEmptyInstance() => create();
  static $pb.PbList<GtfsDeltaHeader> createRepeated() => $pb.PbList<GtfsDeltaHeader>();
  @$core.pragma('dart2js:noInline')
  static GtfsDeltaHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GtfsDeltaHeader>(create);
  static GtfsDeltaHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get oldVersion => $_getIZ(0);
  @$pb.TagNumber(1)
  set oldVersion($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOldVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearOldVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get date => $_getIZ(2);
  @$pb.TagNumber(3)
  set date($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get compressed => $_getBF(3);
  @$pb.TagNumber(4)
  set compressed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompressed() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompressed() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get blocks => $_getList(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
