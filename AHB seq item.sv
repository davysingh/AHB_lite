import uvm_pkg::*;
`include "uvm_macros.svh"

class ahb_transaction extends uvm_sequence_item;
  //`uvm_object_utils(ahb_transaction)
  // Declare transaction fields
    rand bit [31:0] HADDR;
    rand bit [31:0] HWDATA;
 
    rand bit        HWRITE;
    rand bit [1:0]  HTRANS;
    rand bit        HSEL;
    rand bit        HREADY;

    function new (string name = "ahb_transaction");
       super.new(name);
    endfunction
   
  // Constraints
  constraint addr_align_c {
    HADDR[1:0] == 2'b00; // Word-aligned addresses
  }

  constraint addr_range_c {
    HADDR inside {[32'h0000_0000 : 32'h0000_00FC]}; // 16 words (64 bytes)
  }

  constraint data_range_c {
    HWDATA inside {[32'h0000_0000 : 32'hFFFF_FFFF]};
  }

  constraint htrans_valid_c {
    HTRANS inside {2'b10, 2'b11}; // NONSEQ or SEQ
  }

  constraint hsel_c {
    HSEL == 1;
  }

  constraint hready_c {
    HREADY == 1;
  }

    `uvm_object_utils_begin(ahb_transaction)
        `uvm_field_int(HADDR,    UVM_ALL_ON)
        `uvm_field_int(HWDATA,   UVM_ALL_ON)
        `uvm_field_int(HWRITE,   UVM_ALL_ON)
        `uvm_field_int(HTRANS,   UVM_ALL_ON)
        `uvm_field_int(HSEL,     UVM_ALL_ON)
        `uvm_field_int(HREADY,   UVM_ALL_ON)
    `uvm_object_utils_end

endclass
