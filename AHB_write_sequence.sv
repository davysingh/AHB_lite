class ahb_write_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(ahb_write_sequence)
  // Constructor
  function new(string name = "ahb_sequence");
    super.new(name);
  endfunction


  // Body task: generates and sends transactions
  virtual task body();
    ahb_transaction req;
     
     req=ahb_transaction::type_id::create("req");
     
      start_item(req);
      if (!req.randomize() with {
          HWRITE == 1; 
          HADDR == 32'h0000_1000;
          //HADDR inside {[32'h0000_0000 : 32'h0000_FFFF]};
          HWDATA inside {[32'h0000_0000 : 32'hFFFF_FFFF]};
        }) begin
        `uvm_error("SEQ", "Randomization failed for ahb_write_transaction")
      end
      finish_item(req);
      `uvm_info(get_type_name(),
        $sformatf("WRITE: HADDR=0x%0h HWDATA=0x%0h", req.HADDR, req.HWDATA),
        UVM_LOW)
  endtask

endclass
