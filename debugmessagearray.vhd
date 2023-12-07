```
library ieee;
use ieee.std_logic_1164.all;

entity debugmessagearray is
    port (
        load: in std_logic;
		  clk: in std_logic;
		  IQR: in std_logic_vector(1 downto 0);
		  reset: in std_logic;
		  SI: in std_logic_vector(1 downto 0);
		  
		  msgsent: out std_logic;
		  parallelsend: out std_logic;
    );
end;

architecture rtl of debugmessagearray is
    component Counter8 is
		port (
        CLK, RESETN, EN: in std_logic;
        VALUE: out std_logic_vector(3 downto 0)
		);
	 end component;
begin
	signal countNum: std_logic;
	signal tranmitSignal: std_logic(7 downto 0);
	signal localReset: std_logic;
	
	Count: Counter8
    port map(
        CLK => clk,
		  RESETN => localReset;
		  EN => IQR[1];
		  VALUE => countNum;
    );
if(SI == '00'){
    if(IQR[1] == '1'){
		if(countNum == '000'){
		tranmitSignal <= '#M';
		}
		elsif(countNum == '001'){
		transmitSignal <= '#g';
		}
		elsif(countNum == '010'){
		transmitSignal <= '#_';
		}
		elsif(countNum == '011'){
		transmitSignal <= '#S';
		}
		elsif(countNum == '100'){
		transmitSignal <= '#r';
		localReset <= 1;
		}
	}
}

elsif(SI == '01'){
		if(IQR[1] == '1'){
		if(countNum == '000'){
		tranmitSignal <= '#M';
		}
		elsif(countNum == '001'){
		transmitSignal <= '#y';
		}
		elsif(countNum == '010'){
		transmitSignal <= '#_';
		}
		elsif(countNum == '011'){
		transmitSignal <= '#S';
		}
		elsif(countNum == '100'){
		transmitSignal <= '#r';
		localReset <= 1;
		}
	}
}

elsif(SI == '10'){
		if(IQR[1] == '1'){
		if(countNum == '000'){
		tranmitSignal <= '#M';
		}
		elsif(countNum == '001'){
		transmitSignal <= '#r';
		}
		elsif(countNum == '010'){
		transmitSignal <= '#_';
		}
		elsif(countNum == '011'){
		transmitSignal <= '#S';
		}
		elsif(countNum == '100'){
		transmitSignal <= '#g';
		localReset <= 1;
		}
	}
}

elsif(SI == '11'){
		if(IQR[1] == '1'){
		if(countNum == '000'){
		tranmitSignal <= '#M';
		}
		elsif(countNum == '001'){
		transmitSignal <= '#r';
		}
		elsif(countNum == '010'){
		transmitSignal <= '#_';
		}
		elsif(countNum == '011'){
		transmitSignal <= '#S';
		}
		elsif(countNum == '100'){
		transmitSignal <= '#y';
		localReset <= 1;
		}
	}
}

 --output signals
 parallelsend <= tranmitSignal;
 msgsent <= localReset;
end;
```