OPERATION_1 string : bam = Channel
		.fromPath(params.bam)
		.ifEmpty { exit 1, "${params.bam} not found.\nPlease specify --bam option (--bam bamfile)"}
OPERATION_1 origin : [['params.bam', 'A']]
OPERATION_1 gives  : [['bam', 'P']]


OPERATION_2 string : Channel
		.fromPath(params.genome)
		.ifEmpty { exit 1, "${params.genome} not found.\nPlease specify --genome option (--genome fastafile)"}
		.into { fastaToFai; fastaToHipSTR }
OPERATION_2 origin : [['params.genome', 'A']]
OPERATION_2 gives  : [['fastaToFai', 'P'], ['fastaToHipSTR', 'P']]


OPERATION_3 string : fai = Channel
			.fromPath(params.fai)
			.ifEmpty { exit 1, "${params.fai} not found.\nYou can remove your --fai option (--fai faifile) and it will be produced for you automatically"}
OPERATION_3 origin : [['params.fai', 'A']]
OPERATION_3 gives  : [['fai', 'P']]


OPERATION_4 string : bed = Channel
    .fromPath(params.bed)
    .ifEmpty { exit 1, "${params.bed} not found.\nPlease specify --bed option (--bed bedfile)"}
OPERATION_4 origin : [['params.bed', 'A']]
OPERATION_4 gives  : [['bed', 'P']]


OPERATION_5 string : summary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
OPERATION_5 origin : [['summary', 'P']]
OPERATION_5 gives  : []


