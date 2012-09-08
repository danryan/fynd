require 'etc'

module Fynd::Tests
  # Numeric arguments can be specified as
  # 
  # +n     for greater than n,
  # 
  # -n     for less than n,
  # 
  # n      for exactly n.
  
  # File was last accessed n minutes ago.
  def amin(n)
  end

  # File was last accessed more recently than file was modified. If
  # file is a symbolic link and the -H option or the -L option is in
  # effect, the access time of the file it points to is always used.
  def anewer(other)
    files.select! do |file|
      File.stat(file).atime > File.stat(other).atime
    end
  end

  # File was last accessed n*24 hours ago. When find figures out
  # how many 24-hour periods ago the file was last accessed, any
  # fractional part is ignored, so to match -atime +1, a file has to
  # have been accessed at least two days ago.
  def atime(n)
    match = n.match(/([-+]?)(\d+)/)
    comparer, interval = match[1], match[2].to_i
    time = Time.now    
    
    files.select! do |file|
      atime = File.stat(file).atime
      
      case comparer
      when '+'
        # more than n days ago
        atime < time - interval.days
      when '-'
        # less than n days ago
        atime > time - interval.days
      when ''
        # exactly n days ago
        atime <= time - (interval - 1).days && atime >= time - interval.days
      else
        raise ArgumentError, "argument must be n, +n, or -n"
      end    
    end
  end

  # File's status was last changed n minutes ago.
  def cmin(n)
  end

  # File's status was last changed more recently than file was modi-
  # fied. If file is a symbolic link and the -H option or the -L
  # option is in effect, the status-change time of the file it
  # points to is always used.
  def cnewer(other)
    files.select! do |file|
      File.stat(file).ctime > File.stat(other).ctime
    end
  end

  # File's status was last changed n*24 hours ago. See the comments
  # for -atime to understand how rounding affects the interpretation
  # of file status change times.
  def ctime(n)
  end

  # File is empty and is either a regular file or a directory.
  def empty
    files.select! do |file|
      File.stat(file).zero?
    end
  end

  alias :empty? :empty

  # Always false.
  def false
    # false
  end

  alias :false? :false

  # File's numeric group ID is n.
  def gid(n)
    files.select! do |file|
      File.stat(file).gid == n.to_i
    end
  end

  # File belongs to group gname (numeric group ID allowed).
  def group(name)
    files.select! do |file|
      gid = File.stat(file).gid
      Etc.getgrgid(gid).name == name
    end
  end

  # Like -lname, but the match is case insensitive.  If the -L
  # option or the -follow option is in effect, this test returns
  # false unless the symbolic link is broken.
  def ilname(pattern)
  end

  # Like -name, but the match is case insensitive. For example, the
  # patterns 'fo*' and 'F??' match the file names 'Foo', 'FOO',
  # 'foo', 'fOo', etc.  In these patterns, unlike filename expan-
  # sion by the shell, an initial '.' can be matched by '*'. That
  # is, find -name *bar will match the file '.foobar'.  Please note
  # that you should quote patterns as a matter of course, otherwise
  # the shell will expand any wildcard characters in them.
  def iname(pattern)
    files.select! do |file|
      file =~ /#{pattern}/i
    end
  end

  # File has inode number n. It is normally easier to use the
  # -samefile test instead.
  def inum(n)
    files.select! do |file|
      File.stat(file).ino == n.to_i
    end
  end

  # Like -regex, but the match is case insensitive.
  def iregex(pattern)
  end

  # Like -wholename, but the match is case insensitive.
  def iwholename(pattern)
  end

  # File has n links.
  def links(n)
  end

  # File is a symbolic link whose contents match shell pattern pat-
  # tern. The metacharacters do not treat '/' or '.' specially. If
  # the -L option or the -follow option is in effect, this test
  # returns false unless the symbolic link is broken.
  def lname(pattern)
  end

  # File's data was last modified n minutes ago.
  def mmin(n)
  end

  # File's data was last modified n*24 hours ago. See the comments
  # for -atime to understand how rounding affects the interpretation
  # of file modification times.
  def mtime(n)
  end

  # Base of file name (the path with the leading directories
  # removed) matches shell pattern pattern.  The metacharacters
  # ('*', '?', and '[]') match a '.' at the start of the base name
  # (this is a change in findutils-4.2.2; see section STANDARDS CON-
  # FORMANCE below). To ignore a directory and the files under it,
  # use -prune; see an example in the description of -wholename.
  # Braces are not recognised as being special, despite the fact
  # that some shells including Bash imbue braces with a special
  # meaning in shell patterns. The filename matching is performed
  # with the use of the fnmatch(3) library function.  Don't forget
  # to enclose the pattern in quotes in order to protect it from
  # expansion by the shell.
  def name(pattern)
    files.select! do |file|
      file =~ /#{pattern}/
    end
  end

  # File was modified more recently than file. If file is a sym-
  # bolic link and the -H option or the -L option is in effect, the
  # modification time of the file it points to is always used.
  def newer(other)
  end

  # No user corresponds to file's numeric user ID.
  def nouser
    files.select! do |file|
      uid = File.stat(file).uid
      begin
        Etc.getpwuid(uid)
        false
      rescue ArgumentError => e
        true
      end
    end
  end

  # No group corresponds to file's numeric group ID.
  def nogroup
    files.select! do |file|
      gid = File.stat(file).gid
      begin
        Etc.getgrgid(gid)
        false
      rescue ArgumentError => e
        true
      end
    end
  end

  # See -wholename. The predicate -path is also supported by HP-UX find.
  def path(pattern)
  end

  # -perm mode
  #
  # File's permission bits are exactly mode (octal or symbolic).
  # Since an exact match is required, if you want to use this form
  # for symbolic modes, you may have to specify a rather complex
  # mode string. For example '-perm g=w' will only match files
  # which have mode 0020 (that is, ones for which group write per-
  # mission is the only permission set). It is more likely that you
  # will want to use the '/' or '-' forms, for example '-perm -g=w',
  # which matches any file with group write permission.  See the
  # EXAMPLES section for some illustrative examples.
  #
  # -perm -mode
  #
  # All of the permission bits mode are set for the file. Symbolic
  # modes are accepted in this form, and this is usually the way in
  # which would want to use them. You must specify 'u', 'g' or 'o'
  # if you use a symbolic mode.  See the EXAMPLES section for some
  # illustrative examples.
  # 
  # -perm /mode
  #
  # Any of the permission bits mode are set for the file. Symbolic
  # modes are accepted in this form. You must specify 'u', 'g' or
  # 'o' if you use a symbolic mode. See the EXAMPLES section for
  # some illustrative examples. If no permission bits in mode are
  # set, this test currently matches no files. However, it will
  # soon be changed to match any file (the idea is to be more con-
  # sistent with the behaviour of perm -000).
  def perm(mode)
  end

  # File name matches regular expression pattern. This is a match
  # on the whole path, not a search. For example, to match a file
  # named './fubar3', you can use the regular expression '.*bar.' or
  # '.*b.*3', but not 'f.*r3'. The regular expressions understood
  # by find are by default Emacs Regular Expressions, but this can
  # be changed with the -regextype option.
  def regex(pattern)
  end

  # File refers to the same inode as name.  When -L is in effect,
  # this can include symbolic links.
  def samefile(other)
  end

  # File uses n units of space. The following suffixes can be used:
  # 
  # 'b'  for 512-byte blocks (this is the default if no suffix is
  #    used)
  # 
  # 'c'  for bytes
  # 
  # 'w'  for two-byte words
  # 
  # 'k'  for Kilobytes (units of 1024 bytes)
  # 
  # 'M'  for Megabytes (units of 1048576 bytes)
  # 
  # 'G'  for Gigabytes (units of 1073741824 bytes)
  # 
  # The size  does not count indirect blocks, but it does count
  # blocks in sparse files that are not actually allocated. Bear in
  # mind that the '%k' and '%b' format specifiers of -printf handle
  # sparse files differently.  The  'b' suffix always  denotes
  # 512-byte blocks and never 1 Kilobyte blocks, which is different
  # to the behaviour of -ls.
  def size(n)
  end

  # Always true.
  def true
  end

  # File is of type c:
  # 
  # b   block (buffered) special
  # c   character (unbuffered) special
  # d   directory
  # p   named pipe (FIFO)
  # f   regular file
  # l   symbolic link; this is never true if the -L option or the
  #     -follow option is in effect, unless the symbolic link is
  #     broken. If you want to search for symbolic links when -L
  #     is in effect, use -xtype.
  # s   socket
  # D   door (Solaris)
  def type(c)
    files.select! do |file|
      case c.to_s
      when 'f', 'file'
        File.stat(file).file?
      when 'd', 'dir', 'directory'
        File.stat(file).directory?
      else
        false
      end
    end
  end

  # File's numeric user ID is n.
  def uid(n)
    files.select! do |file|
      File.stat(file).uid == n.to_i
    end
  end

  # File was last accessed n days after its status was last changed.
  def used(n)
  end

  # File is owned by user uname (numeric user ID allowed).
  def user(name)
    files.select! do |file|
      uid = File.stat(file).uid.to_i
      Etc.getpwuid(uid).name == name
    end
  end

  # File name matches shell pattern pattern. The metacharacters do
  # not treat '/' or '.' specially; so, for example,
  #   
  #   find . -wholename './sr*sc'
  #
  # will print an entry for a directory called './src/misc' (if one
  # exists). To ignore a whole directory tree, use -prune rather
  # than checking every file in the tree. For example, to skip the
  # directory 'src/emacs' and all files and directories under it,
  # and print the names of the other files found, do something like
  # this:
  # 
  #   find . -wholename './src/emacs' -prune -o -print
  #
  def wholename(pattern)
  end

  # The same as -type unless the file is a symbolic link. For sym-
  # bolic links: if the -H or -P option was specified, true if the
  # file is a link to a file of type c; if the -L option has been
  # given, true if c is 'l'. In other words, for symbolic links,
  # -xtype checks the type of the file that -type does not check.
  def xtype(c)
  end
end