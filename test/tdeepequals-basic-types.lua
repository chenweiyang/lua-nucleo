-- tdeepequals-basic-types.lua -- different datatypes tests for tdeepequals package
-- This file is a part of lua-nucleo library
-- Copyright (c) lua-nucleo authors (see file `COPYRIGHT` for the license)

dofile("lua/strict.lua")
assert(type(import)=="function","Import is required to run")
local make_suite = select(1, ...)
assert(type(make_suite) == "function")
local check_ok  = import 'test/lib/tdeepequals-test-utils.lua' { 'check_ok' }
local test = make_suite("basic types")

test "1" ( function() check_ok(1,1,true) end)
test "2" ( function() check_ok(1,0,false) end)
test "3" ( function() check_ok(1,"",false) end)
test "4" ( function() check_ok("1","",false) end)
test "5" ( function() check_ok("1",function () end,false) end)

test "6" ( function()
  local t=function () end
  check_ok(t,t,true)
end)

test "7" ( function() check_ok(true,true,true) end)

test "8" ( function()
  local t=function () end
  check_ok(true,t,false)
end)

test "9" ( function() check_ok(true,{},false) end)

test "10" ( function()
  local t=function () end
  check_ok(t,{},false)
end)

assert (test:run())
