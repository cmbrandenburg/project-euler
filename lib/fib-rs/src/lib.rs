pub struct Fib {
    former: u64,
    latter: u64,
}

impl Fib {
    pub fn new() -> Self {
        Fib {
            former: 0,
            latter: 1,
        }
    }
}

impl Iterator for Fib {
    type Item = u64;

    fn next(&mut self) -> Option<Self::Item> {
        let next = self.former + self.latter;
        self.former = self.latter;
        self.latter = next;
        Some(next)
    }
}

#[cfg(test)]
mod tests {

    #[test]
    fn iter() {
        let expected = vec![1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
        let got = super::Fib::new().take_while(|&x| x <= 89).collect::<Vec<_>>();
        assert_eq!(expected, got);
    }
}
