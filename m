Content-Type: multipart/mixed; boundary="===============1920679474745368111=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Skip unsolicied CREG/CGREG correctly while checking
 GPRS attach status
Date: Mon, 06 Dec 2010 21:41:34 -0600
Message-ID: <4CFDACEE.9080807@gmail.com>
In-Reply-To: <1291389612.2043.25.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1920679474745368111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/03/2010 09:20 AM, Tonny Tzeng wrote:
> This patch is to skip unsolicited CGREG while checking the GPRS attach
> status, especially for Huawei modem which sends lac and ci strings in
> unquoted format, and casues at_util_parse_reg() return lac value as
> status.
> =

> ---
>  drivers/atmodem/atutil.c |   12 ++++++++----
>  gatchat/gatresult.c      |    5 +++++
>  gatchat/gatresult.h      |    1 +

We like to see patches split on a top level directory boundary.  Please
see the 'Submitting patches' section in the HACKING document.

>  3 files changed, 14 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index b6f0d92..c190aa2 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -243,13 +243,11 @@ gboolean at_util_parse_reg(GAtResult *result,
> const char *prefix,
>  		if (g_at_result_iter_next_number(&iter, &s) =3D=3D FALSE)
>  			continue;
>  =

> -		/* Some firmware will report bogus lac/ci when unregistered */
> -		if (s !=3D 1 && s !=3D 5)
> -			goto out;
> -

Skipping this check is still a bad idea.

>  		switch (vendor) {
>  		case OFONO_VENDOR_HUAWEI:
>  		case OFONO_VENDOR_NOVATEL:
> +			if (g_at_result_iter_eol(&iter))
> +				continue;

Coding style item M1.

>  			r =3D g_at_result_iter_next_unquoted_string(&iter, &str);
>  =

>  			if (r =3D=3D TRUE)
> @@ -257,6 +255,8 @@ gboolean at_util_parse_reg(GAtResult *result, const
> char *prefix,
>  			else
>  				goto out;
>  =

> +			if (g_at_result_iter_eol(&iter))
> +				continue;

Coding style item M1.

>  			r =3D g_at_result_iter_next_unquoted_string(&iter, &str);
>  =

>  			if (r =3D=3D TRUE)
> @@ -266,11 +266,15 @@ gboolean at_util_parse_reg(GAtResult *result,
> const char *prefix,
>  =

>  			break;
>  		default:
> +			if (g_at_result_iter_eol(&iter))
> +				continue;

Coding style item M1.  And continuing is not the right thing to do here

>  			if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
>  				l =3D strtol(str, NULL, 16);
>  			else
>  				goto out;
>  =

> +			if (g_at_result_iter_eol(&iter))
> +				continue;

Ditto

>  			if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
>  				c =3D strtol(str, NULL, 16);
>  			else
> diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
> index 8a6dfae..c919305 100644
> --- a/gatchat/gatresult.c
> +++ b/gatchat/gatresult.c
> @@ -39,6 +39,11 @@ void g_at_result_iter_init(GAtResultIter *iter,
> GAtResult *result)
>  	iter->line_pos =3D 0;
>  }
>  =

> +gboolean g_at_result_iter_eol(GAtResultIter *iter)
> +{
> +	return iter->line_pos >=3D strlen(iter->l->data);
> +}
> +

And I pretty much don't see the need for this.  It doesn't really help
you here.

>  gboolean g_at_result_iter_next(GAtResultIter *iter, const char *prefix)
>  {
>  	char *line;
> diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
> index a74741f..33c0b2c 100644
> --- a/gatchat/gatresult.h
> +++ b/gatchat/gatresult.h
> @@ -46,6 +46,7 @@ struct _GAtResultIter {
>  typedef struct _GAtResultIter GAtResultIter;
>  =

>  void g_at_result_iter_init(GAtResultIter *iter, GAtResult *result);
> +gboolean g_at_result_iter_eol(GAtResultIter *iter);
>  =

>  gboolean g_at_result_iter_next(GAtResultIter *iter, const char
> *prefix);
>  gboolean g_at_result_iter_open_list(GAtResultIter *iter);

Anyhow, can you please try the attached patch and see if it solves your
problems.

Regards,
-Denis

--===============1920679474745368111==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-atutil-Fix-parsing-of-un-quoted-CREG-CGREG.patch"

PkZyb20gZjU0NzNjMzk4YTJlMjlhOThjNzRhZDRjOThhNDI3NTY0ZTI1ZDlkMCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgNiBEZWMgMjAxMCAyMTozNjo1NCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGF0dXRp
bDogRml4IHBhcnNpbmcgb2YgdW4tcXVvdGVkIENSRUcgLyBDR1JFRwoKT24gYnJva2VuIGhhcmR3
YXJlIGxpa2UgdGhlIEh1YXdlaSwgaXQgaXMgcG9zc2libGUgdG8gcmVjZWl2ZSBib3RoIGFuCnVu
c29saWNpdGVkIGFuZCBhIHNvbGljaXRlZCB2ZXJzaW9uIG9mIHRoZSBDUkVHIC8gQ0dSRUcgd2l0
aGluIHdpdGhpbgp0aGUgc2FtZSByZXNwb25zZSBzZXQuICBTa2lwcGluZyBvZiB0aGUgdW5zb2xp
Y2l0ZWQgdmVyc2lvbiB3YXMgbm90CmhhbmRsZWQgY29ycmVjdGx5LiAgVGhpcyBhdHRlbXB0cyB0
byBmaXggdGhpcyBpc3N1ZS4KLS0tCiBkcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmMgfCAgIDE5ICsr
KysrKysrKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmMgYi9kcml2
ZXJzL2F0bW9kZW0vYXR1dGlsLmMKaW5kZXggYjZmMGQ5Mi4uNDI3YjA5OCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9hdG1vZGVtL2F0dXRpbC5jCisrKyBiL2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwuYwpA
QCAtMjQwLDggKzI0MCwyMyBAQCBnYm9vbGVhbiBhdF91dGlsX3BhcnNlX3JlZyhHQXRSZXN1bHQg
KnJlc3VsdCwgY29uc3QgY2hhciAqcHJlZml4LAogCQlnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVt
YmVyKCZpdGVyLCAmbSk7CiAKIAkJLyogU29tZXRpbWVzIHdlIGdldCBhbiB1bnNvbGljaXRlZCBD
UkVHL0NHUkVHIGhlcmUsIHNraXAgaXQgKi8KLQkJaWYgKGdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9u
dW1iZXIoJml0ZXIsICZzKSA9PSBGQUxTRSkKLQkJCWNvbnRpbnVlOworCQlzd2l0Y2ggKHZlbmRv
cikgeworCQljYXNlIE9GT05PX1ZFTkRPUl9IVUFXRUk6CisJCWNhc2UgT0ZPTk9fVkVORE9SX05P
VkFURUw6CisJCQlyID0gZ19hdF9yZXN1bHRfaXRlcl9uZXh0X3VucXVvdGVkX3N0cmluZygmaXRl
ciwgJnN0cik7CisKKwkJCWlmIChyID09IEZBTFNFIHx8IHN0cmxlbihzdHIpICE9IDEpCisJCQkJ
Y29udGludWU7CisKKwkJCXMgPSBzdHJ0b2woc3RyLCBOVUxMLCAxMCk7CisKKwkJCWJyZWFrOwor
CQlkZWZhdWx0OgorCQkJaWYgKGdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZz
KSA9PSBGQUxTRSkKKwkJCQljb250aW51ZTsKKworCQkJYnJlYWs7CisJCX0KIAogCQkvKiBTb21l
IGZpcm13YXJlIHdpbGwgcmVwb3J0IGJvZ3VzIGxhYy9jaSB3aGVuIHVucmVnaXN0ZXJlZCAqLwog
CQlpZiAocyAhPSAxICYmIHMgIT0gNSkKLS0gCjEuNy4wLjQKCg==

--===============1920679474745368111==--

