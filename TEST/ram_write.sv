class ram_write extends ram_gen;
  
  ram_trans trans_h1;  
  
  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
	super.new(gen_wd,gen_rd);
  endfunction

  virtual task start();
  
    repeat(no_of_trans) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 1; rd_enb == 0;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
	
	repeat(no_of_trans) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 0; rd_enb == 1;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
 endtask
 
endclass