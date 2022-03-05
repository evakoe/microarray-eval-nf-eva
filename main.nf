#!/usr/bin/env nextflow
/*
========================================================================================
    seppinho/microarray-eval-nf
========================================================================================
    Github : https://github.com/seppinho/microarray-eval-nf
    Author: Sebastian Schönherr
    ---------------------------
*/

nextflow.enable.dsl = 2

include { MICROARRAY_EVAL } from './workflows/microarray_eval'

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

workflow {
    MICROARRAY_EVAL ()
}
