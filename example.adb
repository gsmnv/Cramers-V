---
-- Copyright © 2012 - present, George Semenov
--
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH REGARD
-- TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
-- FITNESS. IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
-- CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
-- DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
-- ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
-- SOFTWARE.
---

with Cramer;
with Ada.Text_IO;

procedure Example is
   type Coefficient is delta 0.0001 digits 5;
   package Coefficient_IO is new Ada.Text_IO.Decimal_IO (Coefficient);
   package Stats is new Cramer (2,3);
   use Stats; use Coefficient_IO;

   ---
   -- Test scenario was brought from http://stattrek.com/chi-square-test/independence.aspx
   -- But here, as you can see, a little different kind of calculus.
   --
   -- A public opinion poll surveyed a simple random sample of 1000 voters.
   -- Respondents were classified by gender (male or female) and by voting
   -- preference (Republican, Democrat, or Independent).
   ---

   --                     Republican |  Democrat | Independent
   Data : Test_Data := ( (   200.0,      150.0,       50.0),    -- Male
                         (   250.0,      300.0,       50.0) );  -- Female
begin

   Put (Coefficient (Cramer_V (Data)));

   ---
   -- Cramer's coefficient:  0.1272
   -- In this case gender gap is insignificant (voting preferences nearly unrelated with voter's gender).
   --
   -- Informal standards of the Cramer's coeficient:
   -- 1.0 - 0.8  -- Very strongly related.
   -- 0.8 - 0.5  -- Fairly strongly related.
   -- 0.5 - 0.25 -- Fairly weakly related.
   -- Below 0.25 -- Unrelated/nearly unrelated.
   ---

end Example;
