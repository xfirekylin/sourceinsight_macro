macro InsertProjectName()
{//get project name by sourceinsight name ,and remove date (F8_20091223 --->F18)
	hprj = GetCurrentProj()
	name = GetProjName(hprj)
	len = strlen(name)
	i = len
	
	while ("\\"  != name[i]) 
	{
		i=i-1
	}
	name = strmid (name, i+1,len)

	len = strlen(name)
	i = len
	while ("_"  != name[i]) 
	{
		if (i == 1)
		{
			i = 0;
			break;
		}
		i = i-1
	}

	
	if (i > 0)
	{
		last_str = strmid(name, i+1, len)
		
		if (IsNumber(last_str))
		name = strmid (name, 0,i)
	}

	return name

}

macro GetUserID()
{
    szMyName = getreg(MYNAME)
    if(strlen( szMyName ) == 0)
    {
        szMyName = Ask("Please Enter your name:")
        setreg(MYNAME, szMyName)
    }

	return szMyName
}

macro SetUserName()
{
    szMyName = Ask("请输入你的名字:")
    setreg(MYNAME, szMyName)
}

macro GetSetMacro()
{
    set_macro_index = getreg(SETMACRO_INDEX)
    if(strlen( set_macro_index ) == 0)
    {
	    set_macro_index = 0;
        setreg(SETMACRO_INDEX, set_macro_index)
    }

	if (0 == set_macro_index)
	{
	    set_macro = getreg(SETMACRO)
	    if(strlen( set_macro ) == 0)
	    {
	        set_macro = Ask("Please Enter the Macro name:")
	        setreg(SETMACRO, set_macro)
	    }

		return set_macro
	}
	else if (1 == set_macro_index)
	{
	    set_macro = getreg(SETMACRO1)
	    if(strlen( set_macro ) == 0)
	    {
	        set_macro = Ask("Please Enter the Macro1 name:")
	        setreg(SETMACRO1, set_macro)
	    }

		return set_macro
	}
	else if (2 == set_macro_index)
	{
	    set_macro = getreg(SETMACRO2)
	    if(strlen( set_macro ) == 0)
	    {
	        set_macro = Ask("Please Enter the Macro2 name:")
	        setreg(SETMACRO2, set_macro)
	    }

		return set_macro
	}
}

macro SetTheMacroIndex()
{
    set_macro_index = getreg(SETMACRO_INDEX)

    if(strlen( set_macro_index ) == 0)
    {
    	set_macro_index = 0
        setreg(SETMACRO_INDEX, set_macro_index)
        return 
    }

	if (set_macro_index  == 2)
	{
		set_macro_index = 0;
	}
	else
	{
		set_macro_index = set_macro_index + 1;
	}
	
    setreg(SETMACRO_INDEX, set_macro_index)

    set_macro_index = cat(set_macro_index,": ")
    set_macro_index = cat(set_macro_index,GetSetMacro())
    
	msg(set_macro_index)
}

macro GetSetMacroSingle()
{
    set_macro_index = getreg(SETMACRO_S_INDEX)
    if(strlen( set_macro_index ) == 0)
    {
	    set_macro_index = 0;
        setreg(SETMACRO_S_INDEX, set_macro_index)
    }

	if (0 == set_macro_index)
	{
		return "|| "
	}
	else if (1 == set_macro_index)
	{
			return "|| !"
	}
	else if (2 == set_macro_index)
	{
		return "&& "
	}
	else if (3 == set_macro_index)
	{
		return "&& !"
	}
}
macro SetTheMacroSingalIndex()
{
    set_macro_index = getreg(SETMACRO_S_INDEX)

    if(strlen( set_macro_index ) == 0)
    {
    	set_macro_index = 0
        setreg(SETMACRO_S_INDEX, set_macro_index)
        return 
    }

	if (set_macro_index  == 3)
	{
		set_macro_index = 0;
	}
	else
	{
		set_macro_index = set_macro_index + 1;
	}
	
    setreg(SETMACRO_S_INDEX, set_macro_index)

	if (set_macro_index  == 0)
	{
	    set_macro_index = cat(set_macro_index,":|| ")
	}
	else if (1 == set_macro_index)
	{
	    set_macro_index = cat(set_macro_index,":|| !")
	}	
	else if (2 == set_macro_index)
	{
	    set_macro_index = cat(set_macro_index,":&& ")
	}
	else if (3 == set_macro_index)
	{
	    set_macro_index = cat(set_macro_index,":&& !")
	}
    
	msg(set_macro_index)
}
macro SetTheMacro()
{
    set_macro = Ask("Please Enter the Macro name:")
    setreg(SETMACRO, set_macro)
}

 
macro SetTheMacroBySelectText()
{
    set_macro_index = getreg(SETMACRO_INDEX)

    set_macro = GetBufSelText(GetCurrentBuf())

    if(strlen( set_macro_index ) == 0)
    {
	    set_macro_index = 0;
        setreg(SETMACRO_INDEX, set_macro_index)
    }

	if (0 == set_macro_index)
	{
        setreg(SETMACRO, set_macro)
	}
	else if (1 == set_macro_index)
	{
        setreg(SETMACRO1, set_macro)
	}
	else if (2 == set_macro_index)
	{
	    setreg(SETMACRO2, set_macro)
	}
}

macro GetFileTypeFlag()
{//get comment type
	hbuf = GetCurrentBuf()
	filename=GetBufName(hbuf) 
	len = strlen(filename)
	i = len

	while ("\\"  != filename[i]) 
	{
		i=i-1
	}
	filename = strmid (filename, i+1,len)
	len = strlen(filename)
	i = len

	if (len > 8)
	{
		temp = strmid(filename,0,4)
		if (temp == "scat")
		return ";"
	}
	

	while ("."  != filename[i]) 
	{
		i=i-1

		if (0 == i)
		{
			if (filename == Makefile)
			{
				return "#"
			}
			return ""
		}
	}
	
	filename_a = strmid (filename, 0,i)
	//msg (filename_a)
	if (filename_a == Makefile)
	{
		return "#"
	}

	if (filename == "bat")
	return "rem "

	
	filename = strmid (filename, i+1,len)

	if (filename == "mk" || filename == "mak" || filename == "pl" || filename == "bld")
	return "#"

	if (filename == "bat")
	return "rem "
	
}

macro GetFileType()
{//get comment type
	hbuf = GetCurrentBuf()
	filename=GetBufName(hbuf) 
	len = strlen(filename)
	i = len

	while ("\\"  != filename[i]) 
	{
		i=i-1
	}
	filename = strmid (filename, i+1,len)
	len = strlen(filename)
	i = len

	if (len > 8)
	{
		temp = strmid(filename,0,4)
		if (temp == "scat")
		return "scat"
	}
	

	while ("."  != filename[i]) 
	{
		i=i-1

		if (0 == i)
		{
			if (filename == Makefile)
			{
				return "mak"
			}
			return ""
		}
	}
	
	filename_a = strmid (filename, 0,i)
	//msg (filename_a)
	if (filename_a == Makefile)
	{
		return "mak"
	}

	if (filename == "bat")
	return "bat"

	
	filename = strmid (filename, i+1,len)

	if (filename == "mk" || filename == "mak")
	return "mak"

	if(filename == "pl" || filename == "bld")
	return "perl"

	if(filename == "bld")
	return "bld"

	if (filename == "bat")
	return "rem "
}
macro CommentLine()
{
	hbuf = GetCurrentBuf()
	szFunc = GetCurSymbol()
	ln = GetBufLnCur(hbuf)
	fLocalTime = GetSysTime(1)
	sz = "/*----"
	sz = cat(sz, fLocalTime.Year)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Month)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Day)
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, "----*/")
	InsBufLine(hbuf, ln, sz)
	sz1 = "// Reason-"
	sz1 = cat(sz1, GetUserID())
	sz1 = cat(sz1, " : ")	
	sz1 = cat(sz1, Ask("Input Comment"))
	InsBufLine(hbuf, ln+1, sz1)

}

macro CommentBlock()
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
    hbuf = GetCurrentBuf()
    lnMax = GetBufLineCount(hbuf)
    if(lnMax != 0)
    {
        szLine = GetBufLine( hbuf, lnFirst )    
    }
    nLeft = GetLeftBlank(szLine)
    if (nLeft > 4)
    {
    	nLeft = nLeft - 4;
    }
    szLeft = strmid(szLine,0,nLeft);
	 
	hbuf = GetCurrentBuf()
	szFunc = GetCurSymbol()
	ln = GetBufLnCur(hbuf)
	fLocalTime = GetSysTime(1)
	sz = GetFileTypeFlag()
	sz = cat(sz,"@szLeft@/*---")
	sz = cat(sz, fLocalTime.Year)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Month)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Day)
	sz = cat(sz, "   ")
	if (fLocalTime.Hour < 10)
	sz = cat(sz, "0")
  	sz = cat(sz, fLocalTime.Hour)
	sz = cat(sz, ":")
	if (fLocalTime.Minute < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Minute)
	sz = cat(sz, ":")
	if (fLocalTime.Second < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Second)	
	sz = cat(sz, "---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " Begin---")
	sz = cat(sz, GetUserID())
	sz = cat(sz, "---Reason")
	sz = cat(sz, " : ")	
	sz = cat(sz, Ask("Input Comment"))
	sz = cat(sz, "---*/")	
	InsBufLine(hbuf, ln, sz)
	sz = GetFileTypeFlag()
	sz = cat(sz,"@szLeft@/*---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " End ----*/")
	InsBufLine(hbuf, lnLast+2, sz)
}

macro BlockErase()
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
    hbuf = GetCurrentBuf()
    lnMax = GetBufLineCount(hbuf)
    if(lnMax != 0)
    {
        szLine = GetBufLine( hbuf, lnFirst )    
    }
    nLeft = GetLeftBlank(szLine)
    if (nLeft > 4)
    {
    	nLeft = nLeft - 4;
    }
    szLeft = strmid(szLine,0,nLeft);
	 
	hbuf = GetCurrentBuf()
	szFunc = GetCurSymbol()
	ln = GetBufLnCur(hbuf)
	fLocalTime = GetSysTime(1)
	sz = GetFileTypeFlag()
	sz = cat(sz,"@szLeft@/*---")
	sz = cat(sz, fLocalTime.Year)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Month)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Day)
	sz = cat(sz, "   ")
	if (fLocalTime.Hour < 10)
	sz = cat(sz, "0")
  	sz = cat(sz, fLocalTime.Hour)
	sz = cat(sz, ":")
	if (fLocalTime.Minute < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Minute)
	sz = cat(sz, ":")
	if (fLocalTime.Second < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Second)	
	sz = cat(sz, "---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " Begin---")
	sz = cat(sz, GetUserID())
	sz = cat(sz, "---Reason")
	sz = cat(sz, " : ")	
	sz = cat(sz, Ask("Input Comment"))
	sz = cat(sz, "---*/")	
	InsBufLine(hbuf, ln, sz)

	sz = "@szLeft@#if 0"
	InsBufLine(hbuf, ln+1, sz)

	sz = "@szLeft@#endif"
	InsBufLine(hbuf, lnLast+3, sz)
	
	sz = GetFileTypeFlag()
	sz = cat(sz,"@szLeft@/*---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " End ----*/")
	InsBufLine(hbuf, lnLast+4, sz)
}

macro EraseBlock()
{
	InsertTopBottomStr("#if 0" "#endif")
}

macro EraseBlock2()
{
	InsertTopBottomStr("/*" "*/")
}

macro InsertMacroWin32()
{
	IfdefStr("WIN32")
}

macro InsertMacroNWin32()
{
	IfndefStr("WIN32")
}

macro InsertTheSetMacro()
{
	if (GetFileType() == "mak")
	{
		InsertMakMacro()
	}
	else
	{
		IfdefStrExt(GetSetMacro(),GetSetMacroSingle())
	}
}

macro InsertTheSetMacroElse()
{
	if (GetFileType() == "mak")
	{
		InsertMakNMacro()
	}
	else
	{
		IfdefelseStr(GetSetMacro())
    }
}

macro InsertTheSetMacroElseIf()
{
	ElseIfdefStr(GetSetMacro())
}

macro InsertTheSetNMacro()
{
	IfndefStr(GetSetMacro())
}
macro InsertTheSetMkMacro()
{
	sz = "ifeq ($(strip $("
	sz = cat(sz, GetSetMacro())
	sz = cat(sz, ")), TRUE)")
	
	InsertTopBottomStr(sz, "endif")
}

macro InsertTempMacro()
{
	IfdefStr("__KP_MMI_TST_MACRO_1__")
}

macro InsertIncludeMacro()
{
    hbufClip = GetBufHandle("Clipboard")
    sz = "#include \""
    
    sz = cat(sz,GetBufLine(hbufClip,0))

	sz = cat(sz,"\"")

	InsertLineStr(sz)
}

macro InsertMakMacro()
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
	 
	hbuf = GetCurrentBuf()
	ln = GetBufLnCur(hbuf)

    hbufClip = GetBufHandle("Clipboard")
    sz = "ifeq ($(strip $("
    sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,")), TRUE)")

	InsBufLine(hbuf, ln, sz)

	sz = "    COM_DEFS += __"
	sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,"__")

	InsBufLine(hbuf, ln+1, sz)

	sz = "endif"

	InsBufLine(hbuf, ln+2, sz)

}

macro InsertMakNMacro()
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
	 
	hbuf = GetCurrentBuf()
	ln = GetBufLnCur(hbuf)

    hbufClip = GetBufHandle("Clipboard")
    sz = "ifdef "
    sz = cat(sz,GetBufLine(hbufClip,0))
	InsBufLine(hbuf, ln, sz)

    sz = "ifneq ($(strip $("
    sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,")),NONE)")
	InsBufLine(hbuf, ln+1, sz)

    sz = "ifneq ($(strip $("
    sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,")),FALSE)")
	InsBufLine(hbuf, ln+2, sz)
	
	sz = "    COM_DEFS += __"
	sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,"_$(strip $(")
	sz = cat(sz,GetBufLine(hbufClip,0))
	sz = cat(sz,"))__")

	InsBufLine(hbuf, ln+3, sz)

	sz = "endif"
	InsBufLine(hbuf, ln+4, sz)
	InsBufLine(hbuf, ln+5, sz)
	InsBufLine(hbuf, ln+6, sz)
}

macro MTKTARGET()
{
	hwnd = GetCurrentWnd()
	lnFirst = GetWndSelLnFirst(hwnd)
	lnLast = GetWndSelLnLast(hwnd)
	 
	hbuf = GetCurrentBuf()
	szFunc = GetCurSymbol()
	ln = GetBufLnCur(hbuf)
	fLocalTime = GetSysTime(1)
	sz = GetFileTypeFlag()
	sz = cat(sz,"/*---")
	sz = cat(sz, fLocalTime.Year)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Month)
	sz = cat(sz, "-")
	sz = cat(sz, fLocalTime.Day)
	sz = cat(sz, "   ")
	if (fLocalTime.Hour < 10)
	sz = cat(sz, "0")
  	sz = cat(sz, fLocalTime.Hour)
	sz = cat(sz, ":")
	if (fLocalTime.Minute < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Minute)
	sz = cat(sz, ":")
	if (fLocalTime.Second < 10)
	sz = cat(sz, "0")
	sz = cat(sz, fLocalTime.Second)	
	sz = cat(sz, "---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " Begin---")
	sz = cat(sz, GetUserID())
	sz = cat(sz, "---Reason")
	sz = cat(sz, " : ")	
	sz = cat(sz, Ask("Input Comment"))
	sz = cat(sz, "---*/")	
	InsBufLine(hbuf, ln, sz)

	sz = "#ifdef __MTK_TARGET__"
	InsBufLine(hbuf, ln+1, sz)

	sz = "#endif"
	InsBufLine(hbuf, lnLast+3, sz)
	
	sz = GetFileTypeFlag()
	sz = cat(sz,"/*---")
	sz = cat(sz, InsertProjectName())
	sz = cat(sz, " End ----*/")
	InsBufLine(hbuf, lnLast+4, sz)
}

macro SelectAsLeftCompareFile()
{
    hbuf = GetCurrentBuf()
    
    setreg(COMPARE_LEFTFILE, GetBufName(hbuf))
}

macro GetFullFileNameToClipboard()
{
    hbuf = GetCurrentBuf()
    hbufClip = GetBufHandle("Clipboard")
    EmptyBuf(hbufClip)
    AppendBufLine(hbufClip,GetBufName(hbuf))
}

macro GetFileNameToClipboard()
{
    hbuf = GetCurrentBuf()
    hbufClip = GetBufHandle("Clipboard")
    EmptyBuf(hbufClip)

    filename=GetBufName(hbuf) 
	len = strlen(filename)
	i = len
	
    if(i == 0)
    {
      return ""
    }
    
	while ("\\"  != filename[i]) 
	{
		i=i-1
	}
	filename = strmid (filename, i+1,len)

    AppendBufLine(hbufClip,filename)
}

macro GetFileNameIncToClipboard()
{
    hbuf = GetCurrentBuf()
    hbufClip = GetBufHandle("Clipboard")
    EmptyBuf(hbufClip)

    filename=GetBufName(hbuf) 
	len = strlen(filename)
	i = len
	
    if(i == 0)
    {
      return ""
    }
    
	while ("\\"  != filename[i]) 
	{
		i=i-1
	}
	filename = strmid (filename, i+1,len)

	filename = cat("#include \"",filename)
	filename = cat(filename, "\"")
    AppendBufLine(hbufClip,filename)
}
macro Searchstrinstr(str1,str2)
{
	len = strlen(str1)
	i = 0
	j = 0
	len_m = strlen(str2)
	is_match = 0;

	while(i < len)
	{
		if (str1[i] == str2[j])
		{
			j = j + 1
			
			if (j == len_m)
			{
				is_match = 1
				
				break
			}
		}
		else
		{
			j = 0
		}

		i = i + 1
	}

	if (1 == is_match)
	{
		return i
	}

	return -1
}

macro DoSvnOperation(cmd_str)
{
    hbuf = GetCurrentBuf()

    filename=GetBufName(hbuf) 

	svn_cmd = "/command:"
	svn_cmd = cat(svn_cmd,cmd_str)
	svn_cmd = cat(svn_cmd," /path:")
	svn_cmd = cat(svn_cmd,filename)
	svn_cmd = cat(svn_cmd," /notempfile /closeonend")

	ShellExecute("open","TortoiseProc.exe",svn_cmd,"",1)
}

macro SvnShowLog()
{
	DoSvnOperation("log");
}

macro SvnDiff()
{
	DoSvnOperation("diff");
}

macro SvnCommit()
{
	DoSvnOperation("commit");
}

macro SvnUpdate()
{
	DoSvnOperation("update");
}

macro SvnRevert()
{
	DoSvnOperation("revert");
}

macro SvnBlame()
{
    hbuf = GetCurrentBuf()

    filename=GetBufName(hbuf) 

	svn_cmd = "/command:"
	svn_cmd = cat(svn_cmd,"blame")
	svn_cmd = cat(svn_cmd," /path:")
	svn_cmd = cat(svn_cmd,filename)
	svn_cmd = cat(svn_cmd," -r HEAD -v -g /notempfile /closeonend")

	ShellExecute("open","TortoiseProc.exe",svn_cmd,"",1)
}

macro GetMyDocumentDir()
{
    setting_dir = getreg(MY_SETTING_DIR)
    
    if(strlen( setting_dir ) == 0)
    {
        setting_dir = Ask("请输入'我的文档'路径:")
        setreg(MY_SETTING_DIR, setting_dir)
    }

    return setting_dir
}

macro GetCompareTool()
{
    compare_tool = getreg(MY_COMPARE_TOOL)
    
    if(strlen( compare_tool ) == 0)
    {
        compare_tool = Ask("请输入比较工具路径:")
        setreg(MY_COMPARE_TOOL, compare_tool)
    }

    return compare_tool
}

macro SetMyDocumentDir()
{
	prompt = "请输入'我的文档'路径:"
	old = getreg(MY_SETTING_DIR)
	
	if (0 != strlen(old))
	{
		prompt = cat(prompt, "(")
		prompt = cat(prompt, old)
		prompt = cat(prompt, ")")
	}

    setting_dir = Ask(prompt)
    setreg(MY_SETTING_DIR, setting_dir)
}

macro SetCompareTool()
{
	prompt = "请输入比较工具路径:"
	old = getreg(MY_COMPARE_TOOL)
	
	if (0 != strlen(old))
	{
		prompt = cat(prompt, "(")
		prompt = cat(prompt, old)
		prompt = cat(prompt, ")")
	}

    compare_tool = Ask(prompt)
    
    setreg(MY_COMPARE_TOOL, compare_tool)
}

macro RunPerlCmd(cmd_str2)
{
    hbuf = GetCurrentBuf()

    filename=GetBufName(hbuf) 

	setting_dir = GetMyDocumentDir()

	cmd_str = "perl -f \"";
	cmd_str = cat(cmd_str,setting_dir)
	cmd_str = cat(cmd_str,"\\Source Insight\\Projects\\Base\\si.pl\" ")
	cmd_str = cat(cmd_str,cmd_str2)
	cmd_str = cat(cmd_str," ")
	cmd_str = cat(cmd_str,filename)

	runcmdline(cmd_str, "",false)
}

macro Compare_files()
{
    hbuf = GetCurrentBuf()

    cur_file=GetBufName(hbuf) 
    
	leftfile = getreg(COMPARE_LEFTFILE)

	cmd_str = " "
	cmd_str = cat(cmd_str,leftfile)
	
	cmd_str = cat(cmd_str," ")
	cmd_str = cat(cmd_str,cur_file)

    //msg(cmd_str)
    
	ShellExecute("open",GetCompareTool(),cmd_str,"",1)
}

macro Get_patch()
{
	RunPerlCmd("get_file");
}

macro Touch_file()
{
	RunPerlCmd("touch");
}

macro SetUedit_path()
{
	prompt = "请输入uedit路径:"
	old = getreg(MY_UEDIT_PATH)
	
	if (0 != strlen(old))
	{
		prompt = cat(prompt, "(")
		prompt = cat(prompt, old)
		prompt = cat(prompt, ")")
	}

    uedit_path = Ask(prompt)

    setreg(MY_UEDIT_PATH, uedit_path)
}

macro GetUedit_path()
{
    uedit_path = getreg(MY_UEDIT_PATH)
    
    if(strlen( uedit_path ) == 0)
    {
	    uedit_path = Ask("请输入uedit路径:")
	    setreg(MY_UEDIT_PATH, uedit_path)
    }

    return uedit_path
}

macro Uedit_file()
{
    hbuf = GetCurrentBuf()

    filename=GetBufName(hbuf) 

	ShellExecute("open",GetUedit_path(),filename,"",1)
}

macro Config_set()
{
	SetUserName()
	SetMyDocumentDir()
	SetCompareTool()
	SetUedit_path()
}

macro CmdOpen()
{
	cmd_str = getreg(CUR_PRJ_BASE)
    if(strlen( cmd_str ) == 0)
    {
        setreg(MY_SETTING_DIR, " ")
    }
    
	sProjRoot = GetProjDir(GetCurrentProj())


	setting_dir = GetMyDocumentDir()

	cmd_str = "perl -f \"";
	cmd_str = cat(cmd_str,setting_dir)
	cmd_str = cat(cmd_str,"\\Source Insight\\Projects\\Base\\si.pl\" ")
	cmd_str = cat(cmd_str,"open_cmd")
	cmd_str = cat(cmd_str," ")
	cmd_str = cat(cmd_str,sProjRoot)

	runcmdline(cmd_str, "",false)

		
	cmd_str = "/k cd "
	cmd_str = cat(cmd_str, getreg(CUR_PRJ_BASE))

	ShellExecute("open","CMD.exe",cmd_str,"",1)
}


