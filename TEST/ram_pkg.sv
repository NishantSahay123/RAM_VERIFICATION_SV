package ram_pkg;
 
  int no_of_trans = 50;
  
  `include "ram_trans.sv"
  `include "ram_gen.sv"
  `include "ram_wd.sv"
  `include "ram_rd.sv"
  `include "ram_wm.sv"
  `include "ram_rm.sv"
  `include "ram_rf.sv"
  `include "ram_sb.sv"
  `include "ram_env.sv"  
  
  `include "ram_w_r.sv"
  `include "ram_write.sv"
  `include "ram_write_reset.sv"
  `include "ram_read_reset.sv"
  `include "ram_wr_reset.sv"
  `include "ram_test.sv"
  
endpackage