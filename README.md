## Distributed Operating System Principles
## Project 1 : Bitcoin Mining Using Actor model in Erlang

### Group Members
| Names | UF-ID |
| ------ | ------ |
| Vamsi Pachamatla | 1708-0059 |
| Satya Venkata Sai Nirupam Yashas Kuchimanchi | 5043-1189 |

## Steps to Run the Code

1. Install Erlang on your system using the homebrew.
2. Find the IP address of your machine.
3. Initialize the Erlang shell in the folder you want using the code "erl -name vamsi@192.168.0.55" in the terminal.
4. Compile the module using the "c(question1mining).".
5. Initialize the server using this "question1mining:startNewServer()."
6. Enter the number of leading zeroes that you would like.
7. You can start the mining with the code ."question1mining:minebitcoin('vamsi@192.168.0.55',10).".

 
## 1. Size of the Work Unit for 4 leading zeros

| Actors | Ratio( CPU time / Realtime) - 3 Leading Zeros | Ratio( CPU time / Realtime) - 4 Leading Zeros |
| ------ | ------ | ------ |
| 4 | 1.625 | 2.22672 |
| 5 | 2.27 | 2.13895 |
| 10 | 4.9 | 3.00313 |
| 100 | 6.49857 | 5.63650 |
| 500 | 5.87721 | 5.77696 |
| 1000 | 6.59783 | 5.86406  |

## 2. Result for running the program on Input: 4

- The CPU to Real-time ratio for four leading zeroes with 100 workers is 5.63650, the ratio for 500 workers is 5.77696, and the ratio for 1000 workers is 5.86406. The utilization of the cores keeps on increasing when we increase the cores.
#### 100 workers with 4 leading zeroes
<img width="1440" alt="4 leading zeroes and 100 Bitcoins" src="https://user-images.githubusercontent.com/48962308/192126428-b197d80e-ab0a-4dfa-87fd-71f174213c59.png">

#### 500 workers with 4 leading zeroes
<img width="1438" alt="4 leading zeroes and 500 Bitcoins" src="https://user-images.githubusercontent.com/48962308/192126431-bd7c43b7-a615-4c03-bde6-0748b494e39d.png">

#### 1000 workers with 4 leading zeroes
<img width="1439" alt="4 leading zeroes and 1000 Bitcoins" src="https://user-images.githubusercontent.com/48962308/192126433-f81b26e0-5425-42a6-9250-30ebc20f0f96.png">

## 3. Cores Utilization
- For 8 core machine, our program managed to get 6.59782 ratio for 3 leading zeroes while mining 1000 bitcoins.
<img width="1440" alt="3 leading zeroes and 500 Bitcoins" src="https://user-images.githubusercontent.com/48962308/192126754-27886b78-59af-4c76-b816-bb3a59bb8baa.png">



## 4. The coin with the most 0s you managed to find
- It took approximately 30 mins to find one coin with 7 Leading Zeros.
<img width="1440" alt="Screenshot 2022-09-24 at 11 41 31 PM" src="https://user-images.githubusercontent.com/48962308/192127276-186a8c60-da03-41cf-822d-bc49fc2b631c.png">

## 5. The largest number of working machines you were able to run your code with.

#### We Executed our program on 4 machines, and we managed to get access from all of them. We also managed to make server client connection work in all the combinations possible. 

- Apple M1 Pro chip: 10-core CPU with 8 performance cores and 2 efficiency cores
- Apple M1 chip:  8-core CPU with 4 performance cores and 4 efficiency cores
- Intel® CoreTM i5-6200U Processor, 2 core processor
- Intel® CoreTM i7-8750H Processor, 6 cores
