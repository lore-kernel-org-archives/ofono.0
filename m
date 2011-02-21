Content-Type: multipart/mixed; boundary="===============6473638646432297820=="
MIME-Version: 1.0
From: Marit Sofie Henriksen <maritsofie.henriksen8@gmail.com>
Subject: Re: [PATCH 2/2] stemodem: Add support for multiple pdp contexts.
Date: Mon, 21 Feb 2011 12:46:45 +0100
Message-ID: <AANLkTimNz-3Ni1qC_WV-jOW1TLV1tYNrKidQJF4D=+TO@mail.gmail.com>
In-Reply-To: <1298052044.2519.30.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6473638646432297820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/2/18 Marcel Holtmann <marcel@holtmann.org>

> Hi Marit,
>
> > Redesigned, there will be only one contexts for each instance of
> > the driver and only one CAIF interface, no longer need the list
> > of caif devices.
> > ---
> >  drivers/stemodem/gprs-context.c |  273
> ++++++++-------------------------------
> >  1 files changed, 57 insertions(+), 216 deletions(-)
>
> it does not compile cleanly.
>
>  CC     drivers/stemodem/gprs-context.o
> cc1: warnings being treated as errors
> drivers/stemodem/gprs-context.c: In function =E2=80=98ste_gprs_context_pr=
obe=E2=80=99:
> drivers/stemodem/gprs-context.c:382:20: error: cast from pointer to integ=
er
> of different size
>
>
Thanks Marcel
I did not get this warning. Maybe because I'm running on 32 bits machine?
I'll resend the patches.

br Marit



> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============6473638646432297820==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8yLzE4IE1hcmNlbCBIb2x0bWFu
biA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzptYXJjZWxAaG9sdG1hbm4ub3Jn
Ij5tYXJjZWxAaG9sdG1hbm4ub3JnPC9hPiZndDs8L3NwYW4+PGJyPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1s
ZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpI
aSBNYXJpdCw8YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDsgUmVkZXNpZ25lZCwgdGhlcmUg
d2lsbCBiZSBvbmx5IG9uZSBjb250ZXh0cyBmb3IgZWFjaCBpbnN0YW5jZSBvZjxicj4KJmd0OyB0
aGUgZHJpdmVyIGFuZCBvbmx5IG9uZSBDQUlGIGludGVyZmFjZSwgbm8gbG9uZ2VyIG5lZWQgdGhl
IGxpc3Q8YnI+CiZndDsgb2YgY2FpZiBkZXZpY2VzLjxicj4KJmd0OyAtLS08YnI+CiZndDsgoGRy
aXZlcnMvc3RlbW9kZW0vZ3Bycy1jb250ZXh0LmMgfCCgMjczICsrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KJmd0OyCgMSBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRp
b25zKCspLCAyMTYgZGVsZXRpb25zKC0pPGJyPgo8YnI+CjwvZGl2Pml0IGRvZXMgbm90IGNvbXBp
bGUgY2xlYW5seS48YnI+Cjxicj4KIKBDQyCgIKAgZHJpdmVycy9zdGVtb2RlbS9ncHJzLWNvbnRl
eHQubzxicj4KY2MxOiB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9yczxicj4KZHJpdmVy
cy9zdGVtb2RlbS9ncHJzLWNvbnRleHQuYzogSW4gZnVuY3Rpb24gkXN0ZV9ncHJzX2NvbnRleHRf
cHJvYmWSOjxicj4KZHJpdmVycy9zdGVtb2RlbS9ncHJzLWNvbnRleHQuYzozODI6MjA6IGVycm9y
OiBjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplPGJyPgo8YnI+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPlRoYW5rcyBNYXJjZWwgPGJyPjwvZGl2PjxkaXY+SSBkaWQg
bm90IGdldCB0aGlzIHdhcm5pbmcuIE1heWJlIGJlY2F1c2UgSSYjMzk7bSBydW5uaW5nIG9uIDMy
IGJpdHMgbWFjaGluZT8gSSYjMzk7bGwgcmVzZW5kIHRoZSBwYXRjaGVzLjxicj48YnI+YnIgTWFy
aXQ8YnI+PGJyPqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2Io
MjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+CgpSZWdhcmRzPGJyPgo8YnI+Ck1h
cmNlbDxicj4KPGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9u
b0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0
cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMu
b2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============6473638646432297820==--

