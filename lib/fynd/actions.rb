module Fynd::Actions
  # Delete files; true if removal succeeded.  If the removal failed,
  # an error message is issued.  Use of  this  action  automatically
  # turns on the '-depth' option.
  def delete
  end

  # Execute  command;  true  if 0 status is returned.  All following
  # arguments to find are taken to be arguments to the command until
  # an  argument  consisting of ';' is encountered.  The string '{}'
  # is replaced by the current file name being processed  everywhere
  # it occurs in the arguments to the command, not just in arguments
  # where it is alone, as in some versions of find.  Both  of  these
  # constructions might need to be escaped (with a '\') or quoted to
  # protect them from expansion by the shell.  See the EXAMPLES sec-
  # tion  for examples of the use of the '-exec' option.  The speci-
  # fied command is run once for each matched file.  The command  is
  # executed  in  the  starting  directory.  There are unavoidable
  # security problems surrounding  use  of  the  -exec  option;  you
  # should use the -execdir option instead.
  #
  # -exec command {} +
  #
  # This  variant  of the -exec option runs the specified command on
  # the selected files, but the command line is built  by  appending
  # each  selected file name at the end; the total number of invoca-
  # tions of the command will  be  much  less  than  the  number  of
  # matched  files. The command line is built in much the same way
  # that xargs builds its command lines.  Only one instance of  '{}'
  # is  allowed  within the command.  The command is executed in the
  # starting directory.
  def exec(command)
  end

  # Like -exec, but the specified command is run from the  subdirec-
  # tory  containing  the  matched  file,  which is not normally the
  # directory in which you started find.  This a  much  more  secure
  # method  for invoking commands, as it avoids race conditions dur-
  # ing resolution of the paths to the matched files.  As  with  the
  # -exec option, the '+' form of -execdir will build a command line
  # to process more than one matched file, but any given  invocation
  # of command will only list files that exist in the same subdirec-
  # tory.  If you use this option, you must ensure that  your  $PATH
  # environment  variable  does not reference the current directory;
  # otherwise, an attacker can run any commands they like by leaving
  # an appropriately-named file in a directory in which you will run
  # -execdir.
  def execdir(command)
  end

  # True; like -ls but write to file like -fprint.  The output  file
  # is  always created, even if the predicate is never matched.  See
  # the UNUSUAL FILENAMES section for information about how  unusual
  # characters in filenames are handled.
  def fls(file)
  end

  # True; print the full file name into file file.  If file does not
  # exist when find is run, it is created; if it does exist,  it  is
  # truncated.   The  file names ''/dev/stdout'' and ''/dev/stderr''
  # are handled specially; they refer to  the  standard  output  and
  # standard  error output, respectively.  The output file is always
  # created, even if  the  predicate  is  never  matched.   See  the
  # UNUSUAL  FILENAMES  section  for  information  about how unusual
  # characters in filenames are handled.
  def fprint(file)
  end

  # True; like -print0 but write to file like -fprint.   The  output
  # file  is always created, even if the predicate is never matched.
  # See the UNUSUAL FILENAMES  section  for  information  about  how
  # unusual characters in filenames are handled.
  def fprint0(file)
  end

  # True;  like  -printf but write to file like -fprint.  The output
  # file is always created, even if the predicate is never  matched.
  # See  the  UNUSUAL  FILENAMES  section  for information about how
  # unusual characters in filenames are handled.
  def fprintf(file, format)
  end

  # Like -exec but ask the user first (on the  standard  input);  if
  # the response does not start with 'y' or 'Y', do not run the com-
  # mand, and return false.  If the command  is  run,  its  standard
  # input is redirected from /dev/null.
  def ok(command)
  end

  # Like -execdir but ask the user first (on the standard input); if
  # the response does not start with 'y' or 'Y', do not run the com-
  # mand,  and  return  false.   If the command is run, its standard
  # input is redirected from /dev/null.
  def okdir(command)
  end

  # Print the full file name on the standard output, followed
  # by a newline.   If you  are  piping  the  output  of  find  into
  # another  program  and there is the faintest possibility that the
  # files which you are searching for might contain a newline,  then
  # you should seriously consider using the '-print0' option instead
  # of '-print'.  See the UNUSUAL FILENAMES section for  information
  # about how unusual characters in filenames are handled.
  def print

  end

  # Print the full file name on the standard output,  followed
  # by  a  null  character  (instead  of  the newline character that
  # '-print' uses).  This allows file names that contain newlines or
  # other  types  of white space to be correctly interpreted by pro-
  # grams that process the find output.  This option corresponds  to
  # the '-0' option of xargs.
  def print0
  end

  # Print  format  on  the  standard output, interpreting '\'
  # escapes and '%' directives.  Field widths and precisions can  be
  # specified  as  with  the  'printf' C function.  Please note that
  # many of the fields are printed as %s rather than  %d,  and  this
  # may  mean  that flags don't work as you might expect.  This also
  # means that the '-' flag does work (it forces fields to be  left-
  # aligned).   Unlike -print, -printf does not add a newline at the
  # end of the string.  The escapes and directives are:
  # 
  # \a     Alarm bell.
  # 
  # \b     Backspace.
  # 
  # \c     Stop printing from this format immediately and flush  the
  #  output.
  # 
  # \f     Form feed.
  # 
  # \n     Newline.
  # 
  # \r     Carriage return.
  # 
  # \t     Horizontal tab.
  # 
  # \v     Vertical tab.
  # 
  # \      ASCII NUL.
  # 
  # \\     A literal backslash ('\').
  # 
  # \NNN   The character whose ASCII code is NNN (octal).
  # 
  # A '\' character followed by any other character is treated as an
  # ordinary character, so they both are printed.
  # 
  # %%     A literal percent sign.
  # 
  # %a     File's last access time in the format returned by  the  C
  #  'ctime' function.
  # 
  # %Ak    File's  last  access  time  in the format specified by k,
  #  which is either '@' or a directive for the  C  'strftime'
  #  function.   The  possible  values for k are listed below;
  #  some of them might not be available on all  systems,  due
  #  to differences in 'strftime' between systems.
  # 
  #   @      seconds since Jan. 1, 1970, 00:00 GMT.
  # 
  #  Time fields:
  # 
  #   H     hour (00..23)
  # 
  #   I     hour (01..12)
  # 
  #   k     hour ( 0..23)
  # 
  #   l     hour ( 1..12)
  # 
  #   M     minute (00..59)
  # 
  #   p     locale's AM or PM
  # 
  #   r     time, 12-hour (hh:mm:ss [AP]M)
  # 
  #   S     second (00..61)
  # 
  #   T     time, 24-hour (hh:mm:ss)
  # 
  #   +     Date  and  time,  separated  by  '+', for example
  #         '2004-04-28+22:22:05'.  The time is given in  the
  #         current  timezone  (which may be affected by set-
  #         ting the TZ environment variable).  This is a GNU
  #         extension.
  # 
  #   X     locale's time representation (H:M:S)
  # 
  #   Z     time zone (e.g., EDT), or nothing if no time zone
  #         is determinable
  # 
  #  Date fields:
  # 
  #   a     locale's abbreviated weekday name (Sun..Sat)
  # 
  #   A     locale's full weekday name, variable length (Sun-
  #         day..Saturday)
  # 
  #   b     locale's abbreviated month name (Jan..Dec)
  # 
  #   B     locale's  full  month name, variable length (Jan-
  #         uary..December)
  # 
  #   c     locale's date and time (Sat Nov 04  12:02:33  EST
  #         1989)
  # 
  #   d     day of month (01..31)
  # 
  #   D     date (mm/dd/yy)
  # 
  #   h     same as b
  # 
  #   j     day of year (001..366)
  # 
  #   m     month (01..12)
  # 
  #   U     week  number  of year with Sunday as first day of
  #         week (00..53)
  # 
  #   w     day of week (0..6)
  # 
  #   W     week number of year with Monday as first  day  of
  #         week (00..53)
  # 
  #   x     locale's date representation (mm/dd/yy)
  # 
  #   y     last two digits of year (00..99)
  # 
  #   Y     year (1970...)
  # 
  # %b    The  amount  of disk space used for this file in 512-byte
  #       blocks. Since disk space is allocated in multiples of the
  #       filesystem  block  size  this  is  usually  greater  than
  #       %s/1024, but it can also be smaller  if  the  file  is  a
  #       sparse file.
  # 
  # %c    File's  last status change time in the format returned by
  #       the C 'ctime' function.
  # 
  # %Ck   File's last status change time in the format specified by
  #       k, which is the same as for %A.
  # 
  # %d    File's depth in the directory tree; 0 means the file is a
  #       command line argument.
  # 
  # %D    The device number on which the file  exists  (the  st_dev
  #       field of struct stat), in decimal.
  # 
  # %f    File's  name  with  any leading directories removed (only
  #       the last element).
  # 
  # %F    Type of the filesystem the file is on; this value can  be
  #       used for -fstype.
  # 
  # %g    File's  group  name, or numeric group ID if the group has
  #       no name.
  # 
  # %G    File's numeric group ID.
  # 
  # %h    Leading directories of file's name (all but the last ele-
  #       ment).  If the file name contains no slashes (since it is
  #       in the current directory) the  %h  specifier  expands  to
  #       ".".
  # 
  # %H    Command line argument under which file was found.
  # 
  # %i    File's inode number (in decimal).
  # 
  # %k    The amount of disk space used for this file in 1K blocks.
  #       Since  disk  space  is  allocated  in  multiples  of  the
  #       filesystem  block  size  this  is  usually  greater  than
  #       %s/1024, but it can also be smaller  if  the  file  is  a
  #       sparse file.
  # 
  # %l    Object  of  symbolic  link (empty string if file is not a
  #       symbolic link).
  # 
  # %m    File's permission bits (in octal).  This option uses  the
  #       'traditional'  numbers  which  most  Unix implementations
  #       use,  but  if  your  particular  implementation  uses  an
  #       unusual  ordering of octal permissions bits, you will see
  #       a difference between the actual value of the file's  mode
  #       and  the output of %m.   Normally you will want to have a
  #       leading zero on this number, and to do this,  you  should
  #       use the # flag (as in, for example, '%#m').
  # 
  # %M    File's  permissions  (in symbolic form, as for ls).  This
  #       directive is supported in findutils 4.2.5 and later.
  # 
  # %n    Number of hard links to file.
  # 
  # %p    File's name.
  # 
  # %P    File's name with the name of the  command  line  argument
  #       under which it was found removed.
  # 
  # %s    File's size in bytes.
  # 
  # %t    File's  last  modification time in the format returned by
  #       the C 'ctime' function.
  # 
  # %Tk   File's last modification time in the format specified  by
  #       k, which is the same as for %A.
  # 
  # %u    File's  user  name, or numeric user ID if the user has no
  #       name.
  # 
  # %U    File's numeric user ID.
  # 
  # %y    File's type (like in ls -l),  U=unknown  type  (shouldn't
  #       happen)
  # 
  # %Y    File's  type  (like  %y),  plus  follow symlinks: L=loop,
  #       N=nonexistent
  # 
  # %Z    (SELinux only) file's security context.
  # 
  # A '%' character followed by any  other  character  is  discarded
  # (but the other character is printed).
  # 
  # The  %m and %d directives support the # , 0 and + flags, but the
  # other directives do not, even if they  print  numbers.   Numeric
  # directives that do not support these flags include G, U, b, D, k
  # and n.  The '-' format flag is supported and changes the  align-
  # ment  of  a field from right-justified (which is the default) to
  # left-justified.
  # 
  # See the UNUSUAL FILENAMES  section  for  information  about  how
  # unusual characters in filenames are handled.
  def printf(format)
  end
end
