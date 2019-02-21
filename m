Content-Type: multipart/mixed; boundary="===============4246553566931173955=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] xmm7modem: data channel setup for xmm7modem
Date: Thu, 21 Feb 2019 11:26:29 -0600
Message-ID: <62375416-c7e8-f012-4ea1-1428462090f4@gmail.com>
In-Reply-To: <1550231039-28842-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4246553566931173955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/15/2019 05:43 AM, Antara Borwankar wrote:
> Added the implementation required to setup data channel in
> ifxmodem gprs-context driver for xmm7modem vendor
> ---
>   drivers/ifxmodem/gprs-context.c | 43 ++++++++++++++++++++++++++++++++++=
+++----
>   1 file changed, 39 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 7f3628b..278d507 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -260,6 +260,22 @@ error:
>   	failed_setup(gc, NULL, TRUE);
>   }
>   =

> +static void cgdata_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Failed to establish session");
> +		failed_setup(gc, result, TRUE);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +}
> +
>   static void cgcontrdp_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>   {
>   	struct ofono_gprs_context *gc =3D user_data;
> @@ -269,8 +285,11 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   =

>   	const char *laddrnetmask =3D NULL;
>   	const char *gw =3D NULL;
> -	const char *interface;
>   	const char *dns[3];
> +	const char *ctrlpath;
> +	char *datapath;
> +	char buf[100];
> +	const char *interface;
>   =

>   	DBG("ok %d", ok);
>   =

> @@ -327,9 +346,13 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   	DBG("DNS2: %s\n", gcd->dns2);
>   	DBG("Gateway: %s\n", gcd->gateway);
>   =

> -	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
> +	interface =3D ofono_gprs_context_get_interface(gc);
> +
> +	sprintf(buf, "%s%c", ofono_modem_get_string(modem, "DataPath"),
> +					interface[strlen(interface)-1]);

Wouldn't this fail if multiple modems are plugged in?  It seems like =

just basing this off the interface name is not enough.

See attached patches for an idea of how to handle this.  Not fully happy =

with it, so if you have other ideas please suggest.

> +	datapath =3D g_strdup(buf);

Why do you need this strdup?  Just make your life easier and use =

g_strdup_printf instead of sprintf above.

Or better yet, simply use a different buffer on the stack for this.

>   =

> -	ofono_gprs_context_set_interface(gc, interface);
>   	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
>   =

>   	if (gcd->netmask[0])
> @@ -340,7 +363,19 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   =

>   	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
>   =

> -	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +	sprintf(buf, "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u", ctrlpath,
> +				datapath, gcd->active_context);

You can free datapath here actually instead of repeating the g_free =

twice below.

> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%u", gcd->active_context);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix, cgdata_cb,
> +						gc, NULL) > 0) {
> +		g_free(datapath);
> +		return;
> +	}
> +
> +	g_free(datapath);
> +	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>   }
>   =

>   static void ifx_read_settings(struct ofono_gprs_context *gc)
> =


Regards,
-Denis

--===============4246553566931173955==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-include-Add-ofono_gprs_context_get_ordinal.patch"

PkZyb20gNDk3ZGExMDNhNmVjMGQxNzQ0MGZkZjhkMDBjNGYyMjM3NDI0ZGE0ZSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjEgRmViIDIwMTkgMTE6MDc6MzAgLTA2MDAKU3ViamVjdDogW1BBVENIIDEvMl0g
aW5jbHVkZTogQWRkIG9mb25vX2dwcnNfY29udGV4dF9nZXRfb3JkaW5hbAoKLS0tCiBpbmNsdWRl
L2dwcnMtY29udGV4dC5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2dwcnMtY29udGV4dC5oIGIvaW5jbHVkZS9ncHJzLWNvbnRleHQu
aAppbmRleCBhZDA4NzJmNC4uOGMwMjI2ZWUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZ3Bycy1jb250
ZXh0LmgKKysrIGIvaW5jbHVkZS9ncHJzLWNvbnRleHQuaApAQCAtODYsNiArODYsNyBAQCB2b2lk
IG9mb25vX2dwcnNfY29udGV4dF9zZXRfZGF0YShzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpn
Yywgdm9pZCAqZGF0YSk7CiB2b2lkICpvZm9ub19ncHJzX2NvbnRleHRfZ2V0X2RhdGEoc3RydWN0
IG9mb25vX2dwcnNfY29udGV4dCAqZ2MpOwogCiBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm9mb25vX2dw
cnNfY29udGV4dF9nZXRfbW9kZW0oc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2MpOwordW5z
aWduZWQgaW50IG9mb25vX2dwcnNfY29udGV4dF9nZXRfb3JkaW5hbChzdHJ1Y3Qgb2Zvbm9fZ3By
c19jb250ZXh0ICpnYyk7CiAKIHZvaWQgb2Zvbm9fZ3Byc19jb250ZXh0X3NldF90eXBlKHN0cnVj
dCBvZm9ub19ncHJzX2NvbnRleHQgKmdjLAogCQkJCQllbnVtIG9mb25vX2dwcnNfY29udGV4dF90
eXBlIHR5cGUpOwotLSAKMi4xMy41Cgo=

--===============4246553566931173955==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-gprs-implement-ofono_gprs_context_get_ordinal.patch"

PkZyb20gOGIwNmQyYmMyMDNlZTQ3Mzc2MjBlNGRmZWY5NTNlZDEzYThiYmY4MSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjEgRmViIDIwMTkgMTE6MjE6MzggLTA2MDAKU3ViamVjdDogW1BBVENIIDIvMl0g
Z3ByczogaW1wbGVtZW50IG9mb25vX2dwcnNfY29udGV4dF9nZXRfb3JkaW5hbAoKLS0tCiBzcmMv
Z3Bycy5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9zcmMvZ3Bycy5jIGIvc3JjL2dwcnMuYwppbmRleCBiMGQ1
NmUxZS4uYmEyYTQ3Y2IgMTAwNjQ0Ci0tLSBhL3NyYy9ncHJzLmMKKysrIGIvc3JjL2dwcnMuYwpA
QCAtMjc5Nyw2ICsyNzk3LDI1IEBAIHN0cnVjdCBvZm9ub19tb2RlbSAqb2Zvbm9fZ3Byc19jb250
ZXh0X2dldF9tb2RlbShzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYykKIAlyZXR1cm4gX19v
Zm9ub19hdG9tX2dldF9tb2RlbShnYy0+YXRvbSk7CiB9CiAKKy8qCisgKiBSZXR1cm5zIHRoZSBv
cmRpbmFsIHBvc2l0aW9uIG9mIHRoaXMgY29udGV4dCAodGhlIG9yZGVyIGlzIHVzdWFsbHkgdGhl
IHNhbWUKKyAqIGFzIHRoZSBzZXF1ZW5jZSBvZiBvZm9ub19ncHJzX2FkZF9jb250ZXh0IGNhbGxz
KSBzdGFydGluZyBmcm9tIDEuICBOb3RlIHRoYXQKKyAqIGlmIG9uZSBvZiB0aGUgY29udGV4dCBk
cml2ZXJzIGZhaWxzIHRvIHByb2JlIG9yIGNhbGxzCisgKiBvZm9ub19ncHJzX2NvbnRleHRfcmVt
b3ZlLCB0aGVuIHRoaXMgZnVuY3Rpb24gd2lsbCByZXR1cm4gYW4gaW5kZXggdGhhdAorICogZGlm
ZmVycyBmcm9tIHRoZSBvZm9ub19ncHJzX2FkZF9jb250ZXh0IG9yZGVyLiAgVGhpcyBzaG91bGQg
Z2VuZXJhbGx5IG5vdAorICogaGFwcGVuLCBhcyB0aGUgYWJvdmUgc2l0dWF0aW9uIGdlbmVyYWxs
eSBpbmRpY2F0ZXMgYSBiaWdnZXIgcHJvYmxlbQorICovCit1bnNpZ25lZCBpbnQgb2Zvbm9fZ3By
c19jb250ZXh0X2dldF9vcmRpbmFsKHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjKQorewor
CWlmICghZ2MpCisJCXJldHVybiAwOworCisJaWYgKCFfX29mb25vX2F0b21fZ2V0X3JlZ2lzdGVy
ZWQoZ2MtPmF0b20pKQorCQlyZXR1cm4gMDsKKworCXJldHVybiBnX3NsaXN0X2luZGV4KGdjLT5n
cHJzLT5jb250ZXh0X2RyaXZlcnMsIGdjKSArIDE7Cit9CisKIHZvaWQgb2Zvbm9fZ3Byc19jb250
ZXh0X3NldF90eXBlKHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQgKmdjLAogCQkJCQllbnVtIG9m
b25vX2dwcnNfY29udGV4dF90eXBlIHR5cGUpCiB7Ci0tIAoyLjEzLjUKCg==

--===============4246553566931173955==--

