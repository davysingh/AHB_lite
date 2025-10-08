class ahb_driver extends uvm_driver #(ahb_transaction);
  `uvm_component_utils(ahb_driver)

   virtual ahb_if vif;

   function new (string name="ahb_driver", uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual ahb_if)::get(this,"","vif",vif))
        `uvm_fatal("NVIF", "driver interface not found")
    endfunction

    task run_phase(uvm_phase phase);
       ahb_transaction req;

    // Wait until reset is deasserted
    wait (vif.HRESETn == 1);

       forever begin
          seq_item_port.get_next_item(req);
          req.print();
          if(vif.HRESETn) begin
            vif.HADDR<=req.HADDR;
            vif.HWDATA<=req.HWDATA;
            vif.HSEL<=req.HSEL;
            vif.HTRANS<=req.HTRANS;
            vif.HREADY<=req.HREADY;
            vif.HWRITE<=req.HWRITE;
          end
          else begin
            vif.HADDR<='x;
            vif.HWDATA<='x;
            vif.HSEL<='x;
            vif.HTRANS<='x;
            vif.HREADY<='x;
            vif.HWRITE<='x;
          end
          @(vif.cb)
          seq_item_port.item_done();
       end
     endtask

endclass
