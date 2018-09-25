Content-Type: multipart/mixed; boundary="===============5851896782099009462=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/sim: added vendor Gemalto
Date: Tue, 25 Sep 2018 06:07:02 +0200
Message-ID: <CAKSBH7HcXLwdrd73ACcQCVRvfdqJQmNmOheBH3oJuHBMjD7u+g@mail.gmail.com>
In-Reply-To: <08079727-3969-e420-52da-1d8fd9f63066@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5851896782099009462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 6:04 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> > But the VENDOR_CINTERION remains in the code, there are no changes for
> > the plugin.
> >
>
> That's exactly the point.  You have taken out all VENDOR_CINTERION
> logic, yet plugins/gemalto.c still sets VENDOR_CINTERION for the sim
> atom.  So now you broke that driver.  Your change set is not
> self-contained.  If I apply this patch and you get hit by a bus
> tomorrow, the plugin remains broken for everyone.
>

It is not taken out. It is:
       case OFONO_VENDOR_CINTERION:
       case OFONO_VENDOR_GEMALTO:
               if (g_at_chat_send(sd->chat, "AT^SPIC", gemalto_spic_prefix,
                                       gemalto_spic_cb, cbd, g_free) > 0)

both are there, and the functions are renamed, but still there.
Or shall I duplicate the functions for the time being?



>
> Regards,
> -Denis
>

--===============5851896782099009462==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gVHVlLCBTZXAgMjUsIDIwMTggYXQgNjowNCBBTSBEZW5pcyBLZW56aW9yICZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgomZ3Q7IEJ1dCB0aGUgVkVORE9SX0NJTlRFUklP
TiByZW1haW5zIGluIHRoZSBjb2RlLCB0aGVyZSBhcmUgbm8gY2hhbmdlcyBmb3IgPGJyPgomZ3Q7
IHRoZSBwbHVnaW4uPGJyPgomZ3Q7IDxicj4KPGJyPgpUaGF0JiMzOTtzIGV4YWN0bHkgdGhlIHBv
aW50LsKgIFlvdSBoYXZlIHRha2VuIG91dCBhbGwgVkVORE9SX0NJTlRFUklPTiA8YnI+CmxvZ2lj
LCB5ZXQgcGx1Z2lucy9nZW1hbHRvLmMgc3RpbGwgc2V0cyBWRU5ET1JfQ0lOVEVSSU9OIGZvciB0
aGUgc2ltIDxicj4KYXRvbS7CoCBTbyBub3cgeW91IGJyb2tlIHRoYXQgZHJpdmVyLsKgIFlvdXIg
Y2hhbmdlIHNldCBpcyBub3QgPGJyPgpzZWxmLWNvbnRhaW5lZC7CoCBJZiBJIGFwcGx5IHRoaXMg
cGF0Y2ggYW5kIHlvdSBnZXQgaGl0IGJ5IGEgYnVzIDxicj4KdG9tb3Jyb3csIHRoZSBwbHVnaW4g
cmVtYWlucyBicm9rZW4gZm9yIGV2ZXJ5b25lLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5JdCBpcyBub3QgdGFrZW4gb3V0LiBJdCBpczo8L2Rpdj48ZGl2PsKgwqAgwqAgwqAg
Y2FzZSBPRk9OT19WRU5ET1JfQ0lOVEVSSU9OOjxicj7CoCDCoCDCoCDCoGNhc2UgT0ZPTk9fVkVO
RE9SX0dFTUFMVE86PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGdfYXRfY2hhdF9zZW5k
KHNkLSZndDtjaGF0LCAmcXVvdDtBVF5TUElDJnF1b3Q7LCBnZW1hbHRvX3NwaWNfcHJlZml4LDxi
cj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdlbWFsdG9fc3BpY19jYiwgY2JkLCBnX2ZyZWUpICZndDsgMCk8YnI+wqA8YnI+PC9kaXY+
PGRpdj5ib3RoIGFyZSB0aGVyZSwgYW5kIHRoZSBmdW5jdGlvbnMgYXJlIHJlbmFtZWQsIGJ1dCBz
dGlsbCB0aGVyZS48L2Rpdj48ZGl2Pk9yIHNoYWxsIEkgZHVwbGljYXRlIHRoZSBmdW5jdGlvbnMg
Zm9yIHRoZSB0aW1lIGJlaW5nPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpSZWdhcmRzLDxi
cj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============5851896782099009462==--

