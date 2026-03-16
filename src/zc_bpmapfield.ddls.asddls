@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BP Field Mapping - Field Map'
@Metadata.allowExtensions: true

@UI.headerInfo: {
  typeName: 'Field Mapping',
  typeNamePlural: 'Field Mappings'
}

define view entity ZC_BpMapField
  as projection on ZI_BpMapField
{
      @UI.hidden: true
  key FieldUUID,

      @UI.hidden: true
      ParentUUID,

      @UI: {
        lineItem: [{ position: 10 }],
        identification: [{ position: 10 }]
      }
      @Consumption.valueHelpDefinition: [{
        entity: { name: 'ZI_BpSourceField', element: 'FieldName' },
        additionalBinding: [{
          localElement: 'SourceFieldName',
          element: 'FieldName'
        }]
      }]
      SourceFieldName,

      @UI: {
        lineItem: [{ position: 20 }],
        identification: [{ position: 20 }]
      }
      TargetFieldName,

      @UI: {
        lineItem: [{ position: 30 }],
        identification: [{ position: 30 }]
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
      _Recipient : redirected to parent ZC_BpMapRecipient
}
