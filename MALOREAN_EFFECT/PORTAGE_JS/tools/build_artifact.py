# Assemble index.html + tous les <script src> en une seule page pour l'Artifact claude.ai (pas de <html>/<head>/<body>, scripts en ligne).
# Usage : python3 tools/build_artifact.py <sortie.html>
import re, sys, os
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
s = open(os.path.join(root, 'index.html'), encoding='utf8').read()
s = re.sub(r'<script src="([^"]+)"></script>', lambda m: '<script>\n' + open(os.path.join(root, m.group(1)), encoding='utf8').read().replace('</script', '<\\/script') + '\n</script>', s)
style = ''.join(re.findall(r'<style>.*?</style>', s, re.S))
body = re.search(r'<body[^>]*>(.*)</body>', s, re.S).group(1)
open(sys.argv[1], 'w', encoding='utf8').write('<title>Malorean Effect</title>\n' + style + '\n' + body)
