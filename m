Content-Type: multipart/mixed; boundary="===============7246884593155084947=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 5/6] atmodem/lte: proto and authentication handling
Date: Thu, 11 Oct 2018 21:51:55 +0200
Message-ID: <da05e9af-1ac8-a0ec-c6fd-8d3d96b10bbd@southpole.se>
In-Reply-To: <20181010065454.15232-4-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7246884593155084947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I think this patch deserves a couple of lines of justification in the =

patch description.=C2=A0 From the subject, it isn't obvious what this is =

about, and a quick glance at the diff only raises further questions.=C2=A0 =

Try to explain in the patch description what this is about, what problem =

your modification is solving.


On 10/10/18 08:54, Giacinto Cifelli wrote:
> ---
>   drivers/atmodem/lte.c | 79 +++++++++++++++++++++++++++----------------
>   1 file changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
> index efa4e5fe..1d097c68 100644
> --- a/drivers/atmodem/lte.c
> +++ b/drivers/atmodem/lte.c
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2017  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M

Why is copyright attributed to Gemalto when you and the other purported =

authors (referencing your AUTHORS patch... see below) all use gmail =

addresses?


On 10/10/18 08:54, Giacinto Cifelli wrote:
> ---
>   AUTHORS | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/AUTHORS b/AUTHORS
> index 2d360e6e..8f0f5893 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -138,3 +138,6 @@ Florent Beillonnet<florent.beillonnet@gmail.com>
>   Martin Hundeb=C3=B8ll<martin@geanix.com>
>   Julien Tournier<tournier.julien@gmail.com>
>   Nandini Rebello<nandini.rebello@intel.com>
> +Giacinto Cifelli<gciofono@gmail.com>
> +Martin Baschin<martin.baschin@googlemail.com>
> +Sebastian Arnd<sebastianarnd@gmail.com>

Three authors but only Giacinto's name appears in the patches?


>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -45,48 +46,67 @@ struct lte_driver_data {
>   	GAtChat *chat;
>   };
>   =

> -static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *re=
sult,
> -							gpointer user_data)
> +static void at_set_reg_info(const struct ofono_lte *lte,
> +			const struct ofono_lte_default_attach_info *info)
>   {
> -	struct cb_data *cbd =3D user_data;
> -	ofono_lte_cb_t cb =3D cbd->cb;
> -	struct ofono_error error;
> +	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> +	char buf_cgdcont[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
> +	char buf_cgauth[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
> +					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
> +	guint buflen =3D sizeof(buf_cgauth);
> +	enum ofono_gprs_auth_method auth_method;
>   =

> -	DBG("ok %d", ok);
> +	if (strlen(info->apn) > 0)
> +		snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> +				"AT+CGDCONT=3D0,\"IP\",\"%s\"", info->apn);
> +	else
> +		snprintf(buf_cgdcont, sizeof(buf_cgdcont),
> +				"AT+CGDCONT=3D0,\"IP\"");
>   =

> -	decode_at_error(&error, g_at_result_final_response(result));
> -	cb(&error, cbd->data);
> +	if (g_at_chat_send(ldd->chat, buf_cgdcont, NULL, NULL, NULL, NULL) =3D=
=3D 0)
> +		return;
> +
> +	snprintf(buf_cgauth, buflen, "AT+CGAUTH=3D0,");
> +	buflen -=3D strlen(buf_cgauth);

Using snprintf() without checking the return value is mostly =

pointless... if you know with certainty that your buffer will hold your =

string just use sprintf.=C2=A0 The above could be better written as:

n =3D sprintf(...);
buflen -=3D n;


> +
> +	auth_method =3D info->auth_method;
> +
> +	/*
> +	 * change the authentication method if the  parameters are invalid
> +	 * for behavior compatibility
> +	 */
> +	if(!*info->username || !*info->password)
> +		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
> +	switch(auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		snprintf(buf_cgauth+strlen(buf_cgauth),

You know strlen(buf_cgauth) already... it's 'n' above, the return value =

from snprintf.=C2=A0 No need to traverse the string again to figure this ou=
t.

> +				buflen, "1,\"%s\",\"%s\"",
> +				info->username, info->password);
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		snprintf(buf_cgauth+strlen(buf_cgauth),
> +				buflen, "2,\"%s\",\"%s\"",
> +				info->username, info->password);
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_NONE:
> +		snprintf(buf_cgauth+strlen(buf_cgauth), buflen, "0");
> +		break;
> +	}
> +
> +	g_at_chat_send(ldd->chat, buf_cgauth, NULL, NULL, NULL, NULL);

Can't fail?

>   }
>   =

>   static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
>   			const struct ofono_lte_default_attach_info *info,
>   			ofono_lte_cb_t cb, void *data)
>   {
> -	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
> -	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
> -	struct cb_data *cbd =3D cb_data_new(cb, data);
> -
> -	DBG("LTE config with APN: %s", info->apn);
> -
> -	if (strlen(info->apn) > 0)
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
> -				info->apn);
> -	else
> -		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
> -
> -	/* We can't do much in case of failure so don't check response. */
> -	if (g_at_chat_send(ldd->chat, buf, NULL,
> -			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
> -		return;
> -
> -	CALLBACK_WITH_FAILURE(cb, data);
> +	CALLBACK_WITH_SUCCESS(cb, data);
>   }
>   =


Aside from abandoning all error handling, what does set_reg_info provide =

that could not have been handled by set_default_attach_info?


>   static gboolean lte_delayed_register(gpointer user_data)
>   {
> -	struct ofono_lte *lte =3D user_data;
> -
> -	ofono_lte_register(lte);
> +	ofono_lte_register(user_data);

I prefer the original version... nonetheless, this change doesn't belong =

in this patch.

>   =

>   	return FALSE;
>   }
> @@ -129,6 +149,7 @@ static struct ofono_lte_driver driver =3D {
>   	.probe				=3D at_lte_probe,
>   	.remove				=3D at_lte_remove,
>   	.set_default_attach_info	=3D at_lte_set_default_attach_info,
> +	.set_reg_info			=3D at_set_reg_info,
>   };
>   =

>   void at_lte_init(void)

/Jonas

--===============7246884593155084947==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+SGksPC9wPgogICAgPHA+SSB0aGluayB0
aGlzIHBhdGNoIGRlc2VydmVzIGEgY291cGxlIG9mIGxpbmVzIG9mIGp1c3RpZmljYXRpb24gaW4K
ICAgICAgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLsKgIEZyb20gdGhlIHN1YmplY3QsIGl0IGlzbid0
IG9idmlvdXMgd2hhdAogICAgICB0aGlzIGlzIGFib3V0LCBhbmQgYSBxdWljayBnbGFuY2UgYXQg
dGhlIGRpZmYgb25seSByYWlzZXMgZnVydGhlcgogICAgICBxdWVzdGlvbnMuwqAgVHJ5IHRvIGV4
cGxhaW4gaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHdoYXQgdGhpcyBpcwogICAgICBhYm91dCwg
d2hhdCBwcm9ibGVtIHlvdXIgbW9kaWZpY2F0aW9uIGlzIHNvbHZpbmcuPGJyPgogICAgPC9wPgog
ICAgPGJyPgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAxMC8xMC8xOCAwODo1
NCwgR2lhY2ludG8gQ2lmZWxsaQogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDoyMDE4MTAxMDA2NTQ1NC4xNTIzMi00
LWdjaW9mb25vQGdtYWlsLmNvbSI+CiAgICAgIDxwcmUgd3JhcD0iIj4tLS0KIGRyaXZlcnMvYXRt
b2RlbS9sdGUuYyB8IDc5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2F0bW9kZW0vbHRlLmMgYi9kcml2ZXJzL2F0bW9kZW0vbHRlLmMK
aW5kZXggZWZhNGU1ZmUuLjFkMDk3YzY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0bW9kZW0vbHRl
LmMKKysrIGIvZHJpdmVycy9hdG1vZGVtL2x0ZS5jCkBAIC0zLDYgKzMsNyBAQAogICogIG9Gb25v
IC0gT3BlbiBTb3VyY2UgVGVsZXBob255CiAgKgogICogIENvcHlyaWdodCAoQykgMjAxNyAgSW50
ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuCisgKiAgQ29weXJpZ2h0IChDKSAy
MDE4IEdlbWFsdG8gTTJNPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBXaHkg
aXMgY29weXJpZ2h0IGF0dHJpYnV0ZWQgdG8gR2VtYWx0byB3aGVuIHlvdSBhbmQgdGhlIG90aGVy
CiAgICBwdXJwb3J0ZWQgYXV0aG9ycyAocmVmZXJlbmNpbmcgeW91ciBBVVRIT1JTIHBhdGNoLi4u
IHNlZSBiZWxvdykgYWxsCiAgICB1c2UgZ21haWwgYWRkcmVzc2VzPzxicj4KICAgIDxicj4KICAg
IDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMTAvMTAvMTggMDg6NTQs
IEdpYWNpbnRvIENpZmVsbGkKICAgICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6MjAxODEwMTAwNjU0NTQuMTUyMzItNi1n
Y2lvZm9ub0BnbWFpbC5jb20iPgogICAgICA8cHJlIHdyYXA9IiI+LS0tCiBBVVRIT1JTIHwgMyAr
KysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9BVVRIT1JT
IGIvQVVUSE9SUwppbmRleCAyZDM2MGU2ZS4uOGYwZjU4OTMgMTAwNjQ0Ci0tLSBhL0FVVEhPUlMK
KysrIGIvQVVUSE9SUwpAQCAtMTM4LDMgKzEzOCw2IEBAIEZsb3JlbnQgQmVpbGxvbm5ldCA8YSBj
bGFzcz0ibW96LXR4dC1saW5rLXJmYzIzOTZFIiBocmVmPSJtYWlsdG86ZmxvcmVudC5iZWlsbG9u
bmV0QGdtYWlsLmNvbSI+Jmx0O2Zsb3JlbnQuYmVpbGxvbm5ldEBnbWFpbC5jb20mZ3Q7PC9hPgog
TWFydGluIEh1bmRlYsO4bGwgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMyMzk2RSIgaHJlZj0i
bWFpbHRvOm1hcnRpbkBnZWFuaXguY29tIj4mbHQ7bWFydGluQGdlYW5peC5jb20mZ3Q7PC9hPgog
SnVsaWVuIFRvdXJuaWVyIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1h
aWx0bzp0b3Vybmllci5qdWxpZW5AZ21haWwuY29tIj4mbHQ7dG91cm5pZXIuanVsaWVuQGdtYWls
LmNvbSZndDs8L2E+CiBOYW5kaW5pIFJlYmVsbG8gPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMy
Mzk2RSIgaHJlZj0ibWFpbHRvOm5hbmRpbmkucmViZWxsb0BpbnRlbC5jb20iPiZsdDtuYW5kaW5p
LnJlYmVsbG9AaW50ZWwuY29tJmd0OzwvYT4KK0dpYWNpbnRvIENpZmVsbGkgPGEgY2xhc3M9Im1v
ei10eHQtbGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSI+Jmx0
O2djaW9mb25vQGdtYWlsLmNvbSZndDs8L2E+CitNYXJ0aW4gQmFzY2hpbiA8YSBjbGFzcz0ibW96
LXR4dC1saW5rLXJmYzIzOTZFIiBocmVmPSJtYWlsdG86bWFydGluLmJhc2NoaW5AZ29vZ2xlbWFp
bC5jb20iPiZsdDttYXJ0aW4uYmFzY2hpbkBnb29nbGVtYWlsLmNvbSZndDs8L2E+CitTZWJhc3Rp
YW4gQXJuZCA8YSBjbGFzcz0ibW96LXR4dC1saW5rLXJmYzIzOTZFIiBocmVmPSJtYWlsdG86c2Vi
YXN0aWFuYXJuZEBnbWFpbC5jb20iPiZsdDtzZWJhc3RpYW5hcm5kQGdtYWlsLmNvbSZndDs8L2E+
PC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBUaHJlZSBhdXRob3JzIGJ1dCBv
bmx5IEdpYWNpbnRvJ3MgbmFtZSBhcHBlYXJzIGluIHRoZSBwYXRjaGVzPzxicj4KICAgIDxicj4K
ICAgIDxicj4KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDoyMDE4
MTAxMDA2NTQ1NC4xNTIzMi00LWdjaW9mb25vQGdtYWlsLmNvbSI+CiAgICAgIDxwcmUgd3JhcD0i
Ij4KICAqCiAgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKICAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwpAQCAtNDUsNDggKzQ2LDY3IEBA
IHN0cnVjdCBsdGVfZHJpdmVyX2RhdGEgewogCUdBdENoYXQgKmNoYXQ7CiB9OwogCi1zdGF0aWMg
dm9pZCBhdF9sdGVfc2V0X2RlZmF1bHRfYXR0YWNoX2luZm9fY2IoZ2Jvb2xlYW4gb2ssIEdBdFJl
c3VsdCAqcmVzdWx0LAotCQkJCQkJCWdwb2ludGVyIHVzZXJfZGF0YSkKK3N0YXRpYyB2b2lkIGF0
X3NldF9yZWdfaW5mbyhjb25zdCBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUsCisJCQljb25zdCBzdHJ1
Y3Qgb2Zvbm9fbHRlX2RlZmF1bHRfYXR0YWNoX2luZm8gKmluZm8pCiB7Ci0Jc3RydWN0IGNiX2Rh
dGEgKmNiZCA9IHVzZXJfZGF0YTsKLQlvZm9ub19sdGVfY2JfdCBjYiA9IGNiZC0mZ3Q7Y2I7Ci0J
c3RydWN0IG9mb25vX2Vycm9yIGVycm9yOworCXN0cnVjdCBsdGVfZHJpdmVyX2RhdGEgKmxkZCA9
IG9mb25vX2x0ZV9nZXRfZGF0YShsdGUpOworCWNoYXIgYnVmX2NnZGNvbnRbMzIgKyBPRk9OT19H
UFJTX01BWF9BUE5fTEVOR1RIICArMV07CisJY2hhciBidWZfY2dhdXRoWzMyICsgT0ZPTk9fR1BS
U19NQVhfVVNFUk5BTUVfTEVOR1RIICsKKwkJCQkJT0ZPTk9fR1BSU19NQVhfUEFTU1dPUkRfTEVO
R1RIICsxXTsKKwlndWludCBidWZsZW4gPSBzaXplb2YoYnVmX2NnYXV0aCk7CisJZW51bSBvZm9u
b19ncHJzX2F1dGhfbWV0aG9kIGF1dGhfbWV0aG9kOwogCi0JREJHKCJvayAlZCIsIG9rKTsKKwlp
ZiAoc3RybGVuKGluZm8tJmd0O2FwbikgJmd0OyAwKQorCQlzbnByaW50ZihidWZfY2dkY29udCwg
c2l6ZW9mKGJ1Zl9jZ2Rjb250KSwKKwkJCQkiQVQrQ0dEQ09OVD0wLFwiSVBcIixcIiVzXCIiLCBp
bmZvLSZndDthcG4pOworCWVsc2UKKwkJc25wcmludGYoYnVmX2NnZGNvbnQsIHNpemVvZihidWZf
Y2dkY29udCksCisJCQkJIkFUK0NHRENPTlQ9MCxcIklQXCIiKTsKIAotCWRlY29kZV9hdF9lcnJv
cigmYW1wO2Vycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1bHQpKTsKLQljYigm
YW1wO2Vycm9yLCBjYmQtJmd0O2RhdGEpOworCWlmIChnX2F0X2NoYXRfc2VuZChsZGQtJmd0O2No
YXQsIGJ1Zl9jZ2Rjb250LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKSA9PSAwKQorCQlyZXR1cm47
CisKKwlzbnByaW50ZihidWZfY2dhdXRoLCBidWZsZW4sICJBVCtDR0FVVEg9MCwiKTsKKwlidWZs
ZW4gLT0gc3RybGVuKGJ1Zl9jZ2F1dGgpOzwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJy
PgogICAgVXNpbmcgc25wcmludGYoKSB3aXRob3V0IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUg
aXMgbW9zdGx5CiAgICBwb2ludGxlc3MuLi4gaWYgeW91IGtub3cgd2l0aCBjZXJ0YWludHkgdGhh
dCB5b3VyIGJ1ZmZlciB3aWxsIGhvbGQKICAgIHlvdXIgc3RyaW5nIGp1c3QgdXNlIHNwcmludGYu
wqAgVGhlIGFib3ZlIGNvdWxkIGJlIGJldHRlciB3cml0dGVuIGFzOjxicj4KICAgIDxicj4KICAg
IG4gPSBzcHJpbnRmKC4uLik7PGJyPgogICAgYnVmbGVuIC09IG47PGJyPgogICAgPGJyPgogICAg
PGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjIwMTgxMDEw
MDY1NDU0LjE1MjMyLTQtZ2Npb2Zvbm9AZ21haWwuY29tIj4KICAgICAgPHByZSB3cmFwPSIiPgor
CisJYXV0aF9tZXRob2QgPSBpbmZvLSZndDthdXRoX21ldGhvZDsKKworCS8qCisJICogY2hhbmdl
IHRoZSBhdXRoZW50aWNhdGlvbiBtZXRob2QgaWYgdGhlICBwYXJhbWV0ZXJzIGFyZSBpbnZhbGlk
CisJICogZm9yIGJlaGF2aW9yIGNvbXBhdGliaWxpdHkKKwkgKi8KKwlpZighKmluZm8tJmd0O3Vz
ZXJuYW1lIHx8ICEqaW5mby0mZ3Q7cGFzc3dvcmQpCisJCWF1dGhfbWV0aG9kID0gT0ZPTk9fR1BS
U19BVVRIX01FVEhPRF9OT05FOworCisJc3dpdGNoKGF1dGhfbWV0aG9kKSB7CisJY2FzZSBPRk9O
T19HUFJTX0FVVEhfTUVUSE9EX1BBUDoKKwkJc25wcmludGYoYnVmX2NnYXV0aCtzdHJsZW4oYnVm
X2NnYXV0aCksPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBZb3Uga25vdyBz
dHJsZW4oYnVmX2NnYXV0aCkgYWxyZWFkeS4uLiBpdCdzICduJyBhYm92ZSwgdGhlIHJldHVybgog
ICAgdmFsdWUgZnJvbSBzbnByaW50Zi7CoCBObyBuZWVkIHRvIHRyYXZlcnNlIHRoZSBzdHJpbmcg
YWdhaW4gdG8gZmlndXJlCiAgICB0aGlzIG91dC48YnI+CiAgICA8YnI+CiAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6MjAxODEwMTAwNjU0NTQuMTUyMzItNC1nY2lv
Zm9ub0BnbWFpbC5jb20iPgogICAgICA8cHJlIHdyYXA9IiI+CisJCQkJYnVmbGVuLCAiMSxcIiVz
XCIsXCIlc1wiIiwKKwkJCQlpbmZvLSZndDt1c2VybmFtZSwgaW5mby0mZ3Q7cGFzc3dvcmQpOwor
CQlicmVhazsKKwljYXNlIE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfQ0hBUDoKKwkJc25wcmludGYo
YnVmX2NnYXV0aCtzdHJsZW4oYnVmX2NnYXV0aCksCisJCQkJYnVmbGVuLCAiMixcIiVzXCIsXCIl
c1wiIiwKKwkJCQlpbmZvLSZndDt1c2VybmFtZSwgaW5mby0mZ3Q7cGFzc3dvcmQpOworCQlicmVh
azsKKwljYXNlIE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfTk9ORToKKwkJc25wcmludGYoYnVmX2Nn
YXV0aCtzdHJsZW4oYnVmX2NnYXV0aCksIGJ1ZmxlbiwgIjAiKTsKKwkJYnJlYWs7CisJfQorCisJ
Z19hdF9jaGF0X3NlbmQobGRkLSZndDtjaGF0LCBidWZfY2dhdXRoLCBOVUxMLCBOVUxMLCBOVUxM
LCBOVUxMKTs8L3ByZT4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj4KICAgIENhbid0IGZhaWw/
PGJyPgogICAgPGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlk
OjIwMTgxMDEwMDY1NDU0LjE1MjMyLTQtZ2Npb2Zvbm9AZ21haWwuY29tIj4KICAgICAgPHByZSB3
cmFwPSIiPgogfQogCiBzdGF0aWMgdm9pZCBhdF9sdGVfc2V0X2RlZmF1bHRfYXR0YWNoX2luZm8o
Y29uc3Qgc3RydWN0IG9mb25vX2x0ZSAqbHRlLAogCQkJY29uc3Qgc3RydWN0IG9mb25vX2x0ZV9k
ZWZhdWx0X2F0dGFjaF9pbmZvICppbmZvLAogCQkJb2Zvbm9fbHRlX2NiX3QgY2IsIHZvaWQgKmRh
dGEpCiB7Ci0Jc3RydWN0IGx0ZV9kcml2ZXJfZGF0YSAqbGRkID0gb2Zvbm9fbHRlX2dldF9kYXRh
KGx0ZSk7Ci0JY2hhciBidWZbMzIgKyBPRk9OT19HUFJTX01BWF9BUE5fTEVOR1RIICsgMV07Ci0J
c3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNiLCBkYXRhKTsKLQotCURCRygiTFRF
IGNvbmZpZyB3aXRoIEFQTjogJXMiLCBpbmZvLSZndDthcG4pOwotCi0JaWYgKHN0cmxlbihpbmZv
LSZndDthcG4pICZndDsgMCkKLQkJc25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgIkFUK0NHRENP
TlQ9MCxcIklQXCIsXCIlc1wiIiwKLQkJCQlpbmZvLSZndDthcG4pOwotCWVsc2UKLQkJc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgIkFUK0NHRENPTlQ9MCxcIklQXCIiKTsKLQotCS8qIFdlIGNh
bid0IGRvIG11Y2ggaW4gY2FzZSBvZiBmYWlsdXJlIHNvIGRvbid0IGNoZWNrIHJlc3BvbnNlLiAq
LwotCWlmIChnX2F0X2NoYXRfc2VuZChsZGQtJmd0O2NoYXQsIGJ1ZiwgTlVMTCwKLQkJCWF0X2x0
ZV9zZXRfZGVmYXVsdF9hdHRhY2hfaW5mb19jYiwgY2JkLCBnX2ZyZWUpICZndDsgMCkKLQkJcmV0
dXJuOwotCi0JQ0FMTEJBQ0tfV0lUSF9GQUlMVVJFKGNiLCBkYXRhKTsKKwlDQUxMQkFDS19XSVRI
X1NVQ0NFU1MoY2IsIGRhdGEpOwogfQogPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+
CiAgICBBc2lkZSBmcm9tIGFiYW5kb25pbmcgYWxsIGVycm9yIGhhbmRsaW5nLCB3aGF0IGRvZXMg
c2V0X3JlZ19pbmZvCiAgICBwcm92aWRlIHRoYXQgY291bGQgbm90IGhhdmUgYmVlbiBoYW5kbGVk
IGJ5IHNldF9kZWZhdWx0X2F0dGFjaF9pbmZvPzxicj4KICAgIDxicj4KICAgIDxicj4KICAgIDxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDoyMDE4MTAxMDA2NTQ1NC4xNTIz
Mi00LWdjaW9mb25vQGdtYWlsLmNvbSI+CiAgICAgIDxwcmUgd3JhcD0iIj4KIHN0YXRpYyBnYm9v
bGVhbiBsdGVfZGVsYXllZF9yZWdpc3RlcihncG9pbnRlciB1c2VyX2RhdGEpCiB7Ci0Jc3RydWN0
IG9mb25vX2x0ZSAqbHRlID0gdXNlcl9kYXRhOwotCi0Jb2Zvbm9fbHRlX3JlZ2lzdGVyKGx0ZSk7
CisJb2Zvbm9fbHRlX3JlZ2lzdGVyKHVzZXJfZGF0YSk7PC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+
CiAgICA8YnI+CiAgICBJIHByZWZlciB0aGUgb3JpZ2luYWwgdmVyc2lvbi4uLiBub25ldGhlbGVz
cywgdGhpcyBjaGFuZ2UgZG9lc24ndAogICAgYmVsb25nIGluIHRoaXMgcGF0Y2guPGJyPgogICAg
PGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjIwMTgxMDEw
MDY1NDU0LjE1MjMyLTQtZ2Npb2Zvbm9AZ21haWwuY29tIj4KICAgICAgPHByZSB3cmFwPSIiPgog
CiAJcmV0dXJuIEZBTFNFOwogfQpAQCAtMTI5LDYgKzE0OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgb2Zv
bm9fbHRlX2RyaXZlciBkcml2ZXIgPSB7CiAJLnByb2JlCQkJCT0gYXRfbHRlX3Byb2JlLAogCS5y
ZW1vdmUJCQkJPSBhdF9sdGVfcmVtb3ZlLAogCS5zZXRfZGVmYXVsdF9hdHRhY2hfaW5mbwk9IGF0
X2x0ZV9zZXRfZGVmYXVsdF9hdHRhY2hfaW5mbywKKwkuc2V0X3JlZ19pbmZvCQkJPSBhdF9zZXRf
cmVnX2luZm8sCiB9OwogCiB2b2lkIGF0X2x0ZV9pbml0KHZvaWQpCjwvcHJlPgogICAgPC9ibG9j
a3F1b3RlPgogICAgPGJyPgogICAgL0pvbmFzPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============7246884593155084947==--

