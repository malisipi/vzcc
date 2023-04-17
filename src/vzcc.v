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
	mut vflags := ""
	mut ldflags := ""
	if target_os=="windows"{
		ldflags += "-I" + @VMODROOT.replace("\"","\\\"") + "/src -include win_boot.h "
	} else if target_os=="linux" {
		vflags += "-gc none "
	}
	
	system_command := "VCROSS_COMPILER_NAME=\"zig_cc\" v -cc zig_cc -d zigcc -cflags \"-target ${target_arch}-${target_os}${target_os_extra} -Wno-everything -fno-sanitize=undefined\" -ldflags \"${ldflags}\" ${vflags} -os ${target_os} ${file} -o ${output_file}"
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
		} else { panic("!!") }
	}
}
