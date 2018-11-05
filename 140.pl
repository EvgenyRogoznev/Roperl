#!/usr/bin/env perl;
use strict;
use 5.010;
#isrevalid return 1 or 0 
require 'Isrevalid.pm';
use Isrevalid;
Isrevalid::isrevalid();
say &isrevalid(3);