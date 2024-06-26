# GP Refresh System Benchmark (GP2BM)

The following 7 application benchmarks make up the GP Refresh System Benchmark (GP2BM),
for the 2024 GP Refresh System procurement.
Each benchmark includes the source codes or download links to source code, benchmark run requirements and the instructions for reporting results.

Proponents involved in any ongoing Requests for Proposals (RFPs) are hereby instructed against initiating Pull Requests or Issues to seek clarifications. Proponents are urged to adhere to the designated communication protocol by directly contacting the Procurement Offices of the host institutions, as specified within the respective RFP documentation.

## CPU-node benchmarks

## HPCG

- The High Performance Conjugate Gradients [HPCG](https://www.hpcg-benchmark.org/) benchmark is designed to exercise computational and data access patterns that closely match a broad set of important scientific applications, and to give incentive to computer system designers to invest in capabilities that will have impact on the collective performance of these applications. 
- HPCG is an open source benchmark developed by Mike Heroux, Jack Dongarra and Piotr Luszcze. 
- The source code can be downloaded [here](https://github.com/hpcg-benchmark/hpcg/archive/refs/tags/HPCG-release-3-1-0.tar.gz). (md5sum: bebe50185b365daf7b6b60f26ef3a390)
- Specific instructions can be found in the [hpcg](hpcg) directory.


### Quantum Espresso

- [Quantum Espresso](https://www.quantum-espresso.org) is an integrated suite of Open-Source computer codes for electronic-structure calculations and materials modeling at the nanoscale. It is based on density-functional theory, plane waves, and pseudopotentials.
- Specific instructions and input files can be found in the [quantum-espresso](quantum-espresso) directory.
- The reported Quantum Espresso benchmark results must be run on 8 CPU nodes.

### SPEChpc 2021 Small

- The Standard Performance Evaluation Corporation [SPEC](https://www.spec.org/) is a non-profit consortium that establishes, maintains and endorses standardized benchmarks and tools to evaluate performance for the newest generation of computing systems.
- One of SPEC's benchmarks, [SPEChpc 2021 Benchmark Suites](https://www.spec.org/hpc2021/), provides a set of application benchmark suites using a comprehensive measure of real-world performance for the state-of-the-art HPC systems. They offer well-selected science and engineering codes that are representative of HPC workloads and are portable across CPU and accelerators, along with certain fair comparative performance metrics.
- To download the SPEChpc 2021 Benchmark Suites please register at its website [https://www.spec.org/hpc2021/](https://www.spec.org/hpc2021/).
- Please refer to their documentation site [here](https://www.spec.org/hpc2021/docs/overview.html) and installation guide [here](https://www.spec.org/hpc2021/docs/install-guide-linux.html).
- Follow their run and reporting rules on this [link](https://www.spec.org/hpc2021/docs/runrules.html) and report back the scores for the base build along with the system description, configuration file and any other script setting the environment needed to reproduce the benchmark.
- GP2BM specific instructions can be found in the [SPEChpc2021](SPEChpc2021) directory.

## Mixed GPU and CPU benchmarks

### NAMD

- [NAMD](http://www.ks.uiuc.edu/Research/namd/) is a parallel molecular dynamics code designed for high-performance simulation of large biomolecular systems.
- NAMD is Licensed under the [University of Illinois NAMD Molecular Dynamics Software Non-Exclusive, Non-Commercial Use License](http://www.ks.uiuc.edu/Research/namd/license.html)
- NAMD version 3.0b6  source, and/or binary packages, must be obtained directly from the Theoretical and Computational Biophysics Group at UIUC [here](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD).
- The benchmark to be used is the simulation of the "Satellite Tobacco Mosaic Virus" found [here](http://www.ks.uiuc.edu/Research/namd/utilities/).
- Specific instructions and input files can be found in the [namd](namd) directory.
- Two reported NAMD benchmark results must be provided
  - run on a minimum of 4 CPU nodes.
  - run on a single GPU with cores == total cores / total GPU devices
 
    
## GPU-node benchmarks

### GROMACS

- [GROMACS](https://www.gromacs.org/) (GROningen MAchine for Chemical Simulations) is a versatile package used primarily for molecular dynamics simulations of biomolecules, such as proteins, lipids, and nucleic acids. It is designed to perform simulations of large biomolecular systems with high efficiency on CPUs, GPUs, and specialized hardware. GROMACS provides a wide range of functionalities for simulating molecular systems, including energy minimization, molecular dynamics simulations, free energy calculations, and analysis tools for studying the dynamics and properties of biomolecules at the atomic level. It is widely used in various fields such as biochemistry, biophysics, pharmaceutical research, and materials science.
- Specific instructions and input files can be found in the [gromacs](gromacs) directory.
- The reported GROMACS benchmark results must be run on one GPU node.

### MLPerf

- [MLPerf](https://mlcommons.org/) is an industry-standard benchmark suite for measuring the performance of machine learning tasks.
- It is developed by MLCommons, a consortium of AI leaders from academia, research labs, and industry.
- The benchmark measures how fast a system can train models to a target quality metric.
- Specific instructions can be found in the [mlperf](mlperf) directory.
- The reported MLPerf benchmark results must be run on a single GPU node.

## File Systems

### IOR

- The HPC IO Benchmark [IOR](https://ior.readthedocs.io/en/latest/) is a parallel IO benchmark that can be used to test the performance of parallel storage systems using various interfaces and access patterns. 
- The IOR benchmark source code can be downloaded from [github](https://github.com/hpc/ior). Use their latest [release](https://github.com/hpc/ior/releases) or at least [version 4.0.0](https://github.com/hpc/ior/releases/tag/4.0.0).
- Please refer to their documentation site [here](https://ior.readthedocs.io/en/latest/intro.html) and installation guide [here](https://ior.readthedocs.io/en/latest/userDoc/install.html).
- GP2BM specific instructions can be found in the [IOR](IOR) directory.
- The reported IOR benchmark results must be run on at least the minimum 
number of nodes and tasks necessary to saturate the storage appliance bandwidth and IOPs.

