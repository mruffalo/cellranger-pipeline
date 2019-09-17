cwlVersion: v1.0
class: CommandLineTool
label: QC checks
hints:
  DockerRequirement:
    dockerPull: mruffalo/scanpy:latest
baseCommand: scanpy_entry_point.py

arguments:
  - qc_check
inputs:
  cellranger_results_dir:
    type: Directory
outputs:
  qc_check:
    type: File
    outputBinding:
      glob: qc_check.h5
