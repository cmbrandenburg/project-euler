fn solve(n: u32) -> u32 {
    (1..n).filter(|x| 0 == x % 3 || 0 == x % 5).fold(0, |a, b| a + b)
}

#[cfg(test)]
mod tests {
    #[test]
    fn examples() {
        assert_eq!(23, super::solve(10));
    }
}

fn main() {
    println!("{}", solve(1000));
}
