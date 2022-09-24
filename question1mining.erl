-module(question1mining).
-import(string,[to_lower/1]).
-import(string,[sub_string/3]).
-export([startNewServer/0, server/1, generateCoin/1, worker/1, creatingWorker/2, spawn_slaves/2,minebitcoin/2]).



prefixZeroes(0) -> "";
prefixZeroes(N) -> 
    "0"++prefixZeroes(N-1).

generateCoin(K) ->
    receive
        {mine, From, SNode} ->
            Characters = get_random_string(100,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;!@#$%^&*()+-_="),
            RandomisedString = "vamsipachamatla;"++Characters,
            HashedRandomisedString = to_lower(integer_to_list(binary:decode_unsigned(crypto:hash(sha256,RandomisedString)),16)),
            LengthOfHashedRandomisedString = string:len(HashedRandomisedString),
            if 
                LengthOfHashedRandomisedString =< (64-K) ->
                    io:format("Coin Found ~n"),
                    client ! printstatistics,
                    {From, SNode} ! {found_coin,{RandomisedString, prefixZeroes(K)++HashedRandomisedString}};
                true ->
                    spawn(question1mining, generateCoin,[K]) ! {mine, From, SNode}
            end
    end.

server(K)->
    receive
        {found_coin, {Coin, Hash}} ->
            io:format(" : 100 letter random string = ~p~n", [Coin]),
            io:format("SHA256 encrypted random string = ~p~n",[Hash]);
        {mine, WPid} ->
            WPid ! {zcount, K};
        {time, Ratio} ->
            io:format("Ratio of the cpu time and the real time is : ~p",[Ratio])
    end,
    server(K).

worker(SNode) ->
    
    {serverPid, SNode} ! {mine, self()},
    receive
        {zcount, K} ->
            spawn(question1mining, generateCoin,[K]) ! {mine, serverPid, SNode}
    end.

spawn_slaves(1, SNode) ->
    spawn(question1mining, worker, [SNode]);
    
spawn_slaves(N, SNode) ->
    spawn(question1mining, worker, [SNode]),
    spawn_slaves(N-1, SNode).

minebitcoin(S,C) ->
    register(client,spawn(question1mining,creatingWorker,[S,C])).

creatingWorker(SNode,C) ->
    {_,_}=statistics(runtime),
    {_,_}=statistics(wall_clock),
    spawn_slaves(C, SNode),
    listen(1,C,SNode).

startNewServer() ->
    {ok, K} = io:read("Enter number of leading zeroes: "),
    register(serverPid,spawn(question1mining, server,[K])),
    {_,_}=statistics(runtime),
    {_,_}=statistics(wall_clock).

get_random_string(Length, AllowedChars) ->
    lists:foldl(fun(_, Acc) ->
                        [lists:nth(rand:uniform(length(AllowedChars)),
                                   AllowedChars)]
                            ++ Acc
                end, [], lists:seq(1, Length)).

listen(N,C,SNode) ->
    receive 
        printstatistics ->
            io:format("Bitcoin-~p" , [N]), 
            if 
                N == C ->
                    {_,CPU}=statistics(runtime),
                    {_,REAL}=statistics(wall_clock),
                    {serverPid,SNode} ! {time, CPU/REAL};
                true -> 
                    listen(N+1,C,SNode)
            end
    end.


