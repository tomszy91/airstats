# AirStats dbt Capstone Project

A dbt project that transforms raw global aviation data (airports, runways, member comments) from [OurAirports](https://ourairports.com/) into clean, tested and documented models on BigQuery, built with the dbt Fusion engine (dbt 2.0).

Created as a capstone assignment for the Udemy course **"The Complete dbt Bootcamp: Zero to Hero + Certification Prep"**.

---

## 1. Project Overview & Scope

The main goal is to turn raw aviation data into structured, tested models, with historical tracking for the key entities.

### Scope & Constraints

- **Declared sources**: 7 raw tables are registered in `models/__sources.yml`: `airports`, `airport_comments`, `runways`, `airport_frequencies`, `countries`, `navaids`, `regions`.
- **Used sources**: only 3 of them feed the pipeline: `airports`, `airport_comments` and `runways`.
- **Active entities**: transformations are implemented for `airports`, `airport_comments` and `runways`.
- **Declared but unused tables**: `airport_frequencies`, `countries`, `navaids` and `regions` are kept in the source definitions. Their bronze templates exist in `models/bronze/` with the prefix **`z_`** and are disabled via `config(enabled=false)`. They are not part of the DAG, the build or the test runs. They stay in place so they can be enabled later without rewriting the source definitions.

---

## 2. Data Architecture (Medallion Architecture)

The project follows a Bronze / Silver layout with SCD Type 2 snapshots for historical tracking.

![Airstats schema](https://raw.githubusercontent.com/tomszy91/airstats/main/assets/airstats_schema.png)

- **Raw Data / Sources** (`models/__sources.yml`): raw OurAirports tables loaded into BigQuery.
- **Bronze Layer** (`models/bronze/`): one staging model per used source (`src_airports`, `src_airport_comments`, `src_runways`). They cast types and standardise column names. Materialised as `ephemeral`, so they do not create objects in BigQuery. Disabled templates for unused tables are prefixed `z_`.
- **Silver Layer** (`models/silver/`): business-ready models (`silver_airports`, `silver_runways` as tables, `silver_airport_comments` as an incremental model merged on `comment_id`). Empty or null values are replaced with `__UNKNOWN__` where needed.
- **Snapshots** (`snapshots/`): SCD Type 2 history for `scd_silver_airports` and `scd_silver_runways`, stored in the `scd` schema, with hard deletes invalidated.
- **Audit**: every model writes a row to an `audit_log` table through a post-hook, and the table is created on run start.

---

## 3. Data Quality & Testing

Data integrity and transformation logic are checked with automated tests:

- **Schema Tests**: defined in `models/bronze/_src_schema.yml` and `models/silver/_silver_schema.yml`: `unique`, `not_null`, `relationships` (links between runways, comments and airports), `accepted_values`, and `dbt_expectations` range and regex checks.
- **Unit Tests**: `tests/unit_test_silver_airport_comments.yml` and `tests/unit_test_silver_runways.yml` verify the transformation logic against mock input rows before the models are built.
- **Stored Failures**: failing test rows are stored in BigQuery in the `test_audit` schema.

---

## 4. Custom Macros & Utilities

The project includes custom Jinja macros in `macros/`:

- `generate_schema_name.sql`: resolves target schemas. In `prod` the custom schema name is used as is. In every other target it is prefixed with the target schema (`<target_schema>_<custom_schema>`), so developers do not overwrite each other's objects.
- `drop_dev_schemas.sql`: drops developer schemas whose names start with the target prefix. It refuses to run unless the target schema starts with `dbt`, so it cannot drop production schemas.
- `list_columns_with_cast.sql`: helper that prints a `select` with explicit casts for every column of a source table, used as a starting point for bronze models.

---

## 5. Repository Structure

```text
airstats/
├── analyses/                  # Ad-hoc SQL checks, model generators and task notes
│   ├── check_airports_table.sql
│   ├── count_airport_types.sql
│   ├── generate_model_yml.sql
│   └── tasks.md
├── assets/                    # Schema diagram (.png, .dbml)
├── macros/                    # Reusable Jinja macros
├── models/
│   ├── bronze/                # Staging layer (src_*), disabled templates (z_src_*)
│   ├── silver/                # Business-ready layer (silver_*)
│   ├── __sources.yml          # All declared raw sources
│   ├── docs.md                # Doc blocks (e.g. airport_type)
│   └── overview.md            # Landing page of the documentation
├── snapshots/                 # SCD Type 2 snapshots
├── tests/                     # Unit tests
├── dbt_project.yml            # Main dbt project configuration
└── packages.yml               # dbt package dependencies
```

---

## 6. How to Run the Project

### Prerequisites

- dbt 2.0 with the dbt Fusion engine
- A BigQuery project and a profile named `airstats` in `~/.dbt/profiles.yml`
- Google Cloud credentials configured for the BigQuery adapter

### Execution Steps

1. **Clone the repository**:

```bash
git clone https://github.com/tomszy91/airstats.git
cd airstats
```

2. **Install dbt dependencies** (`dbt_utils`, `codegen`, `dbt_expectations`):

```bash
dbt deps
```

3. **Run models**:

```bash
# Run all active models (Bronze & Silver)
dbt run

# Run specific layers
dbt run --select bronze
dbt run --select silver
```

4. **Execute tests and unit tests**:

```bash
dbt test
```

5. **Create snapshots (SCD Type 2)**:

```bash
dbt snapshot
```

6. **Generate documentation** (with column-level lineage):

```bash
dbt build --generate-info-schema --static-analysis strict
dbt docs generate --no-compile
dbt docs serve
```

`dbt docs serve` is for local preview only.

---

## Author

tomszy91
