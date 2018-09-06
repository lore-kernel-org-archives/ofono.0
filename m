Content-Type: multipart/mixed; boundary="===============7472485421874543210=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Getting gprs context username and password
Date: Thu, 06 Sep 2018 18:56:51 +0200
Message-ID: <CAKSBH7EqAoL7jX_wqcUGnTcA-aJ9TEDJr-TO+tK_XmbbRnC_Gw@mail.gmail.com>
In-Reply-To: <1d1ee058-4491-83d0-a7f3-0052a586e3dd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7472485421874543210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Mark,

may I know which module are you using?

Regards,
Giacinto



On Thu, Sep 6, 2018 at 6:43 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Mark,
>
> On 09/06/2018 11:31 AM, Mark van der Putten wrote:
> > In the gemalto plugin (static void gemalto_post_sim(struct ofono_modem
> > *modem)) or maybe something sooner in startup phase I would like to
> > implement AT^SGAUTH
>
> Hmm, are you sure you actually need the AT^SGAUTH?
>
> Gemalto is using the atmodem driver.  This driver uses PPP.  Generally
> any CHAP/PAP authentication is done during PPP negotiation phase, not
> via any vendor +FOOAUTH commands (although I think there are a few
> exceptions now)
>
> For modems that use a high-speed interface, the auth parameters are sent
> during context setup phase.  e.g. after +CGDCONT.  See
> drivers/ifxmodem/gprs-context.c setup_cb() for an example.
>
> If you do need the SGAUTH, then the logical place to put it would be
> into drivers/atmodem/gprs-context.c and use a vendor quirk for gemalto.
> E.g. something like:
>
> switch(gcd->vendor) {
> case OFONO_VENDOR_GEMALTO:
>         g_at_chat_send(gcd->chat, "AT^XGAUTH..."....);
>         break;
> }
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============7472485421874543210==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+aGkgTWFyayw8ZGl2Pjxicj48L2Rpdj48ZGl2Pm1heSBJIGtub3cgd2hp
Y2ggbW9kdWxlIGFyZSB5b3UgdXNpbmc/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRz
LDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwg
U2VwIDYsIDIwMTggYXQgNjo0MyBQTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86
ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhpIE1hcmss
PGJyPgo8YnI+Ck9uIDA5LzA2LzIwMTggMTE6MzEgQU0sIE1hcmsgdmFuIGRlciBQdXR0ZW4gd3Jv
dGU6PGJyPgomZ3Q7IEluIHRoZSBnZW1hbHRvIHBsdWdpbiAoc3RhdGljIHZvaWQgZ2VtYWx0b19w
b3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW08YnI+CiZndDsgKm1vZGVtKSkgb3IgbWF5YmUgc29t
ZXRoaW5nIHNvb25lciBpbiBzdGFydHVwIHBoYXNlIEkgd291bGQgbGlrZSB0bzxicj4KJmd0OyBp
bXBsZW1lbnQgQVReU0dBVVRIPGJyPgo8YnI+CkhtbSwgYXJlIHlvdSBzdXJlIHlvdSBhY3R1YWxs
eSBuZWVkIHRoZSBBVF5TR0FVVEg/PGJyPgo8YnI+CkdlbWFsdG8gaXMgdXNpbmcgdGhlIGF0bW9k
ZW0gZHJpdmVyLsKgIFRoaXMgZHJpdmVyIHVzZXMgUFBQLsKgIEdlbmVyYWxseSA8YnI+CmFueSBD
SEFQL1BBUCBhdXRoZW50aWNhdGlvbiBpcyBkb25lIGR1cmluZyBQUFAgbmVnb3RpYXRpb24gcGhh
c2UsIG5vdCA8YnI+CnZpYSBhbnkgdmVuZG9yICtGT09BVVRIIGNvbW1hbmRzIChhbHRob3VnaCBJ
IHRoaW5rIHRoZXJlIGFyZSBhIGZldyA8YnI+CmV4Y2VwdGlvbnMgbm93KTxicj4KPGJyPgpGb3Ig
bW9kZW1zIHRoYXQgdXNlIGEgaGlnaC1zcGVlZCBpbnRlcmZhY2UsIHRoZSBhdXRoIHBhcmFtZXRl
cnMgYXJlIHNlbnQgPGJyPgpkdXJpbmcgY29udGV4dCBzZXR1cCBwaGFzZS7CoCBlLmcuIGFmdGVy
ICtDR0RDT05ULsKgIFNlZSA8YnI+CmRyaXZlcnMvaWZ4bW9kZW0vZ3Bycy1jb250ZXh0LmMgc2V0
dXBfY2IoKSBmb3IgYW4gZXhhbXBsZS48YnI+Cjxicj4KSWYgeW91IGRvIG5lZWQgdGhlIFNHQVVU
SCwgdGhlbiB0aGUgbG9naWNhbCBwbGFjZSB0byBwdXQgaXQgd291bGQgYmUgPGJyPgppbnRvIGRy
aXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYyBhbmQgdXNlIGEgdmVuZG9yIHF1aXJrIGZvciBn
ZW1hbHRvLiA8YnI+CkUuZy4gc29tZXRoaW5nIGxpa2U6PGJyPgo8YnI+CnN3aXRjaChnY2QtJmd0
O3ZlbmRvcikgezxicj4KY2FzZSBPRk9OT19WRU5ET1JfR0VNQUxUTzo8YnI+CsKgIMKgIMKgIMKg
IGdfYXRfY2hhdF9zZW5kKGdjZC0mZ3Q7Y2hhdCwgJnF1b3Q7QVReWEdBVVRILi4uJnF1b3Q7Li4u
Lik7PGJyPgrCoCDCoCDCoCDCoCBicmVhazs8YnI+Cn08YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1E
ZW5pczxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188
YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9y
ZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBz
Oi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGlu
Zm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============7472485421874543210==--

