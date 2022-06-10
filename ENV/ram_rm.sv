class ram_rm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) rm_rf;
  mailbox #(ram_trans) rm_sb;
  
  virtual ram_if.RMON_MP vif;
  
  covergroup cvg;
   READ_ADDR : coverpoint trans_h.rd_addr { bins rd_addr     = {[0:15]};}
   READ_DATA : coverpoint trans_h.rd_data { bins rd_data[10] = {[0:`DATA_WIDTH**2]};}
   READ_ENB  : coverpoint trans_h.rd_enb  { bins rd_enb	     = (0=>1);}
  endgroup
  
   function new (mailbox #(ram_trans) rm_rf, 
                 mailbox #(ram_trans) rm_sb, 
                 virtual ram_if.RMON_MP vif);
	this.rm_rf = rm_rf;
	this.rm_sb = rm_sb;
	this.vif   = vif;
	cvg 	   = new();
 endfunction
 
 task start();
  forever begin
   monitor();
   // reset_monitor();
   rm_rf.put(trans_h);
   rm_sb.put(trans_h);
   cvg.sample();
   // display();
   end
 endtask
 
 
 task monitor();
   trans_h = new ();
   trans_h.rd_enb  = vif.rmon_cb.rd_enb;
   trans_h.rst     = vif.rmon_cb.rst;
   trans_h.rd_addr = vif.rmon_cb.rd_addr; 
   delay();
   trans_h.rd_data = vif.rmon_cb.rd_data;   
 endtask
 
 task display();
	if(!trans_h.rd_enb)
	$display("%t read enable not active : rd_enb = %b", $time, trans_h.rd_enb);
 endtask
 
 task delay();
	 @(vif.rmon_cb);
 endtask
  
 task reset_monitor();
	if(trans_h.rst)
	$display("READ MONITOR::RESET is ON!!! : rd_addr = %d ; rd_data = %d", trans_h.rd_addr, trans_h.rd_data );
 endtask
  
endclass