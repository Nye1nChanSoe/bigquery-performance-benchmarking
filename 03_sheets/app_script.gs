function generateData() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();

  // Get all sheets in the spreadsheet
  const sheets = ss.getSheets();

  // Remove every sheet except the first one
  // This keeps the spreadsheet clean before generating new data
  sheets.forEach((s, i) => {
    if (i > 0) ss.deleteSheet(s);
  });

  // Use the first remaining sheet and rename it to "data"
  const sheet = sheets[0];
  sheet.setName("data");

  // Clear existing content from the sheet
  sheet.clearContents();

  // Google Sheets creates 26 columns by default (A-Z)
  // This app only needs 2 columns:
  // A = group_id
  // B = random_value
  // So remove all extra columns
  sheet.deleteColumns(3, sheet.getMaxColumns() - 2);

  // Ensure the sheet has enough rows:
  // 1 header row + 1,000,000 data rows
  // Total required rows = 1,000,001
  if (sheet.getMaxRows() < 1000001) {
    sheet.insertRowsAfter(sheet.getMaxRows(), 1000001 - sheet.getMaxRows());
  }

  // Write column headers
  sheet.getRange(1, 1, 1, 2).setValues([["group_id", "random_value"]]);

  // Total number of rows to generate
  const TOTAL = 1000000;

  // Number of rows written per batch
  // Writing in batches is much faster than row-by-row
  const BATCH = 10000;

  // Generate and write data in chunks
  for (let start = 0; start < TOTAL; start += BATCH) {
    const rows = [];

    // Create one batch of random data
    for (let i = 0; i < BATCH; i++) {
      // group_id:
      // Random integer between 0 and 999
      //
      // random_value:
      // Random decimal between 0 and 1
      rows.push([Math.floor(Math.random() * 1000), Math.random()]);
    }

    // Write the batch into the sheet
    // +2 because:
    // Row 1 = header
    // Data starts at row 2
    sheet.getRange(start + 2, 1, rows.length, 2).setValues(rows);

    // Log progress every 100,000 rows
    // Useful for tracking long-running execution
    if (start % 100000 === 0) {
      console.log(
        `Written ${start.toLocaleString()} / ${TOTAL.toLocaleString()} rows`,
      );
    }
  }

  // Show completion popup
  SpreadsheetApp.getUi().alert("Done! 1,000,000 rows written.");
}
