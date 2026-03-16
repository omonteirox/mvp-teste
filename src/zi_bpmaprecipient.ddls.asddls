@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BP Field Mapping - Recipient'
@ObjectModel.usageType: {
  serviceQuality: #A,
  sizeCategory: #S,
  dataClass: #TRANSACTIONAL
}
define view entity ZI_BpMapRecipient
  as select from zdez_map_recip as Recipient

  composition [0..*] of ZI_BpMapField as _FieldMapping
{
  key Recipient.recipient_uuid       as RecipientUUID,
      Recipient.recipient_id         as RecipientId,
      Recipient.recipient_name       as RecipientName,
      Recipient.description          as Description,
      Recipient.source_entity        as SourceEntity,
      Recipient.is_active            as IsActive,

      @Semantics.user.createdBy: true
      Recipient.created_by           as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      Recipient.created_at           as CreatedAt,
      @Semantics.user.lastChangedBy: true
      Recipient.last_changed_by      as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Recipient.last_changed_at      as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Recipient.local_last_changed_at as LocalLastChangedAt,

      // Associations
      _FieldMapping
}
