module stimulus;

	reg clk;
	reg reset;
	reg next_input;

	wire Z;

	initial begin
    	$dumpfile("fifth_question.vcd");
    	$dumpvars(0,stimulus);
	end

	FSM f (.up_down_counter(next_input), .clock(clk), .reset(reset), .out(Z));

	initial begin
    	clk = 1'b1;
	forever
    	#5 clk = ~clk;
	end

	initial
	begin
    	next_input = 1'b0;
    	reset = 1'b1;
    	#30 reset = 1'b0;
    	#10 next_input = 1'b1;
    	#30 next_input = 1'b0;
    	#30 next_input = 1'b1;
    	#40 next_input = 1'b0;
    	#20 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#40 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#40 next_input = 1'b1;
    	#40 next_input = 1'b0;
    	#20 next_input = 1'b1;
    	#30 next_input = 1'b0;
    	#50 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#10 next_input = 1'b1;
    	#40 next_input = 1'b0;
    	#20 next_input = 1'b1;
    	#30 next_input = 1'b0;
    	#20 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#40 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#50 next_input = 1'b1;
    	#20 next_input = 1'b0;
    	#10 next_input = 1'b1;
    	#40 next_input = 1'b0;
    	#10 $finish;
	end

	initial begin
    	$monitor ("Reset = %d, Input = %d Output = %d", reset, next_input, Z);
	forever
    	#10 $monitor ("Reset = %d, Input = %d Output = %d", reset, next_input, Z);
	end

endmodule

module FSM(up_down_counter, clock, reset, out);

	input clock;
	input reset;
	input up_down_counter;
	output reg out;
	// when state A=11, B=00, C=01 and D=10
	parameter A = 2'b11, B = 2'b00, C = 2'b01, D = 2'b10;
	// if we want to change the encoding, we can just change the parameters
	reg [2:0] current_state, next_state;

	// initial begin
	// 	$dumpvars(0,FSM);
	// end

	// sequential memory of the Moore FSM
	always @(posedge clock, posedge reset)
	begin
    	if(reset==1)
        	current_state <= B;
    	else
        	current_state <= next_state;
	end

	// Next State logic of FSM
	always @(current_state,up_down_counter)
	begin
    	case(current_state)
    	A:begin
        	if(up_down_counter==1)
            	next_state = C;
        	else
            	next_state = D;
    	end
        B:begin
        	if(up_down_counter==1)
            	next_state = A;
        	else
            	next_state = D;
    	end
    	C:begin
        	if(up_down_counter==1)
            	next_state = B;
        	else
            	next_state = C;
    	end
    	D:begin
        	if(up_down_counter==1)
            	next_state = B;
        	else
            	next_state = A;
    	end
    	
    	endcase
	end
    
	// Output Logic
	always @(current_state)
	begin
    	case(current_state)
    	A:   out = 1;
        B:   out = 0;
    	C:   out = 0;
    	D:   out = 0;
    	
    	default:  out = 0;
    	endcase
	end
endmodule
