library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity OpcodeDecoder is
  port (
    OPCODE : in unsigned(7 downto 0);

    Immediate : out std_logic;
    Calculate : out std_logic;
    Copy : out std_logic;
    Cond : out std_logic
  );
end OpcodeDecoder;

architecture IMPL of OpcodeDecoder is
    type instruct_t is (IMM, CALC, CPY, CND);
    signal I : instruct_t := IMM;
begin

    -- This is mainly a utility process to make it easier
    -- to add or change the Opcode later
    process(OPCODE)
        variable OPR : unsigned(7 downto 0);
    begin
        OPR := OPCODE and "11000000";

        case(OPR) is
            when "00000000" =>
                I <= IMM;
            when "01000000" =>
                I <= CALC;
            when "10000000" =>
                I <= CPY;
            when "11000000" =>
                I <= CND;
                
            -- if we messed up our mask
            when others =>
                I <= IMM;
        end case;
    end process;

    process(I)
    begin
        case(I) is
            when IMM =>
                Immediate <= '1';
                Calculate <= '0';
                Copy <= '0';
                Cond <= '0';

            when CALC =>
                Immediate <= '0';
                Calculate <= '1';
                Copy <= '0';
                Cond <= '0';

            when CPY =>
                Immediate <= '0';
                Calculate <= '0';
                Copy <= '1';
                Cond <= '0';

            when CND =>
                Immediate <= '0';
                Calculate <= '0';
                Copy <= '0';
                Cond <= '1';
                
            -- Unmapped Opcode
            when others =>
                Immediate <= '0';
                Calculate <= '0';
                Copy <= '0';
                Cond <= '0';
        end case;
    end process;
    

end IMPL;