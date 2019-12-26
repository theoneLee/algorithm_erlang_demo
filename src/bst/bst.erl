%%%-------------------------------------------------------------------
%%% @author lzw
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%   binary search tree
%%% @end
%%% Created : 26. 12月 2019 6:10 下午
%%%-------------------------------------------------------------------
-module(bst).

%% API
-export([insert/2, find/2]).

-record(btree, {
    value,
    left, %% left tree
    right %% right tree
}).

insert(NV, null) ->
    #btree{value = NV};
insert(NV, #btree{value = V, left = null, right = null} = N) ->
    if
        NV =< V ->
            N#btree{left = #btree{value = NV}};
        true ->
            N#btree{right = #btree{value = NV}}
    end;
insert(NV, #btree{value = V, left = L, right = null} = N) ->
    if
        NV =< V ->
            N#btree{left = insert(NV, L)};
        true ->
            N#btree{right = #btree{value = NV}}
    end;
insert(NV, #btree{value = V, left = null, right = R} = N) ->
    if
        NV =< V ->
            N#btree{left = #btree{value = NV}};
        true ->
            N#btree{right = insert(NV, R)}
    end;
insert(NV, #btree{value = V, left = L, right = R} = N) ->
    if
        NV =< V ->
            N#btree{left = insert(NV, L)};
        true ->
            N#btree{right = insert(NV, R)}
    end.



find(NV, #btree{value = V, left = null, right = null}) ->
    NV == V;
find(NV,#btree{value = V, left = Left, right = Right})->
    if
        NV >V-> find(NV,Right);
        true -> find(NV,Left)
    end.


