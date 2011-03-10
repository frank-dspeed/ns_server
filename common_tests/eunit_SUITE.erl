-module(eunit_SUITE).
-include_lib("common_test/include/ct.hrl").

-compile(export_all).

suite() ->
    [].

init_per_suite(Config) ->
    Config.
end_per_suite(_Config) ->
    ok.

init_per_testcase(_Case, Config) ->
    Config.
end_per_testcase(_Case, _Config) ->
    ok.

all() ->
    [eunit].

%%--------------------------------------------------------------------
%% TEST CASES
%%--------------------------------------------------------------------

%% Just run all the eunit tests defined in modules within ns_server.app
eunit(_Config) ->

    % Yup this is nasty, find the right way to get the path
    {ok, [{application, ns_server, Vals}]}
        = file:consult("../../../ebin/ns_server.app"),

    {modules, Mods} = lists:keyfind(modules, 1, Vals),

    [ begin
          io:format("Starting ~p:test()~n", [Mod]),
          ok = eunit:test(Mod)
      end || Mod <- Mods],
    ok.
