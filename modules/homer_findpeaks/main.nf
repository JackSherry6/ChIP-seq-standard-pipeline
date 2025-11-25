#!/usr/bin/env nextflow

process FINDPEAKS {
    label 'process_single'
    container 'ghcr.io/bf528/homer_samtools:latest'
    
    input:
    tuple val(sample), path(controlDir), path(chipDir)

    output:
    tuple val(sample), path("${sample}_peaks.txt")
    
    script:
    """
    echo "Listing contents of ChIP tag directory: ${chipDir}"
    ls -lh ${chipDir}
    echo "Listing contents of control tag directory: ${controlDir}"
    ls -lh ${controlDir}
    findPeaks "${chipDir}" \
        -style factor \
        -i "${controlDir}" \
        -o "${sample}_peaks.txt"
    """

    stub:
    """
    touch ${rep}_peaks.txt
    """
}


