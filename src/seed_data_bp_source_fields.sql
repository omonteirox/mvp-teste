-- ============================================================
-- Seed Data for ZDEZ_BP_SRCFLD (BP Source Fields - Value Help)
-- Run this in ADT SQL Console after table activation
-- ============================================================

INSERT INTO zdez_bp_srcfld VALUES
  ('', 'BusinessPartner',           'Business Partner Number',    'CHAR', 10),
  ('', 'BusinessPartnerName',       'Business Partner Name',      'CHAR', 81),
  ('', 'BusinessPartnerFullName',   'Full Name',                  'CHAR', 81),
  ('', 'FirstName',                 'First Name',                 'CHAR', 40),
  ('', 'LastName',                  'Last Name',                  'CHAR', 40),
  ('', 'MiddleName',               'Middle Name',                'CHAR', 40),
  ('', 'BusinessPartnerCategory',  'Category',                   'CHAR',  1),
  ('', 'BusinessPartnerType',      'BP Type',                    'CHAR',  4),
  ('', 'OrganizationBPName1',      'Organization Name 1',        'CHAR', 40),
  ('', 'OrganizationBPName2',      'Organization Name 2',        'CHAR', 40),
  ('', 'SearchTerm1',              'Search Term 1',              'CHAR', 20),
  ('', 'SearchTerm2',              'Search Term 2',              'CHAR', 20),
  ('', 'Industry',                 'Industry Sector',            'CHAR', 10),
  ('', 'Language',                 'Language',                    'CHAR',  2),
  ('', 'CorrespondenceLanguage',   'Correspondence Language',    'CHAR',  2),
  ('', 'LegalForm',               'Legal Form',                 'CHAR',  2),
  ('', 'Customer',                 'Customer Number',            'CHAR', 10),
  ('', 'Supplier',                 'Supplier Number',            'CHAR', 10),
  ('', 'BusinessPartnerIsBlocked', 'Central Block',              'BOOL',  1),
  ('', 'BirthDate',               'Date of Birth',              'DATS',  8);
