import yaml, sys

try:
    quelle = open("neo20.yaml")
    try:
        wurzel = yaml.load(quelle) #_all entfernen
    finally:
        quelle.close()
    
except IOError:
    pass
except yaml.YAMLError, exc:
    if hasattr(exc, 'problem_mark'):
        mark = exc.problem_mark
        print "YAML-Parserfehler: (%s:%s)" % (mark.line+1, mark.column+1)
        sys.stdin.read()
