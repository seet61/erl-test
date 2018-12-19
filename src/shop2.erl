%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Дек. 2018 17:11
%%%-------------------------------------------------------------------
-module(shop2).
-author("seet").

%% API
-export([total/1]).
-import(lists, [map/2, sum/1]).

total(L) -> sum(map(fun({What, N}) -> shop:cost(What) * N end, L)).