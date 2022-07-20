OPERATION_1 string : Channel
  .fromFilePairs(params.reads)
  .ifEmpty { exit 1, "Cannot find any reads matching: ${reads}\nNB: Path needs to be enclosed in quotes!\n"}
  .into {reads_ch; reads_ch1; reads_ch2; reads_ch3}
OPERATION_1 origin : [['params.reads', 'A']]
OPERATION_1 gives  : [['reads_ch', 'P'], ['reads_ch1', 'P'], ['reads_ch2', 'P'], ['reads_ch3', 'P']]


OPERATION_2 string : readlen_file_ch.map { it.text.trim().toInteger() }.into { read_len_ch1; read_len_ch2; read_len_ch3; read_len_ch4; read_len_ch5; read_len_ch6 }
OPERATION_2 origin : [['readlen_file_ch', 'P']]
OPERATION_2 gives  : [['read_len_ch1', 'P'], ['read_len_ch2', 'P'], ['read_len_ch3', 'P'], ['read_len_ch4', 'P'], ['read_len_ch5', 'P'], ['read_len_ch6', 'P']]


