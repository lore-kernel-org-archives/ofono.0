Content-Type: multipart/mixed; boundary="===============8320820600333213127=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] added voice call support to ublox plugin
Date: Thu, 09 Aug 2018 07:18:16 +0200
Message-ID: <CAKSBH7GGCdP5ny4L_b73nby4tQ-2jKLAQZceR9hGjV2LQh+Q3A@mail.gmail.com>
In-Reply-To: <1533752977-4103-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8320820600333213127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dear all,

please disregard this patch, it breaks compilation because of a missing
include, and the comment is not clear enough.
I am submitting an update now.

best regards,
Giacinto


On Wed, Aug 8, 2018 at 8:29 PM Giacinto Cifelli <gciofono@gmail.com> wrot=
e:

> ---
>  plugins/ublox.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index cfcdd3f..1c46d6f 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -286,6 +286,7 @@ static void ublox_pre_sim(struct ofono_modem *modem)
>         DBG("%p", modem);
>
>         ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> +       ofono_voicecall_create(modem, 0, "atmodem", data->app); /*
> emergency calls already possible */
>         sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
>                                         data->aux);
>
> --
> 1.9.1
>
>

--===============8320820600333213127==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+ZGVhciBhbGwsPGRpdj48YnI+PC9kaXY+PGRpdj5wbGVhc2UgZGlzcmVn
YXJkIHRoaXMgcGF0Y2gsIGl0IGJyZWFrcyBjb21waWxhdGlvbiBiZWNhdXNlIG9mIGEgbWlzc2lu
ZyBpbmNsdWRlLCBhbmQgdGhlIGNvbW1lbnQgaXMgbm90IGNsZWFyIGVub3VnaC48L2Rpdj48ZGl2
PkkgYW0gc3VibWl0dGluZyBhbiB1cGRhdGUgbm93LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
YmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rp
dj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFdlZCwgQXVn
IDgsIDIwMTggYXQgODoyOSBQTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86
Z2Npb2Zvbm9AZ21haWwuY29tIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+LS0tPGJy
PgrCoHBsdWdpbnMvdWJsb3guYyB8IDEgKzxicj4KwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL3BsdWdpbnMvdWJsb3guYyBiL3BsdWdpbnMvdWJs
b3guYzxicj4KaW5kZXggY2ZjZGQzZi4uMWM0NmQ2ZiAxMDA2NDQ8YnI+Ci0tLSBhL3BsdWdpbnMv
dWJsb3guYzxicj4KKysrIGIvcGx1Z2lucy91YmxveC5jPGJyPgpAQCAtMjg2LDYgKzI4Niw3IEBA
IHN0YXRpYyB2b2lkIHVibG94X3ByZV9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+
CsKgIMKgIMKgIMKgIERCRygmcXVvdDslcCZxdW90OywgbW9kZW0pOzxicj4KPGJyPgrCoCDCoCDC
oCDCoCBvZm9ub19kZXZpbmZvX2NyZWF0ZShtb2RlbSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90Oywg
ZGF0YS0mZ3Q7YXV4KTs8YnI+CivCoCDCoCDCoCDCoG9mb25vX3ZvaWNlY2FsbF9jcmVhdGUobW9k
ZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2FwcCk7IC8qIGVtZXJnZW5jeSBj
YWxscyBhbHJlYWR5IHBvc3NpYmxlICovPGJyPgrCoCDCoCDCoCDCoCBzaW0gPSBvZm9ub19zaW1f
Y3JlYXRlKG1vZGVtLCBkYXRhLSZndDt2ZW5kb3JfZmFtaWx5LCAmcXVvdDthdG1vZGVtJnF1b3Q7
LDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZGF0YS0mZ3Q7YXV4KTs8YnI+Cjxicj4KLS0gPGJyPgoxLjkuMTxicj4KPGJyPgo8
L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============8320820600333213127==--

