Content-Type: multipart/mixed; boundary="===============8206444674778426192=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: CDMA modems and oFono
Date: Fri, 04 Nov 2011 14:00:36 +0100
Message-ID: <4EB3E1F4.1010007@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8206444674778426192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I have sent some patches concerning UIM for CDMA modem but I think I am =

missing something around modem.c so you can give them up :)

For the moment, "modem.c" is designed for GSM modem, SIM atom is watched =

to add a state watch to make modem progressing into pre_sim post_sim =

online states etc...
However in the case of a CDMA modem we will have to watch another type =

of atom (UIM for instance) and make the modem progressing into the =

following states: pre_uim post_uim etc...

So what would you suggest to introduce CDMA modem into oFono?
Should we create another src/cdma_modem.c with its own watches, states =

and cdma_atoms?
Or should we keep the current naming (e.g. pre_sim post_sim etc...) and =

change current api to create cdma modem?
Something like: ofono_modem_create(cdma=3Dtrue/false) that is called from =

udevng. Then this new modem would be tagged as cdma and we would look =

for UIM atom intstead of SIM atom in case of cdma modem.

What do you think about it?

Kind regards,
Guillaume

--===============8206444674778426192==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgoKICAgIDxtZXRhIGh0dHAtZXF1aXY9ImNvbnRlbnQtdHlw
ZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PUlTTy04ODU5LTEiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjZmZmZmZmIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxkaXYgY2xhc3M9Im1v
ei10ZXh0LWZsb3dlZCIgc3R5bGU9ImZvbnQtZmFtaWx5OiAtbW96LWZpeGVkOwogICAgICBmb250
LXNpemU6IDEycHg7IiBsYW5nPSJ4LXdlc3Rlcm4iPkhpIERlbmlzLAogICAgICA8YnI+CiAgICAg
IDxicj4KICAgICAgSSBoYXZlIHNlbnQgc29tZSBwYXRjaGVzIGNvbmNlcm5pbmcgVUlNIGZvciBD
RE1BIG1vZGVtIGJ1dCBJIHRoaW5rCiAgICAgIEkgYW0gbWlzc2luZyBzb21ldGhpbmcgYXJvdW5k
IG1vZGVtLmMgc28geW91IGNhbiBnaXZlIHRoZW0gdXAgPHNwYW4KICAgICAgICBjbGFzcz0ibW96
LXNtaWxleS1zMSIgdGl0bGU9IjopIj48c3Bhbj46KTwvc3Bhbj48L3NwYW4+CiAgICAgIDxicj4K
ICAgICAgPGJyPgogICAgICBGb3IgdGhlIG1vbWVudCwgIm1vZGVtLmMiIGlzIGRlc2lnbmVkIGZv
ciBHU00gbW9kZW0sIFNJTSBhdG9tIGlzCiAgICAgIHdhdGNoZWQgdG8gYWRkIGEgc3RhdGUgd2F0
Y2ggdG8gbWFrZSBtb2RlbSBwcm9ncmVzc2luZyBpbnRvCiAgICAgIHByZV9zaW0gcG9zdF9zaW0g
b25saW5lIHN0YXRlcyBldGMuLi4KICAgICAgPGJyPgogICAgICBIb3dldmVyIGluIHRoZSBjYXNl
IG9mIGEgQ0RNQSBtb2RlbSB3ZSB3aWxsIGhhdmUgdG8gd2F0Y2ggYW5vdGhlcgogICAgICB0eXBl
IG9mIGF0b20gKFVJTSBmb3IgaW5zdGFuY2UpIGFuZCBtYWtlIHRoZSBtb2RlbSBwcm9ncmVzc2lu
ZwogICAgICBpbnRvIHRoZSBmb2xsb3dpbmcgc3RhdGVzOiBwcmVfdWltIHBvc3RfdWltIGV0Yy4u
LgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgU28gd2hhdCB3b3VsZCB5b3Ugc3VnZ2VzdCB0
byBpbnRyb2R1Y2UgQ0RNQSBtb2RlbSBpbnRvIG9Gb25vPwogICAgICA8YnI+CiAgICAgIFNob3Vs
ZCB3ZSBjcmVhdGUgYW5vdGhlciBzcmMvY2RtYV9tb2RlbS5jIHdpdGggaXRzIG93biB3YXRjaGVz
LAogICAgICBzdGF0ZXMgYW5kIGNkbWFfYXRvbXM/CiAgICAgIDxicj4KICAgICAgT3Igc2hvdWxk
IHdlIGtlZXAgdGhlIGN1cnJlbnQgbmFtaW5nIChlLmcuIHByZV9zaW0gcG9zdF9zaW0KICAgICAg
ZXRjLi4uKSBhbmQgY2hhbmdlIGN1cnJlbnQgYXBpIHRvIGNyZWF0ZSBjZG1hIG1vZGVtPwogICAg
ICA8YnI+CiAgICAgIFNvbWV0aGluZyBsaWtlOiBvZm9ub19tb2RlbV9jcmVhdGUoY2RtYT10cnVl
L2ZhbHNlKSB0aGF0IGlzIGNhbGxlZAogICAgICBmcm9tIHVkZXZuZy4gVGhlbiB0aGlzIG5ldyBt
b2RlbSB3b3VsZCBiZSB0YWdnZWQgYXMgY2RtYSBhbmQgd2UKICAgICAgd291bGQgbG9vayBmb3Ig
VUlNIGF0b20gaW50c3RlYWQgb2YgU0lNIGF0b20gaW4gY2FzZSBvZiBjZG1hCiAgICAgIG1vZGVt
LgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/
CiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBLaW5kIHJlZ2FyZHMsCiAgICAgIDxicj4KICAg
ICAgR3VpbGxhdW1lCiAgICAgIDxicj4KICAgIDwvZGl2PgogIDwvYm9keT4KPC9odG1sPgo=

--===============8206444674778426192==--

