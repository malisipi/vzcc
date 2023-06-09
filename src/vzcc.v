module main

import os
import v.pref

fn user_arch() string {
	arch := pref.get_host_arch()
	match int(arch) {
		1 {
			return "x86_64"
		} else {
			panic("Arch Undefined")
		}
	}
}

fn compile(file string, output_file string, target_arch string, target_os string, target_os_extra string){
	mut vflags := os.getenv("VZCC_VFLAGS") + " "
	mut cflags := os.getenv("VZCC_CFLAGS") + " "
	mut ldflags := os.getenv("VZCC_LDFLAGS") + " "
	if target_os=="windows" && os.getenv("SKIP_WINMAIN")!="1" {
		ldflags += "-I" + @VMODROOT.replace("\"","\\\"") + "/src -include win_boot.h "
	} else if target_os!="windows" {
		vflags += "-gc none "
	}
	
	system_command := "VCROSS_COMPILER_NAME=\"zig_cc\" v -cc zig_cc -d zigcc -cflags \"-target ${target_arch}-${target_os}${target_os_extra} -Wno-everything -fno-sanitize=undefined -D__ZIGCC__ ${cflags}\" -d zigcc -ldflags \"${ldflags}\" ${vflags} -os ${target_os} ${file} -o ${output_file}"
	$if debug? {
		println("[VZCC] $ ${system_command}")
	}
	os.system(system_command)
}

fn main(){
	match os.args.len {
		5 {
			compile(os.args[1], os.args[4], os.args[3], os.args[2], "")
		} 6 {
			compile(os.args[1], os.args[4], os.args[3], os.args[2], os.args[5])
		} 4 {
			compile(os.args[1], os.args[3], user_arch(), os.args[2], "")
		} 3 {
			compile(os.args[1], os.args[2], user_arch(), os.user_os(), "")
		} else { panic("[VZCC]: Zig CC for V") }
	}
}
