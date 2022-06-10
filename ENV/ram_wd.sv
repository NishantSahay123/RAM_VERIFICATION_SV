class ram_wd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_wd;

 //interface
 virtual ram_if.WDR_MP vif;


 function new (mailbox #(ram_trans) gen_wd, 
               virtual ram_if.WDR_MP vif);
	this.gen_wd = gen_wd;
	this.vif = vif;
 endfunction
 
 task start();
   trans_h = new();
   reset();
   forever begin
     gen_wd.get(trans_h);
	 send_to_dut();
	 @(vif.wdr_cb);
    end
  endtask
 
 task send_to_dut();
   vif.wdr_cb.rst     <= trans_h.rst;
   vif.wdr_cb.wr_enb  <= trans_h.wr_enb;
   vif.wdr_cb.wr_addr <= trans_h.wr_addr;
   vif.wdr_cb.wr_data <= trans_h.wr_data;   
 endtask
 
 task reset();
	@(vif.wdr_cb);
	trans_h.rst = 1;	
	vif.wdr_cb.rst  <= trans_h.rst;	
	@(vif.wdr_cb);
	trans_h.rst = 0;	
	vif.wdr_cb.rst  <= trans_h.rst;	
  endtask
  
endclass