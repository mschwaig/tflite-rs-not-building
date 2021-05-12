For some reason
```
nix develop -c cargo build
```
successfully builds the project, while

```
nix build
```
fails with the following error:
```
  --- stderr
  Failed to run rustfmt: Cannot find binary path (non-fatal, continuing)
  make command = "make" "-j" "8" "BUILD_WITH_NNAPI=false" "-f" "tensorflow/lite/tools/make/Makefile" "TAR>
  /nix/store/5xyjd2qiily84lcv2w2grmwsb8r1hqpr-binutils-2.35.1/bin/ld: /nix/store/v8q6nxyppy1myi3rxni2080b>
  /build/glibc-2.32/csu/../sysdeps/x86_64/start.S:104: undefined reference to `main'
  collect2: error: ld returned 1 exit status
  make: *** [tensorflow/lite/tools/make/Makefile:250: /build/dummy-src/target/release/build/tflite-17dd30>
  make: *** Waiting for unfinished jobs....
  /nix/store/5xyjd2qiily84lcv2w2grmwsb8r1hqpr-binutils-2.35.1/bin/ld: /nix/store/v8q6nxyppy1myi3rxni2080b>
  /build/glibc-2.32/csu/../sysdeps/x86_64/start.S:104: undefined reference to `main'
  collect2: error: ld returned 1 exit status

```
