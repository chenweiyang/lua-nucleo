dofile("lua/strict.lua")
dofile("lua/import.lua")
local make_suite = select(1, ...)
assert(type(make_suite) == "function")
local check_ok  = import 'test/tdeepequals-test-utils.lua' { 'check_ok' }
-- ----------------------------------------------------------------------------
-- Recursion
-- ----------------------------------------------------------------------------
local test = make_suite("shared subtables and recursion")
test "1" ( function()
  local t1={}
  local t2={}
  local t3={}
  local t4={}
  local u={t1,t2,[t1]=t1,[t2]=t2}
  local v={t3,t4,[t4]=t4,[t3]=t3}
  check_ok(u,v,true)
end)

test "2" ( function()
  local t1={}
  local t2={}
  local t3={}
  local t4={}
  local u={{{{t1}}},{{{t2}}},[t1]=t1,[t2]=t2}
  local v={{{{t3}}},{{{t4}}},[t4]=t4,[t3]=t3}
  check_ok(u,v,true)
end)

test "3" ( function()
  local t1={}
  local t2={}
  local t3={}
  local t4={}
  local u={{{{t1}}},{t2},[t1]=t1,[t2]=t2}
  local v={{{{t3}}},{t4},[t4]=t4,[t3]=t3}
  check_ok(u,v,true)
end)

test "4" ( function()
  local t1={}
  local t2={}
  local t3={}
  local t4={}
  local u={t1,t2,[t1]=t2,[t2]=t1}
  local v={t3,t4,[t3]=t3,[t4]=t4}
  check_ok(u,v,false)
end)

test "5" ( function()
  local u={}
  local v={}
  u[u]=u
  v[v]=v
  check_ok(u,v,true)
end)

test "6" ( function()
  local u={}
  local v={}
  u[v]=u
  v[u]=v
  check_ok(u,v,true)
end)

test "7" ( function()
  local t1={}
  local t2={}
  t1[t1]=t2
  local t3={}
  local u={t2,t1}
  local v={t3,t1}
  check_ok(u,v,false)
end)

test "8" ( function()
  local t1={}
  local t2={}
  t1[t1]=t2
  local t3={}
  local t4={}
  t3[t3]=t3
  local u={t1,t2}
  local v={t3,t4}
  check_ok(u,v,false)
end)

test "9" ( function()
  local a={1,2,3}
  local u={[a]=a,[{a,a}]={a,a}, { {a,{a,{a}},{[a]=a}} } }
  check_ok(u,u,true)
end)

test "10" ( function()
  local a={1,2,3}
  local u={[a]=a,[{a,a}]={a,a}, { {a,{a,{a}},{[a]=a}} } }
  local v={[a]=a,[{a,a}]={a,a}, { {a,{a,{{a}}},{[a]=a}} } }
  check_ok(u,v,false)
end)

test "10" ( function()
  local a={}
  a[a]=a a[{a,a}]={a,a} a[3]={ {a,{a,{a}},{[a]=a}} }
  local b={}
  b[b]=b b[{b,b}]={b,b,b} b[3]={ {b,{b,{b}},{[b]=b}} }
  check_ok(a,b,false)
end)


test "11" ( function()
  local var1={} var1[1]=var1
  local a={}
  a[1]={ {a} }
  check_ok(var1,a,false)
end)



assert (test:run())