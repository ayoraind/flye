#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// include definitions
include  { helpMessage; Version } from './modules/messages.nf'

// include processes
include { FLYE } from './modules/processes.nf'

log.info """\
    ============================================
    LONG READ ASSEMBLY  - TAPIR  P I P E L I N E
    ============================================
    output_dir      : ${params.output_dir}
    """
    .stripIndent()

workflow {
         reads_ch = channel
                          .fromPath( params.reads, checkIfExists: true )
                          .map { file -> tuple(file.simpleName, file) }
         mode_ch = channel.of( params.valid_mode )

    FLYE(reads_ch, params.valid_mode)

}
