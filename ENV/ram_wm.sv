class ram_wm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) wm_rf;
  
  virtual ram_if.WMON_MP vif;
  
  covergroup cvg;
   WRITE_ADDR : coverpoint trans_h.wr_addr { bins wr_addr     = {[0:15]};}
   WRITE_DATA : coverpoint trans_h.wr_data { bins wr_data[10] = {[0:`DATA_WIDTH**2]};}
   WRITE_ENB  : coverpoint trans_h.wr_enb  { bins wr_enb      = (0=>1);}
  endgroup
   
  function new (mailbox #(ram_trans) wm_rf, 
               virtual ram_if.WMON_MP vif);
	this.wm_rf = wm_rf;
	this.vif   = vif;
	cvg 	   = new();
 endfunction
 
 task start();
  forever begin
   monitor();
   // reset_monitor();
   wm_rf.put(trans_h);
   cvg.sample();
   delay();
   // display();
  end
 endtask
 
 
 task monitor();
   begin
   trans_h 		   = new();
   trans_h.rst     = vif.wmon_cb.rst;
   trans_h.wr_enb  = vif.wmon_cb.wr_enb;
   trans_h.wr_addr = vif.wmon_cb.wr_addr;
   trans_h.wr_data = vif.wmon_cb.wr_data;
   end
 endtask
 
 task display();
	if(!trans_h.wr_enb)
	$display("%t write enable not active : wr_enb = %b", $time, trans_h.wr_enb);
  endtask
 
 task delay();
	@(vif.wmon_cb);
 endtask
 
 task reset_monitor();
	if(trans_h.rst)
	$display("WRITE MONITOR::RESET is ON!!!	wr_addr = %d ; wr_data = %d", trans_h.wr_addr, trans_h.wr_data);
 endtask
 
endclass