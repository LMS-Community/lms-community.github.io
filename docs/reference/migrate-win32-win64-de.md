---
layout: default
title: Von der Windows 32-bit Version auf 64-bit umsteigen
---

# Von der Windows 32-bit Version auf 64-bit umsteigen

Wenn Sie Lyrion Music Server auf einem Windows 64-Bit System betreiben, empfehlen wir Ihnen dringend, das 64-Bit-Paket zu installieren.
Es enthält aktuellere Bibliotheken und verlässt sich nicht auf ein Tool, das von seinen Entwicklern vor vielen Jahren aufgegeben wurde.

Das 32-Bit Buildsystem läuft derzeit auf einer virtuellen Maschine, die auf einem Mac Mini von 2014 läuft... wenn diese Maschine ihren Betrieb einstellt, wird die 32-Bit Version verschwinden. Das Buildsystem wird nicht aktualisiert werden.

## Gut zu wissen

Die neue 64-Bit-Version verfügt weder über ein Symbol in der Taskleiste, noch über ein Kontrollfeld. Es gibt ein Werkzeug im Startmenü zur Konfiguration
des Lyrion Music Server Startmodus. Die restliche Konfiguration erfolgt über die LMS Web UI [http://localhost:9000](http://localhost:9000).

## Logitech Media Server (or Lyrion Music Server) 32-bit entfernen

Rufen Sie das Windows-Startmenü auf, um das LMS-Deinstallationsprogramm zu starten. Wenn Sie gefragt werden, ob Sie auch Voreinstellungen und Daten entfernen möchten, _ablehnen_!

Die 64-Bit-Version ist in der Lage, die Daten einer älteren Installation zu übernehmen. Sie müssen also nicht alles neu konfigurieren.

## Die 64-bit Version installieren

Wenn Sie die 64-Bit-Version zum ersten Mal installieren, müssen Sie etwas Geduld haben: Das Installationsprogramm bringt
[Strawberry Perl](https://strawberryperl.com) auf Ihr System. Dies kann einige Minuten dauern, muss aber nur einmal durchgeführt werden.

Sobald die Installation abgeschlossen ist, sollte LMS laufen und Sie sollten in der Lage sein, unter [http://localhost:9000](http://localhost:9000) darauf zuzugreifen.
