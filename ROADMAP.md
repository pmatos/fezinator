# Fezinator Development Roadmap

## Project Vision

Complete the FEX vs QEMU comparison workflow to identify bugs and missing features in FEX-Emu through systematic assembly code analysis and simulation comparison.

## Target Workflow

1. **Extract code from binary and store in database** ✅ **COMPLETE**
2. **Analyze code for live-in registers and memory locations** ✅ **COMPLETE**  
3. **Simulate with QEMU and capture results** ⚠️ **PARTIALLY IMPLEMENTED**
4. **Simulate with FEX and capture results** ⚠️ **PARTIALLY IMPLEMENTED**
5. **Compare simulation results to identify FEX bugs/gaps** ❌ **NOT IMPLEMENTED**

## Current Implementation Status

### ✅ **Fully Implemented Components**

#### Binary Extraction & Storage (Step 1)
- ELF/PE binary parsing with architecture detection
- Random and targeted assembly block extraction using Capstone
- SQLite database with comprehensive schema and deduplication
- SHA256-based binary fingerprinting
- **Files:** `src/extractor/`, `src/db/`, `src/cli/extract.rs`

#### Static Analysis Engine (Step 2)  
- Live-in/live-out register analysis across x86/x86_64 register hierarchies
- Control flow analysis (jumps, calls, returns, exit points)
- Memory access pattern detection (stack vs heap classification)
- Analysis results stored with JSON serialization
- **Files:** `src/analyzer/`, `src/cli/analyze.rs`

### ⚠️ **Partially Implemented Components**

#### Simulation Infrastructure (Steps 3 & 4)
**What's Working:**
- QEMU (`qemu-x86_64`, `qemu-i386`) and FEX (`FEXInterpreter`) emulator integration
- Random initial state generation for live-in registers and memory
- Assembly generation with preamble/epilogue for state capture
- NASM compilation pipeline with GCC linking
- Binary execution with timeout handling
- Final state parsing from execution output
- Individual simulation result storage in database

**What's Missing:**
- Limited memory location analysis (only stack values captured)
- No batch simulation workflow
- Manual process for running both emulators
- **Files:** `src/simulator/`, `src/cli/simulate.rs`

### ❌ **Missing Components**

#### Simulation Comparison & Analysis (Step 5)
- No comparison infrastructure for QEMU vs FEX results
- No detection of register/memory/flag differences
- No automated bug/feature gap identification
- No difference classification or reporting
- No batch comparison workflow

## Implementation Plan

### **Phase 1: Comparison Engine Infrastructure**

#### 1.1 Create Comparison Module
- **File:** `src/comparator/mod.rs`
- **Components:**
  - `SimulationComparator` struct for result comparison
  - Register difference detection with configurable tolerance
  - Memory difference analysis with address-specific comparison
  - Flag/status register comparison
  - Difference classification (bug vs missing feature vs acceptable variance)

#### 1.2 Extend Database Schema
- **File:** `src/db/mod.rs`
- **New Table:** `comparisons`
  ```sql
  CREATE TABLE comparisons (
      id INTEGER PRIMARY KEY,
      simulation_id_1 INTEGER NOT NULL,
      simulation_id_2 INTEGER NOT NULL,
      emulator_1 TEXT NOT NULL,
      emulator_2 TEXT NOT NULL,
      
      -- Difference summary
      has_register_diff BOOLEAN NOT NULL,
      has_memory_diff BOOLEAN NOT NULL, 
      has_flags_diff BOOLEAN NOT NULL,
      
      -- Detailed differences (JSON)
      register_differences TEXT,
      memory_differences TEXT,
      flags_differences TEXT,
      
      -- Classification
      difference_severity TEXT CHECK (difference_severity IN ('none', 'minor', 'major', 'critical')),
      difference_category TEXT CHECK (difference_category IN ('bug', 'unimplemented', 'variance', 'unknown')),
      
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (simulation_id_1) REFERENCES simulations(id),
      FOREIGN KEY (simulation_id_2) REFERENCES simulations(id)
  );
  ```
- **Indices:** Add performance indices for frequent queries

#### 1.3 Comparison Data Structures
- **File:** `src/comparator/types.rs`
- **Structures:**
  ```rust
  pub struct ComparisonResult {
      pub register_differences: Vec<RegisterDifference>,
      pub memory_differences: Vec<MemoryDifference>, 
      pub flags_differences: Option<FlagsDifference>,
      pub severity: DifferenceSeverity,
      pub category: DifferenceCategory,
  }
  
  pub struct RegisterDifference {
      pub register: String,
      pub qemu_value: u64,
      pub fex_value: u64,
      pub difference: i64,
  }
  
  pub struct MemoryDifference {
      pub address: u64,
      pub qemu_data: Vec<u8>,
      pub fex_data: Vec<u8>,
  }
  ```

### **Phase 2: Enhanced CLI Commands**

#### 2.1 Add Compare Subcommand  
- **File:** `src/cli/compare.rs`
- **Commands:**
  - `fezinator compare <block_number>` - Run QEMU + FEX simulation, then compare
  - `fezinator compare-existing <sim_id_1> <sim_id_2>` - Compare existing simulation results
- **Flags:**
  - `--detailed` - Verbose difference reporting
  - `--tolerance <value>` - Set acceptable numeric difference tolerance
  - `--ignore-flags` - Skip flags comparison (for noisy flag differences)

#### 2.2 Enhance Simulate Command
- **File:** `src/cli/simulate.rs` 
- **New Flags:**
  - `--all-emulators` - Run on both QEMU and FEX automatically
  - `--compare` - Automatically compare results after dual simulation
  - `--runs-per-emulator <n>` - Multiple runs per emulator for variance analysis

#### 2.3 Update Main CLI
- **File:** `src/main.rs`
- Add `Compare(CompareCommand)` to `Commands` enum
- Wire up command execution

### **Phase 3: Enhanced Analysis & Memory Handling**

#### 3.1 Improved Memory Location Detection
- **File:** `src/analyzer/mod.rs`
- **Enhancements:**
  - Track specific memory addresses accessed (not just patterns)
  - Analyze addressing modes to identify base addresses needing initialization
  - Detect memory dependencies between instructions
  - Better classification of stack vs heap vs global memory accesses

#### 3.2 Enhanced Simulation State Capture
- **File:** `src/simulator/assembly_generator.rs`
- **Improvements:**
  - Generate epilogue based on actual memory locations from analysis
  - Capture memory at addresses identified during analysis phase
  - Better handling of dynamic memory accesses during execution
  - More comprehensive register state capture (including segment registers)

#### 3.3 Better Random State Generation
- **File:** `src/simulator/random_generator.rs`  
- **Enhancements:**
  - Memory initialization based on analysis results
  - Configurable random strategies (uniform, realistic ranges, edge values)
  - Seed management for reproducible comparisons

### **Phase 4: Reporting & Workflow Automation**

#### 4.1 Add Report Subcommand
- **File:** `src/cli/report.rs`
- **Commands:**
  - `fezinator report differences` - Summary of all found differences
  - `fezinator report patterns` - Common difference patterns across blocks  
  - `fezinator report statistics` - Comparison success rates, common failure modes
- **Export Options:**
  - `--format json|csv|markdown` - Different output formats
  - `--output <file>` - Save to file instead of stdout

#### 4.2 Batch Processing Capabilities
- **File:** `src/cli/batch.rs`
- **Commands:**
  - `fezinator batch-compare` - Run comparison workflow on all analyzed blocks
  - `fezinator batch-simulate` - Simulate all blocks on specified emulators
- **Features:**
  - Progress tracking with progress bars
  - Parallel execution support with configurable concurrency
  - Resume capability for interrupted batch jobs
  - Filtering by architecture, binary type, block size, etc.

#### 4.3 Enhanced Database Queries
- **File:** `src/db/mod.rs`
- **New Methods:**
  - `list_comparisons_by_severity()` - Find critical differences first
  - `get_comparison_statistics()` - Overall success/failure rates
  - `find_similar_differences()` - Pattern matching across comparisons
  - `get_emulator_compatibility_report()` - Per-emulator success rates

### **Phase 5: Testing & Validation**

#### 5.1 Comparison Engine Tests
- **File:** `tests/comparison_test.rs`
- **Test Cases:**
  - Register difference detection with various tolerances
  - Memory difference detection for different data sizes
  - Flag comparison accuracy
  - Edge cases (identical results, maximum differences)

#### 5.2 Integration Tests
- **File:** `tests/workflow_test.rs`
- **Test Scenarios:**
  - Complete extract → analyze → simulate → compare workflow
  - Batch processing with multiple blocks
  - Error handling for emulator unavailability
  - Database integrity after complex operations

#### 5.3 Performance Tests
- **File:** `tests/performance_test.rs`
- **Benchmarks:**
  - Comparison speed for large simulation results
  - Batch processing throughput
  - Database query performance with large datasets

## Success Criteria

### **Functional Requirements**
1. ✅ **Extract and store assembly blocks from binaries**
2. ✅ **Analyze blocks for live registers and memory accesses**  
3. ✅ **Simulate blocks on QEMU with state capture**
4. ✅ **Simulate blocks on FEX with state capture**
5. ❌ **Compare QEMU vs FEX results with detailed difference analysis**
6. ❌ **Classify differences as bugs vs missing features vs acceptable variance**
7. ❌ **Generate reports for FEX development team**
8. ❌ **Support batch processing for systematic FEX validation**

### **Performance Requirements**  
- Comparison of simulation results should complete in <100ms
- Batch processing should handle 1000+ blocks with progress tracking
- Database queries should remain responsive with 10k+ comparison results

### **Quality Requirements**
- All new code covered by unit tests (>90% coverage)
- Integration tests for complete workflows
- Error handling for all emulator failure modes
- Comprehensive input validation and sanitization

## Technical Dependencies

### **Required Tools**
- QEMU (`qemu-x86_64`, `qemu-i386`) - ✅ Already integrated
- FEX-Emu (`FEXInterpreter`) - ✅ Already integrated  
- NASM assembler - ✅ Already required
- GCC compiler - ✅ Already required

### **Rust Dependencies**
- `serde` - ✅ Already used for JSON serialization
- `rusqlite` - ✅ Already used for database operations
- `capstone` - ✅ Already used for disassembly
- Additional: Consider `rayon` for parallel batch processing

## File Structure After Implementation

```
src/
├── analyzer/           # ✅ Static analysis (complete)
├── cli/                # ⚠️ Partial (missing compare, report, batch commands)
│   ├── analyze.rs      # ✅ Complete
│   ├── extract.rs      # ✅ Complete  
│   ├── list.rs         # ✅ Complete
│   ├── remove.rs       # ✅ Complete
│   ├── simulate.rs     # ⚠️ Needs enhancement
│   ├── compare.rs      # ❌ New (Phase 2)
│   ├── report.rs       # ❌ New (Phase 4)
│   └── batch.rs        # ❌ New (Phase 4)
├── comparator/         # ❌ New module (Phase 1)
│   ├── mod.rs          # Core comparison engine
│   └── types.rs        # Comparison data structures
├── db/                 # ⚠️ Needs schema extension
├── extractor/          # ✅ Complete
├── simulator/          # ⚠️ Needs enhancement
└── error.rs            # ⚠️ May need new error types
```

## Implementation Timeline

### **Phase 1 (Core Infrastructure): 2-3 weeks**
- Comparison engine and database schema
- Essential for all other phases

### **Phase 2 (CLI Enhancement): 1-2 weeks**  
- New commands and enhanced existing commands
- Depends on Phase 1 completion

### **Phase 3 (Analysis Enhancement): 1-2 weeks**
- Can run in parallel with Phase 2
- Improves simulation accuracy

### **Phase 4 (Reporting & Automation): 1-2 weeks**
- Depends on Phases 1-2 completion
- Provides complete workflow automation

### **Phase 5 (Testing & Polish): 1 week**
- Comprehensive testing and documentation
- Final validation of complete workflow

**Total Estimated Timeline: 6-10 weeks**

## Next Steps

1. **Start with Phase 1.1** - Create the basic comparison module structure
2. **Implement database schema changes** - Extend existing database with comparison tables
3. **Build comparison algorithms** - Register, memory, and flags difference detection
4. **Add basic compare CLI command** - Enable manual comparison testing
5. **Iteratively enhance** - Add automation, reporting, and batch processing

This roadmap provides a systematic path to achieve the complete FEX validation workflow through Fezinator.