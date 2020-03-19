%%%-------------------------------------------------------------------
%% @doc mqtt2redis public API
%% @end
%%%-------------------------------------------------------------------

-module(mqtt2redis_app).

-behaviour(application).

-include("mqtt2redis.hrl").


-emqx_plugin(?MODULE).

-export([ start/2
        , stop/1
        ]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = mqtt2redis_sup:start_link(),
    mqtt2redis:load(application:get_all_env()),
    {ok, Db} = application:get_env(mqtt2redis, db),
    io:format("Database Host ~p~n ", [Db]),
    % {ok, MqttParam} = application:get_env(mqtt2redis, mqtt),
    % io:format("Database Host ~p~n ", [MqttParam]),
    {ok, Sup}.

stop(_State) ->
    mqtt2redis:unload(application:get_all_env()).