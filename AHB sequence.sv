import uvm_pkg::*;
`include "uvm_macros.svh"


class ahb_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(ahb_sequence)
  // Constructor
  function new(string name = "ahb_sequence");
    super.new(name);
  endfunction


  // Body task: generates and sends transactions
  virtual task body();
    ahb_transaction req;
     
     req=ahb_transaction::type_id::create("req");
     
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQ", "Randomization failed for ahb_transaction")
      end
      finish_item(req);
/*
      // Populate AHB fields
      //req.HCLK    = 1;
      //req.HRESETn = 1;
      req.HADDR.randomize();
     // req.HADDR   = 32'h0000_1000;
      req.HWDATA  = 32'hDEADBEEF;
      req.HWRITE  = 1;
      req.HTRANS  = 2'b10; // NONSEQ
      req.HSEL    = 1;
      req.HREADY  = 1;

    // Send transaction
    start_item(req);
    finish_item(req);*/
  endtask

endclass
