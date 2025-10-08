class ahb_test extends uvm_test;

  ahb_env env;
  virtual ahb_if vif;
  `uvm_component_utils(ahb_test)

  function new(string name = "ahb_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual ahb_if)::get(this, "", "vif", vif)) begin
     `uvm_fatal("NOVIF", "Virtual interface not found")
    end
    env = ahb_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    ahb_write_sequence wr_seq;
    ahb_read_sequence rd_seq;
    phase.raise_objection(this);
  fork
    begin
    wr_seq = ahb_write_sequence::type_id::create("wr_seq");
    rd_seq = ahb_read_sequence::type_id::create("rd_seq");
      repeat(50) begin 
        wr_seq.start(env.agent.seqr);
        rd_seq.start(env.agent.seqr);
      end
    end
    begin
      automatic int delay;
      repeat(1) begin
        #20; 
        vif.HRESETn<=1;
        delay = $urandom_range(100,200);
        #(delay);
        vif.HRESETn<=0;
        #20;
        vif.HRESETn<=1;
        end
     end
  join
    phase.drop_objection(this);
  endtask

endclass
