extern crate fib;

fn solve(n: u64) -> u64 {
    fib::Fib::new()
        .take_while(|x| *x <= n)
        .filter(|x| 0 == x % 2)
        .fold(0, |a, b| a + b)
}

#[cfg(test)]
mod tests {
    #[test]
    fn examples() {
        assert_eq!(2 + 8 + 34, super::solve(89));
    }
}

fn main() {
    println!("{}", solve(4_000_000));
}
