extern crate rutie;

use rutie::{Object, RString, VM};

fn try_it(s: &str) -> String {
    let a = RString::new(s);

    // Send returns an AnyObject type
    let b = a.send("reverse", None);

    // We must try to convert the AnyObject
    // type back to our usable type.
    match b.try_convert_to::<RString>() {
        Ok(ruby_string) => ruby_string.to_string(),
        Err(_) => "Fail!".to_string(),
    }
}

#[test]
fn it_works() {

    // Rust projects must start the Ruby VM
    VM::init();

    assert_eq!("selppa", try_it("apples"));
}

fn main() {}
