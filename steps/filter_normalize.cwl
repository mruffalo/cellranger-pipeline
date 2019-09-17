cwlVersion: v1.0
class: CommandLineTool
label: Additional filtering and normalization
hints:
  DockerRequirement:
    dockerPull: mruffalo/scanpy:latest
baseCommand: scanpy_entry_point.py

arguments:
  - filter_normalize
inputs:
  cellranger_results_dir:
    type: Directory
outputs:
  filtered_normalized:
    type: File
    outputBinding:
      glob: filtered_normalized.h5
