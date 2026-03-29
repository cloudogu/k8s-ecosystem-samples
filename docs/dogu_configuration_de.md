# Dogu-Konfiguration
In manchen Fällen kann es nötig sein, dass für Dogus lokal eine spezielle Konfiguration vorgenommen werden muss.
Dies ist zurzeit nur für cas der Fall. Damit das Bereitstellen der Konfiguration für cas ebenfalls einfach gehalten wird, wurde ein Parameter zum Skript `create_dogu_config.sh` ergänzt.
Dieser Parameter ist optional und muss nur gesetzt werden, wenn cas in einer lokalen Umgebung ausgeführt wird.
Entsprechend ist das Skript `cas_config.sh` ebenfalls ergänzt.
Zum Bereitstellen der lokalen Konfiguration:
```shell
./cas_config "local"
```