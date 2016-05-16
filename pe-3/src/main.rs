extern crate factor;

fn solve(n: u64) -> u32 {
    factor::prime_factors(&mut factor::Primes::new(), n).last().unwrap()
}

#[cfg(test)]
mod tests {
    #[test]
    fn examples() {
        assert_eq!(29, super::solve(13195));
    }
}

fn main() {
    println!("{}", solve(600_851_475_143));
}
