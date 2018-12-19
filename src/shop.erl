%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Дек. 2018 19:04
%%%-------------------------------------------------------------------
-module(shop).
-author("seet").

%% API
-export([cost/1]).

cost(oranges) -> 5;
cost(newspaper) -> 8;
cost(apples) -> 2;
cost(pears) -> 9;
cost(milk) -> 7.