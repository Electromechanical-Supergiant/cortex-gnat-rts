--  Copyright (C) 2018 Free Software Foundation, Inc.

--  This file is part of the Cortex GNAT RTS package.
--
--  The Cortex GNAT RTS package is free software; you can redistribute
--  it and/or modify it under the terms of the GNU General Public
--  License as published by the Free Software Foundation; either
--  version 3 of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; see the file COPYING3.  If not, see
--  <http://www.gnu.org/licenses/>.

with nrf51.GPIO;

package body LEDs is

   --  The LEDs are driven as a 3-row, 9-column matrix, addressed by
   --  row/column (i.e., to set LED 1.1, set row 1, column 1 each to
   --  High).

   --  See https://www.iot-programmer.com/index.php/books/\
   --  27-micro-bit-iot-in-c/chapters-micro-bit-iot-in-c/\
   --  54-micro-bit-iot-in-c-the-led-display

   type Row_Pin is (R1, R2, R3);
   for Row_Pin use (R1 => 13, R2 => 14, R3 => 15);

   type Col_Pin is (C1, C2, C3, C4, C5, C6, C7, C8, C9);
   for Col_Pin use (C1 => 4, C2 => 5, C3 => 6, C4 => 7, C5 => 8,
                    C6 => 9, C7 => 10, C8 => 11, C9 => 12);

   type LED_Pins is record
      R : Row_Pin;
      C : Col_Pin;
   end record;
   type LED_Array is array (Coord, Coord) of LED_Pins;
   LEDs : constant LED_Array :=
     (((R1, C1), (R2, C4), (R1, C2), (R2, C5), (R1, C3)),
      ((R3, C4), (R3, C5), (R3, C6), (R3, C7), (R3, C8)),
      ((R2, C2), (R1, C9), (R2, C3), (R3, C9), (R2, C1)),
      ((R1, C8), (R1, C7), (R1, C6), (R1, C5), (R1, C4)),
      ((R3, C3), (R2, C7), (R3, C1), (R2, C6), (R3, C2)));

   procedure Clear_All_LEDs is
      use nrf51.GPIO;
   begin
      for R in Row_Pin loop
         GPIO_Periph.OUT_k.Arr (R'Enum_Rep) := Low;
      end loop;
      for C in Col_Pin loop
         GPIO_Periph.OUT_k.Arr (C'Enum_Rep) := High;
      end loop;
   end Clear_All_LEDs;

   procedure Set_One_LED (Row, Col : Coord) is
      Pins : constant LED_Pins := LEDs (Row, Col);
      use nrf51.GPIO;
   begin
      GPIO_Periph.OUT_k.Arr (Pins.R'Enum_Rep) := High;
      GPIO_Periph.OUT_k.Arr (Pins.C'Enum_Rep) := Low;
   end Set_One_LED;

   procedure Initialize;
   procedure Initialize is
      use nrf51.GPIO;
   begin
      --  LED matrix
      for R in Row_Pin loop
         GPIO_Periph.PIN_CNF (R'Enum_Rep) := (DIR    => Output,
                                              PULL   => Pullup,
                                              others => <>);
      end loop;
      for C in Col_Pin loop
         GPIO_Periph.PIN_CNF (C'Enum_Rep) := (DIR    => Output,
                                              PULL   => Pullup,
                                              others => <>);
      end loop;

      Clear_All_LEDs;
   end Initialize;

begin
   Initialize;
end LEDs;
