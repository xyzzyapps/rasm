package disasm

import "fmt"

// regMap translates Intel register spellings into Readable Assembly names.
// The keys are the lowercase names produced by the decoder.
var regMap = map[string]string{
	"rax": "accumulator", "rbx": "base", "rcx": "counter", "rdx": "data",
	"rsi": "source_index", "rdi": "destination_index",
	"rbp": "base_pointer", "rsp": "stack_pointer", "rip": "register_rip",

	"eax": "accumulator_32", "ebx": "base_32", "ecx": "counter_32", "edx": "data_32",
	"esi": "source_index_32", "edi": "destination_index_32",
	"ebp": "base_pointer_32", "esp": "stack_pointer_32", "eip": "register_eip",

	"ax": "accumulator_16", "bx": "base_16", "cx": "counter_16", "dx": "data_16",
	"si": "source_index_16", "di": "destination_index_16",
	"bp": "base_pointer_16", "sp": "stack_pointer_16", "ip": "register_ip",

	"al": "accumulator_8", "bl": "base_8", "cl": "counter_8", "dl": "data_8",
	"sil": "source_index_8", "dil": "destination_index_8",
	"bpl": "base_pointer_8", "spl": "stack_pointer_8",

	"ah": "accumulator_8_high", "bh": "base_8_high",
	"ch": "counter_8_high", "dh": "data_8_high",

	"eflags": "register_eflags", "rflags": "register_rflags", "mxcsr": "register_mxcsr",

	"cr0": "control_register_0", "cr2": "control_register_2", "cr3": "control_register_3",
	"cr4": "control_register_4", "cr8": "control_register_8",
	"dr0": "debug_register_0", "dr1": "debug_register_1", "dr2": "debug_register_2",
	"dr3": "debug_register_3", "dr6": "debug_register_6", "dr7": "debug_register_7",
	"cs": "code_segment", "ds": "data_segment", "es": "extra_segment",
	"ss": "stack_segment", "fs": "fs_segment", "gs": "gs_segment",
}

func init() {
	for i := 8; i <= 15; i++ {
		n := fmt.Sprintf("r%d", i)
		regMap[n] = "register_" + n
		regMap[n+"d"] = "register_" + n + "_32"
		regMap[n+"w"] = "register_" + n + "_16"
		regMap[n+"b"] = "register_" + n + "_8"
	}
	for i := 0; i <= 31; i++ {
		regMap[fmt.Sprintf("xmm%d", i)] = fmt.Sprintf("sse_register_%d", i)
		regMap[fmt.Sprintf("ymm%d", i)] = fmt.Sprintf("avx_register_%d", i)
		regMap[fmt.Sprintf("zmm%d", i)] = fmt.Sprintf("avx512_register_%d", i)
	}
	for i := 0; i <= 7; i++ {
		regMap[fmt.Sprintf("mmx%d", i)] = fmt.Sprintf("multimedia_register_%d", i)
		regMap[fmt.Sprintf("k%d", i)] = fmt.Sprintf("mask_register_%d", i)
	}
}

// insMap translates a lowercase Intel mnemonic into a Readable Assembly name.
// The set matches tools/readablify. Intel's "n" spellings (jnb, setnb, ...)
// are included because the decoder prints those forms.
var insMap = map[string]string{
	"mov": "move", "lea": "load_effective_address", "xchg": "exchange",
	"xadd": "exchange_and_add", "bswap": "byte_swap", "xlat": "translate_byte",
	"push": "push_onto_stack", "pop": "pop_from_stack",
	"pusha": "push_all", "pushad": "push_all", "popa": "pop_all", "popad": "pop_all",
	"pushf": "push_flags", "pushfw": "push_flags_word",
	"pushfd": "push_flags_double_word", "pushfq": "push_flags_quad_word",
	"popf": "pop_flags", "popfw": "pop_flags_word",
	"popfd": "pop_flags_double_word", "popfq": "pop_flags_quad_word",
	"movsb": "move_string_byte", "movsw": "move_string_word",
	"movsd": "move_string_double_word", "movsq": "move_string_quad_word",
	"movzx": "move_with_zero_extend", "movsx": "move_with_sign_extend",
	"movsxd": "move_with_sign_extend_double_word",

	"add": "add", "adc": "add_with_carry",
	"adcx": "add_with_carry_flag", "adox": "add_with_overflow_flag",
	"sub": "subtract", "sbb": "subtract_with_borrow",
	"inc": "increment", "dec": "decrement",
	"mul": "multiply", "imul": "signed_multiply",
	"div": "divide", "idiv": "signed_divide",
	"neg": "negate", "cmp": "compare",

	"and": "logical_and", "andn": "logical_and_not",
	"or": "logical_or", "xor": "logical_xor", "not": "logical_not",
	"test": "test",

	"shl": "shift_logical_left", "sal": "shift_arithmetic_left",
	"shr": "shift_logical_right", "sar": "shift_arithmetic_right",
	"rol": "rotate_left", "ror": "rotate_right",
	"rcl": "rotate_left_through_carry", "rcr": "rotate_right_through_carry",
	"shld": "shift_left_double", "shrd": "shift_right_double",
	"shlx": "shift_left_without_affecting_flags",
	"sarx": "shift_right_arithmetic_without_affecting_flags",
	"shrx": "shift_right_logical_without_affecting_flags",
	"rorx": "rotate_right_without_affecting_flags",

	"bsf": "bit_scan_forward", "bsr": "bit_scan_reverse",
	"bt": "bit_test", "btc": "bit_test_and_complement",
	"btr": "bit_test_and_reset", "bts": "bit_test_and_set",
	"lzcnt": "count_leading_zeros", "tzcnt": "count_trailing_zeros",
	"popcnt": "population_count",
	"pdep":   "parallel_bits_deposit", "pext": "parallel_bits_extract",
	"bextr": "bit_field_extract", "blsi": "extract_lowest_set_isolated_bit",
	"blsmsk": "get_mask_up_to_lowest_set_bit", "blsr": "reset_lowest_set_bit",
	"bzhi": "zero_high_bits",

	"jmp": "jump",
	"je":  "jump_if_equal", "jz": "jump_if_zero",
	"jne": "jump_if_not_equal", "jnz": "jump_if_not_zero",
	"jg": "jump_if_greater", "jge": "jump_if_greater_or_equal",
	"jl": "jump_if_less", "jle": "jump_if_less_or_equal",
	"ja": "jump_if_above", "jae": "jump_if_above_or_equal",
	"jb": "jump_if_below", "jbe": "jump_if_below_or_equal",
	"jc": "jump_if_carry", "jnc": "jump_if_not_carry",
	"jo": "jump_if_overflow", "jno": "jump_if_not_overflow",
	"js": "jump_if_sign", "jns": "jump_if_not_sign",
	"jp": "jump_if_parity", "jnp": "jump_if_no_parity",
	"jpe": "jump_if_parity_even", "jpo": "jump_if_parity_odd",
	"jnb": "jump_if_not_below", "jnbe": "jump_if_not_below_or_equal",
	"jnl": "jump_if_not_less", "jnle": "jump_if_not_less_or_equal",
	"jna": "jump_if_not_above", "jnae": "jump_if_not_above_or_equal",
	"jng": "jump_if_not_greater", "jnge": "jump_if_not_greater_or_equal",
	"jcxz": "jump_if_cx_zero", "jecxz": "jump_if_ecx_zero", "jrcxz": "jump_if_rcx_zero",
	"call": "call_procedure",
	"ret":  "return_from_procedure", "retn": "return_from_procedure",
	"retf": "return_far",
	"loop": "loop", "loope": "loop_if_equal", "loopz": "loop_if_zero",
	"loopne": "loop_if_not_equal", "loopnz": "loop_if_not_zero",
	"enter": "enter_stack_frame", "leave": "leave_stack_frame",

	"cmove": "move_if_equal", "cmovz": "move_if_zero",
	"cmovne": "move_if_not_equal", "cmovnz": "move_if_not_zero",
	"cmovg": "move_if_greater", "cmovge": "move_if_greater_or_equal",
	"cmovl": "move_if_less", "cmovle": "move_if_less_or_equal",
	"cmova": "move_if_above", "cmovae": "move_if_above_or_equal",
	"cmovb": "move_if_below", "cmovbe": "move_if_below_or_equal",
	"cmovc": "move_if_carry", "cmovnc": "move_if_not_carry",
	"cmovo": "move_if_overflow", "cmovno": "move_if_not_overflow",
	"cmovs": "move_if_sign", "cmovns": "move_if_not_sign",
	"cmovp": "move_if_parity", "cmovnp": "move_if_no_parity",
	"cmovpe": "move_if_parity_even", "cmovpo": "move_if_parity_odd",
	"cmovna": "move_if_not_above", "cmovnae": "move_if_not_above_or_equal",
	"cmovnb": "move_if_not_below", "cmovnbe": "move_if_not_below_or_equal",
	"cmovng": "move_if_not_greater", "cmovnge": "move_if_not_greater_or_equal",
	"cmovnl": "move_if_not_less", "cmovnle": "move_if_not_less_or_equal",

	"sete": "set_if_equal", "setz": "set_if_zero",
	"setne": "set_if_not_equal", "setnz": "set_if_not_zero",
	"setg": "set_if_greater", "setge": "set_if_greater_or_equal",
	"setl": "set_if_less", "setle": "set_if_less_or_equal",
	"seta": "set_if_above", "setae": "set_if_above_or_equal",
	"setb": "set_if_below", "setbe": "set_if_below_or_equal",
	"setc": "set_if_carry", "setnc": "set_if_not_carry",
	"seto": "set_if_overflow", "setno": "set_if_not_overflow",
	"sets": "set_if_sign", "setns": "set_if_not_sign",
	"setp": "set_if_parity", "setnp": "set_if_no_parity",
	"setpe": "set_if_parity_even", "setpo": "set_if_parity_odd",
	"setna": "set_if_not_above", "setnae": "set_if_not_above_or_equal",
	"setnb": "set_if_not_below", "setnbe": "set_if_not_below_or_equal",
	"setng": "set_if_not_greater", "setnge": "set_if_not_greater_or_equal",
	"setnl": "set_if_not_less", "setnle": "set_if_not_less_or_equal",

	"cmpsb": "compare_string_byte", "cmpsw": "compare_string_word",
	"cmpsd": "compare_string_double_word", "cmpsq": "compare_string_quad_word",
	"stosb": "store_string_byte", "stosw": "store_string_word",
	"stosd": "store_string_double_word", "stosq": "store_string_quad_word",
	"lodsb": "load_string_byte", "lodsw": "load_string_word",
	"lodsd": "load_string_double_word", "lodsq": "load_string_quad_word",
	"scasb": "scan_string_byte", "scasw": "scan_string_word",
	"scasd": "scan_string_double_word", "scasq": "scan_string_quad_word",

	"clc": "clear_carry_flag", "stc": "set_carry_flag",
	"cld": "clear_direction_flag", "std": "set_direction_flag",
	"cli": "clear_interrupt_flag", "sti": "set_interrupt_flag",
	"clac": "clear_ac_flag", "stac": "set_ac_flag",
	"cmc":  "complement_carry_flag",
	"lahf": "load_flags_into_accumulator_8_high", "sahf": "store_accumulator_8_high_into_flags",

	"cbw": "convert_byte_to_word", "cwde": "convert_word_to_double_word",
	"cdqe": "convert_double_word_to_quad_word",
	"cwd":  "convert_word_to_double_word_pair", "cdq": "convert_double_word_to_quad_word_pair",
	"cqo": "convert_quad_word_to_octa_word_pair",

	"syscall":  "syscall_invoke",
	"sysenter": "system_enter", "sysexit": "system_exit", "sysret": "system_return",
	"int": "interrupt", "int3": "interrupt_3", "int1": "interrupt_1",
	"into": "interrupt_on_overflow",
	"iret": "return_from_interrupt", "iretd": "return_from_interrupt_double_word",
	"iretq": "return_from_interrupt_quad_word",
	"hlt":   "halt", "nop": "no_operation", "pause": "pause",
	"cpuid": "cpu_identification", "ud2": "undefined_instruction",
	"lock":  "lock_bus",
	"rdtsc": "read_time_stamp_counter", "rdtscp": "read_time_stamp_counter_and_processor_id",
	"rdmsr": "read_model_specific_register", "wrmsr": "write_model_specific_register",
	"rdpmc":  "read_performance_counter",
	"rdrand": "read_random_value", "rdseed": "read_seed_value",

	"fld": "fpu_load", "fst": "fpu_store", "fstp": "fpu_store_and_pop",
	"fld1": "fpu_load_one", "fldz": "fpu_load_zero", "fldpi": "fpu_load_pi",
	"fadd": "fpu_add", "faddp": "fpu_add_and_pop",
	"fsub": "fpu_subtract", "fsubp": "fpu_subtract_and_pop",
	"fmul": "fpu_multiply", "fmulp": "fpu_multiply_and_pop",
	"fdiv": "fpu_divide", "fdivp": "fpu_divide_and_pop",
	"fsqrt": "fpu_square_root", "fsin": "fpu_sine", "fcos": "fpu_cosine",
	"fabs": "fpu_absolute_value", "fchs": "fpu_change_sign",
	"fxch": "fpu_exchange", "fcom": "fpu_compare", "fcomp": "fpu_compare_and_pop",
	"finit": "fpu_initialize", "fwait": "fpu_wait", "fnop": "fpu_no_operation",
	"emms": "mmx_empty_state",
}

// sizedIns lists mnemonics that have _byte/_word/_dword/_qword macro forms.
var sizedIns = map[string]bool{
	"mov": true, "cmp": true, "add": true, "sub": true, "inc": true, "dec": true,
	"neg": true, "and": true, "or": true, "xor": true, "not": true,
	"shl": true, "sal": true, "shr": true, "sar": true,
	"rol": true, "ror": true, "rcl": true, "rcr": true,
	"mul": true, "imul": true, "div": true, "idiv": true,
	"adc": true, "sbb": true,
}

var sizeSuffix = map[string]string{
	"byte": "_byte", "word": "_word", "dword": "_double_word", "qword": "_quad_word",
}

// implicitOperand mnemonics carry memory operands that the readable macros
// do not take. The readable form drops those operands.
var implicitOperand = map[string]bool{
	"movsb": true, "movsw": true, "movsd": true, "movsq": true,
	"cmpsb": true, "cmpsw": true, "cmpsd": true, "cmpsq": true,
	"stosb": true, "stosw": true, "stosd": true, "stosq": true,
	"lodsb": true, "lodsw": true, "lodsd": true, "lodsq": true,
	"scasb": true, "scasw": true, "scasd": true, "scasq": true,
	"insb": true, "insw": true, "insd": true,
	"outsb": true, "outsw": true, "outsd": true,
	"xlat": true, "xlatb": true,
}
