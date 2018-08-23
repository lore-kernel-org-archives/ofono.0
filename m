Content-Type: multipart/mixed; boundary="===============5428738282658515038=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Ofono and Intel Clovertrail+
Date: Thu, 23 Aug 2018 04:29:56 +0200
Message-ID: <CAKSBH7GLGKby8WrveH3uYv3pbcvqCAKobrUZh5Vdt6PDjkvHVQ@mail.gmail.com>
In-Reply-To: <165636a9e99.1080f78118117.5400090142518811727@zoho.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5428738282658515038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Ilya,

it looks like a RIL issue, not especially due to oFono, which is merely
reporting the error.
I don't know if you can enable the log of the modem commands in the RIL
driver, but it looks like nothing is executed.

My opinion is that the oFono-RIL connection works fine, but the RIL-modem
connection doesn't.

is your modem switched on? Just after the RIL is initialized, I see in the
RIL trace;
07-31 05:52:41.748    65   144 I RILR1   : [RIL STATE] (RIL <- MMGR)
MODEM_DOWN

Check your android logs for security issues, make sure that RIL is using
the right device , and that the modem works.
If you can connect directly to the modem with a terminal program instead of
the RIL driver, try sending a couple of AT commands, like 'AT', 'AT+CFUN?',
'AT+CPIN?', 'AT+COPS?'.

Best Regards,
Giacinto


On Wed, Aug 22, 2018@10:54 PM Ilya Bizyaev <bizyaev@zoho.com> wrote:

> Hello everyone,
>
> I am currently working on a Halium <https://halium.org> port to an Intel
> Clovertrail+ phone, ASUS ZenFone 5 (A501CG). At the moment most vital
> device functions are supported, but it lacks the ability to make calls and
> send SMS. I have made some attempts to enable these features with Ofono b=
ut
> ran into issues.
>
> The device uses the XMM6360 modem and Intrinsyc Rapid-RIL M6.59, so I
> attempted to start the Ofono daemon like this:
> # OFONO_RIL_DEVICE=3Dril OFONO_RIL_TRACE=3D1 ofonod -d -n
> But it failed to detect the SIM card with various errors like
> E_RADIO_NOT_AVAILABLE:
> Ofono log: https://paste.kde.org/pjpiczknh
> RIL log: https://paste.kde.org/pmt7drhforo8
> <https://paste.kde.org/pmt7drho8>
>
> There is almost no publicly available information on the subject, so I
> would like to ask your opinion about my project, especially from the
> perspective of Ofono. Do you think it is possible to make this modem work
> with Ofono? Are there any tricky details or quirks I should know about? A=
ny
> experience you can share is highly valuable to me.
>
> Best regards,
> Ilya Bizyaev.
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============5428738282658515038==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8gSWx5YSw8ZGl2Pjxicj48L2Rpdj48ZGl2Pml0IGxvb2tzIGxp
a2UgYSBSSUwgaXNzdWUsIG5vdCBlc3BlY2lhbGx5IGR1ZSB0byBvRm9ubywgd2hpY2ggaXMgbWVy
ZWx5IHJlcG9ydGluZyB0aGUgZXJyb3IuPC9kaXY+PGRpdj5JIGRvbiYjMzk7dCBrbm93IGlmIHlv
dSBjYW4gZW5hYmxlIHRoZSBsb2cgb2YgdGhlIG1vZGVtIGNvbW1hbmRzIGluIHRoZSBSSUwgZHJp
dmVyLCBidXQgaXQgbG9va3MgbGlrZSBub3RoaW5nIGlzIGV4ZWN1dGVkLjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+TXkgb3BpbmlvbiBpcyB0aGF0IHRoZSBvRm9uby1SSUwgY29ubmVjdGlvbiB3
b3JrcyBmaW5lLCBidXQgdGhlIFJJTC1tb2RlbSBjb25uZWN0aW9uIGRvZXNuJiMzOTt0LjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+aXMgeW91ciBtb2RlbSBzd2l0Y2hlZCBvbj8gSnVzdCBhZnRl
ciB0aGUgUklMIGlzIGluaXRpYWxpemVkLCBJIHNlZSBpbiB0aGUgUklMIHRyYWNlOzwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig0Niw1Miw1NCk7Zm9udC1mYW1pbHk6bW9ub3NwYWNl
O2ZvbnQtc2l6ZToxM3B4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1MSwyNDcsMjExKSI+MDctMzEg
MDU6NTI6NDEuNzQ4IMKgIMKgNjUgwqAgMTQ0IEkgUklMUjEgwqAgOiBbUklMIFNUQVRFXSAoUklM
ICZsdDstIE1NR1IpIE1PREVNX0RPV048L3NwYW4+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+Q2hlY2sgeW91ciBhbmRyb2lkIGxvZ3MgZm9yIHNlY3VyaXR5IGlzc3VlcywgbWFrZSBzdXJl
IHRoYXQgUklMIGlzIHVzaW5nIHRoZSByaWdodCBkZXZpY2UgLCBhbmQgdGhhdCB0aGUgbW9kZW0g
d29ya3MuPC9kaXY+PGRpdj5JZiB5b3UgY2FuIGNvbm5lY3QgZGlyZWN0bHkgdG8gdGhlIG1vZGVt
IHdpdGggYSB0ZXJtaW5hbCBwcm9ncmFtIGluc3RlYWQgb2YgdGhlIFJJTCBkcml2ZXIsIHRyeSBz
ZW5kaW5nIGEgY291cGxlIG9mIEFUIGNvbW1hbmRzLCBsaWtlICYjMzk7QVQmIzM5OywgJiMzOTtB
VCtDRlVOPyYjMzk7LCAmIzM5O0FUK0NQSU4/JiMzOTssICYjMzk7QVQrQ09QUz8mIzM5Oy48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgUmVnYXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9k
aXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIj5PbiBXZWQsIEF1ZyAyMiwgMjAxOCBhdCAxMDo1NCBQTSBJbHlhIEJpenlhZXYg
Jmx0OzxhIGhyZWY9Im1haWx0bzpiaXp5YWV2QHpvaG8uY29tIj5iaXp5YWV2QHpvaG8uY29tPC9h
PiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPjx1PjwvdT48ZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxMHB0O2ZvbnQtZmFt
aWx5OlZlcmRhbmEsQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Y29sb3I6IzAwMDAwIj48ZGl2
PkhlbGxvIGV2ZXJ5b25lLDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gY3VycmVu
dGx5IHdvcmtpbmcgb24gYSA8YSBocmVmPSJodHRwczovL2hhbGl1bS5vcmciIHRhcmdldD0iX2Js
YW5rIj5IYWxpdW08L2E+IHBvcnQgdG8gYW4gSW50ZWwgQ2xvdmVydHJhaWwrIHBob25lLCBBU1VT
IFplbkZvbmUgNSAoQTUwMUNHKS4gQXQgdGhlIG1vbWVudCBtb3N0IHZpdGFsIGRldmljZSBmdW5j
dGlvbnMgYXJlIHN1cHBvcnRlZCwgYnV0IGl0IGxhY2tzIHRoZSBhYmlsaXR5IHRvIG1ha2UgY2Fs
bHMgYW5kIHNlbmQgU01TLiBJIGhhdmUgbWFkZSBzb21lIGF0dGVtcHRzIHRvIGVuYWJsZSB0aGVz
ZSBmZWF0dXJlcyB3aXRoIE9mb25vIGJ1dCByYW4gaW50byBpc3N1ZXMuPGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+VGhlIGRldmljZSB1c2VzIHRoZSBYTU02MzYwIG1vZGVtIGFuZCBJbnRy
aW5zeWMgUmFwaWQtUklMIE02LjU5LCBzbyBJIGF0dGVtcHRlZCB0byBzdGFydCB0aGUgT2Zvbm8g
ZGFlbW9uIGxpa2UgdGhpczo8YnI+PC9kaXY+PGRpdj48c3BhbiBjbGFzcz0ibV8tODc1MjIyMjQ1
NTUzMDQyOTgzNGZvbnQiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtjb3VyaWVyIG5ldyZxdW90
Oyxjb3VyaWVyLG1vbm9zcGFjZSxzYW5zLXNlcmlmIj4jIE9GT05PX1JJTF9ERVZJQ0U9cmlsIE9G
T05PX1JJTF9UUkFDRT0xIG9mb25vZCAtZCAtbjwvc3Bhbj48YnI+PC9kaXY+PGRpdj48c3BhbiBj
bGFzcz0ibV8tODc1MjIyMjQ1NTUzMDQyOTgzNGZvbnQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJk
YW5hLHNhbnMtc2VyaWYiPkJ1dCBpdCBmYWlsZWQgdG8gZGV0ZWN0IHRoZSBTSU0gY2FyZCB3aXRo
IHZhcmlvdXMgZXJyb3JzIGxpa2UgRV9SQURJT19OT1RfQVZBSUxBQkxFOjwvc3Bhbj48YnI+PC9k
aXY+PGRpdj5PZm9ubyBsb2c6IDxhIGhyZWY9Imh0dHBzOi8vcGFzdGUua2RlLm9yZy9wanBpY3pr
bmgiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3Bhc3RlLmtkZS5vcmcvcGpwaWN6a25oPC9hPjxi
cj48L2Rpdj48ZGl2PlJJTCBsb2c6IDxhIGhyZWY9Imh0dHBzOi8vcGFzdGUua2RlLm9yZy9wbXQ3
ZHJobzgiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3Bhc3RlLmtkZS5vcmcvcG10N2RyaGZvcm84
PC9hPjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlIGlzIGFsbW9zdCBubyBwdWJs
aWNseSBhdmFpbGFibGUgaW5mb3JtYXRpb24gb24gdGhlIHN1YmplY3QsIHNvIEkgCndvdWxkIGxp
a2UgdG8gYXNrIHlvdXIgb3BpbmlvbiBhYm91dCBteSBwcm9qZWN0LCBlc3BlY2lhbGx5IGZyb20g
dGhlIApwZXJzcGVjdGl2ZSBvZiBPZm9uby4gRG8geW91IHRoaW5rIGl0IGlzIHBvc3NpYmxlIHRv
IG1ha2UgdGhpcyBtb2RlbSAKd29yayB3aXRoIE9mb25vPyBBcmUgdGhlcmUgYW55IHRyaWNreSBk
ZXRhaWxzIG9yIHF1aXJrcyBJIHNob3VsZCBrbm93IAphYm91dD8gQW55IGV4cGVyaWVuY2UgeW91
IGNhbiBzaGFyZSBpcyBoaWdobHkgdmFsdWFibGUgdG8gbWUuPGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+QmVzdCByZWdhcmRzLDxicj48L2Rpdj48ZGl2PklseWEgQml6eWFldi48YnI+PC9k
aXY+PC9kaXY+PGJyPjwvZGl2Pl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9u
b0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBo
cmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWls
bWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============5428738282658515038==--

