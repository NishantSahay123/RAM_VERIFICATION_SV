class ram_rf;

  ram_trans trans_h1,trans_h2; 
    
   //mailbox
   mailbox #(ram_trans) wm_rf;
   mailbox #(ram_trans) rm_rf;
   mailbox #(ram_trans) rf_sb;
   
    
   function new (mailbox #(ram_trans) wm_rf,
                 mailbox #(ram_trans) rm_rf,
                 mailbox #(ram_trans) rf_sb);
	this.wm_rf = wm_rf;
	this.rm_rf = rm_rf;
	this.rf_sb = rf_sb;
  endfunction
  
  
  task start();
   forever begin
    wm_rf.get(trans_h1);
	rm_rf.get(trans_h2);
	ref_model();
	rf_sb.put(trans_h2);
	// loop();	
   end
  endtask
  
  //to load data in local memory and exp_data  
  task ref_model();   
	if(trans_h1.wr_enb) 
	trans_h2.rm_rf[trans_h1.wr_addr] = trans_h1.wr_data;
		
	if(trans_h2.rd_enb) 
	trans_h2.exp_data = trans_h2.rm_rf[trans_h2.rd_addr];
	
  endtask
  
  //loop to see all values in local memory and current value in read monitor
  task loop();
    $display("@%t REFERENCE on read:: rd_addr = %d ; rd_data = %d ; exp_data = %d\n",
			$time, trans_h2.rd_addr, trans_h2.rd_data, trans_h2.exp_data);
			
	for(shortint i = 0; i<(2**`ADDR_WIDTH); i++) 
	$display("REFERENCE RF_LOOP::rm_rf[i] = %d[%d]", trans_h2.rm_rf[i], i);
	$display("-----------------------------------------------\n");
   endtask
	  
 endclass
	