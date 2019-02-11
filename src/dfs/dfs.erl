%%%-------------------------------------------------------------------
%%% @author lizhiwei
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. 一月 2019 15:18
%%%-------------------------------------------------------------------
-module(dfs).
-author("lizhiwei").

%% API
-export([dfs/1]).

dfs(V)->
    Fun = fun(V)->
            io:format("V:~w~n", [V])
          end,

    case point(V) of
        [] ->
            ok;
        CfgList ->
            dfs(Fun,CfgList,[V])
    end.

dfs(_Fun,[],CheckPointList)->
    CheckPointList;
dfs(Fun,[{NextPoint,_Weight}|LCfgList],CheckPointList)->
    if
        length(CheckPointList) == 1->
            Fun(hd(CheckPointList));%% io:format("V:~w~n", [hd(CheckPointList)]);
        true ->
            ok
    end,
    case lists:member(NextPoint, CheckPointList) of
        true ->
            NewCheckPointList = CheckPointList;
        false ->
            Fun(NextPoint),%%io:format("V:~w~n", [NextPoint]),
            NewCheckPointListTemp = [NextPoint | CheckPointList],
            NewCheckPointList = dfs(Fun,point(NextPoint),NewCheckPointListTemp)
    end,
    dfs(Fun,LCfgList,NewCheckPointList).%% NextPoint为下一个边，如果




%% 数据结构
%% 邻接表
point(0)->[{1,1},{2,1}];%% element => {NextPointId, Weight}
point(1)->[{0,1},{2,1},{3,1}];
point(2)->[{0,1},{1,1},{3,1},{4,1},{5,1}];
point(3)->[{1,1},{2,1},{4,1},{5,1}];
point(4)->[{2,1},{3,1},{6,1}];
point(5)->[{3,1},{6,1}];
point(6)->[{4,1},{5,1}];
point(_)->[].