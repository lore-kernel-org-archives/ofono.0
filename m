Content-Type: multipart/mixed; boundary="===============7330829258572787254=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 7/9] huaweimodme: prevent use of uninitialized variable
Date: Fri, 26 Oct 2018 12:32:45 +0200
Message-ID: <CAKSBH7Gz-6xPY01SWvPdAwBigaNDo+LELKtrBDr4Tjp8M1teWA@mail.gmail.com>
In-Reply-To: <20181026101319.27709-8-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7330829258572787254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Jonas,

On Fri, 26 Oct 2018, 12:13 Jonas Bonn, <jonas@norrbonn.se> wrote:

> From: Jonas Bonn <jonas@southpole.se>
>
> Move initialization of 'dcs' ahead of 'content' fetch to prevent
> uninitialized use.
> ---
>  drivers/huaweimodem/ussd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
> index fbed3cd0..f4001108 100644
> --- a/drivers/huaweimodem/ussd.c
> +++ b/drivers/huaweimodem/ussd.c
> @@ -62,12 +62,12 @@ static void cusd_parse(GAtResult *result, struct
> ofono_ussd *ussd)
>         if (!g_at_result_iter_next_number(&iter, &status))
>                 return;
>
> -       if (!g_at_result_iter_next_string(&iter, &content))
> -               goto out;
> -
>         if (!g_at_result_iter_next_number(&iter, &dcs))
>                 dcs =3D 0;
>
> +       if (!g_at_result_iter_next_string(&iter, &content))
> +               goto out;
> +
>

aren't you changing the order of the parameters in the command response?
Have you tested this on an actual modem?

        msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
>
> regards,
Giacinto

--===============7330829258572787254==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+aGkgSm9uYXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gRnJpLCAyNiBPY3QgMjAxOCwgMTI6MTMgSm9uYXMgQm9u
biwgJmx0OzxhIGhyZWY9Im1haWx0bzpqb25hc0Bub3JyYm9ubi5zZSI+am9uYXNAbm9ycmJvbm4u
c2U8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+RnJvbTogSm9uYXMgQm9ubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpvbmFz
QHNvdXRocG9sZS5zZSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+am9uYXNAc291
dGhwb2xlLnNlPC9hPiZndDs8YnI+Cjxicj4KTW92ZSBpbml0aWFsaXphdGlvbiBvZiAmIzM5O2Rj
cyYjMzk7IGFoZWFkIG9mICYjMzk7Y29udGVudCYjMzk7IGZldGNoIHRvIHByZXZlbnQ8YnI+CnVu
aW5pdGlhbGl6ZWQgdXNlLjxicj4KLS0tPGJyPgrCoGRyaXZlcnMvaHVhd2VpbW9kZW0vdXNzZC5j
IHwgNiArKystLS08YnI+CsKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHVhd2VpbW9kZW0vdXNzZC5j
IGIvZHJpdmVycy9odWF3ZWltb2RlbS91c3NkLmM8YnI+CmluZGV4IGZiZWQzY2QwLi5mNDAwMTEw
OCAxMDA2NDQ8YnI+Ci0tLSBhL2RyaXZlcnMvaHVhd2VpbW9kZW0vdXNzZC5jPGJyPgorKysgYi9k
cml2ZXJzL2h1YXdlaW1vZGVtL3Vzc2QuYzxicj4KQEAgLTYyLDEyICs2MiwxMiBAQCBzdGF0aWMg
dm9pZCBjdXNkX3BhcnNlKEdBdFJlc3VsdCAqcmVzdWx0LCBzdHJ1Y3Qgb2Zvbm9fdXNzZCAqdXNz
ZCk8YnI+CsKgIMKgIMKgIMKgIGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmYW1w
O2l0ZXIsICZhbXA7c3RhdHVzKSk8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8
YnI+Cjxicj4KLcKgIMKgIMKgIMKgaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfc3RyaW5nKCZh
bXA7aXRlciwgJmFtcDtjb250ZW50KSk8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8g
b3V0Ozxicj4KLTxicj4KwqAgwqAgwqAgwqAgaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVt
YmVyKCZhbXA7aXRlciwgJmFtcDtkY3MpKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGNz
ID0gMDs8YnI+Cjxicj4KK8KgIMKgIMKgIMKgaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfc3Ry
aW5nKCZhbXA7aXRlciwgJmFtcDtjb250ZW50KSk8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGdvdG8gb3V0Ozxicj4KKzxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9ImF1
dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+YXJlbiYjMzk7dCB5b3UgY2hhbmdpbmcgdGhl
IG9yZGVyIG9mIHRoZSBwYXJhbWV0ZXJzIGluIHRoZSBjb21tYW5kIHJlc3BvbnNlPzwvZGl2Pjxk
aXYgZGlyPSJhdXRvIj5IYXZlIHlvdSB0ZXN0ZWQgdGhpcyBvbiBhbiBhY3R1YWwgbW9kZW0/PC9k
aXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PgrCoCDCoCDCoCDCoCBtc2dfcHRyID0gZGVjb2RlX2hleF9vd25fYnVmKGNvbnRlbnQsIC0xLCAm
YW1wO21zZ19sZW4sIDAsIG1zZyk7PGJyPgo8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pjxk
aXYgZGlyPSJhdXRvIj5yZWdhcmRzLDwvZGl2PjxkaXYgZGlyPSJhdXRvIj5HaWFjaW50bzwvZGl2
PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============7330829258572787254==--

