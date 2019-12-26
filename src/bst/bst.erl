%%%-------------------------------------------------------------------
%%% @author lzw
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%   binary search tree
%%% @end
%%% Created : 26. 12月 2019 6:10 下午
%%%-------------------------------------------------------------------
-module(bst).

-ifdef(debug).
-define(DBG(Str, Args), io:format(Str, Args)).
-else.

%% API
-export([insert/2, find/2, is_btree/1, maxv/1, sum/1]).

-record(btree, {
    value,
    left, %% left tree
    right %% right tree
}).

%% new a bst or insert node into the existed bst
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


%% calc sum that all nodes in bst
sum (null) -> 0;
sum (#btree{value=V, left=null, right=null}) ->
    V;
sum (#btree{value=V, left=L, right=null}) ->
    V + sum(L);
sum (#btree{value=V, left=null, right=R}) ->
    V + sum(R);
sum (#btree{value=V, left=L, right=R}) ->
    V + sum(L) + sum(R).


%% find the max value node
maxv(#btree{value=V, left=null, right=null}) ->
    V;
maxv(#btree{value=V, left=L, right=null}) ->
    TV = maxv(L),
    if
        TV < V -> V;
        true -> TV
    end;
maxv(#btree{value=V, left=null, right=R})->
    TV = maxv(R),
    if
        TV < V -> V;
        true -> TV
    end;
maxv(#btree{value=V, left=L, right=R}) ->
    TL = maxv(L),
    TR = maxv(R),
    T = if
            TL < TR -> TR;
            true -> TL
        end,
    if
        T < V -> V;
        true -> T
    end.


%% is a bst or not(bst need the left node's value is smaller than the root node's value and the root node's value is smaller than the right node's value)
is_btree (#btree{value=V, left=null, right=null}) ->
    ?DBG("~p  line=~p~n", [V, ?LINE]),
    true;
is_btree (#btree{value=V, left=L, right=null}) ->
    ?DBG("~p  line=~p~n", [V, ?LINE]),
    if
        L#btree.value =< V ->
            is_btree(L);
        true ->
            false
    end;
is_btree(#btree{value=V, left=null, right=R}) ->
    ?DBG("~p  line=~p~n", [V, ?LINE]),
    if
        V < R#btree.value ->
            is_btree(R);
        true -> false
    end;
is_btree(#btree{value=V, left=L, right=R}) when (V >= L#btree.value) and (V < R#btree.value) ->
    ?DBG("~p  line=~p~n", [V, ?LINE]),
    is_btree (L) and is_btree(R);
is_btree(_) ->
    ?DBG("line=~p~n", [?LINE]),
    false.
