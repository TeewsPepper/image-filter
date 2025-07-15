(module
 (type $0 (func (param i32 i32 i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32) (result i32)))
 (type $5 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $src/assembly/index/PIXEL_PTR i32 (i32.const 0))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 1036) "\1c")
 (data $0.1 (i32.const 1048) "\01\00\00\00\0c\00\00\00\00\00\00\00\ff\ff\ff\ff")
 (data $1 (i32.const 1068) "<")
 (data $1.1 (i32.const 1080) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $2 (i32.const 1132) "<")
 (data $2.1 (i32.const 1144) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00s\00t\00u\00b\00.\00t\00s")
 (data $3 (i32.const 1196) "\1c")
 (data $3.1 (i32.const 1208) "\01\00\00\00\0c\00\00\00\ff\ff\ff\ff\05\00\00\00\ff\ff\ff\ff")
 (data $4 (i32.const 1228) "\1c")
 (data $4.1 (i32.const 1240) "\01\00\00\00\0c\00\00\00\00\00\00\00\ff\ff\ff\ff")
 (data $5 (i32.const 1260) "<")
 (data $5.1 (i32.const 1272) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $6 (i32.const 1324) ",")
 (data $6.1 (i32.const 1336) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $7 (i32.const 1372) ",")
 (data $7.1 (i32.const 1384) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $8 (i32.const 1420) "|")
 (data $8.1 (i32.const 1432) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (export "PIXEL_PTR" (global $src/assembly/index/PIXEL_PTR))
 (export "getPixelPtr" (func $src/assembly/index/getPixelPtr))
 (export "grayscale" (func $src/assembly/index/grayscale))
 (export "sepia" (func $src/assembly/index/sepia))
 (export "invert" (func $src/assembly/index/invert))
 (export "blur" (func $src/assembly/index/blur))
 (export "sharpen" (func $src/assembly/index/sharpen))
 (export "memory" (memory $0))
 (start $~start)
 (func $src/assembly/index/getPixelPtr (result i32)
  i32.const 0
 )
 (func $src/assembly/index/grayscale (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $2
  i32.mul
  i32.const 2
  i32.shl
  local.set $2
  loop $for-loop|0
   local.get $2
   local.get $3
   i32.gt_s
   if
    local.get $0
    local.get $3
    i32.add
    local.tee $4
    local.get $4
    i32.const 2
    i32.add
    i32.load8_u
    local.get $4
    i32.load8_u
    local.get $4
    i32.load8_u offset=1
    i32.add
    i32.add
    i32.const 255
    i32.and
    i32.const 3
    i32.div_u
    local.tee $1
    i32.store8
    local.get $4
    local.get $1
    i32.store8 offset=1
    local.get $4
    local.get $1
    i32.store8 offset=2
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $src/assembly/index/sepia (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 f64)
  (local $5 f64)
  (local $6 f64)
  local.get $1
  local.get $2
  i32.mul
  i32.const 2
  i32.shl
  local.set $1
  loop $for-loop|0
   local.get $1
   local.get $3
   i32.gt_s
   if
    local.get $0
    local.get $3
    i32.add
    local.tee $2
    local.get $2
    i32.load8_u
    f64.convert_i32_u
    local.tee $4
    f64.const 0.393
    f64.mul
    local.get $2
    i32.load8_u offset=1
    f64.convert_i32_u
    local.tee $5
    f64.const 0.769
    f64.mul
    f64.add
    local.get $2
    i32.load8_u offset=2
    f64.convert_i32_u
    local.tee $6
    f64.const 0.189
    f64.mul
    f64.add
    f64.const 255
    f64.min
    i32.trunc_sat_f64_u
    i32.store8
    local.get $2
    local.get $4
    f64.const 0.349
    f64.mul
    local.get $5
    f64.const 0.686
    f64.mul
    f64.add
    local.get $6
    f64.const 0.168
    f64.mul
    f64.add
    f64.const 255
    f64.min
    i32.trunc_sat_f64_u
    i32.store8 offset=1
    local.get $2
    local.get $4
    f64.const 0.272
    f64.mul
    local.get $5
    f64.const 0.534
    f64.mul
    f64.add
    local.get $6
    f64.const 0.131
    f64.mul
    f64.add
    f64.const 255
    f64.min
    i32.trunc_sat_f64_u
    i32.store8 offset=2
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $src/assembly/index/invert (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  local.get $2
  i32.mul
  i32.const 2
  i32.shl
  local.set $1
  loop $for-loop|0
   local.get $1
   local.get $3
   i32.gt_s
   if
    local.get $0
    local.get $3
    i32.add
    local.tee $2
    i32.const 255
    local.get $2
    i32.load8_u
    i32.sub
    i32.store8
    local.get $2
    i32.const 1
    i32.add
    i32.const 255
    local.get $2
    i32.load8_u offset=1
    i32.sub
    i32.store8
    local.get $2
    i32.const 2
    i32.add
    i32.const 255
    local.get $2
    i32.load8_u offset=2
    i32.sub
    i32.store8
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $src/assembly/index/blur (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  i32.const 1
  local.set $4
  loop $for-loop|0
   local.get $4
   local.get $2
   i32.const 1
   i32.sub
   i32.lt_s
   if
    i32.const 1
    local.set $5
    loop $for-loop|1
     local.get $5
     local.get $1
     i32.const 1
     i32.sub
     i32.lt_s
     if
      i32.const 0
      local.set $7
      i32.const 0
      local.set $8
      i32.const 0
      local.set $9
      i32.const -1
      local.set $3
      loop $for-loop|2
       local.get $3
       i32.const 1
       i32.le_s
       if
        i32.const -1
        local.set $6
        loop $for-loop|3
         local.get $6
         i32.const 1
         i32.le_s
         if
          local.get $7
          local.get $0
          local.get $5
          local.get $6
          i32.add
          local.get $3
          local.get $4
          i32.add
          local.get $1
          i32.mul
          i32.add
          i32.const 2
          i32.shl
          i32.add
          local.tee $10
          i32.load8_u
          i32.add
          local.set $7
          local.get $8
          local.get $10
          i32.load8_u offset=1
          i32.add
          local.set $8
          local.get $9
          local.get $10
          i32.load8_u offset=2
          i32.add
          local.set $9
          local.get $6
          i32.const 1
          i32.add
          local.set $6
          br $for-loop|3
         end
        end
        local.get $3
        i32.const 1
        i32.add
        local.set $3
        br $for-loop|2
       end
      end
      local.get $0
      local.get $1
      local.get $4
      i32.mul
      local.get $5
      i32.add
      i32.const 2
      i32.shl
      i32.add
      local.tee $3
      local.get $7
      i32.const 9
      i32.div_s
      i32.store8
      local.get $3
      local.get $8
      i32.const 9
      i32.div_s
      i32.store8 offset=1
      local.get $3
      local.get $9
      i32.const 9
      i32.div_s
      i32.store8 offset=2
      local.get $5
      i32.const 1
      i32.add
      local.set $5
      br $for-loop|1
     end
    end
    local.get $4
    i32.const 1
    i32.add
    local.set $4
    br $for-loop|0
   end
  end
 )
 (func $~lib/rt/stub/__alloc (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1088
   i32.const 1152
   i32.const 33
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/stub/offset
  global.get $~lib/rt/stub/offset
  i32.const 4
  i32.add
  local.tee $2
  local.get $0
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.tee $0
  i32.add
  local.tee $3
  memory.size
  local.tee $4
  i32.const 16
  i32.shl
  i32.const 15
  i32.add
  i32.const -16
  i32.and
  local.tee $5
  i32.gt_u
  if
   local.get $4
   local.get $3
   local.get $5
   i32.sub
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $5
   local.get $4
   local.get $5
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $5
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $3
  global.set $~lib/rt/stub/offset
  local.get $0
  i32.store
  local.get $2
 )
 (func $~lib/rt/stub/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 1073741804
  i32.gt_u
  if
   i32.const 1088
   i32.const 1152
   i32.const 86
   i32.const 30
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 16
  i32.add
  call $~lib/rt/stub/__alloc
  local.tee $3
  i32.const 4
  i32.sub
  local.tee $2
  i32.const 0
  i32.store offset=4
  local.get $2
  i32.const 0
  i32.store offset=8
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  local.get $3
  i32.const 16
  i32.add
 )
 (func $~lib/rt/__newArray (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  i32.const 12
  i32.const 1
  call $~lib/rt/stub/__new
  local.set $2
  local.get $1
  if
   local.get $2
   local.get $1
   i32.const 12
   memory.copy
  end
  i32.const 16
  local.get $0
  call $~lib/rt/stub/__new
  local.tee $0
  local.get $2
  i32.store
  local.get $0
  local.get $2
  i32.store offset=4
  local.get $0
  i32.const 12
  i32.store offset=8
  local.get $0
  i32.const 3
  i32.store offset=12
  local.get $0
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   local.get $1
   i32.const 0
   i32.lt_s
   if
    i32.const 1280
    i32.const 1344
    i32.const 130
    i32.const 22
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 1
   i32.add
   local.tee $5
   local.get $0
   i32.load offset=8
   local.tee $11
   i32.const 2
   i32.shr_u
   i32.gt_u
   if
    local.get $5
    i32.const 268435455
    i32.gt_u
    if
     i32.const 1392
     i32.const 1344
     i32.const 19
     i32.const 48
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.load
    local.set $10
    i32.const 1073741820
    local.get $11
    i32.const 1
    i32.shl
    local.tee $3
    local.get $3
    i32.const 1073741820
    i32.ge_u
    select
    local.tee $4
    i32.const 8
    local.get $5
    local.get $5
    i32.const 8
    i32.le_u
    select
    i32.const 2
    i32.shl
    local.tee $3
    local.get $3
    local.get $4
    i32.lt_u
    select
    local.tee $9
    i32.const 1073741804
    i32.gt_u
    if
     i32.const 1088
     i32.const 1152
     i32.const 99
     i32.const 30
     call $~lib/builtins/abort
     unreachable
    end
    local.get $10
    i32.const 16
    i32.sub
    local.tee $4
    i32.const 15
    i32.and
    i32.const 1
    local.get $4
    select
    if
     i32.const 0
     i32.const 1152
     i32.const 45
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    global.get $~lib/rt/stub/offset
    local.get $4
    i32.const 4
    i32.sub
    local.tee $8
    i32.load
    local.tee $6
    local.get $4
    i32.add
    i32.eq
    local.set $5
    local.get $9
    i32.const 16
    i32.add
    local.tee $3
    i32.const 19
    i32.add
    i32.const -16
    i32.and
    i32.const 4
    i32.sub
    local.set $7
    local.get $3
    local.get $6
    i32.gt_u
    if
     local.get $5
     if
      local.get $3
      i32.const 1073741820
      i32.gt_u
      if
       i32.const 1088
       i32.const 1152
       i32.const 52
       i32.const 33
       call $~lib/builtins/abort
       unreachable
      end
      local.get $4
      local.get $7
      i32.add
      local.tee $6
      memory.size
      local.tee $5
      i32.const 16
      i32.shl
      i32.const 15
      i32.add
      i32.const -16
      i32.and
      local.tee $3
      i32.gt_u
      if
       local.get $5
       local.get $6
       local.get $3
       i32.sub
       i32.const 65535
       i32.add
       i32.const -65536
       i32.and
       i32.const 16
       i32.shr_u
       local.tee $3
       local.get $3
       local.get $5
       i32.lt_s
       select
       memory.grow
       i32.const 0
       i32.lt_s
       if
        local.get $3
        memory.grow
        i32.const 0
        i32.lt_s
        if
         unreachable
        end
       end
      end
      local.get $6
      global.set $~lib/rt/stub/offset
      local.get $8
      local.get $7
      i32.store
     else
      local.get $7
      local.get $6
      i32.const 1
      i32.shl
      local.tee $3
      local.get $3
      local.get $7
      i32.lt_u
      select
      call $~lib/rt/stub/__alloc
      local.tee $3
      local.get $4
      local.get $6
      memory.copy
      local.get $3
      local.set $4
     end
    else
     local.get $5
     if
      local.get $4
      local.get $7
      i32.add
      global.set $~lib/rt/stub/offset
      local.get $8
      local.get $7
      i32.store
     end
    end
    local.get $4
    i32.const 4
    i32.sub
    local.get $9
    i32.store offset=16
    local.get $4
    i32.const 16
    i32.add
    local.tee $3
    local.get $11
    i32.add
    i32.const 0
    local.get $9
    local.get $11
    i32.sub
    memory.fill
    local.get $3
    local.get $10
    i32.ne
    if
     local.get $0
     local.get $3
     i32.store
     local.get $0
     local.get $3
     i32.store offset=4
    end
    local.get $0
    local.get $9
    i32.store offset=8
   end
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   i32.store offset=12
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
 )
 (func $src/assembly/index/sharpen (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  i32.const 5
  i32.const 0
  call $~lib/rt/__newArray
  local.tee $7
  i32.const 0
  i32.const 4
  i32.const 1056
  call $~lib/rt/__newArray
  call $~lib/array/Array<~lib/array/Array<i32>>#__set
  local.get $7
  i32.const 1
  i32.const 4
  i32.const 1216
  call $~lib/rt/__newArray
  call $~lib/array/Array<~lib/array/Array<i32>>#__set
  local.get $7
  i32.const 2
  i32.const 4
  i32.const 1248
  call $~lib/rt/__newArray
  call $~lib/array/Array<~lib/array/Array<i32>>#__set
  i32.const 1
  local.set $4
  block $folding-inner0
   loop $for-loop|0
    local.get $4
    local.get $2
    i32.const 1
    i32.sub
    i32.lt_s
    if
     i32.const 1
     local.set $5
     loop $for-loop|1
      local.get $5
      local.get $1
      i32.const 1
      i32.sub
      i32.lt_s
      if
       i32.const 0
       local.set $8
       i32.const 0
       local.set $9
       i32.const 0
       local.set $10
       i32.const -1
       local.set $6
       loop $for-loop|2
        local.get $6
        i32.const 1
        i32.le_s
        if
         i32.const -1
         local.set $3
         loop $for-loop|3
          local.get $3
          i32.const 1
          i32.le_s
          if
           local.get $6
           i32.const 1
           i32.add
           local.tee $11
           local.get $7
           i32.load offset=12
           i32.ge_u
           br_if $folding-inner0
           local.get $7
           i32.load offset=4
           local.get $11
           i32.const 2
           i32.shl
           i32.add
           i32.load
           local.tee $11
           i32.eqz
           if
            i32.const 1440
            i32.const 1344
            i32.const 118
            i32.const 40
            call $~lib/builtins/abort
            unreachable
           end
           local.get $3
           local.get $5
           i32.add
           local.get $4
           local.get $6
           i32.add
           local.get $1
           i32.mul
           i32.add
           i32.const 2
           i32.shl
           local.set $12
           local.get $3
           i32.const 1
           i32.add
           local.tee $3
           local.get $11
           i32.load offset=12
           i32.ge_u
           br_if $folding-inner0
           local.get $8
           local.get $11
           i32.load offset=4
           local.get $3
           i32.const 2
           i32.shl
           i32.add
           i32.load
           local.tee $11
           local.get $0
           local.get $12
           i32.add
           local.tee $12
           i32.load8_u
           i32.mul
           i32.add
           local.set $8
           local.get $9
           local.get $12
           i32.load8_u offset=1
           local.get $11
           i32.mul
           i32.add
           local.set $9
           local.get $10
           local.get $12
           i32.load8_u offset=2
           local.get $11
           i32.mul
           i32.add
           local.set $10
           br $for-loop|3
          end
         end
         local.get $6
         i32.const 1
         i32.add
         local.set $6
         br $for-loop|2
        end
       end
       local.get $1
       local.get $4
       i32.mul
       local.get $5
       i32.add
       i32.const 2
       i32.shl
       local.get $0
       i32.add
       local.tee $3
       local.get $8
       f64.convert_i32_s
       f64.const 255
       f64.min
       f64.const 0
       f64.max
       i32.trunc_sat_f64_u
       i32.store8
       local.get $3
       local.get $9
       f64.convert_i32_s
       f64.const 255
       f64.min
       f64.const 0
       f64.max
       i32.trunc_sat_f64_u
       i32.store8 offset=1
       local.get $3
       local.get $10
       f64.convert_i32_s
       f64.const 255
       f64.min
       f64.const 0
       f64.max
       i32.trunc_sat_f64_u
       i32.store8 offset=2
       local.get $5
       i32.const 1
       i32.add
       local.set $5
       br $for-loop|1
      end
     end
     local.get $4
     i32.const 1
     i32.add
     local.set $4
     br $for-loop|0
    end
   end
   return
  end
  i32.const 1280
  i32.const 1344
  i32.const 114
  i32.const 42
  call $~lib/builtins/abort
  unreachable
 )
 (func $~start
  i32.const 1548
  global.set $~lib/rt/stub/offset
 )
)
