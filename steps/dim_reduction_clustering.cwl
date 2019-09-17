cwlVersion: v1.0
class: CommandLineTool
label: Dimensionality reduction and clustering
hints:
  DockerRequirement:
    dockerPull: mruffalo/scanpy:latest
baseCommand: scanpy_entry_point.py

arguments:
  - dim_reduction_clustering
inputs:
  filtered_normalized:
    type: File
outputs:
  results_dir:
    type: File
    outputBinding:
      glob: dim_reduced_clustered.h5
