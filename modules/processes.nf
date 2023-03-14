process FLYE {
    publishDir "${params.output_dir}/${meta}_FLYE", mode:'copy'
    tag "flye on $meta"
    
    errorStrategy 'ignore'
    
    conda "/MIGE/01_DATA/07_TOOLS_AND_SOFTWARE/nextflow_pipelines/flye_assembly/flye_env.yml"
    // outside of the TAPIR network, simply edit script and use conda '../flye_env.yml'

    input:
    tuple val(meta), path(reads)
    val mode

    output:
    tuple val(meta), path("*.fasta")   , emit: fasta_ch
    tuple val(meta), path("*.gfa")     , emit: gfa_ch
    tuple val(meta), path("*.gv")      , emit: gv_ch
    tuple val(meta), path("*.txt")     , emit: txt_ch
    tuple val(meta), path("*.log")     , emit: log_ch
    tuple val(meta), path("*.json")    , emit: json_ch
    path "versions.yml"                , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    def valid_mode = ["--pacbio-raw", "--pacbio-corr", "--pacbio-hifi", "--nano-raw", "--nano-corr", "--nano-hq"]
    if ( !valid_mode.contains(mode) )  { error "Unrecognised mode to run Flye. Options: ${valid_mode.join(', ')}" }
    """
    
    flye $mode $reads --keep-haplotypes --meta --out-dir . --threads $task.cpus $args
    
    mv assembly.fasta ${prefix}.fasta
    mv flye.log ${prefix}.flye.log
    mv assembly_graph.gfa ${prefix}.assembly_graph.gfa
    mv assembly_graph.gv ${prefix}.assembly_graph.gv
    mv assembly_info.txt ${prefix}.assembly_info.txt
    mv params.json ${prefix}.params.json
    sed -i "s/^>/>${prefix}_/g" ${prefix}.fasta
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        flye: \$( flye --version )
    END_VERSIONS
    """

}
