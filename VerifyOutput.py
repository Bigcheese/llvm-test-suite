def executeCommand(command, cwd=None, env=None):
  import signal, subprocess
  p = subprocess.Popen(command, cwd=cwd,
                       stdin=subprocess.PIPE,
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE,
                       env=env)
  out, err = p.communicate()
  exitCode = p.wait()

  # Detect Ctrl-C in subprocess.
  if exitCode == -signal.SIGINT:
    raise KeyboardInterrupt

  return out, err, exitCode

if __name__ == "__main__":
  from optparse import OptionParser, OptionGroup
  import sys
  parser = OptionParser("usage: %prog \"command to run\" reference-output")
#  parser.add_option("", "--dump-section-data", dest="dumpSectionData",
#  help="Dump the contents of sections",
#  action="store_true", default=False)
  (opts, args) = parser.parse_args()

  if len(args) == 0:
    parser.error("incorrect number of arguments")

  print('command: ' + args[0])
  if len(args) > 1:
    print('reference output: ' + args[1])

  out, err, exit = executeCommand(args[0].split(' '))

  ExitStr = "exit %s" % exit

  if len(args) > 1:
    ReferenceOutput = open(args[1], 'r')
    ReferenceOutputLines = ReferenceOutput.read().splitlines()
  else:
    ReferenceOutputLines = ["exit 0"]

  if out.splitlines() != ReferenceOutputLines[:-1]:
    print("======================TEST FAILED!!!!============================")
    print(out.splitlines())
    print(ReferenceOutputLines[:-1])
    print("=================================================================")
    sys.exit("Reference Output Differs!")

  if ExitStr != ReferenceOutputLines[-1]:
    print("======================TEST FAILED!!!!============================")
    print(ExitStr)
    print(ReferenceOutputLines[-1][:-1])
    print("=================================================================")
    sys.exit("Reference Exit Code Differs!")
