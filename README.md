## Workflow to assemble long reads using Flye.
### Usage

```

===================================================================
 ASSEMBLY OF LONG READS USING FLYE: TAPIR Pipeline version 1.0dev
===================================================================
 The typical command for running the pipeline is as follows:
        nextflow run main.nf --reads "PathToReadFile(s)" --output_dir "PathToOutputDir" --valid-mode "ModeName"

        Mandatory arguments:
         --reads                        Query fastq.gz file of sequences you wish to supply as input (e.g., "/MIGE/01_DATA/01_FASTQ/T055-8-*.fastq.gz")
         --output_dir                   Output directory to place assembly (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         
        Optional arguments:
	 --valid_mode                   This should be one of "--pacbio-raw", "--pacbio-corr", "--pacbio-hifi", "--nano-raw", "--nano-corr", or "--nano-hq". [Default: "--nano-raw"]
         --help                         This usage statement.
         --version                      Version statement

```


## Introduction
This pipeline assembles long reads using flye. This Nextflow pipeline was adapted from NF Core's [Flye module](https://github.com/nf-core/modules/tree/master/modules/nf-core/flye).  


## Sample command
An example of a command to run this pipeline is:

```
nextflow run main.nf --reads "Sample_files/*.fastq.gz" --output_dir "test2" --valid_mode "--nano-raw"
```

## Word of Note
This is an ongoing project at the Microbial Genome Analysis Group, Institute for Infection Prevention and Hospital Epidemiology, Üniversitätsklinikum, Freiburg. The project is funded by BMBF, Germany, and is led by [Dr. Sandra Reuter](https://www.uniklinik-freiburg.de/iuk-en/infection-prevention-and-hospital-epidemiology/research-group-reuter.html).


## Authors and acknowledgment
The TAPIR (Track Acquisition of Pathogens In Real-time) team.
