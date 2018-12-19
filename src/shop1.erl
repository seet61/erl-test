%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Дек. 2018 19:10
%%%-------------------------------------------------------------------
-module(shop1).
-author("seet").

%% API
-export([total/1]).

total([{What, N} | T]) -> shop:cost(What) * N + total(T);
total([]) -> 0.
