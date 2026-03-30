MRuby::CrossBuild.new('esp32-microruby') do |conf|
  conf.toolchain('gcc')

  conf.cc.command = "xtensa-#{ENV['CONFIG_IDF_TARGET']}-elf-gcc"
  conf.linker.command = "xtensa-#{ENV['CONFIG_IDF_TARGET']}-elf-ld"
  conf.archiver.command = "xtensa-#{ENV['CONFIG_IDF_TARGET']}-elf-ar"

  conf.cc.host_command = 'gcc'
  conf.cc.flags << '-Wall'
  conf.cc.flags << '-Wno-format'
  conf.cc.flags << '-Wno-unused-function'
  conf.cc.flags << '-Wno-maybe-uninitialized'
  conf.cc.flags << '-mlongcalls'

  conf.cc.defines << 'MRB_TICK_UNIT=10'
  conf.cc.defines << 'MRB_TIMESLICE_TICK_COUNT=1'
  conf.cc.defines << 'MRBC_CONVERT_CRLF=1'
  conf.cc.defines << 'MRB_INT64'
  conf.cc.defines << 'MRB_32BIT'
  conf.cc.defines << 'PICORB_ALLOC_ESTALLOC'
  conf.cc.defines << 'PICORB_ALLOC_ALIGN=8'
  conf.cc.defines << 'USE_FAT_FLASH_DISK'
  conf.cc.defines << 'NDEBUG'
  conf.cc.defines << 'ESP32_PLATFORM'

  if ENV['PICORB_DEBUG']
    conf.cc.defines << 'ESTALLOC_DEBUG'
    conf.enable_debug
  end

  conf.microruby
  conf.gembox 'minimum'
  conf.gembox 'core'

  # Add core gems from mruby
  mruby_mrbgem_dir = "../picoruby/mrbgems/picoruby-mruby/lib/mruby/mrbgems"

  # Known working from *-esp-microruby.rb
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-kernel-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-string-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-array-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-objectspace"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-metaprog"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-error"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-sprintf"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-math"

  # From old ESP-IDF project (working)
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-array-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-bigint"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-catch"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-class-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-cmath"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-compar-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-complex"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-error"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-hash-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-math"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-metaprog"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-numeric-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-object-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-objectspace"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-pack"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-random"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-range-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-rational"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-string-ext"
  conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-symbol-ext"

  # Require mruby-fiber (build fails)
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-enum-chain"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-enum-ext"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-enumerator"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-set"

  # Require mruby-compiler (build fails)
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-eval"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-method"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-proc-binding"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-proc-ext"

  # Not needed on picoruby
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-compiler"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-data"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-io"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-os-memsize"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-socket"
  # conf.gem gemdir: "#{mruby_mrbgem_dir}/mruby-time"

  conf.gem core: 'picoruby-esp32'
  # conf.gembox 'shell'

  # stdlib
  conf.gem core: 'picoruby-rng'
  conf.gem core: 'picoruby-base64'
  conf.gem core: 'picoruby-yaml'

  # peripherals
  conf.gem core: 'picoruby-gpio'
  conf.gem core: 'picoruby-i2c'
  conf.gem core: 'picoruby-spi'
  conf.gem core: 'picoruby-adc'
  conf.gem core: 'picoruby-uart'
  conf.gem core: 'picoruby-pwm'

  # others
  # conf.gem core: 'picoruby-rmt'
  conf.gem core: 'picoruby-mbedtls'
  conf.gem core: 'picoruby-socket'
  # conf.gem core: 'picoruby-adafruit_sk6812'

  # ESP32 implementation of Denko::Board
  conf.gem "#{__dir__}/../mrbgems/mruby-denko-esp32"

  # C optimized methods for Denko::Canvas on mruby
  conf.gem github: "denko-rb/mruby-denko-fastcanvas"

  # C optimized methods for GPIO, I2C, and SPI writes, to speed up Display drawing.
  conf.gem "#{__dir__}/../mrbgems/mruby-denko-esp32/mrbgems/mruby-denko-fastio"
  # conf.gem "#{__dir__}/mrbgems/mruby-denko-fastoled"
end
