Content-Type: multipart/mixed; boundary="===============3067424030863977656=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 4/4] src/gprs.c: added support for NONE and ANY
 authentication methods
Date: Fri, 21 Sep 2018 15:41:00 +0200
Message-ID: <CAKSBH7E6M82dNxU8z=SUNWhTcwA91DKdnT=aPc=XinB-yvC2NA@mail.gmail.com>
In-Reply-To: <1537417430-10904-4-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3067424030863977656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

actually also this applies for auth_method NONE alone.

Regards,
Giacinto


On Thu, Sep 20, 2018 at 6:23 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> ---
>  src/gprs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index 377eced..f17f31b 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -261,6 +261,10 @@ static const char *gprs_auth_method_to_string(enum
> ofono_gprs_auth_method auth)
>                 return "chap";
>         case OFONO_GPRS_AUTH_METHOD_PAP:
>                 return "pap";
> +       case OFONO_GPRS_AUTH_METHOD_NONE:
> +               return "none";
> +       default:
> +               return NULL;
>         };
>
>         return NULL;
> @@ -275,6 +279,9 @@ static gboolean gprs_auth_method_from_string(const
> char *str,
>         } else if (g_str_equal(str, "pap")) {
>                 *auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
>                 return TRUE;
> +       } else if (g_str_equal(str, "none")) {
> +               *auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +               return TRUE;
>         }
>
>         return FALSE;
> --
> 1.9.1
>
>

--===============3067424030863977656==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5hY3R1YWxseSBhbHNv
IHRoaXMgYXBwbGllcyBmb3IgYXV0aF9tZXRob2QgTk9ORSBhbG9uZS48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1
LCBTZXAgMjAsIDIwMTggYXQgNjoyMyBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJt
YWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90
ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
LS0tPGJyPgrCoHNyYy9ncHJzLmMgfCA3ICsrKysrKys8YnI+CsKgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJz
LmM8YnI+CmluZGV4IDM3N2VjZWQuLmYxN2YzMWIgMTAwNjQ0PGJyPgotLS0gYS9zcmMvZ3Bycy5j
PGJyPgorKysgYi9zcmMvZ3Bycy5jPGJyPgpAQCAtMjYxLDYgKzI2MSwxMCBAQCBzdGF0aWMgY29u
c3QgY2hhciAqZ3Byc19hdXRoX21ldGhvZF90b19zdHJpbmcoZW51bSBvZm9ub19ncHJzX2F1dGhf
bWV0aG9kIGF1dGgpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gJnF1b3Q7Y2hh
cCZxdW90Ozs8YnI+CsKgIMKgIMKgIMKgIGNhc2UgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9QQVA6
PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gJnF1b3Q7cGFwJnF1b3Q7Ozxicj4K
K8KgIMKgIMKgIMKgY2FzZSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX05PTkU6PGJyPgorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gJnF1b3Q7bm9uZSZxdW90Ozs8YnI+CivCoCDCoCDCoCDC
oGRlZmF1bHQ6PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gTlVMTDs8YnI+CsKg
IMKgIMKgIMKgIH07PGJyPgo8YnI+CsKgIMKgIMKgIMKgIHJldHVybiBOVUxMOzxicj4KQEAgLTI3
NSw2ICsyNzksOSBAQCBzdGF0aWMgZ2Jvb2xlYW4gZ3Byc19hdXRoX21ldGhvZF9mcm9tX3N0cmlu
Zyhjb25zdCBjaGFyICpzdHIsPGJyPgrCoCDCoCDCoCDCoCB9IGVsc2UgaWYgKGdfc3RyX2VxdWFs
KHN0ciwgJnF1b3Q7cGFwJnF1b3Q7KSkgezxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKmF1
dGggPSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX1BBUDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybiBUUlVFOzxicj4KK8KgIMKgIMKgIMKgfSBlbHNlIGlmIChnX3N0cl9lcXVhbChz
dHIsICZxdW90O25vbmUmcXVvdDspKSB7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqYXV0
aCA9IE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfTk9ORTs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBUUlVFOzxicj4KwqAgwqAgwqAgwqAgfTxicj4KPGJyPgrCoCDCoCDCoCDCoCBy
ZXR1cm4gRkFMU0U7PGJyPgotLSA8YnI+CjEuOS4xPGJyPgo8YnI+CjwvYmxvY2txdW90ZT48L2Rp
dj4K

--===============3067424030863977656==--

