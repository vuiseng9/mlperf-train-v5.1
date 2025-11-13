import argparse
from datasets import load_dataset
from itertools import islice
import json


def main():
    parser = argparse.ArgumentParser(description="Create a small C4 subset in JSONL format.")
    parser.add_argument(
        "-n", "--n",
        type=int,
        default=10_000,
        help="Number of samples to dump from C4 split (default: 10000).",
    )
    parser.add_argument(
        "--val",
        action="store_true",
        help="Use the validation split instead of train.",
    )
    args = parser.parse_args()
    N = args.n
    use_val = args.val

    split = "validation" if use_val else "train"
    split_tag = "val" if use_val else "train"

    print(f"Loading C4 (allenai/c4, en, {split} split) in streaming mode...")
    ds = load_dataset("allenai/c4", "en", split=split, streaming=True)

    subset = islice(ds, N)
    out_path = f"c4_{split_tag}_{N}.jsonl"

    print(f"Writing {N} samples from split '{split}' to {out_path} ...")
    with open(out_path, "w", encoding="utf-8") as f:
        for ex in subset:
            text = ex.get("text", "")
            f.write(json.dumps({"text": text}) + "\n")

    print("Done.")


if __name__ == "__main__":
    main()
