#!/usr/bin/env python3
from argparse import ArgumentParser
import os
from pathlib import Path
from subprocess import check_call
from typing import Optional, Sequence

CELLRANGER_COMMAND_TEMPLATE = [
    'cellranger',
    'count',
    '--jobmode=local',
    '--transcriptome=transcriptome_dir',
    '--id={sample_id}',
    '--fastqs={fastq_dirs}',
    '--nosecondary',
    '--disable-ui',
]

def run_cellranger(sample_id: str, expect_cells: Optional[str], fastq_dirs: Sequence[Path]):
    fastq_dirs_str = ','.join(str(fd) for fd in fastq_dirs)

    cellranger_command = [
        piece.format(
            sample_id=sample_id,
            fastq_dirs=fastq_dirs_str,
        )
        for piece in CELLRANGER_COMMAND_TEMPLATE
    ]
    if expect_cells is not None:
        cellranger_command.append(f'--expect-cells={expect_cells}')

    check_call(cellranger_command)

if __name__ == '__main__':
    p = ArgumentParser()
    p.add_argument('sample_id')
    p.add_argument('--expect-cells')
    p.add_argument('fastq_dirs', nargs='+', type=Path)
    args = p.parse_args()

    run_cellranger(args.sample_id, args.expect_cells, args.fastq_dirs)
