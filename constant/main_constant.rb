module MainConstant
  CONFIG = { max_attempts: 10 }.freeze
  LABEL = { 
    collection_cant_be_empty: "Collection can't be empty!",
    collection_must_be_ten: "Collection should has 10 data either single or set of number!",
    collection_must_has_all_numbers: "Collection contains non-integer elements!",
    collection_contains_more_than_two_pairs: "Collection should contains one or two pairs and three pairs in the last!"     
  }.freeze
end