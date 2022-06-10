# RAM_VERIFICATION_SV

## Introdustion
An environment written in system verilog to verify a dual port RAM module. The environment consists of a generator, driver, monitor, reference board, and score board. Read and write operations have there own driver and monitor. An interface, and multiple mail boxes are used for communication with the DUT and among the components. The whole environment is OOP based.

## Transition class
This class is resposible to carry read-write adderesses & data, reset, constraints, and enable signal. The mail boxes uses this class to carry information between components and interface.

## Generator Class
This class is responsible for generating random adderess and data to write in. The generated data is put into two mailboxes, one goes into the write driver, the other goes into the read driver.

## Drivers
Two drivers are used in this environment. The write driver takes the generated data from the mailbox and puts it into the interface. The interface gives the value to the DUT. The read driver gets the genrated data from mailbox and puts it into the interface.

## Monitor
Two monitors are used in this environment. One for write, which consists of two mailboxes, one takes the value from the interface, the other supplies it to the reference model. 
