﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class Singleton_YX_MoblieAPIWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Singleton<YX_MoblieAPI>), typeof(UnityEngine.MonoBehaviour), "Singleton_YX_MoblieAPI");
		L.RegFunction("OnDestroy", OnDestroy);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", Lua_ToString);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int OnDestroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Singleton<YX_MoblieAPI> obj = (Singleton<YX_MoblieAPI>)ToLua.CheckObject(L, 1, typeof(Singleton<YX_MoblieAPI>));
			obj.OnDestroy();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Lua_ToString(IntPtr L)
	{
		object obj = ToLua.ToObject(L, 1);

		if (obj != null)
		{
			LuaDLL.lua_pushstring(L, obj.ToString());
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}

		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Singleton<YX_MoblieAPI>.Instance);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

