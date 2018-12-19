%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Дек. 2018 18:48
%%%-------------------------------------------------------------------
-module(geometry).
-author("seet").

%% API
-export([area/1]).

area({rectangle, Width, Ht}) -> Width * Ht;
area({circle, R}) -> 3.14159 * R * R;
area({squae, X}) -> X * X.