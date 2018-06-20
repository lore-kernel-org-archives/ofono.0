Content-Type: multipart/mixed; boundary="===============3339052626993597177=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: Handling empty row from AT command
Date: Wed, 20 Jun 2018 07:34:29 +0000
Message-ID: <AM5PR1001MB11716B2FEF6BCFC4D2E4C45596770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3339052626993597177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm integrating a new Cinterion module and have a small issue I haven't bee=
n able to solve nicely in Ofono. One of their commands responds with a list=
 of stuff, followed by an OK but also after the OK there is an empty line. =
Which is of course wrong, but it might not be solved for a while. Using the=
 g_at_chat_send function with a callback doesn't seem to work then, the cal=
lback will not be called it seems and I get stuck in the sequence. Can I wi=
thout modifying the AT parser handle this somehow?


/Mattias

--===============3339052626993597177==
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
Z2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+SSdtIGludGVncmF0aW5nIGEgbmV3IENpbnRlcmlv
biBtb2R1bGUgYW5kIGhhdmUgYSBzbWFsbCBpc3N1ZSBJIGhhdmVuJ3QgYmVlbiBhYmxlIHRvIHNv
bHZlIG5pY2VseSBpbiBPZm9uby4gT25lIG9mIHRoZWlyIGNvbW1hbmRzIHJlc3BvbmRzIHdpdGgg
YSBsaXN0IG9mIHN0dWZmLCBmb2xsb3dlZCBieSBhbiBPSyBidXQgYWxzbyBhZnRlciB0aGUgT0sg
dGhlcmUgaXMgYW4gZW1wdHkKIGxpbmUuIFdoaWNoIGlzIG9mIGNvdXJzZSB3cm9uZywgYnV0IGl0
IG1pZ2h0IG5vdCBiZSBzb2x2ZWQgZm9yIGEgd2hpbGUuJm5ic3A7VXNpbmcgdGhlIGdfYXRfY2hh
dF9zZW5kIGZ1bmN0aW9uIHdpdGggYSBjYWxsYmFjayBkb2Vzbid0IHNlZW0gdG8gd29yayB0aGVu
LCB0aGUgY2FsbGJhY2sgd2lsbCBub3QgYmUgY2FsbGVkIGl0IHNlZW1zJm5ic3A7YW5kIEkgZ2V0
IHN0dWNrIGluIHRoZSBzZXF1ZW5jZS4gQ2FuIEkgd2l0aG91dCBtb2RpZnlpbmcgdGhlIEFUIHBh
cnNlcgogaGFuZGxlIHRoaXMgc29tZWhvdz88L3A+CjxwIHN0eWxlPSJtYXJnaW4tdG9wOjA7bWFy
Z2luLWJvdHRvbTowIj48YnI+CjwvcD4KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJnaW4tYm90
dG9tOjAiPi9NYXR0aWFzPC9wPgo8L2Rpdj4KPC9ib2R5Pgo8L2h0bWw+Cg==

--===============3339052626993597177==--

