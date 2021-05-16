import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';
import 'package:money_converter/money_converter.dart';
import 'package:money_converter/Currency.dart';

import 'custom_container.dart';

class WalletSummary extends StatelessWidget {

  final AsyncMemoizer memoizer = AsyncMemoizer();

  _fetchData() {
    return this.memoizer.runOnce(() async {
      return MoneyConverter.convert(
          Currency(Currency.USD), Currency(Currency.INR));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (BuildContext context, state) {
            if (state is WalletLoadedState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.grey[600],
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Wallet Balance',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            state.wallet.balance > 100
                                ? state.wallet.balance.toStringAsFixed(2)
                                : state.wallet.balance.toStringAsFixed(5),
                            style: TextStyle(color: Colors.white, fontSize: 22),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ' ETH',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            state.wallet.inBTC.toStringAsFixed(5),
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                          Text(
                            ' BTC',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
    FutureBuilder(future: _fetchData(), builder: (context, snapshot) {
      return Text(
        ((snapshot.hasData ? snapshot.data : 0) * (state.wallet.inUSD)).toStringAsFixed(2),
        style: TextStyle(
            color: Colors.grey[500], fontSize: 14),
      );
    }),
                          Text(
                            ' INR',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
            if (state is WalletInitial) {
              return Center(
                  child: Text('No Wallet Added',
                      style: Theme.of(context).textTheme.bodyText1));
            }

            if (state is WalletErrorState) {
              return Center(
                  child: Text('Error: try to reload',
                      style: Theme.of(context).textTheme.bodyText1));
            }

            if (state is WalletNoConnectionState) {
              return Center(
                  child: Text('No internet Connection',
                      style: Theme.of(context).textTheme.bodyText1));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
