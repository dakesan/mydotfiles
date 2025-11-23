#!/usr/bin/env python3
"""
Analyze Excel data and generate Markdown summary tables.

Usage:
    python3 analyze_excel_data.py <excel_file> <sheet_name> [--output <output_file>]

Arguments:
    excel_file: Path to Excel file
    sheet_name: Name of sheet to analyze
    --output: Optional output file path (default: stdout)

Example:
    python3 analyze_excel_data.py data.xlsx "Results" --output summary.md

Dependencies:
    - pandas (pip install pandas openpyxl)
    - tabulate (pip install tabulate)
"""

import sys
import argparse
import pandas as pd
from pathlib import Path


def analyze_qpcr_data(df, sample_col='Sample Name', ct_col='CT', tm_col='Tm (°C)',
                      target_col='Target Name', ct_mean_col='Ct Mean', ct_sd_col='Ct SD'):
    """
    Analyze qPCR data and generate summary table.

    Expects columns:
    - Sample Name: Sample identifier
    - CT: Ct value (may contain 'Undetermined')
    - Ct Mean, Ct SD: Statistics
    - Tm (°C): Melting temperature
    - Target Name: Target identifier
    """
    # Exclude negative controls
    df = df[~df[sample_col].str.contains('DW|NTC|Blank', case=False, na=False)]

    # Convert CT to numeric
    df['CT_numeric'] = pd.to_numeric(df[ct_col], errors='coerce')

    # Group by sample and create summary
    summary_data = []
    for sample_name, group in df.groupby(sample_col):
        ct = group['CT_numeric'].iloc[0] if len(group) > 0 else None
        ct_mean = group[ct_mean_col].iloc[0] if ct_mean_col in group.columns else '-'
        ct_sd = group[ct_sd_col].iloc[0] if ct_sd_col in group.columns else '-'
        target_name = group[target_col].iloc[0] if target_col in group.columns else '-'

        # Get Tm values
        tm_values = sorted(group[tm_col].dropna().tolist())
        tm_count = len(tm_values)

        # Format Tm values for display (show first 3)
        tm_display = ', '.join([f"{v:.1f}" for v in tm_values[:3]])
        if tm_count > 3:
            tm_display += '...'

        # Amplification status
        amplification = '✅' if pd.notna(ct) else '❌'

        # Non-specific amplification evaluation
        if pd.isna(ct):
            nonspec = '評価不能'
        elif tm_count == 1:
            nonspec = '✅ なし'
        elif tm_count == 2:
            nonspec = '⚠️ 軽度'
        elif tm_count <= 5:
            nonspec = '❌ あり'
        else:
            nonspec = '❌❌ 深刻'

        # Handle 'Undetermined'
        if ct_mean == '---' or ct_mean == 'Undetermined':
            ct_mean = 'Undetermined'
        if ct_sd == '---':
            ct_sd = '-'

        summary_data.append({
            'Sample': sample_name,
            'Target': target_name,
            'Ct Mean': ct_mean,
            'Ct SD': ct_sd,
            'Amplification': amplification,
            'Tm Peaks': tm_count,
            'Tm Values (°C)': tm_display,
            'Non-specific': nonspec
        })

    return pd.DataFrame(summary_data)


def analyze_generic_data(df, max_rows=20):
    """
    Generate generic summary for any Excel data.
    Shows basic statistics and first few rows.
    """
    summary = []
    summary.append("## Data Summary\n")
    summary.append(f"**Total rows:** {len(df)}")
    summary.append(f"**Total columns:** {len(df.columns)}\n")

    summary.append("**Columns:**")
    for col in df.columns:
        summary.append(f"- {col} ({df[col].dtype})")

    summary.append(f"\n**First {min(max_rows, len(df))} rows:**\n")
    summary.append(df.head(max_rows).to_markdown(index=False))

    return '\n'.join(summary)


def main():
    parser = argparse.ArgumentParser(description='Analyze Excel data and generate Markdown tables')
    parser.add_argument('excel_file', help='Path to Excel file')
    parser.add_argument('sheet_name', help='Sheet name to analyze')
    parser.add_argument('--output', '-o', help='Output file path (default: stdout)')
    parser.add_argument('--analysis-type', '-t',
                       choices=['qpcr', 'generic'],
                       default='generic',
                       help='Type of analysis to perform')
    parser.add_argument('--max-rows', '-n', type=int, default=20,
                       help='Maximum rows to display in generic analysis')

    args = parser.parse_args()

    # Validate input
    if not Path(args.excel_file).exists():
        print(f"Error: File not found: {args.excel_file}")
        sys.exit(1)

    # Read Excel file
    try:
        df = pd.read_excel(args.excel_file, sheet_name=args.sheet_name)
    except Exception as e:
        print(f"Error reading Excel file: {e}")
        sys.exit(1)

    # Analyze data based on type
    if args.analysis_type == 'qpcr':
        try:
            summary_df = analyze_qpcr_data(df)
            output = summary_df.to_markdown(index=False)
        except Exception as e:
            print(f"Error analyzing qPCR data: {e}")
            print("Falling back to generic analysis...")
            output = analyze_generic_data(df, args.max_rows)
    else:
        output = analyze_generic_data(df, args.max_rows)

    # Write output
    if args.output:
        with open(args.output, 'w') as f:
            f.write(output)
        print(f"✅ Summary saved to {args.output}")
    else:
        print(output)


if __name__ == "__main__":
    main()
