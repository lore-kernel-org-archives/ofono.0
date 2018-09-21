Content-Type: multipart/mixed; boundary="===============3307098491783106101=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/4] added default values handling for gprs authentication
 in atmodem and mbimmodem
Date: Fri, 21 Sep 2018 13:32:13 +0200
Message-ID: <CAKSBH7F01CqX+1Fx7aCsGbE21KVm4OyUa-rhbwszhMxxFvag+w@mail.gmail.com>
In-Reply-To: <1537417430-10904-2-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3307098491783106101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

could you take this? It applies even only for the NONE auth_method, because
it just adds default to the switch/cases.
I am resubmitting the other 3.

BR,
Giacinto


On Thu, Sep 20, 2018 at 6:23 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> this is needed so that with the additional methods NONE and ANY
> the compilation is not broken
> ---
>  drivers/atmodem/gprs-context.c   | 2 ++
>  drivers/mbimmodem/gprs-context.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/atmodem/gprs-context.c
> b/drivers/atmodem/gprs-context.c
> index 79ac4c8..0585850 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -304,6 +304,8 @@ static void at_gprs_activate_primary(struct
> ofono_gprs_context *gc,
>                                 snprintf(buf + len, sizeof(buf) - len - 3,
>                                                 ",\"PAP:%s\"", ctx->apn);
>                                 break;
> +                       default:
> +                               break;
>                         }
>                         break;
>                 default:
> diff --git a/drivers/mbimmodem/gprs-context.c
> b/drivers/mbimmodem/gprs-context.c
> index 79793c9..ce33b92 100644
> --- a/drivers/mbimmodem/gprs-context.c
> +++ b/drivers/mbimmodem/gprs-context.c
> @@ -75,6 +75,8 @@ static uint32_t auth_method_to_auth_protocol(enum
> ofono_gprs_auth_method method)
>                 return 2; /* MBIMAuthProtocolChap */
>         case OFONO_GPRS_AUTH_METHOD_PAP:
>                 return 1; /* MBIMAuthProtocolPap */
> +       default:
> +               return 0;
>         }
>
>         return 0;
> --
> 1.9.1
>
>

--===============3307098491783106101==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5jb3VsZCB5b3UgdGFr
ZSB0aGlzPyBJdCBhcHBsaWVzIGV2ZW4gb25seSBmb3IgdGhlIE5PTkUgYXV0aF9tZXRob2QsIGJl
Y2F1c2UgaXQganVzdCBhZGRzIGRlZmF1bHQgdG8gdGhlIHN3aXRjaC9jYXNlcy48L2Rpdj48ZGl2
PkkgYW0gcmVzdWJtaXR0aW5nIHRoZSBvdGhlciAzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QlIsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMjAsIDIwMTgg
YXQgNjoyMyBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9A
Z21haWwuY29tIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+dGhpcyBpcyBuZWVkZWQg
c28gdGhhdCB3aXRoIHRoZSBhZGRpdGlvbmFsIG1ldGhvZHMgTk9ORSBhbmQgQU5ZPGJyPgp0aGUg
Y29tcGlsYXRpb24gaXMgbm90IGJyb2tlbjxicj4KLS0tPGJyPgrCoGRyaXZlcnMvYXRtb2RlbS9n
cHJzLWNvbnRleHQuY8KgIMKgfCAyICsrPGJyPgrCoGRyaXZlcnMvbWJpbW1vZGVtL2dwcnMtY29u
dGV4dC5jIHwgMiArKzxicj4KwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKTxicj4K
PGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jIGIvZHJpdmVy
cy9hdG1vZGVtL2dwcnMtY29udGV4dC5jPGJyPgppbmRleCA3OWFjNGM4Li4wNTg1ODUwIDEwMDY0
NDxicj4KLS0tIGEvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jPGJyPgorKysgYi9kcml2
ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM8YnI+CkBAIC0zMDQsNiArMzA0LDggQEAgc3RhdGlj
IHZvaWQgYXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQg
KmdjLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c25wcmludGYoYnVmICsgbGVuLCBzaXplb2YoYnVmKSAtIGxlbiAtIDMsPGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAmcXVvdDssXCZxdW90O1BBUDolc1wmcXVvdDsmcXVvdDssIGN0eC0mZ3Q7YXBuKTs8YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxi
cj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+CivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZWZh
dWx0Ojxicj4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWJpbW1vZGVtL2dwcnMtY29udGV4dC5jIGIv
ZHJpdmVycy9tYmltbW9kZW0vZ3Bycy1jb250ZXh0LmM8YnI+CmluZGV4IDc5NzkzYzkuLmNlMzNi
OTIgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL21iaW1tb2RlbS9ncHJzLWNvbnRleHQuYzxicj4K
KysrIGIvZHJpdmVycy9tYmltbW9kZW0vZ3Bycy1jb250ZXh0LmM8YnI+CkBAIC03NSw2ICs3NSw4
IEBAIHN0YXRpYyB1aW50MzJfdCBhdXRoX21ldGhvZF90b19hdXRoX3Byb3RvY29sKGVudW0gb2Zv
bm9fZ3Byc19hdXRoX21ldGhvZCBtZXRob2QpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm4gMjsgLyogTUJJTUF1dGhQcm90b2NvbENoYXAgKi88YnI+CsKgIMKgIMKgIMKgIGNhc2Ug
T0ZPTk9fR1BSU19BVVRIX01FVEhPRF9QQVA6PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm4gMTsgLyogTUJJTUF1dGhQcm90b2NvbFBhcCAqLzxicj4KK8KgIMKgIMKgIMKgZGVmYXVs
dDo8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxicj4KwqAgwqAgwqAgwqAg
fTxicj4KPGJyPgrCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+Ci0tIDxicj4KMS45LjE8YnI+Cjxi
cj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============3307098491783106101==--

