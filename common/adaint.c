// Copyright (C) 2017 Free Software Foundation, Inc.
//
// GNAT is free software;  you can  redistribute it  and/or modify it under
// terms of the  GNU General Public License as published  by the Free Soft-
// ware  Foundation;  either version 3,  or (at your option) any later ver-
// sion.  GNAT is distributed in the hope that it will be useful, but WITH-
// OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE.
//
// As a special exception under Section 7 of GPL version 3, you are granted
// additional permissions described in the GCC Runtime Library Exception,
// version 3.1, as published by the Free Software Foundation.
//
// You should have received a copy of the GNU General Public License and
// a copy of the GCC Runtime Library Exception along with this program;
// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
// <http://www.gnu.org/licenses/>.
//
// The variable __gl_main_priority is initialized to -1
// (System.Tasking.Unspecified_Priority) and will be updated if the main
// program has pragma Priority.

int __gl_main_priority = -1;

int __gl_time_slice_val;

char __gl_wc_encoding;

char __gl_locking_policy;

char __gl_queuing_policy;

char __gl_task_dispatching_policy;

void *__gl_priority_specific_dispatching;

int __gl_num_specific_dispatching;

int __gl_main_cpu;

void *__gl_interrupt_states;

int __gl_num_interrupt_states;

int __gl_unreserve_all_interrupts;

int __gl_detect_blocking;

int __gl_default_stack_size;

int __gl_default_ss_size;

int __gl_leap_seconds_support;

void __gnat_runtime_initialize(int install_handler)
{
}

void __gnat_runtime_finalize(int install_handler)
{
}
