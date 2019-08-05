﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UnityEngine_AnimationCurveWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEngine.AnimationCurve), typeof(System.Object));
		L.RegFunction("Evaluate", Evaluate);
		L.RegFunction("AddKey", AddKey);
		L.RegFunction("MoveKey", MoveKey);
		L.RegFunction("RemoveKey", RemoveKey);
		L.RegFunction("get_Item", get_Item);
		L.RegFunction("SmoothTangents", SmoothTangents);
		L.RegFunction("Linear", Linear);
		L.RegFunction("EaseInOut", EaseInOut);
		L.RegFunction("New", _CreateUnityEngine_AnimationCurve);
		L.RegVar("this", _this, null);
		L.RegFunction("__tostring", Lua_ToString);
		L.RegVar("keys", get_keys, set_keys);
		L.RegVar("length", get_length, null);
		L.RegVar("preWrapMode", get_preWrapMode, set_preWrapMode);
		L.RegVar("postWrapMode", get_postWrapMode, set_postWrapMode);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_AnimationCurve(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				UnityEngine.AnimationCurve obj = new UnityEngine.AnimationCurve();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else if (TypeChecker.CheckParamsType(L, typeof(UnityEngine.Keyframe), 1, count))
			{
				UnityEngine.Keyframe[] arg0 = ToLua.CheckParamsObject<UnityEngine.Keyframe>(L, 1, count);
				UnityEngine.AnimationCurve obj = new UnityEngine.AnimationCurve(arg0);
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AnimationCurve.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _get_this(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.Keyframe o = obj[arg0];
			ToLua.PushValue(L, o);
			return 1;

		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _this(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushvalue(L, 1);
			LuaDLL.tolua_bindthis(L, _get_this, null);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Evaluate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			float o = obj.Evaluate(arg0);
			LuaDLL.lua_pushnumber(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddKey(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 2 && TypeChecker.CheckTypes(L, 1, typeof(UnityEngine.AnimationCurve), typeof(UnityEngine.Keyframe)))
			{
				UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.ToObject(L, 1);
				UnityEngine.Keyframe arg0 = (UnityEngine.Keyframe)ToLua.ToObject(L, 2);
				int o = obj.AddKey(arg0);
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else if (count == 3 && TypeChecker.CheckTypes(L, 1, typeof(UnityEngine.AnimationCurve), typeof(float), typeof(float)))
			{
				UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.ToObject(L, 1);
				float arg0 = (float)LuaDLL.lua_tonumber(L, 2);
				float arg1 = (float)LuaDLL.lua_tonumber(L, 3);
				int o = obj.AddKey(arg0, arg1);
				LuaDLL.lua_pushinteger(L, o);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AnimationCurve.AddKey");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int MoveKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.Keyframe arg1 = (UnityEngine.Keyframe)ToLua.CheckObject(L, 3, typeof(UnityEngine.Keyframe));
			int o = obj.MoveKey(arg0, arg1);
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int RemoveKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveKey(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.Keyframe o = obj[arg0];
			ToLua.PushValue(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SmoothTangents(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)ToLua.CheckObject(L, 1, typeof(UnityEngine.AnimationCurve));
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SmoothTangents(arg0, arg1);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Linear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 1);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 2);
			float arg2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float arg3 = (float)LuaDLL.luaL_checknumber(L, 4);
			UnityEngine.AnimationCurve o = UnityEngine.AnimationCurve.Linear(arg0, arg1, arg2, arg3);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int EaseInOut(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 1);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 2);
			float arg2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float arg3 = (float)LuaDLL.luaL_checknumber(L, 4);
			UnityEngine.AnimationCurve o = UnityEngine.AnimationCurve.EaseInOut(arg0, arg1, arg2, arg3);
			ToLua.PushObject(L, o);
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
	static int get_keys(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.Keyframe[] ret = obj.keys;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index keys on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_length(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			int ret = obj.length;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index length on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_preWrapMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.WrapMode ret = obj.preWrapMode;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index preWrapMode on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_postWrapMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.WrapMode ret = obj.postWrapMode;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index postWrapMode on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_keys(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.Keyframe[] arg0 = ToLua.CheckObjectArray<UnityEngine.Keyframe>(L, 2);
			obj.keys = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index keys on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_preWrapMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.WrapMode arg0 = (UnityEngine.WrapMode)ToLua.CheckObject(L, 2, typeof(UnityEngine.WrapMode));
			obj.preWrapMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index preWrapMode on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_postWrapMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AnimationCurve obj = (UnityEngine.AnimationCurve)o;
			UnityEngine.WrapMode arg0 = (UnityEngine.WrapMode)ToLua.CheckObject(L, 2, typeof(UnityEngine.WrapMode));
			obj.postWrapMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index postWrapMode on a nil value" : e.Message);
		}
	}
}

