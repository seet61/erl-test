%%%-------------------------------------------------------------------
%%% @author seet
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. Дек. 2018 21:59
%%%-------------------------------------------------------------------
-module(try_test).
-author("seet").

%% API
-export([demo1/0]).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> erlang:error(a).


demo1() -> [catcher(I) || I <- [1,2,3,4,5]].

catcher(N) ->
  try
    generate_exception(N) of Val -> {N, normal, Val}
  catch
    throw:X -> {N, caught, thrown, X};
    exit:X -> {N, caught, exited, X};
    error:X -> {N, caught, error, X}
  end.