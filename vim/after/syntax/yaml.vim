syn match MembOperator "\." containedIn=yamlFlowMappingKey,yamlPlainScalar

hi! link yamlBool Statement
hi! link yamlKeyValueDelimiter Normal
hi! link yamlFlowIndicator Normal
hi! link yamlBlockMappingKey Function
hi! link yamlBlockCollectionItemStart SpecialComment
