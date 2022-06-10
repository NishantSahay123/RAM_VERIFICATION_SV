class ram_sb;
  ram_trans trans_h, trans_h2;
    
  //mailbox
   mailbox #(ram_trans) rf_sb;
   mailbox #(ram_trans) rm_sb;
   
   covergroup cvg;
   READ_ADDR : coverpoint trans_h.rd_addr { bins rd_addr     = {[0:15]};}
   READ_DATA : coverpoint trans_h.rd_data { bins rd_data[10] = {[0:`DATA_WIDTH**2]};}
   READ_ENB  : coverpoint trans_h.rd_enb  { bins rd_enb 	 = (0=>1);}
   endgroup
   
   function new (mailbox #(ram_trans) rf_sb,
                 mailbox #(ram_trans) rm_sb);
	this.rf_sb  = rf_sb;
	this.rm_sb  = rm_sb;
	cvg         = new();
   endfunction
   
   task start();
    forever begin
	  rf_sb.get(trans_h);
	  rm_sb.get(trans_h2);
	  check_data();
	  cvg.sample();
	  end
   endtask
   
   //match the data in reference model in DUT
   task check_data();
	if(trans_h2.rd_data !== 0 && trans_h2.rd_enb == 1 && trans_h2.rst == 0) begin
		if(trans_h2.rd_data == trans_h.exp_data)
			$display("SUCCESS ! rd_addr = %d :------RD_data = %d : %d = exp_data------",
					trans_h2.rd_addr, trans_h2.rd_data, trans_h.exp_data);
		else begin
			$display("@%t DATA MISMATCH ! rd_addr = %d :------RD_data = %d : %d = exp_data------",
					$time, trans_h2.rd_addr, trans_h2.rd_data, trans_h.exp_data);
		end
	end	
	
	else if (trans_h2.rst == 1)
	$display("DUT in RESET STATE!!!");
	
   endtask
   
    
   //loop to see all values in local memory and current value in read monitor
   task loop();
   if(trans_h2.rd_data !== 0) 
        begin
		$display("\n-----------------------------------------------");
		$display("CONTENTS OF LOCAL MEMORY AT THE END OF SIMULATION\n");
		for(shortint i = 0; i<(2**`ADDR_WIDTH); i++) 
		$display("SCOREBOARD RF_LOOP::rm_rf[i] = %d[%d]", trans_h.rm_rf[i], i);
		$display("-------------------------------------------------");
		end
    endtask
	
endclass