pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__geo_tests.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__geo_tests.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E069 : Short_Integer; pragma Import (Ada, E069, "system__os_lib_E");
   E016 : Short_Integer; pragma Import (Ada, E016, "ada__exceptions_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "system__soft_links_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__exception_table_E");
   E035 : Short_Integer; pragma Import (Ada, E035, "ada__containers_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__io_exceptions_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "ada__numerics_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "ada__strings_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings__maps_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__strings__maps__constants_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "interfaces__c_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exceptions_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__object_reader_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__dwarf_lines_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "system__soft_links__initialize_E");
   E034 : Short_Integer; pragma Import (Ada, E034, "system__traceback__symbolic_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__strings__utf_encoding_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "ada__tags_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__strings__text_buffers_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "ada__streams_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "system__file_control_block_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "system__finalization_root_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "ada__finalization_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "system__file_io_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "ada__text_io_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "geo_mag_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "geo_mag__common_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "geo_mag__convertions_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "geo_mag__data__initialization_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "geo_mag__magnetic_model_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "geo_mag__math_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E117 := E117 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__file_io__finalize_body");
      begin
         E127 := E127 - 1;
         F2;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Exception_Tracebacks_Symbolic : Integer;
      pragma Import (C, Exception_Tracebacks_Symbolic, "__gl_exception_tracebacks_symbolic");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := '8';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Exception_Tracebacks_Symbolic := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E010 := E010 + 1;
      Ada.Containers'Elab_Spec;
      E035 := E035 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E064 := E064 + 1;
      Ada.Numerics'Elab_Spec;
      E025 := E025 + 1;
      Ada.Strings'Elab_Spec;
      E007 := E007 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E053 := E053 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E056 := E056 + 1;
      Interfaces.C'Elab_Spec;
      E040 := E040 + 1;
      System.Exceptions'Elab_Spec;
      E019 := E019 + 1;
      System.Object_Reader'Elab_Spec;
      E080 := E080 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E047 := E047 + 1;
      System.Os_Lib'Elab_Body;
      E069 := E069 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E099 := E099 + 1;
      E012 := E012 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E034 := E034 + 1;
      E016 := E016 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E103 := E103 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E111 := E111 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      E006 := E006 + 1;
      Ada.Streams'Elab_Spec;
      E119 := E119 + 1;
      System.File_Control_Block'Elab_Spec;
      E131 := E131 + 1;
      System.Finalization_Root'Elab_Spec;
      E130 := E130 + 1;
      Ada.Finalization'Elab_Spec;
      E128 := E128 + 1;
      System.File_Io'Elab_Body;
      E127 := E127 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E117 := E117 + 1;
      E144 := E144 + 1;
      E146 := E146 + 1;
      E150 := E150 + 1;
      E152 := E152 + 1;
      E195 := E195 + 1;
      E133 := E133 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_geo_tests");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-common.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-data.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-data-egms9615.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-convertions.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-data-initialization.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-magnetic_model.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-magnetic_model-read.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-math.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag-math-compute_alf.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_mag.o
   --   /home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/geo_tests.o
   --   -L/home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/
   --   -L/home/gs/Desktop/mz_1/ORAORA/WMM_lib/geo_tests/obj/development/
   --   -L/home/gs/.local/share/alire/toolchains/gnat_native_14.2.1_06bb3def/lib/gcc/x86_64-pc-linux-gnu/14.2.0/adalib/
   --   -static
   --   -lgnat
   --   -lm
   --   -ldl
--  END Object file/option list   

end ada_main;
