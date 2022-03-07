

if (!params.imputation_token) {
   exit 1, "[Pipeline error] Parameter 'token' is not set in the pipeline!\n"
}


include { SIMULATE_ARRAY } from '../modules/local/simulate_array'
include { IMPUTE } from '../modules/local/impute'

workflow MICROARRAY_EVAL {

  array_data    =  channel.fromPath("${params.array_data}/*strand", checkIfExists: true)
  sequence_data =  channel.fromPath("${params.seq_data}/*vcf.gz", checkIfExists: true)


  array_data.combine(sequence_data)
    .map { array_file, seq_file -> tuple(getChromosome(seq_file), array_file, seq_file) }
    .set { array_seq_combined }

  SIMULATE_ARRAY ( array_seq_combined )
    SIMULATE_ARRAY.out.sim_out.groupTuple().view()

  IMPUTE ( SIMULATE_ARRAY.out.sim_out.groupTuple() )



}

// extract string or numbe after "chr"
def getChromosome(seq_file) {
    return (seq_file.baseName =~ /[cC][hH][rR](\d{1,2}|[xX]|MT)/)[0][1]
}
