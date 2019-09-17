cwlVersion: v1.0
class: CommandLineTool
label: Compute cluster marker genes
hints:
  DockerRequirement:
    dockerPull: mruffalo/scanpy:latest
baseCommand: scanpy_entry_point.py

arguments:
  - cluster_diffexpr
inputs:
  dim_reduced_clustered:
    type: File
outputs:
  cluster_diffexpr:
    type: File
    outputBinding:
      glob: cluster_diffexpr.h5
