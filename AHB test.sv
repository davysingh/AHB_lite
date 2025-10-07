
class ahb_test extends uvm_test;

  ahb_env env;
  virtual ahb_if vif;
  `uvm_component_utils(ahb_test)

  function new(string name = "ahb_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    env = ahb_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    ahb_sequence seq;
    phase.raise_objection(this);

    seq = ahb_sequence::type_id::create("seq");
    repeat(10) seq.start(env.agent.seqr);

    phase.drop_objection(this);
  endtask

endclass
