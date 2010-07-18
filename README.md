Detabulator
===========

Extract columnar data from tabulated plain text.

Example
-------

Given some tabulated data:

    sample = <<END
                Column 1    Column 2
    Drinks      Beer        Whiskey
    Not drinks  Toothpaste  Mouthwash
    END

This:

    require "detabulator"
    Detabulator.new.detabulate(sample)

Will produce this:

    [["", "Column 1", "Column 2"],
     ["Drinks", "Beer", "Whiskey"],
     ["Not drinks", "Toothpaste", "Mouthwash"]] 

This is just a first release that does something useful.

Limitations
-----------

* Double-width characters (e.g. Japanese) are not handled correctly.
* Combining diacritics are not handled correctly.
* When one cell contains much longer text and a space, an extra column is generated.
