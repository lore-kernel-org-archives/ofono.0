Content-Type: multipart/mixed; boundary="===============1442457587399403332=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: SV: SV: SV: Handling empty row from AT command
Date: Wed, 20 Jun 2018 14:30:55 +0000
Message-ID: <AM5PR1001MB117113C95262610F52654F3D96770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <3ee3995a-d389-2a50-47b9-d522066a2a9b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1442457587399403332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, thanks! I will talk to them :)

________________________________
Fr=C3=A5n: Denis Kenzior <denkenz@gmail.com>
Skickat: den 20 juni 2018 16:28:12
Till: Mattias M=C3=A5nsson; ofono(a)ofono.org
=C3=84mne: Re: SV: SV: Handling empty row from AT command

Hi Mattias,

By the way, please no top-posting on this list.

> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: AppFinally woke up the modem
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D30\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]:
> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D40\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nDecoder List 0
> bytes sent\r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]:
> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D50\r

So this tells me that XSYSTRACE=3D40 command response was processed
correctly (e.g. OK was detected) and we start the XSYSTRACE=3D50 command.

> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\n\r\n
>

This tells me the modem is buggered and isn't responding with anything
resembling a 'proper' response.  The AT trace will still show anything
that is being sent on the serial port, so if there's no 'OK' showing up,
there isn't much that oFono can do.

> But if I skip the AT+XSYSTRACE=3D40, the sequence runs fine:
>
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: AppFinally woke up the modem
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT+XSYSTRACE=3D30\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]:
> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT+XSYSTRACE=3D50\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]:

Right, so something in the earlier XSYSTRACE sequence is screwing up the
firmware.  Get your vendor on the line.

>
> So I'm suspecting that somehow the extra empty line from AT+XSYSTRACE=3D40
> ends up as the response for the AT+XSYSTRACE=3D50, but as it is not an OK
> it expects more, which for some reason isn't read... Don't know why...

Nope.  The socket is read and data is printed to debug output regardless
of what the syntax state is.  See gatio.c:received_data()

Regards,
-Denis

--===============1442457587399403332==
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
Z2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+T0ssIHRoYW5rcyEgSSB3aWxsIHRhbGsgdG8gdGhl
bSA6KTwvcD4KPC9kaXY+CjxociBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7d2lkdGg6OTgl
IiB0YWJpbmRleD0iLTEiPgo8ZGl2IGlkPSJkaXZScGx5RndkTXNnIiBkaXI9Imx0ciI+PGZvbnQg
ZmFjZT0iQ2FsaWJyaSwgc2Fucy1zZXJpZiIgc3R5bGU9ImZvbnQtc2l6ZToxMXB0IiBjb2xvcj0i
IzAwMDAwMCI+PGI+RnLlbjo8L2I+IERlbmlzIEtlbnppb3IgJmx0O2RlbmtlbnpAZ21haWwuY29t
Jmd0Ozxicj4KPGI+U2tpY2thdDo8L2I+IGRlbiAyMCBqdW5pIDIwMTggMTY6Mjg6MTI8YnI+Cjxi
PlRpbGw6PC9iPiBNYXR0aWFzIE3lbnNzb247IG9mb25vQG9mb25vLm9yZzxicj4KPGI+xG1uZTo8
L2I+IFJlOiBTVjogU1Y6IEhhbmRsaW5nIGVtcHR5IHJvdyBmcm9tIEFUIGNvbW1hbmQ8L2ZvbnQ+
CjxkaXY+Jm5ic3A7PC9kaXY+CjwvZGl2Pgo8ZGl2IGNsYXNzPSJCb2R5RnJhZ21lbnQiPjxmb250
IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTFwdDsiPgo8ZGl2IGNsYXNzPSJQbGFp
blRleHQiPkhpIE1hdHRpYXMsPGJyPgo8YnI+CkJ5IHRoZSB3YXksIHBsZWFzZSBubyB0b3AtcG9z
dGluZyBvbiB0aGlzIGxpc3QuPGJyPgo8YnI+CiZndDsgSnVuIDIwIDEzOjQ0OjAzIGxldi0yNmU3
anZiZSBvZm9ub2RbMTY0NDBdOiBBcHAmZ3Q7IEFUXHI8YnI+CiZndDsgSnVuIDIwIDEzOjQ0OjAz
IGxldi0yNmU3anZiZSBvZm9ub2RbMTY0NDBdOiBBcHAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsg
SnVuIDIwIDEzOjQ0OjAzIGxldi0yNmU3anZiZSBvZm9ub2RbMTY0NDBdOiBBcHBGaW5hbGx5IHdv
a2UgdXAgdGhlIG1vZGVtPGJyPgomZ3Q7IEp1biAyMCAxMzo0NDowMyBsZXYtMjZlN2p2YmUgb2Zv
bm9kWzE2NDQwXTogQXBwJmd0OyBBVCYjNDM7WFNZU1RSQUNFPTMwXHI8YnI+CiZndDsgSnVuIDIw
IDEzOjQ0OjAzIGxldi0yNmU3anZiZSBvZm9ub2RbMTY0NDBdOiBBcHAmbHQ7IFxyXG5PS1xyXG48
YnI+CiZndDsgSnVuIDIwIDEzOjQ0OjAzIGxldi0yNmU3anZiZSBvZm9ub2RbMTY0NDBdOiA8YnI+
CiZndDsgcGx1Z2lucy92ZXJpbWFsdG8uYzp0cmFjZV9zdGFydF9hdF9jYigpPGJyPgomZ3Q7IEp1
biAyMCAxMzo0NDowMyBsZXYtMjZlN2p2YmUgb2Zvbm9kWzE2NDQwXTogQXBwJmd0OyBBVCYjNDM7
WFNZU1RSQUNFPTQwXHI8YnI+CiZndDsgSnVuIDIwIDEzOjQ0OjAzIGxldi0yNmU3anZiZSBvZm9u
b2RbMTY0NDBdOiBBcHAmbHQ7IFxyXG5EZWNvZGVyIExpc3QgMCA8YnI+CiZndDsgYnl0ZXMgc2Vu
dFxyXG5PS1xyXG48YnI+CiZndDsgSnVuIDIwIDEzOjQ0OjAzIGxldi0yNmU3anZiZSBvZm9ub2Rb
MTY0NDBdOiA8YnI+CiZndDsgcGx1Z2lucy92ZXJpbWFsdG8uYzp0cmFjZV9zdGFydF9hdF9jYigp
PGJyPgomZ3Q7IEp1biAyMCAxMzo0NDowMyBsZXYtMjZlN2p2YmUgb2Zvbm9kWzE2NDQwXTogQXBw
Jmd0OyBBVCYjNDM7WFNZU1RSQUNFPTUwXHI8YnI+Cjxicj4KU28gdGhpcyB0ZWxscyBtZSB0aGF0
IFhTWVNUUkFDRT00MCBjb21tYW5kIHJlc3BvbnNlIHdhcyBwcm9jZXNzZWQgPGJyPgpjb3JyZWN0
bHkgKGUuZy4gT0sgd2FzIGRldGVjdGVkKSBhbmQgd2Ugc3RhcnQgdGhlIFhTWVNUUkFDRT01MCBj
b21tYW5kLjxicj4KPGJyPgomZ3Q7IEp1biAyMCAxMzo0NDowMyBsZXYtMjZlN2p2YmUgb2Zvbm9k
WzE2NDQwXTogQXBwJmx0OyBcclxuXHJcbjxicj4KJmd0OyA8YnI+Cjxicj4KVGhpcyB0ZWxscyBt
ZSB0aGUgbW9kZW0gaXMgYnVnZ2VyZWQgYW5kIGlzbid0IHJlc3BvbmRpbmcgd2l0aCBhbnl0aGlu
ZyA8YnI+CnJlc2VtYmxpbmcgYSAncHJvcGVyJyByZXNwb25zZS4mbmJzcDsgVGhlIEFUIHRyYWNl
IHdpbGwgc3RpbGwgc2hvdyBhbnl0aGluZyA8YnI+CnRoYXQgaXMgYmVpbmcgc2VudCBvbiB0aGUg
c2VyaWFsIHBvcnQsIHNvIGlmIHRoZXJlJ3Mgbm8gJ09LJyBzaG93aW5nIHVwLCA8YnI+CnRoZXJl
IGlzbid0IG11Y2ggdGhhdCBvRm9ubyBjYW4gZG8uPGJyPgo8YnI+CiZndDsgQnV0IGlmIEkgc2tp
cCB0aGUmbmJzcDtBVCYjNDM7WFNZU1RSQUNFPTQwLCB0aGUgc2VxdWVuY2UgcnVucyBmaW5lOjxi
cj4KJmd0OyA8YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0IGxldi0yNmU3anZiZSBvZm9ub2RbMTY1
OThdOiBBcHAmZ3Q7IEFUXHI8YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0IGxldi0yNmU3anZiZSBv
Zm9ub2RbMTY1OThdOiBBcHAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0
IGxldi0yNmU3anZiZSBvZm9ub2RbMTY1OThdOiBBcHBGaW5hbGx5IHdva2UgdXAgdGhlIG1vZGVt
PGJyPgomZ3Q7IEp1biAyMCAxMzo1NDowNCBsZXYtMjZlN2p2YmUgb2Zvbm9kWzE2NTk4XTogQXBw
Jmd0OyBBVCYjNDM7WFNZU1RSQUNFPTMwXHI8YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0IGxldi0y
NmU3anZiZSBvZm9ub2RbMTY1OThdOiBBcHAmbHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgSnVuIDIw
IDEzOjU0OjA0IGxldi0yNmU3anZiZSBvZm9ub2RbMTY1OThdOiA8YnI+CiZndDsgcGx1Z2lucy92
ZXJpbWFsdG8uYzp0cmFjZV9zdGFydF9hdF9jYigpPGJyPgomZ3Q7IEp1biAyMCAxMzo1NDowNCBs
ZXYtMjZlN2p2YmUgb2Zvbm9kWzE2NTk4XTogQXBwJmd0OyBBVCYjNDM7WFNZU1RSQUNFPTUwXHI8
YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0IGxldi0yNmU3anZiZSBvZm9ub2RbMTY1OThdOiBBcHAm
bHQ7IFxyXG5PS1xyXG48YnI+CiZndDsgSnVuIDIwIDEzOjU0OjA0IGxldi0yNmU3anZiZSBvZm9u
b2RbMTY1OThdOiA8YnI+Cjxicj4KUmlnaHQsIHNvIHNvbWV0aGluZyBpbiB0aGUgZWFybGllciBY
U1lTVFJBQ0Ugc2VxdWVuY2UgaXMgc2NyZXdpbmcgdXAgdGhlIDxicj4KZmlybXdhcmUuJm5ic3A7
IEdldCB5b3VyIHZlbmRvciBvbiB0aGUgbGluZS48YnI+Cjxicj4KJmd0OyA8YnI+CiZndDsgU28g
SSdtIHN1c3BlY3RpbmcgdGhhdCBzb21laG93IHRoZSBleHRyYSBlbXB0eSBsaW5lIGZyb20gQVQm
IzQzO1hTWVNUUkFDRT00MCA8YnI+CiZndDsgZW5kcyB1cCBhcyB0aGUgcmVzcG9uc2UgZm9yIHRo
ZSBBVCYjNDM7WFNZU1RSQUNFPTUwLCBidXQgYXMgaXQgaXMgbm90IGFuIE9LIDxicj4KJmd0OyBp
dCBleHBlY3RzIG1vcmUsIHdoaWNoIGZvciBzb21lIHJlYXNvbiBpc24ndCByZWFkLi4uIERvbid0
IGtub3cgd2h5Li4uPGJyPgo8YnI+Ck5vcGUuJm5ic3A7IFRoZSBzb2NrZXQgaXMgcmVhZCBhbmQg
ZGF0YSBpcyBwcmludGVkIHRvIGRlYnVnIG91dHB1dCByZWdhcmRsZXNzIDxicj4Kb2Ygd2hhdCB0
aGUgc3ludGF4IHN0YXRlIGlzLiZuYnNwOyBTZWUgZ2F0aW8uYzpyZWNlaXZlZF9kYXRhKCk8YnI+
Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9kaXY+Cjwvc3Bhbj48L2ZvbnQ+PC9kaXY+
CjwvYm9keT4KPC9odG1sPgo=

--===============1442457587399403332==--

