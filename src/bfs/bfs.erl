%%%-------------------------------------------------------------------
%%% @author lizhiwei
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%     bfs
%%%     时间复杂度 O(∣V∣+∣E∣)
%%% @end
%%% Created : 30. 一月 2019 13:53
%%%-------------------------------------------------------------------
-module(bfs).
-author("lizhiwei").

%% API
-export([bfs/1]).

bfs(StartV)->
    Fun = fun(V)->
        io:format("V:~w~n", [V])
          end,
    bfs(Fun,[StartV], []).

%% 实现过程中需要用到一个队列和一个数组，
%% 队列BfsUnCkeckList用于保存所有未被检测的顶点，
%% 而数组CheckedList用于标识哪些顶点已被访问
%% StartV => 起始顶点
bfs(_Fun,[], _CheckedList)->
    io:format("bfs end _CheckedList:~w", [lists:reverse(_CheckedList)]);%% 此处_CheckedList记录的就是遍历顺序的逆序
bfs(Fun,[V | LBfsUnCkeckList], CheckedList)->
    case point(V) of
        []->
            io:format("bfs bad point: ~w~n",[V]),
            bfs(Fun,LBfsUnCkeckList, [V|CheckedList]);
        CfgList ->
%%            io:format("bfs point: ~w~n",[V]),
            F = fun({Id,_Weight}, AccList)->
                case lists:member(V,CheckedList) of
                    true->
                        AccList;
                    false->
                        [Id|AccList]
                end
                end,
            LBfsUnCkeckList2 = lists:foldl(F, [], CfgList),
            LBfsUnCkeckList3 = LBfsUnCkeckList ++ lists:reverse(LBfsUnCkeckList2),
            CheckedList2 = case lists:member(V, CheckedList) of
                               false ->
                                   %% 对图遍历的点进行操作
                                   Fun(V),
                                   [V | CheckedList];
                               true ->
                                   CheckedList
                           end,
            bfs(Fun,LBfsUnCkeckList3,CheckedList2)
    end.


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