#[derive(Debug)]
pub struct Primes {
    max: u32,
    calculated: Vec<u32>,
}

impl Primes {
    pub fn new() -> Self {
        Primes {
            max: 3,
            calculated: {
                let mut v = Vec::new();
                v.reserve(1000);
                v.push(2);
                v
            },
        }
    }

    pub fn iter<'a>(&'a mut self) -> PrimeIter<'a> {
        PrimeIter {
            index: 0,
            primes: self,
        }
    }

    // Calculates more primes.
    fn more(&mut self) {

        debug_assert!(1 == self.max % 2);
        let new_max = 2 * self.max + 1;
        debug_assert!(1 == new_max % 2);

        let mut is_composite = Vec::new();
        is_composite.resize(((self.max + 1) / 2) as usize, false);

        // Mark new composites that are divisible by the primes we've already
        // calculated.

        for &p in self.calculated[1..].iter() {

            let remainder = self.max % p;

            let mut i = if 0 == remainder {
                0
            } else {
                let m = p - remainder;
                if 0 == m % 2 {
                    (m / 2) as usize
                } else {
                    (((m + 1) / 2) + (p / 2)) as usize
                }
            };

            while i < is_composite.len() {
                is_composite[i] = true;
                i += p as usize;
            }
        }

        // Sieve the new primes. Mark new composites that are divisible by only
        // these new primes.

        for i in 0..is_composite.len() {

            let n = self.max + (2 * i) as u32;

            if !is_composite[i] {
                self.calculated.push(n);
                continue;
            }

            let mut j = n + (2 * i) as u32;
            while (j as usize) < is_composite.len() {
                is_composite[j as usize] = true;
                j += n;
            }
        }

        self.max = new_max;
    }
}

pub struct PrimeIter<'a> {
    index: usize,
    primes: &'a mut Primes,
}

impl<'a> Iterator for PrimeIter<'a> {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {

        debug_assert!(self.index <= self.primes.calculated.len());

        if self.index == self.primes.calculated.len() {
            self.primes.more();
            assert!(self.index < self.primes.calculated.len());
        }

        let item = self.primes.calculated[self.index];
        self.index += 1;

        Some(item)
    }
}

pub struct Factors<'a> {
    dividend: u64,
    primes: PrimeIter<'a>,
}

impl<'a> Iterator for Factors<'a> {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {

        if 1 == self.dividend {
            return None;
        }

        loop {
            let p = self.primes.next().unwrap() as u64;

            if 0 == self.dividend % p {
                self.dividend /= p;
                while 0 == self.dividend % p {
                    self.dividend /= p;
                }

                return Some(p as u32);
            }
        }
    }
}

pub fn prime_factors(primes: &mut Primes, n: u64) -> Factors {

    debug_assert!(n >= 1);

    Factors {
        dividend: n,
        primes: primes.iter(),
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn primes() {

        let mut p = super::Primes::new();
        assert_eq!(3, p.max);
        assert_eq!(vec![2], p.calculated);

        p.more();
        assert_eq!(7, p.max);
        assert_eq!(vec![2, 3, 5], p.calculated);

        p.more();
        assert_eq!(15, p.max);
        assert_eq!(vec![2, 3, 5, 7, 11, 13], p.calculated);

        p.more();
        assert_eq!(31, p.max);
        assert_eq!(vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29], p.calculated);

        p.more();
        assert_eq!(63, p.max);
        assert_eq!(vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61],
                   p.calculated);
    }

    #[test]
    fn primes_iter() {

        use super::Primes;

        assert_eq!(vec![2], Primes::new().iter().take(1).collect::<Vec<_>>());
        assert_eq!(vec![2, 3], Primes::new().iter().take(2).collect::<Vec<_>>());
        assert_eq!(vec![2, 3, 5],
                   Primes::new().iter().take(3).collect::<Vec<_>>());
        assert_eq!(vec![2, 3, 5, 7],
                   Primes::new().iter().take(4).collect::<Vec<_>>());
    }


    #[test]
    fn prime_factors() {

        use super::{prime_factors, Primes};

        let mut primes = Primes::new();

        assert_eq!(vec![2], prime_factors(&mut primes, 2).collect::<Vec<_>>());
        assert_eq!(vec![2], prime_factors(&mut primes, 4).collect::<Vec<_>>());
        assert_eq!(vec![2], prime_factors(&mut primes, 8).collect::<Vec<_>>());

        assert_eq!(vec![2, 3],
                   prime_factors(&mut primes, 6).collect::<Vec<_>>());
        assert_eq!(vec![2, 3],
                   prime_factors(&mut primes, 12).collect::<Vec<_>>());
        assert_eq!(vec![2, 3],
                   prime_factors(&mut primes, 36).collect::<Vec<_>>());

        assert_eq!(vec![5, 7, 13, 29],
                   prime_factors(&mut primes, 13_195).collect::<Vec<_>>());
    }
}
