Content-Type: multipart/mixed; boundary="===============7206260684971615921=="
MIME-Version: 1.0
From: Stephan Schmolke <stephan.schmolke@googlemail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sat, 14 May 2016 22:43:10 +0200
Message-ID: <CAP1BnyCTS9OU7a=5QAuQR0SmSo3o7_=EaN2KuTSqE6DBAqmmLg@mail.gmail.com>
In-Reply-To: <5734AFFF.2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7206260684971615921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I assume you don't hear the audio on your PC. It's been 3 years since I
last used ofono but at that time it was necessary to create a loopback
connecting your Bluetooth audio sink and your audio sink (e.g. speakers) so
that the incoming audio is routed to your speakers or headphone.

Best regards,
Stephan Schmolke
Il 12/05/2016 18:11, Denis Kenzior ha scritto:

> There isn't an in-depth tutorial available unfortunately.  If someone
> wants to contribute it to the project, that would be appreciated.
>

I understand. If I will be able to complete my project I will try to write
a more detailed "use-case" manual - at least for the functions I will use.

Modem must be powered & online in order to make calls.
>
> So roughly:
>
> test/enable-modem
> test/online-modem
> test/dial-number
> test/hangup-call
>


Great! Following this procedure my phone made a call.
The last problem (I hope!) is there is no audio.

In the pulseaudio log attached, I see this error:

I: [pulseaudio] module.c: Loaded "module-switch-on-connect" (index: #11;
> argument: "").
> I: [pulseaudio] module.c: Loaded "module-bluetooth-policy" (index: #12;
> argument: "").
> I: [pulseaudio] module.c: Loaded "module-bluez5-discover" (index: #14;
> argument: "headset=3Dauto").
> I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #13;
> argument: "headset=3Dauto").
> I: [pulseaudio] main.c: Daemon startup complete.
> I: [pulseaudio] card.c: Created 2 "bluez_card.08_FD_0E_5A_90_3B"
> W: [pulseaudio] core-error.c: Unable to convert error string to locale,
> filtering.
> E: [pulseaudio] backend-ofono.c: Deferred setup failed on fd -1: Transport
> endpoint is not connected
>

I googled without found something useful about.
Best regards
Marco



_______________________________________________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============7206260684971615921==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHAgZGlyPSJsdHIiPkhpLDwvcD4KPHAgZGlyPSJsdHIiPkkgYXNzdW1lIHlvdSBkb24mIzM5O3Qg
aGVhciB0aGUgYXVkaW8gb24geW91ciBQQy4gSXQmIzM5O3MgYmVlbiAzIHllYXJzIHNpbmNlIEkg
bGFzdCB1c2VkIG9mb25vIGJ1dCBhdCB0aGF0IHRpbWUgaXQgd2FzIG5lY2Vzc2FyeSB0byBjcmVh
dGUgYSBsb29wYmFjayBjb25uZWN0aW5nIHlvdXIgQmx1ZXRvb3RoIGF1ZGlvIHNpbmsgYW5kIHlv
dXIgYXVkaW8gc2luayAoZS5nLiBzcGVha2Vycykgc28gdGhhdCB0aGUgaW5jb21pbmcgYXVkaW8g
aXMgcm91dGVkIHRvIHlvdXIgc3BlYWtlcnMgb3IgaGVhZHBob25lLjwvcD4KPHAgZGlyPSJsdHIi
PkJlc3QgcmVnYXJkcywgPGJyPgpTdGVwaGFuIFNjaG1vbGtlPC9wPgo8ZGl2IGNsYXNzPSJnbWFp
bF9xdW90Jmx0O2Jsb2NrcXVvdGUgY2xhc3M9IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SWwgMTIvMDUvMjAxNiAx
ODoxMSwgRGVuaXMgS2VuemlvciBoYSBzY3JpdHRvOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+ClRoZXJlIGlzbiYjMzk7dCBhbiBpbi1kZXB0aCB0dXRv
cmlhbCBhdmFpbGFibGUgdW5mb3J0dW5hdGVseS7CoCBJZiBzb21lb25lIHdhbnRzIHRvIGNvbnRy
aWJ1dGUgaXQgdG8gdGhlIHByb2plY3QsIHRoYXQgd291bGQgYmUgYXBwcmVjaWF0ZWQuPGJyPgo8
L2Jsb2NrcXVvdGU+Cjxicj4KSSB1bmRlcnN0YW5kLiBJZiBJIHdpbGwgYmUgYWJsZSB0byBjb21w
bGV0ZSBteSBwcm9qZWN0IEkgd2lsbCB0cnkgdG8gd3JpdGUgYSBtb3JlIGRldGFpbGVkICZxdW90
O3VzZS1jYXNlJnF1b3Q7IG1hbnVhbCAtIGF0IGxlYXN0IGZvciB0aGUgZnVuY3Rpb25zIEkgd2ls
bCB1c2UuPGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPgpNb2RlbSBtdXN0IGJlIHBvd2VyZWQgJmFtcDsgb25saW5lIGluIG9yZGVyIHRvIG1ha2Ug
Y2FsbHMuPGJyPgo8YnI+ClNvIHJvdWdobHk6PGJyPgo8YnI+CnRlc3QvZW5hYmxlLW1vZGVtPGJy
Pgp0ZXN0L29ubGluZS1tb2RlbTxicj4KdGVzdC9kaWFsLW51bWJlcjxicj4KdGVzdC9oYW5ndXAt
Y2FsbDxicj4KPC9ibG9ja3F1b3RlPgo8YnI+Cjxicj4KR3JlYXQhIEZvbGxvd2luZyB0aGlzIHBy
b2NlZHVyZSBteSBwaG9uZSBtYWRlIGEgY2FsbC48YnI+ClRoZSBsYXN0IHByb2JsZW0gKEkgaG9w
ZSEpIGlzIHRoZXJlIGlzIG5vIGF1ZGlvLjxicj4KPGJyPgpJbiB0aGUgcHVsc2VhdWRpbyBsb2cg
YXR0YWNoZWQsIEkgc2VlIHRoaXMgZXJyb3I6PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpJOiBbcHVsc2VhdWRpb10gbW9kdWxlLmM6IExvYWRl
ZCAmcXVvdDttb2R1bGUtc3dpdGNoLW9uLWNvbm5lY3QmcXVvdDsgKGluZGV4OiAjMTE7IGFyZ3Vt
ZW50OiAmcXVvdDsmcXVvdDspLjxicj4KSTogW3B1bHNlYXVkaW9dIG1vZHVsZS5jOiBMb2FkZWQg
JnF1b3Q7bW9kdWxlLWJsdWV0b290aC1wb2xpY3kmcXVvdDsgKGluZGV4OiAjMTI7IGFyZ3VtZW50
OiAmcXVvdDsmcXVvdDspLjxicj4KSTogW3B1bHNlYXVkaW9dIG1vZHVsZS5jOiBMb2FkZWQgJnF1
b3Q7bW9kdWxlLWJsdWV6NS1kaXNjb3ZlciZxdW90OyAoaW5kZXg6ICMxNDsgYXJndW1lbnQ6ICZx
dW90O2hlYWRzZXQ9YXV0byZxdW90OykuPGJyPgpJOiBbcHVsc2VhdWRpb10gbW9kdWxlLmM6IExv
YWRlZCAmcXVvdDttb2R1bGUtYmx1ZXRvb3RoLWRpc2NvdmVyJnF1b3Q7IChpbmRleDogIzEzOyBh
cmd1bWVudDogJnF1b3Q7aGVhZHNldD1hdXRvJnF1b3Q7KS48YnI+Ckk6IFtwdWxzZWF1ZGlvXSBt
YWluLmM6IERhZW1vbiBzdGFydHVwIGNvbXBsZXRlLjxicj4KSTogW3B1bHNlYXVkaW9dIGNhcmQu
YzogQ3JlYXRlZCAyICZxdW90O2JsdWV6X2NhcmQuMDhfRkRfMEVfNUFfOTBfM0ImcXVvdDs8YnI+
Clc6IFtwdWxzZWF1ZGlvXSBjb3JlLWVycm9yLmM6IFVuYWJsZSB0byBjb252ZXJ0IGVycm9yIHN0
cmluZyB0byBsb2NhbGUsIGZpbHRlcmluZy48YnI+CkU6IFtwdWxzZWF1ZGlvXSBiYWNrZW5kLW9m
b25vLmM6IERlZmVycmVkIHNldHVwIGZhaWxlZCBvbiBmZCAtMTogVHJhbnNwb3J0IGVuZHBvaW50
IGlzIG5vdCBjb25uZWN0ZWQ8YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpJIGdvb2dsZWQgd2l0aG91
dCBmb3VuZCBzb21ldGhpbmcgdXNlZnVsIGFib3V0Ljxicj4KQmVzdCByZWdhcmRzPGJyPgpNYXJj
bzxicj4KPGJyPgo8YnI+Cjxicj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zv
bm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xp
c3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29m
b25vPC9hPjxicj4KPGJyPjwvZGl2Pgo=

--===============7206260684971615921==--

