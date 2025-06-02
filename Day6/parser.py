import re


def count_failed_login(log_file):
    pattern = r"Failed password for"
    count=0
    with open(log_file,'r') as file:
        for line in file:
            if re.search(pattern,line):
                count += 1
    return count

