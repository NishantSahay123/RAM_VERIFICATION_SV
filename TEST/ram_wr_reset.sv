class ram_wr_reset extends ram_gen;
  
  ram_trans trans_h1;  
  
  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
	super.new(gen_wd,gen_rd);
  endfunction

  virtual task start();
	
	//write for half the number of transitions
    repeat(no_of_trans/2) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 1; rd_enb == 0;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
	
	//reset in the middle
	repeat(10)
	reset_start();	
	reset_end();
	
	//write again for sencond half of the transitions
	repeat(no_of_trans/2) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 1; rd_enb == 0;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
	
	//read for half the number of transitions
	repeat(no_of_trans/4) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 0; rd_enb == 1;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
	
	//reset in the middle
	repeat(10)
	reset_start();	
	reset_end();
	
	//read for second half of the transitions
	repeat(no_of_trans/4) begin
	   trans_h1 = new();
	   assert(trans_h1.randomize() with {wr_enb == 0; rd_enb == 1;});
	   gen_wd.put(trans_h1);	   
	   gen_rd.put(trans_h1);
	end
	
 endtask
 
 task reset_start();
    trans_h1 = new();
	assert(trans_h1.randomize() with {wr_enb == 1; rd_enb == 1;});
    trans_h1.rst = 1;
	gen_wd.put(trans_h1);	   
	gen_rd.put(trans_h1);
 endtask

task reset_end();
	trans_h1 = new();
    trans_h1.rst = 0;
	gen_wd.put(trans_h1);	   
	gen_rd.put(trans_h1);
 endtask
	
endclass