OPERATION_1 string : updated_samplesheet2 = Channel.create()PROCESS DEF parse_jsonfile
OPERATION_1 origin : []
OPERATION_1 gives  : [['updated_samplesheet2', 'P']]


OPERATION_2 string : PROBLEM_SS_CHECK2 = Channel.create()PROCESS DEF recheck_samplesheet
OPERATION_2 origin : []
OPERATION_2 gives  : [['PROBLEM_SS_CHECK2', 'P']]


OPERATION_3 string : fastqcAll = Channel.empty()
OPERATION_3 origin : []
OPERATION_3 gives  : [['fastqcAll', 'P']]


OPERATION_4 string : fastqcScreenAll = Channel.empty()
OPERATION_4 origin : []
OPERATION_4 gives  : [['fastqcScreenAll', 'P']]


OPERATION_5 string : fastq_screen_txt = Channel.create()
OPERATION_5 origin : []
OPERATION_5 gives  : [['fastq_screen_txt', 'P']]


OPERATION_6 string : all_fq_screen_txt_tuple = Channel.create()
OPERATION_6 origin : []
OPERATION_6 gives  : [['all_fq_screen_txt_tuple', 'P']]


OPERATION_7 string : bcl_stats_empty = Channel.empty()
OPERATION_7 origin : []
OPERATION_7 gives  : [['bcl_stats_empty', 'P']]


OPERATION_8 string : summary.collect { k,v -> "${k.padRight(22)}: $v" }.join("\n")
OPERATION_8 origin : [['summary', 'P']]
OPERATION_8 gives  : []


OPERATION_9 string : cr_fastqs_copyfs_tuple_ch = cr_fastqs_copyfs_ch.map { fqfile -> [ getCellRangerProjectName(fqfile), getCellRangerSampleName(fqfile), fqfile.getFileName() ] }
OPERATION_9 origin : [['cr_fastqs_copyfs_ch', 'P']]
OPERATION_9 gives  : [['cr_fastqs_copyfs_tuple_ch', 'P']]


OPERATION_10 string : cr_undetermined_fastqs_copyfs_tuple_ch = cr_undetermined_move_fq_ch.map { fqfile -> [ "Undetermined", fqfile.getFileName() ] }
OPERATION_10 origin : [['cr_undetermined_move_fq_ch', 'P']]
OPERATION_10 gives  : [['cr_undetermined_fastqs_copyfs_tuple_ch', 'P']]


OPERATION_11 string : cr_samplesheet_info_ch = tenx_samplesheet2.splitCsv(header: true, skip: 1).map { row -> [ row.Sample_ID, row.Sample_Project, row.ReferenceGenome, row.DataAnalysisType ] }
OPERATION_11 origin : [['tenx_samplesheet2', 'P']]
OPERATION_11 gives  : [['cr_samplesheet_info_ch', 'P']]


OPERATION_12 string : cr_fqname_fqfile_ch = cr_fastqs_count_ch.map { fqfile -> [ getCellRangerSampleName(fqfile), getCellRangerFastqPath(fqfile) ] }.unique()
OPERATION_12 origin : [['cr_fastqs_count_ch', 'P']]
OPERATION_12 gives  : [['cr_fqname_fqfile_ch', 'P']]


OPERATION_13 string : cr_fqname_fqfile_ch
    .phase(cr_samplesheet_info_ch)
    .map{ left, right ->
        def sampleID = left[0]
        def projectName = right[1]
        def refGenome = right[2]
        def dataType = right[3]
        def fastqDir = left[1]
        tuple(sampleID, projectName, refGenome, dataType, fastqDir) }
   .set { cr_grouped_fastq_dir_sample_ch }
OPERATION_13 origin : [['cr_fqname_fqfile_ch', 'P'], ['cr_samplesheet_info_ch', 'P']]
OPERATION_13 gives  : [['cr_grouped_fastq_dir_sample_ch', 'P']]


OPERATION_14 string : fqname_fqfile_ch = fastqs_fqc_ch.map { fqFile -> [fqFile.getParent().getName(), fqFile ] }
OPERATION_14 origin : [['fastqs_fqc_ch', 'P']]
OPERATION_14 gives  : [['fqname_fqfile_ch', 'P']]


OPERATION_15 string : undetermined_default_fqfile_tuple_ch = undetermined_default_fq_ch.map { fqFile -> ["Undetermined_default", fqFile ] }
OPERATION_15 origin : [['undetermined_default_fq_ch', 'P']]
OPERATION_15 gives  : [['undetermined_default_fqfile_tuple_ch', 'P']]


OPERATION_16 string : cr_fqname_fqfile_fqc_ch = cr_fastqs_fqc_ch.map { fqFile -> [getCellRangerProjectName(fqFile), fqFile ] }
OPERATION_16 origin : [['cr_fastqs_fqc_ch', 'P']]
OPERATION_16 gives  : [['cr_fqname_fqfile_fqc_ch', 'P']]


OPERATION_17 string : cr_undetermined_default_fq_tuple_ch = cr_undetermined_default_fq_ch.map { fqFile -> ["Undetermined_default", fqFile ] }
OPERATION_17 origin : [['cr_undetermined_default_fq_ch', 'P']]
OPERATION_17 gives  : [['cr_undetermined_default_fq_tuple_ch', 'P']]


OPERATION_18 string : fastqcAll_ch = fastqcAll.mix(fqname_fqfile_ch, undetermined_default_fqfile_tuple_ch, cr_fqname_fqfile_fqc_ch, cr_undetermined_default_fq_tuple_ch)
OPERATION_18 origin : [['fastqcAll', 'P'], ['fqname_fqfile_ch', 'P'], ['undetermined_default_fqfile_tuple_ch', 'P'], ['cr_fqname_fqfile_fqc_ch', 'P'], ['cr_undetermined_default_fq_tuple_ch', 'P']]
OPERATION_18 gives  : [['fastqcAll_ch', 'P']]


OPERATION_19 string : fastqs_screen_fqfile_ch = fastqs_screen_ch.map { fqFile -> [fqFile.getParent().getName(), fqFile ] }
OPERATION_19 origin : [['fastqs_screen_ch', 'P']]
OPERATION_19 gives  : [['fastqs_screen_fqfile_ch', 'P']]


OPERATION_20 string : undetermined_fastqs_screen_fqfile_ch = undetermined_default_fastqs_screen_ch.map { fqFile -> ["Undetermined_default", fqFile ] }
OPERATION_20 origin : [['undetermined_default_fastqs_screen_ch', 'P']]
OPERATION_20 gives  : [['undetermined_fastqs_screen_fqfile_ch', 'P']]


OPERATION_21 string : cr_fqname_fqfile_screen_ch = cr_fastqs_screen_ch.map { fqFile -> [getCellRangerProjectName(fqFile), fqFile ] }
OPERATION_21 origin : [['cr_fastqs_screen_ch', 'P']]
OPERATION_21 gives  : [['cr_fqname_fqfile_screen_ch', 'P']]


OPERATION_22 string : cr_undetermined_fastqs_screen_tuple_ch = cr_undetermined_fastqs_screen_ch.map { fqFile -> ["Undetermined_default", fqFile ] }
OPERATION_22 origin : [['cr_undetermined_fastqs_screen_ch', 'P']]
OPERATION_22 gives  : [['cr_undetermined_fastqs_screen_tuple_ch', 'P']]


OPERATION_23 string : grouped_fqscreen_ch = fastqcScreenAll.mix(fastqs_screen_fqfile_ch, cr_fqname_fqfile_screen_ch, cr_undetermined_fastqs_screen_tuple_ch, undetermined_fastqs_screen_fqfile_ch)
OPERATION_23 origin : [['fastqcScreenAll', 'P'], ['fastqs_screen_fqfile_ch', 'P'], ['cr_fqname_fqfile_screen_ch', 'P'], ['cr_undetermined_fastqs_screen_tuple_ch', 'P'], ['undetermined_fastqs_screen_fqfile_ch', 'P']]
OPERATION_23 gives  : [['grouped_fqscreen_ch', 'P']]


OPERATION_24 string : all_fcq_files = all_fcq_files_tuple.map { k,v -> v }.flatten().collect()
OPERATION_24 origin : [['all_fcq_files_tuple', 'P']]
OPERATION_24 gives  : [['all_fcq_files', 'P']]


OPERATION_25 string : all_fq_screen_files = all_fq_screen_txt_tuple.map { k,v -> v }.flatten().collect()
OPERATION_25 origin : [['all_fq_screen_txt_tuple', 'P']]
OPERATION_25 gives  : [['all_fq_screen_files', 'P']]


OPERATION_26 string : b2fq_default_stats_all_ch = bcl_stats_empty.mix(b2fq_default_stats_ch)
OPERATION_26 origin : [['bcl_stats_empty', 'P'], ['b2fq_default_stats_ch', 'P']]
OPERATION_26 gives  : [['b2fq_default_stats_all_ch', 'P']]


OPERATION_27 string : projectList.subscribe { projectList_2.add("$it") }
OPERATION_27 origin : [['projectList', 'P']]
OPERATION_27 gives  : []


OPERATION_28 string : all_multiqc = projectList_2.collect{ project -> ["${project}", "https://sample-selector-bioinformatics.crick.ac.uk/sequencing/${runName}/multiqc/${project}/multiqc_report.html"] }
OPERATION_28 origin : [['projectList_2', 'P']]
OPERATION_28 gives  : [['all_multiqc', 'P']]


