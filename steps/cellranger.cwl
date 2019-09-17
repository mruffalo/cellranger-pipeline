cwlVersion: v1.0
class: CommandLineTool
label: CellRanger 3.0.2
hints:
  DockerRequirement:
    dockerPull: mruffalo/cellranger:3.0.2
baseCommand: cellranger_entry_point.py

inputs:
  sample_id:
    type: string
  fastq_dirs:
    type: Directory[]
outputs:
  results_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.sample_id)
