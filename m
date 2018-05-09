Content-Type: multipart/mixed; boundary="===============7615801217043178711=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: AT error handling
Date: Wed, 09 May 2018 08:28:44 +0000
Message-ID: <AM5PR1001MB1171748B26B24E311D6AB16996990@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7615801217043178711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have a problem with a modem and USB suspend where the OK from some AT com=
mands are sometimes lost. This will be corrected by the vendor, but it got =
me wondering how Ofono handles problems like this. As I can see, there is n=
o timeouts for AT commands that doesn't respond? Or have I missed something=
? It seemed to me that Ofono got stuck in the initial setup forever if this=
 happens. In my experience you can't trust that a modem will always respond=
 and in that case it might be good to have a timeout and reset the modem or=
 something like that.


/Mattias

--===============7615801217043178711==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgo8cCBzdHlsZT0ibWFy
Z2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+SSBoYXZlIGEgcHJvYmxlbSB3aXRoIGEgbW9kZW0g
YW5kIFVTQiBzdXNwZW5kIHdoZXJlIHRoZSBPSyBmcm9tIHNvbWUgQVQgY29tbWFuZHMgYXJlIHNv
bWV0aW1lcyZuYnNwO2xvc3QuIFRoaXMgd2lsbCBiZSBjb3JyZWN0ZWQgYnkgdGhlIHZlbmRvciwg
YnV0IGl0IGdvdCBtZSB3b25kZXJpbmcgaG93IE9mb25vIGhhbmRsZXMgcHJvYmxlbXMgbGlrZSB0
aGlzLiBBcyBJIGNhbiBzZWUsIHRoZXJlCiBpcyBubyB0aW1lb3V0cyBmb3IgQVQgY29tbWFuZHMg
dGhhdCBkb2Vzbid0IHJlc3BvbmQ/IE9yIGhhdmUgSSBtaXNzZWQgc29tZXRoaW5nPyBJdCBzZWVt
ZWQgdG8gbWUgdGhhdCBPZm9ubyBnb3Qgc3R1Y2sgaW4gdGhlIGluaXRpYWwgc2V0dXAgZm9yZXZl
ciBpZiB0aGlzIGhhcHBlbnMuJm5ic3A7SW4gbXkgZXhwZXJpZW5jZSB5b3UgY2FuJ3QgdHJ1c3Qg
dGhhdCBhIG1vZGVtIHdpbGwgYWx3YXlzIHJlc3BvbmQgYW5kIGluIHRoYXQgY2FzZSBpdCBtaWdo
dAogYmUgZ29vZCB0byBoYXZlIGEgdGltZW91dCBhbmQgcmVzZXQgdGhlIG1vZGVtIG9yIHNvbWV0
aGluZyBsaWtlIHRoYXQuPC9wPgo8cCBzdHlsZT0ibWFyZ2luLXRvcDowO21hcmdpbi1ib3R0b206
MCI+PGJyPgo8L3A+CjxwIHN0eWxlPSJtYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowIj4vTWF0
dGlhczwvcD4KPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============7615801217043178711==--

