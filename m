Content-Type: multipart/mixed; boundary="===============4472937930107479152=="
MIME-Version: 1.0
From: Davide Tuccilli <tuccio89@hotmail.com>
Subject: Problem setting up ofono
Date: Thu, 13 Apr 2017 13:09:29 +0000
Message-ID: <VI1PR1001MB07835B467F7C0E0A51AD4C27C9020@VI1PR1001MB0783.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4472937930107479152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to setup ofono on a yocto system, to route calls through HFP. I'=
m running ofono 1.16 pulseaudio 9.0 and bluez 5.28. As far as I understand =
this task shouldn't require much of a setup, and a couple of changes in /et=
c/pulse/default.pa should be enough to get it working:


.ifexists module-bluetooth-policy.so
load-module module-bluetooth-policy ag=3Dtrue
.endif

.ifexists module-bluetooth-discover.so
load-module module-bluetooth-discover headset=3Dofono
.endif


It seems that ofono sees the phone as a modem: https://pastebin.com/bPudNcGR

But nothing happens when I start a call, and even changing the card profile=
 manually to headset_audio_gateway doesn't work, as the bluez source result=
s suspended during calls.


I've tried running ofonod with the -d flag to get some debug information, b=
ut I didn't see anything that could help me, since it stops printing out an=
ything after the connection succeeds, here's the full log: https://pastebin=
.com/gz2tFK4n


It seems to me that I have a problem with ofono/dbus, because when I try to=
 run the dial-number script from the ofono test package, I get this error: =
https://pastebin.com/86iKN5hc


I would need some help to figure out where the problem is, since I don't kn=
ow where to look at.

<https://pastebin.com/86iKN5hc>


<https://pastebin.com/86iKN5hc>

--===============4472937930107479152==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgo8cD5IaSw8
L3A+CjxwPkknbSB0cnlpbmcgdG8gc2V0dXAgb2Zvbm8gb24gYSB5b2N0byBzeXN0ZW0sIHRvIHJv
dXRlIGNhbGxzIHRocm91Z2ggSEZQLiBJJ20gcnVubmluZyBvZm9ubyAxLjE2IHB1bHNlYXVkaW8g
OS4wIGFuZCBibHVleiA1LjI4LiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kIHRoaXMgdGFzayBzaG91
bGRuJ3QgcmVxdWlyZSBtdWNoIG9mIGEgc2V0dXAsIGFuZCBhIGNvdXBsZSBvZiBjaGFuZ2VzIGlu
IC9ldGMvcHVsc2UvZGVmYXVsdC5wYSBzaG91bGQgYmUKIGVub3VnaCB0byBnZXQgaXQgd29ya2lu
Zzo8L3A+CjxwPjxicj4KPC9wPgo8cD48L3A+CjxkaXY+LmlmZXhpc3RzIG1vZHVsZS1ibHVldG9v
dGgtcG9saWN5LnNvPGJyPgpsb2FkLW1vZHVsZSBtb2R1bGUtYmx1ZXRvb3RoLXBvbGljeSBhZz10
cnVlPGJyPgouZW5kaWY8YnI+Cjxicj4KLmlmZXhpc3RzIG1vZHVsZS1ibHVldG9vdGgtZGlzY292
ZXIuc288YnI+CmxvYWQtbW9kdWxlIG1vZHVsZS1ibHVldG9vdGgtZGlzY292ZXIgaGVhZHNldD1v
Zm9ubzxicj4KLmVuZGlmPGJyPgo8L2Rpdj4KPHA+PC9wPgo8cD48YnI+CjwvcD4KPHA+SXQgc2Vl
bXMgdGhhdCBvZm9ubyBzZWVzIHRoZSBwaG9uZSBhcyBhIG1vZGVtOiA8YSBocmVmPSJodHRwczov
L3Bhc3RlYmluLmNvbS9iUHVkTmNHUiIgY2xhc3M9Ik9XQUF1dG9MaW5rIiBpZD0iTFBsbmsyNjg4
MjAiIHByZXZpZXdyZW1vdmVkPSJ0cnVlIj4KaHR0cHM6Ly9wYXN0ZWJpbi5jb20vYlB1ZE5jR1I8
L2E+PGJyPgo8L3A+CjxwPkJ1dCBub3RoaW5nIGhhcHBlbnMgd2hlbiBJIHN0YXJ0IGEgY2FsbCwg
YW5kIGV2ZW4gY2hhbmdpbmcgdGhlIGNhcmQgcHJvZmlsZSBtYW51YWxseSB0byBoZWFkc2V0X2F1
ZGlvX2dhdGV3YXkgZG9lc24ndCB3b3JrLCBhcyB0aGUgYmx1ZXogc291cmNlIHJlc3VsdHMgc3Vz
cGVuZGVkIGR1cmluZyBjYWxscy48L3A+CjxwPjxicj4KPC9wPgo8cD5JJ3ZlIHRyaWVkIHJ1bm5p
bmcgb2Zvbm9kIHdpdGggdGhlIC1kIGZsYWcgdG8gZ2V0IHNvbWUgZGVidWcgaW5mb3JtYXRpb24s
IGJ1dCBJIGRpZG4ndCBzZWUgYW55dGhpbmcgdGhhdCBjb3VsZCBoZWxwIG1lLCBzaW5jZSBpdCBz
dG9wcyBwcmludGluZyBvdXQgYW55dGhpbmcgYWZ0ZXIgdGhlIGNvbm5lY3Rpb24gc3VjY2VlZHMs
IGhlcmUncyB0aGUgZnVsbCBsb2c6CjxhIGhyZWY9Imh0dHBzOi8vcGFzdGViaW4uY29tL2d6MnRG
SzRuIiBjbGFzcz0iT1dBQXV0b0xpbmsiIGlkPSJMUGxuazM5NTc0NSIgcHJldmlld3JlbW92ZWQ9
InRydWUiPgpodHRwczovL3Bhc3RlYmluLmNvbS9nejJ0Rks0bjwvYT48L3A+CjxwPjxicj4KPC9w
Pgo8cD5JdCBzZWVtcyB0byBtZSB0aGF0IEkgaGF2ZSBhIHByb2JsZW0gd2l0aCBvZm9uby9kYnVz
LCBiZWNhdXNlIHdoZW4gSSB0cnkgdG8gcnVuIHRoZSBkaWFsLW51bWJlciBzY3JpcHQgZnJvbSB0
aGUgb2Zvbm8gdGVzdCBwYWNrYWdlLCBJIGdldCB0aGlzIGVycm9yOiZuYnNwOzxhIGhyZWY9Imh0
dHBzOi8vcGFzdGViaW4uY29tLzg2aUtONWhjIiBjbGFzcz0iT1dBQXV0b0xpbmsiIGlkPSJMUGxu
azkxMzkzNiIgcHJldmlld3JlbW92ZWQ9InRydWUiPmh0dHBzOi8vcGFzdGViaW4uY29tLzg2aUtO
NWhjPC9hPjwvcD4KPHA+PGJyPgo8L3A+CjxwPkkgd291bGQgbmVlZCBzb21lIGhlbHAgdG8gZmln
dXJlIG91dCB3aGVyZSB0aGUgcHJvYmxlbSBpcywgc2luY2UgSSBkb24ndCBrbm93IHdoZXJlIHRv
IGxvb2sgYXQuPC9wPgo8cD48YnI+CjxhIGhyZWY9Imh0dHBzOi8vcGFzdGViaW4uY29tLzg2aUtO
NWhjIiBjbGFzcz0iT1dBQXV0b0xpbmsiIGlkPSJMUGxuazYzNzQzMSIgcHJldmlld3JlbW92ZWQ9
InRydWUiPjwvYT48L3A+CjxwPjxhIGhyZWY9Imh0dHBzOi8vcGFzdGViaW4uY29tLzg2aUtONWhj
IiBjbGFzcz0iT1dBQXV0b0xpbmsiIGlkPSJMUGxuazYzNzQzMSIgcHJldmlld3JlbW92ZWQ9InRy
dWUiPjxicj4KPC9hPjwvcD4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============4472937930107479152==--

