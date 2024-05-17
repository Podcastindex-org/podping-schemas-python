import argparse
import json
from pathlib import Path
from typing import Iterable

from jinja2 import Environment, FileSystemLoader, select_autoescape


env = Environment(
        loader=FileSystemLoader("templates"),
        autoescape=select_autoescape()
    )

json_class_template = env.get_template("python_json_template.j2")


def json_schemas(files: Iterable[str]):
    for file_str in files:
        schema_file_path = Path(file_str)

        stem_pjs = f"{schema_file_path.stem}_pjs"
        output_file_path = Path(file_str).with_stem(stem_pjs).with_suffix(".py")

        json_schema_from_file(schema_file_path, output_file_path)


def json_schema_from_file(schema_file_path: Path, output_file_path: Path):
    schema_json = schema_file_path.read_text()
    schema_dict = json.loads(schema_json)
    output_str = json_schema(schema_dict["title"], schema_dict)
    output_file_path.write_text(output_str)


def json_schema(class_name: str, schema: dict) -> str:

    schema_str = str(schema)

    return json_class_template.render(class_name=class_name, schema_dict=schema_str)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("-s", "--schema-file-path")
    parser.add_argument("-o", "--output-file-path")

    args = parser.parse_args()

    json_schemas(
        [args.schema_file_path,]
    )
