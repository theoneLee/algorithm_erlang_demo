%%%-------------------------------------------------------------------
%%% @author lizhiwei
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 二月 2019 15:45
%%%-------------------------------------------------------------------
-module(stack).
-author("lizhiwei").

%% API
-export([new/0, push/2, pop/1, member/2]).

new() ->
    [].

push(Value, OldStack) ->
    [Value|OldStack].

pop([]) ->
    empty;
pop([Value|RestStack]) ->
    {Value, RestStack}.

member(Point,Stack)->
    lists:member(Point,Stack).