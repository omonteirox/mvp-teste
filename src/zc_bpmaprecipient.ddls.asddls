@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BP Field Mapping - Recipient'
@Metadata.allowExtensions: true

@UI.headerInfo: {
  typeName: 'Recipient',
  typeNamePlural: 'Recipients',
  title: { type: #STANDARD, value: 'RecipientName' },
  description: { type: #STANDARD, value: 'RecipientId' }
}

define view entity ZC_BpMapRecipient
  as projection on ZI_BpMapRecipient
{
      @UI.facet: [
        {
          id: 'GeneralInfo',
          purpose: #STANDARD,
          type: #IDENTIFICATION_REFERENCE,
          label: 'General Information',
          position: 10
        },
        {
          id: 'FieldMappings',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          label: 'Field Mappings',
          position: 20,
          targetElement: '_FieldMapping'
        }
      ]

      @UI.hidden: true
  key RecipientUUID,

      @UI: {
        lineItem: [{ position: 10 }],
        identification: [{ position: 10 }],
        selectionField: [{ position: 10 }]
      }
      RecipientId,

      @UI: {
        lineItem: [{ position: 20 }],
        identification: [{ position: 20 }],
        selectionField: [{ position: 20 }]
      }
      RecipientName,

      @UI: {
        lineItem: [{ position: 30 }],
        identification: [{ position: 30 }]
      }
      Description,

      @UI: {
        identification: [{ position: 40 }]
      }
      SourceEntity,

      @UI: {
        lineItem: [{ position: 50 }],
        identification: [{ position: 50 }]
      }
      IsActive,

      @UI.hidden: true
      CreatedBy,
      @UI.hidden: true
      CreatedAt,
      @UI.hidden: true
      LastChangedBy,
      @UI.hidden: true
      LastChangedAt,
      @UI.hidden: true
      LocalLastChangedAt,

      // Associations
      _FieldMapping : redirected to composition child ZC_BpMapField
}
