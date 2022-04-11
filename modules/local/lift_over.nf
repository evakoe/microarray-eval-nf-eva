process LIFT_OVER {

//publishDir "${params.outdir}/aggRSquare", mode: 'copy', pattern: '*aggRSquare'

    input:
    tuple val(array_name), path(dosage_data), path(sequence_data), val(chr)

    output:
    tuple val(array_name), path(dosage_data), path("*.liftover.vcf.gz"), val(chr), emit: imputed_data_lifted

    script:
    def chain_file = (params.build_panel == 'hg19' ? "/opt/imputationserver/chains/hg19ToHg38.over.chain.gz" : '/opt/imputationserver/chains/hg38ToHg19.over.chain.gz')

    """
    java -jar /opt/imputationserver/imputationserver.jar vcf-liftover --input $dosage_data --output ${dosage_data.baseName}.liftover.vcf.gz --chain $chain_file
    """
}
