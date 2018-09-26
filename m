Content-Type: multipart/mixed; boundary="===============3072823497233012692=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/sms: no mms support for gemalto
Date: Wed, 26 Sep 2018 05:30:45 +0200
Message-ID: <CAKSBH7Gk_TXDz8Tz4Cf2DSYMMX2_1_tOSsUS-9LkQAdaPCxFjg@mail.gmail.com>
In-Reply-To: <55cd4a9f-623f-1583-6528-c5b893c49870@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3072823497233012692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Sep 2018, 16:49 Denis Kenzior, <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/25/2018 08:19 AM, Giacinto Cifelli wrote:
> > ---
> >   drivers/atmodem/sms.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> > index 64169086..64d0f6e8 100644
> > --- a/drivers/atmodem/sms.c
> > +++ b/drivers/atmodem/sms.c
> > @@ -219,10 +219,16 @@ static void at_cmgs(struct ofono_sms *sms, const
> unsigned char *pdu,
> >       char buf[512];
> >       int len;
> >
> > -     if (mms) {
> > -             snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
> > -             g_at_chat_send(data->chat, buf, none_prefix,
> > -                             NULL, NULL, NULL);
> > +     switch(data->vendor) {
>
> Space after switch
>

ok. I thought it was after the entire structure, ie, after the closing }.


> > +     case OFONO_VENDOR_GEMALTO:
> > +             break;
> > +     default:
> > +             if (mms) {
> > +                     snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
> > +                     g_at_chat_send(data->chat, buf, none_prefix,
> > +                                     NULL, NULL, NULL);
> > +             }
> > +             break;
> >       }
>
> Hmm, wouldn't this be more logical & readable this way:
>
> if (mms) {
>         switch (data->vendor) {
>         case:
>         default:
>         }
> }
>

that is a good idea. I will change and submit shortly


> >
> >       len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
> >
>
> Regards,
> -Denis
>

regards,
Giacinto

--===============3072823497233012692==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciI+T24gVHVlLCAyNSBTZXAgMjAxOCwgMTY6NDkgRGVuaXMgS2VuemlvciwgJmx0
OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8YnI+Ck9uIDA5LzI1LzIwMTggMDg6MTkgQU0sIEdp
YWNpbnRvIENpZmVsbGkgd3JvdGU6PGJyPgomZ3Q7IC0tLTxicj4KJmd0O8KgIMKgZHJpdmVycy9h
dG1vZGVtL3Ntcy5jIHwgMTQgKysrKysrKysrKy0tLS08YnI+CiZndDvCoCDCoDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKTxicj4KJmd0OyA8YnI+CiZndDsg
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtb2RlbS9zbXMuYyBiL2RyaXZlcnMvYXRtb2RlbS9zbXMu
Yzxicj4KJmd0OyBpbmRleCA2NDE2OTA4Ni4uNjRkMGY2ZTggMTAwNjQ0PGJyPgomZ3Q7IC0tLSBh
L2RyaXZlcnMvYXRtb2RlbS9zbXMuYzxicj4KJmd0OyArKysgYi9kcml2ZXJzL2F0bW9kZW0vc21z
LmM8YnI+CiZndDsgQEAgLTIxOSwxMCArMjE5LDE2IEBAIHN0YXRpYyB2b2lkIGF0X2NtZ3Moc3Ry
dWN0IG9mb25vX3NtcyAqc21zLCBjb25zdCB1bnNpZ25lZCBjaGFyICpwZHUsPGJyPgomZ3Q7wqAg
wqAgwqAgwqBjaGFyIGJ1Zls1MTJdOzxicj4KJmd0O8KgIMKgIMKgIMKgaW50IGxlbjs8YnI+CiZn
dDvCoCDCoDxicj4KJmd0OyAtwqAgwqAgwqBpZiAobW1zKSB7PGJyPgomZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICZxdW90O0FUK0NNTVM9JWQmcXVv
dDssIG1tcyk7PGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGdfYXRfY2hhdF9zZW5kKGRh
dGEtJmd0O2NoYXQsIGJ1Ziwgbm9uZV9wcmVmaXgsPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEwpOzxicj4KJmd0OyAr
wqAgwqAgwqBzd2l0Y2goZGF0YS0mZ3Q7dmVuZG9yKSB7PGJyPgo8YnI+ClNwYWNlIGFmdGVyIHN3
aXRjaDxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rp
dj48ZGl2IGRpcj0iYXV0byI+b2suIEkgdGhvdWdodCBpdCB3YXMgYWZ0ZXIgdGhlIGVudGlyZSBz
dHJ1Y3R1cmUsIGllLCBhZnRlciB0aGUgY2xvc2luZyB9LjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7ICvCoCDCoCDC
oGNhc2UgT0ZPTk9fVkVORE9SX0dFTUFMVE86PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAobW1zKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICZxdW90O0FUK0NNTVM9JWQmcXVvdDssIG1t
cyk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdfYXRfY2hhdF9z
ZW5kKGRhdGEtJmd0O2NoYXQsIGJ1Ziwgbm9uZV9wcmVmaXgsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEws
IE5VTEwpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPgomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KJmd0O8KgIMKgIMKgIMKgfTxicj4KPGJyPgpIbW0sIHdv
dWxkbiYjMzk7dCB0aGlzIGJlIG1vcmUgbG9naWNhbCAmYW1wOyByZWFkYWJsZSB0aGlzIHdheTo8
YnI+Cjxicj4KaWYgKG1tcykgezxicj4KwqAgwqAgwqAgwqAgc3dpdGNoIChkYXRhLSZndDt2ZW5k
b3IpIHs8YnI+CsKgIMKgIMKgIMKgIGNhc2U6PGJyPgrCoCDCoCDCoCDCoCBkZWZhdWx0Ojxicj4K
wqAgwqAgwqAgwqAgfTxicj4KfTxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+dGhhdCBpcyBhIGdvb2QgaWRlYS4gSSB3
aWxsIGNoYW5nZSBhbmQgc3VibWl0IHNob3J0bHk8L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7
wqAgwqAgwqAgwqBsZW4gPSBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAmcXVvdDtBVCtDTUdT
PSVkXHImcXVvdDssIHRwZHVfbGVuKTs8YnI+CiZndDsgPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgot
RGVuaXM8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9k
aXY+PGRpdiBkaXI9ImF1dG8iPnJlZ2FyZHMsPC9kaXY+PGRpdiBkaXI9ImF1dG8iPkdpYWNpbnRv
PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============3072823497233012692==--

