@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BP Field Mapping - Field Map'
@ObjectModel.usageType: {
  serviceQuality: #A,
  sizeCategory: #S,
  dataClass: #TRANSACTIONAL
}
define view entity ZI_BpMapField
  as select from zdez_map_field as FieldMap

  association to parent ZI_BpMapRecipient as _Recipient
    on $projection.ParentUUID = _Recipient.RecipientUUID
{
  key FieldMap.field_uuid              as FieldUUID,
      FieldMap.parent_uuid             as ParentUUID,
      FieldMap.source_field_name       as SourceFieldName,
      FieldMap.target_field_name       as TargetFieldName,
      FieldMap.is_active               as IsActive,

      @Semantics.user.createdBy: true
      FieldMap.created_by              as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      FieldMap.created_at              as CreatedAt,
      @Semantics.user.lastChangedBy: true
      FieldMap.last_changed_by         as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      FieldMap.last_changed_at         as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      FieldMap.local_last_changed_at   as LocalLastChangedAt,

      // Associations
      _Recipient
}
