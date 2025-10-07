//------------------------------------------------------
// Simple AHB-Lite Slave RTL (16x32 memory)
//------------------------------------------------------
module ahb_slave (
    input  logic        HCLK,
    input  logic        HRESETn,
 
    input  logic [31:0] HADDR,
    input  logic [31:0] HWDATA,
    output logic [31:0] HRDATA,
 
    input  logic        HWRITE,
    input  logic [1:0]  HTRANS,
    input  logic        HSEL,
    input  logic        HREADY,
    output logic        HREADYOUT,
    output logic [1:0]  HRESP
);
 
  //------------------------------------------------------
  // Internal signals
  //------------------------------------------------------
  logic [31:0] mem [0:15];      // 16 x 32-bit memory
  logic [31:0] addr_reg;
  logic        write_en;
  logic        read_en;
 
  //------------------------------------------------------
  // Default outputs
  //------------------------------------------------------
  assign HRESP      = 2'b00;     // OKAY response
  assign HREADYOUT  = 1'b1;      // Always ready (no wait states)
 
  //------------------------------------------------------
  // Address phase latch
  //------------------------------------------------------
  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn)
      addr_reg <= 32'd0;
    else if (HREADY && HSEL && (HTRANS[1]))  // NONSEQ or SEQ
      addr_reg <= HADDR;
  end
 
  //------------------------------------------------------
  // Write enable logic
  //------------------------------------------------------
  always_comb begin
    write_en = HSEL && HREADY && HWRITE && HTRANS[1];
    read_en  = HSEL && HREADY && !HWRITE && HTRANS[1];
  end
 
  //------------------------------------------------------
  // Write operation
  //------------------------------------------------------
  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
      for (int i = 0; i < 16; i++)
        mem[i] <= 32'h0;
    end else if (write_en) begin
      mem[addr_reg[5:2]] <= HWDATA;   // Word aligned write
    end
  end
 
  //------------------------------------------------------
  // Read operation
  //------------------------------------------------------
  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn)
      HRDATA <= 32'd0;
    else if (read_en)
      HRDATA <= mem[addr_reg[5:2]];
  end
 
endmodule