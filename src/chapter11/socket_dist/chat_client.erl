%%%-------------------------------------------------------------------
%%% @author seet61
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. Янв. 2019 20:30
%%%-------------------------------------------------------------------
-module(chat_client).
-author("seet61").

%% API
-export([]).

start() -> connect("localhost", 2223, "AsDT67aQ", "general", "joe").

connect(Host, Port, HostPws, Group, Nick) ->
  process_flag(trap_exit, true),
  Widget = io_widget:start(self()),
  set_title(Widget, Nick),
  set_state(Widget, Nick),
  set_prompt(Widget, [Nick, " > "]),
  set_handler(Widget, fun parse_comand/1),
  start_connector(Host, Port, HostPws),
  disconnected(Widget, Group, Nick).

disconnected(Widget, Group, Nick) ->
  receive
    {connected, MM} ->
      insert_str(Widget, "connected to server \\nsending data\\n"),
      MM ! {login, Group, Nick},
      wait_login_response(Widget, MM);
    {Widget, destroyed} ->
      exit(died);
    {status, S} ->
      insert_str(Widget, to_str(S)),
      disconnected(Widget, Group, Nick);
    Other ->
      io:format("chat_client disconnected unexpected:\~p\~n" ,[Other]),
      disconnected(Widget, Group, Nick)
  end.

start_connector(Host, Port, Pwd) ->
  S = self(),
  spawn_link(fun() -> try_to_connect(S, Host, Port, Pwd) end).

try_to_connect(Parent, Host, Port, Pwd) ->
  %% Parent is the Pid of the process that spawned this process
  case lib_chan:connect(Host, Port, chat, Pwd, []) of
    {error, _Why} ->
      Parent ! {status, {cannot, connect, Host, Port}},
      sleep(2000),
      try_to_connect(Parent, Host, Port, Pwd);
    {ok, MM} ->
      lib_chan_mm:controller(MM, Parent),
      Parent ! {connected, MM},
      exit(connectorFinished)
  end.

wait_login_response(Widget, MM) ->
  receive
    {MM, ack} ->
      active(Widget, MM);
    Other ->
      io:format("chat_client login unexpected:\~p\~n" ,[Other]),
      wait_login_response(Widget, MM)
  end.

active(Widget, MM) ->
  receive
    {Widget, Nick, Str} ->
      MM ! {relay, Nick, Str},
      active(Widget, MM);
    {MM, {msg, From, Pid, Str}} ->
      insert_str(Widget, [From, "@", pid_to_list(Pid), " ", Str, "\\n"]),
      active(Widget, MM);
    {'EXIT', Widget, windowDestroyed} ->
      MM ! close;
    {close, MM} ->
      exit(serverDied);
    Other ->
      io:format("chat_client active unexpected:\~p\~n" ,[Other]),
      active(Widget, MM)
  end.