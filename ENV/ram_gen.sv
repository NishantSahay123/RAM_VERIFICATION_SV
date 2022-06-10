class ram_gen;

  ram_trans trans_h;
  
  //mailbox
  mailbox #(ram_trans) gen_wd;
  mailbox #(ram_trans) gen_rd;
  
  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
	this.gen_wd = gen_wd;
	this.gen_rd = gen_rd;
  endfunction
  
  
  virtual task start();
    repeat(no_of_trans) begin
	   trans_h = new();
	   assert(trans_h.randomize());
	   gen_wd.put(trans_h);
	   gen_rd.put(trans_h);
	end
 endtask
	   
endclass

