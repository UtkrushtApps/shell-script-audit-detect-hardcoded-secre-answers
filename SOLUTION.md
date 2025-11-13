# Solution Steps

1. Create a new Bash script file named 'audit_shell_scripts.sh'.

2. Define the directory to scan (scripts/) and the output report file (audit_report.txt).

3. Declare arrays with sensitive patterns ('PASSWORD=', 'API_KEY=', 'SECRET=') and dangerous commands ('rm -rf', 'chmod 777') to search for.

4. Check if the 'scripts/' directory exists. If not, exit with a clear message.

5. Check if there are any .sh files in the directory. If none, exit cleanly and inform the user.

6. Clear (or create) the report file at the beginning of the script to ensure fresh results.

7. Iterate over each .sh file (non-recursively) in 'scripts/'.

8. For each file, search each line for the sensitive patterns and dangerous commands using grep with line numbers.

9. For each match, output the filename, line number, the pattern detected, and the offending line into the report file in a clear format.

10. After processing all files, print a message indicating completion and where to find the report.

