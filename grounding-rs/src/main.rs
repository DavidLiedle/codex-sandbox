use std::io::{self, Write};

const STEPS: &[(u8, &str)] = &[
    (5, "things you can see"),
    (4, "things you can feel"),
    (3, "things you can hear"),
    (2, "things you can smell"),
    (1, "thing you can taste"),
];

fn wait_for_trigger() {
    loop {
        let mut buffer = String::new();
        io::stdin().read_line(&mut buffer).unwrap();
        let trimmed = buffer.trim_end_matches(|c| c == '\n' || c == '\r');
        if trimmed.is_empty() || trimmed == " " {
            break;
        }
    }
}

fn main() {
    println!("Welcome to the 5-4-3-2-1 grounding technique.");
    println!("Press SPACE or ENTER after you identify each item.");

    for (count, description) in STEPS {
        println!();
        println!("Identify {} {}.", count, description);
        for i in (1..=*count).rev() {
            print!("{}... ", i);
            io::stdout().flush().unwrap();
            wait_for_trigger();
        }
        println!();
    }

    println!("Grounding exercise complete. Take a deep breath.");
}
