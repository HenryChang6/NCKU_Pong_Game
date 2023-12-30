module ascii_dot_matrix_controller (
    input clk,               // Clock input
    input [6:0] ascii_code,  // 7-bit ASCII code
    output reg [7:0] row,    // Row data for the dot matrix
    output reg [7:0] col     // Column data for the dot matrix
);

// ROM instance
wire [7:0] rom_data;
ascii_rom ascii_rom_instance (
    .clk(clk),
    .addr({ascii_code, current_row}),
    .data(rom_data)
);

reg [2:0] current_row = 0;  // To cycle through the rows

// Update the display based on the ASCII code and current row
always @(posedge clk) begin
    // Cycle through the rows of the dot matrix
    current_row <= current_row + 1;
    if (current_row == 7) current_row <= 0;

    // Set the row and column data based on the ROM output
    row <= 1'b1 << current_row;  // Activate the current row
    col <= rom_data;             // Set the column pattern for the current row
end

endmodule
