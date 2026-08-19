abstract class BalanceRepository {
  Future<double> getBalance();
  Future<void> updateBalance();
}
