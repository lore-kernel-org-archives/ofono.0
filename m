Content-Type: multipart/mixed; boundary="===============0065328595225043259=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Sun, 23 Sep 2018 13:33:14 +0200
Message-ID: <CAKSBH7HDxmrBEGDAnzDGgdQEs9LwjcBGkShn_xw47rrAU9=rbA@mail.gmail.com>
In-Reply-To: <987C8A00-3F3E-4937-B680-ACBD257FFCDD@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0065328595225043259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Sun, Sep 23, 2018 at 12:37 PM Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Giacinto,
>
> > was it necessary to remove entirely the NEED_THREADS flag?
> >
> > I was going to use it in the Gemalto driver, to speed up the device
> recognition, because for some modules it is hit and miss.
> > But only as an optional feature, because in some systems it might be
> missing.
> >
> > Also, for some high-speed modems which take long to boot, there is a
> potential critical race in the recognition that the use threads can solve
> easily. The alternative is to increase the internal timers a lot.
> >
> > I likely need to add a new flag for it.
>
> using threads is not the solution. This can be all done properly with
> single thread event loop driven methods.
>

for sure, and in fact as of now the support is optional.
But I already need to ask for an extension of the Powered timout from 20 to
60 seconds because several LTE chipsets take at least 30-40 seconds to boot
once they have already enumerated on USB. It would be good to shorten this
time.

Besides, several modules use the option linux driver, which blocks in case
the port doesn't answer.
This single call:
g_at_chat_unref(port);
blocks either 30s or 1 minute, depending on the system. I might step into
it twice during my hardware initialization for several 3G models.
It helps to run this line on a separate thread unblocking the rest.

Again, it is not mandatory, but improves a lot the quality of the software
in this and other cases.


> Regards
>
> Marcel
>
>
Regards,
Giacinto

--===============0065328595225043259==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgTWFyY2VsLDxicj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFN1biwgU2VwIDIzLCAyMDE4IGF0IDEy
OjM3IFBNIE1hcmNlbCBIb2x0bWFubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNlbEBob2x0bWFu
bi5vcmciPm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PkhpIEdpYWNpbnRvLDxicj4KPGJyPgomZ3Q7IHdhcyBpdCBuZWNlc3NhcnkgdG8gcmVtb3ZlIGVu
dGlyZWx5IHRoZSBORUVEX1RIUkVBRFMgZmxhZz88YnI+CiZndDsgPGJyPgomZ3Q7IEkgd2FzIGdv
aW5nIHRvIHVzZSBpdCBpbiB0aGUgR2VtYWx0byBkcml2ZXIsIHRvIHNwZWVkIHVwIHRoZSBkZXZp
Y2UgcmVjb2duaXRpb24sIGJlY2F1c2UgZm9yIHNvbWUgbW9kdWxlcyBpdCBpcyBoaXQgYW5kIG1p
c3MuPGJyPgomZ3Q7IEJ1dCBvbmx5IGFzIGFuIG9wdGlvbmFsIGZlYXR1cmUsIGJlY2F1c2UgaW4g
c29tZSBzeXN0ZW1zIGl0IG1pZ2h0IGJlIG1pc3NpbmcuPGJyPgomZ3Q7IDxicj4KJmd0OyBBbHNv
LCBmb3Igc29tZSBoaWdoLXNwZWVkIG1vZGVtcyB3aGljaCB0YWtlIGxvbmcgdG8gYm9vdCwgdGhl
cmUgaXMgYSBwb3RlbnRpYWwgY3JpdGljYWwgcmFjZSBpbiB0aGUgcmVjb2duaXRpb24gdGhhdCB0
aGUgdXNlIHRocmVhZHMgY2FuIHNvbHZlIGVhc2lseS4gVGhlIGFsdGVybmF0aXZlIGlzIHRvIGlu
Y3JlYXNlIHRoZSBpbnRlcm5hbCB0aW1lcnMgYSBsb3QuPGJyPgomZ3Q7IDxicj4KJmd0OyBJIGxp
a2VseSBuZWVkIHRvIGFkZCBhIG5ldyBmbGFnIGZvciBpdC48YnI+Cjxicj4KdXNpbmcgdGhyZWFk
cyBpcyBub3QgdGhlIHNvbHV0aW9uLiBUaGlzIGNhbiBiZSBhbGwgZG9uZSBwcm9wZXJseSB3aXRo
IHNpbmdsZSB0aHJlYWQgZXZlbnQgbG9vcCBkcml2ZW4gbWV0aG9kcy48YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+Zm9yIHN1cmUsIGFuZCBpbiBmYWN0IGFzIG9mIG5vdyB0aGUg
c3VwcG9ydCBpcyBvcHRpb25hbC48L2Rpdj48ZGl2PkJ1dCBJIGFscmVhZHkgbmVlZCB0byBhc2sg
Zm9yIGFuIGV4dGVuc2lvbiBvZiB0aGUgUG93ZXJlZCB0aW1vdXQgZnJvbSAyMCB0byA2MCBzZWNv
bmRzIGJlY2F1c2Ugc2V2ZXJhbCBMVEUgY2hpcHNldHMgdGFrZSBhdCBsZWFzdCAzMC00MCBzZWNv
bmRzIHRvIGJvb3Qgb25jZSB0aGV5IGhhdmUgYWxyZWFkeSBlbnVtZXJhdGVkIG9uIFVTQi4gSXQg
d291bGQgYmUgZ29vZCB0byBzaG9ydGVuIHRoaXMgdGltZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PkJlc2lkZXMsIHNldmVyYWwgbW9kdWxlcyB1c2UgdGhlIG9wdGlvbiBsaW51eCBkcml2ZXIs
IHdoaWNoIGJsb2NrcyBpbiBjYXNlIHRoZSBwb3J0IGRvZXNuJiMzOTt0IGFuc3dlci48L2Rpdj48
ZGl2PlRoaXMgc2luZ2xlIGNhbGw6PC9kaXY+PGRpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+Z19hdF9jaGF0X3VucmVmKHBvcnQpOzwvZGl2PjwvZGl2PjxkaXY+
YmxvY2tzIGVpdGhlciAzMHMgb3IgMSBtaW51dGUsIGRlcGVuZGluZyBvbiB0aGUgc3lzdGVtLiBJ
IG1pZ2h0IHN0ZXAgaW50byBpdCB0d2ljZSBkdXJpbmcgbXkgaGFyZHdhcmUgaW5pdGlhbGl6YXRp
b24gZm9yIHNldmVyYWwgM0cgbW9kZWxzLjwvZGl2PjxkaXY+SXQgaGVscHMgdG8gcnVuIHRoaXMg
bGluZSBvbiBhIHNlcGFyYXRlIHRocmVhZCB1bmJsb2NraW5nIHRoZSByZXN0Ljxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkFnYWluLCBpdCBpcyBub3QgbWFuZGF0b3J5LCBidXQgaW1wcm92
ZXMgYSBsb3QgdGhlIHF1YWxpdHkgb2YgdGhlIHNvZnR3YXJlIGluIHRoaXMgYW5kIG90aGVyIGNh
c2VzLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlJlZ2FyZHM8YnI+Cjxicj4KTWFyY2Vs
PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48
ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============0065328595225043259==--

