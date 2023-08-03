import io
import os
import sys
import difflib

from os import path
from subprocess import Popen, PIPE

xsltproc = path.join(os.getcwd(), "win32", "bin.msvc", "xsltproc.exe")
if not path.isfile(xsltproc):
    xsltproc = path.join(os.getcwd(), "win32", "bin.mingw", "xsltproc.exe")
    if not path.isfile(xsltproc):
        raise FileNotFoundError(xsltproc)

def runtests(xsl_dir, xml_dir="."):
    old_dir = os.getcwd()
    os.chdir(xsl_dir)

    for xsl_file in os.listdir():
        if not xsl_file.endswith(".xsl"):
            continue
        xsl_path = "./" + xsl_file
        name = path.splitext(xsl_file)[0]

        xml_path = path.join(xml_dir + "/" + name + ".xml")
        if not path.isfile(xml_path):
            continue

        args = [ xsltproc, "--maxdepth", "200", xsl_path, xml_path ]
        p = Popen(args, stdout=PIPE, stderr=PIPE)
        out_path = path.join(xml_dir, name + ".out")
        err_path = path.join(xml_dir, name + ".err")
        out_diff = diff(p.stdout, "<stdout>", name + ".out")
        err_diff = diff(p.stderr, "<stderr>", name + ".err")

        if (len(out_diff) or len(err_diff)):
            sys.stdout.writelines(out_diff)
            sys.stdout.writelines(err_diff)
            print()

    os.chdir(old_dir)

def diff(got_stream, got_name, expected_path):
    text_stream = io.TextIOWrapper(got_stream, encoding="latin_1")
    got_lines = text_stream.readlines()

    if path.isfile(expected_path):
        file = open(expected_path, "r", encoding="latin_1")
        expected_lines = file.readlines()
    else:
        expected_lines = []

    diff = difflib.unified_diff(expected_lines, got_lines,
                                fromfile=expected_path,
                                tofile=got_name)
    return list(diff)

print("## Running REC tests")
runtests("tests/REC")

print("## Running general tests")
runtests("tests/general", "./../docs")

print("## Running exslt common tests")
runtests("tests/exslt/common")

print("## Running exslt functions tests")
runtests("tests/exslt/functions")

print("## Running exslt math tests")
runtests("tests/exslt/math")

print("## Running exslt saxon tests")
runtests("tests/exslt/saxon")

print("## Running exslt sets tests")
runtests("tests/exslt/sets")

print("## Running exslt strings tests")
runtests("tests/exslt/strings")

print("## Running exslt dynamic tests")
runtests("tests/exslt/dynamic")

print("## Running exslt date tests")
runtests("tests/exslt/date")

