%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Янв. 2019 16:50
%%%-------------------------------------------------------------------
-module(fac1).
-author("seet").

%% API
-export([main/1]).

main([A]) ->
  I = list_to_integer(atom_to_list(A)),
  F = fac(I),
  io:format("factorial ~w = ~w~n", [I, F]),
  init:stop().

fac(0) -> 1;
fac(N) -> N * fac(N-1).
