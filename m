Content-Type: multipart/mixed; boundary="===============9136173577114798197=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7modem: Change in xmm7mode plugin for multi PDP
 handling
Date: Mon, 11 Feb 2019 17:58:36 -0600
Message-ID: <cf8c1c39-471b-76cb-f5b4-6ea1d76213ee@gmail.com>
In-Reply-To: <1549442221-29806-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9136173577114798197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/06/2019 02:37 AM, Antara Borwankar wrote:
> Made changes in xmm7modem plugin to allow mutiple PDP context
> activation and to assign correct network interface to the
> activated PDP context.
> ---
>   plugins/udevng.c  | 12 +++++++++++-
>   plugins/xmm7xxx.c | 21 +++++++++++++++++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)

Can you please separate the udevng changes and xmm7xxx changes into =

separate commits?

> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ff6e1fc..e00b6ac 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1179,7 +1179,7 @@ static gboolean setup_gemalto(struct modem_info* mo=
dem)
>   =

>   static gboolean setup_xmm7xxx(struct modem_info *modem)
>   {
> -	const char *mdm =3D NULL, *net =3D NULL;
> +	const char *mdm =3D NULL, *net =3D NULL, *net2 =3D NULL, *net3 =3D NULL;
>   	GSList *list;
>   =

>   	DBG("%s %s\n", __DATE__, __TIME__);
> @@ -1200,6 +1200,10 @@ static gboolean setup_xmm7xxx(struct modem_info *m=
odem)
>   			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
>   				if (g_strcmp0(info->number, "06") =3D=3D 0)
>   					net =3D info->devnode;
> +				if (g_strcmp0(info->number, "08") =3D=3D 0)
> +					net2 =3D info->devnode;
> +				if (g_strcmp0(info->number, "0a") =3D=3D 0)
> +					net3 =3D info->devnode;
>   			}
>   		} else {
>   			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> @@ -1219,6 +1223,12 @@ static gboolean setup_xmm7xxx(struct modem_info *m=
odem)
>   =

>   	ofono_modem_set_string(modem->modem, "Modem", mdm);
>   	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
> +	if (net2)
> +		ofono_modem_set_string(modem->modem, "NetworkInterface2", net2);
> +	if (net3)
> +		ofono_modem_set_string(modem->modem, "NetworkInterface3", net3);

doc/coding-style.txt item M1

> +	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
> +	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
>   =

>   	return TRUE;
>   }
> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index 237c62c..eaae4ad 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -1269,6 +1269,7 @@ static void xmm7xxx_post_online(struct ofono_modem =
*modem)
>   	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
>   	struct ofono_gprs *gprs;
>   	struct ofono_gprs_context *gc;
> +	const char *interface =3D NULL;
>   =

>   	DBG("%p", modem);
>   =

> @@ -1282,6 +1283,26 @@ static void xmm7xxx_post_online(struct ofono_modem=
 *modem)
>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
>   =

> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface2");
> +
> +	if (interface) {
> +		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
> +					data->chat);
> +
> +		if (gprs && gc)
> +			ofono_gprs_add_context(gprs, gc);
> +	}
> +
> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface3");
> +
> +	if (interface) {
> +		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
> +					data->chat);
> +
> +		if (gprs && gc)
> +			ofono_gprs_add_context(gprs, gc);
> +	}
> +

So this looks fine, but there's one problem, how do you map the =

NetworkInterface to a given gprs_context?  Trying to use any sort of cid =

mapping isn't a great idea since the modem or network can assign these =

as well (e.g. for network initiated contexts).

I think we need to tweak the core to fix this particular issue.  I =

attached a proposed patch for this.  I haven't had a chance to test this =

fully yet, can you give it a quick review/spin?

The idea would be to simply invoke ofono_gprs_context_set_interface in =

the modem driver (e.g. setup code above) and skip this step in the =

actual gprs_context driver code.

>   	ofono_ims_create(modem, "xmm7modem", data->chat);
>   	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
>   }
> =


Regards,
-Denis

--===============9136173577114798197==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gprs-Let-gprs_context-interface-be-settable-once.patch"

PkZyb20gMTNjMGUyNWViMjIxMTFmZmE2YWY0NGQ0MWMzZDhkMzg4NTM4ZmRmYiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMTEgRmViIDIwMTkgMTc6NTE6MTYgLTA2MDAKU3ViamVjdDogW1BBVENIXSBncHJz
OiBMZXQgZ3Byc19jb250ZXh0IGludGVyZmFjZSBiZSBzZXR0YWJsZSBvbmNlCgpUaGlzIHBhdGNo
IGFsbG93cyBhIGRyaXZlciB0byBzZXQgdGhlIGludGVyZmFjZSBvbmx5IG9uY2UsIGluc3RlYWQg
b2YgYXQKZXZlcnkgY29udGV4dCBhY3RpdmF0aW9uLiAgVGhlIHByZXZpb3VzIHdheSB3YXMgb3Jp
Z2luYWxseSBkZXNpZ25lZCBmb3IKUFBQIGFuZCBSQVdfSVAgYmFzZWQgY29udGV4dHMgd2hpY2gg
d291bGQgaGF2ZSBhIChwb3RlbnRpYWxseSkKZGlmZmVyZW50bHkgbmFtZWQgaW50ZXJmYWNlIGFm
dGVyIGVhY2ggY29udGV4dCBhY3RpdmF0aW9uIGR1ZSB0byB1c2Ugb2YKVFVOL1RBUC4gIFRoaXMg
YWxzbyB3b3JrZWQgZm9yIHN0YXRpYyBoaWdoLXNwZWVkIGludGVyZmFjZSBzZXR1cHMgYXMKd2Vs
bCwgc2luY2UgdGhlc2UgdXN1YWxseSBoYWQgYSBzaW5nbGUgaW50ZXJmYWNlIG9ubHkuCgpGb3Ig
ZGV2aWNlcyB0aGF0IHN1cHBvcnQgbXVsdGlwbGUgaGlnaC1zcGVlZCBpbnRlcmZhY2VzIGl0IHdv
dWxkIGJlCmFkdmFudGFnZW91cyB0byBoYXZlIGVhY2ggZ3Byc19jb250ZXh0IGdldCBhbiBpbnRl
cmZhY2UgYXNzaWdubWVudCByaWdodAppbiB0aGUgbW9kZW0gZHJpdmVyIGFuZCBza2lwIGhhdmlu
ZyB0byBzZXR1cCB0aGUgaW50ZXJmYWNlIG9uIGV2ZXJ5CmFjdGl2YXRpb24uCi0tLQogc3JjL2dw
cnMuYyB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMzMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJzLmMKaW5kZXggNThh
OTk4Y2EuLjNkY2UwMDFiIDEwMDY0NAotLS0gYS9zcmMvZ3Bycy5jCisrKyBiL3NyYy9ncHJzLmMK
QEAgLTEwNCw3ICsxMDQsNiBAQCBzdHJ1Y3QgaXB2Nl9zZXR0aW5ncyB7CiB9OwogCiBzdHJ1Y3Qg
Y29udGV4dF9zZXR0aW5ncyB7Ci0JY2hhciAqaW50ZXJmYWNlOwogCXN0cnVjdCBpcHY0X3NldHRp
bmdzICppcHY0OwogCXN0cnVjdCBpcHY2X3NldHRpbmdzICppcHY2OwogfTsKQEAgLTExNSw2ICsx
MTQsNyBAQCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0IHsKIAlvZm9ub19ib29sX3QgaW51c2U7
CiAJY29uc3Qgc3RydWN0IG9mb25vX2dwcnNfY29udGV4dF9kcml2ZXIgKmRyaXZlcjsKIAl2b2lk
ICpkcml2ZXJfZGF0YTsKKwljaGFyICppbnRlcmZhY2U7CiAJc3RydWN0IGNvbnRleHRfc2V0dGlu
Z3MgKnNldHRpbmdzOwogCXN0cnVjdCBvZm9ub19hdG9tICphdG9tOwogfTsKQEAgLTMyMiwxMiAr
MzIyLDEwIEBAIHN0YXRpYyB2b2lkIGNvbnRleHRfc2V0dGluZ3NfZnJlZShzdHJ1Y3QgY29udGV4
dF9zZXR0aW5ncyAqc2V0dGluZ3MpCiAJCWdfZnJlZShzZXR0aW5ncy0+aXB2Nik7CiAJCXNldHRp
bmdzLT5pcHY2ID0gTlVMTDsKIAl9Ci0KLQlnX2ZyZWUoc2V0dGluZ3MtPmludGVyZmFjZSk7Ci0J
c2V0dGluZ3MtPmludGVyZmFjZSA9IE5VTEw7CiB9CiAKIHN0YXRpYyB2b2lkIGNvbnRleHRfc2V0
dGluZ3NfYXBwZW5kX2lwdjQoc3RydWN0IGNvbnRleHRfc2V0dGluZ3MgKnNldHRpbmdzLAorCQkJ
CQkJY29uc3QgY2hhciAqaW50ZXJmYWNlLAogCQkJCQkJREJ1c01lc3NhZ2VJdGVyICppdGVyKQog
ewogCURCdXNNZXNzYWdlSXRlciB2YXJpYW50OwpAQCAtMzUyLDcgKzM1MCw3IEBAIHN0YXRpYyB2
b2lkIGNvbnRleHRfc2V0dGluZ3NfYXBwZW5kX2lwdjQoc3RydWN0IGNvbnRleHRfc2V0dGluZ3Mg
KnNldHRpbmdzLAogCQlnb3RvIGRvbmU7CiAKIAlvZm9ub19kYnVzX2RpY3RfYXBwZW5kKCZhcnJh
eSwgIkludGVyZmFjZSIsCi0JCQkJREJVU19UWVBFX1NUUklORywgJnNldHRpbmdzLT5pbnRlcmZh
Y2UpOworCQkJCURCVVNfVFlQRV9TVFJJTkcsICZpbnRlcmZhY2UpOwogCiAJLyogSWYgd2UgaGF2
ZSBhIFByb3h5LCBubyBvdGhlciBzZXR0aW5ncyBhcmUgcmVsZXZhbnQgKi8KIAlpZiAoc2V0dGlu
Z3MtPmlwdjQtPnByb3h5KSB7CkBAIC0zOTIsNiArMzkwLDcgQEAgZG9uZToKIH0KIAogc3RhdGlj
IHZvaWQgY29udGV4dF9zZXR0aW5nc19hcHBlbmRfaXB2NF9kaWN0KHN0cnVjdCBjb250ZXh0X3Nl
dHRpbmdzICpzZXR0aW5ncywKKwkJCQkJCWNvbnN0IGNoYXIgKmludGVyZmFjZSwKIAkJCQkJCURC
dXNNZXNzYWdlSXRlciAqZGljdCkKIHsKIAlEQnVzTWVzc2FnZUl0ZXIgZW50cnk7CkBAIC00MDIs
MTIgKzQwMSwxMyBAQCBzdGF0aWMgdm9pZCBjb250ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY0X2Rp
Y3Qoc3RydWN0IGNvbnRleHRfc2V0dGluZ3MgKnNldHRpbmdzLAogCiAJZGJ1c19tZXNzYWdlX2l0
ZXJfYXBwZW5kX2Jhc2ljKCZlbnRyeSwgREJVU19UWVBFX1NUUklORywgJmtleSk7CiAKLQljb250
ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY0KHNldHRpbmdzLCAmZW50cnkpOworCWNvbnRleHRfc2V0
dGluZ3NfYXBwZW5kX2lwdjQoc2V0dGluZ3MsIGludGVyZmFjZSwgJmVudHJ5KTsKIAogCWRidXNf
bWVzc2FnZV9pdGVyX2Nsb3NlX2NvbnRhaW5lcihkaWN0LCAmZW50cnkpOwogfQogCiBzdGF0aWMg
dm9pZCBjb250ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY2KHN0cnVjdCBjb250ZXh0X3NldHRpbmdz
ICpzZXR0aW5ncywKKwkJCQkJCWNvbnN0IGNoYXIgKmludGVyZmFjZSwKIAkJCQkJCURCdXNNZXNz
YWdlSXRlciAqaXRlcikKIHsKIAlEQnVzTWVzc2FnZUl0ZXIgdmFyaWFudDsKQEAgLTQzMSw3ICs0
MzEsNyBAQCBzdGF0aWMgdm9pZCBjb250ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY2KHN0cnVjdCBj
b250ZXh0X3NldHRpbmdzICpzZXR0aW5ncywKIAkJZ290byBkb25lOwogCiAJb2Zvbm9fZGJ1c19k
aWN0X2FwcGVuZCgmYXJyYXksICJJbnRlcmZhY2UiLAotCQkJCURCVVNfVFlQRV9TVFJJTkcsICZz
ZXR0aW5ncy0+aW50ZXJmYWNlKTsKKwkJCQlEQlVTX1RZUEVfU1RSSU5HLCAmaW50ZXJmYWNlKTsK
IAogCWlmIChzZXR0aW5ncy0+aXB2Ni0+aXApCiAJCW9mb25vX2RidXNfZGljdF9hcHBlbmQoJmFy
cmF5LCAiQWRkcmVzcyIsIERCVVNfVFlQRV9TVFJJTkcsCkBAIC00NTcsNiArNDU3LDcgQEAgZG9u
ZToKIH0KIAogc3RhdGljIHZvaWQgY29udGV4dF9zZXR0aW5nc19hcHBlbmRfaXB2Nl9kaWN0KHN0
cnVjdCBjb250ZXh0X3NldHRpbmdzICpzZXR0aW5ncywKKwkJCQkJCWNvbnN0IGNoYXIgKmludGVy
ZmFjZSwKIAkJCQkJCURCdXNNZXNzYWdlSXRlciAqZGljdCkKIHsKIAlEQnVzTWVzc2FnZUl0ZXIg
ZW50cnk7CkBAIC00NjcsMTMgKzQ2OCwxNCBAQCBzdGF0aWMgdm9pZCBjb250ZXh0X3NldHRpbmdz
X2FwcGVuZF9pcHY2X2RpY3Qoc3RydWN0IGNvbnRleHRfc2V0dGluZ3MgKnNldHRpbmdzLAogCiAJ
ZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2Jhc2ljKCZlbnRyeSwgREJVU19UWVBFX1NUUklORywg
JmtleSk7CiAKLQljb250ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY2KHNldHRpbmdzLCAmZW50cnkp
OworCWNvbnRleHRfc2V0dGluZ3NfYXBwZW5kX2lwdjYoc2V0dGluZ3MsIGludGVyZmFjZSwgJmVu
dHJ5KTsKIAogCWRidXNfbWVzc2FnZV9pdGVyX2Nsb3NlX2NvbnRhaW5lcihkaWN0LCAmZW50cnkp
OwogfQogCiBzdGF0aWMgdm9pZCBzaWduYWxfc2V0dGluZ3Moc3RydWN0IHByaV9jb250ZXh0ICpj
dHgsIGNvbnN0IGNoYXIgKnByb3AsCi0JCXZvaWQgKCphcHBlbmQpKHN0cnVjdCBjb250ZXh0X3Nl
dHRpbmdzICosIERCdXNNZXNzYWdlSXRlciAqKSkKKwkJdm9pZCAoKmFwcGVuZCkoc3RydWN0IGNv
bnRleHRfc2V0dGluZ3MgKiwKKwkJCQkJY29uc3QgY2hhciAqLCBEQnVzTWVzc2FnZUl0ZXIgKikp
CiAKIHsKIAlEQnVzQ29ubmVjdGlvbiAqY29ubiA9IG9mb25vX2RidXNfZ2V0X2Nvbm5lY3Rpb24o
KTsKQEAgLTQ4MSw2ICs0ODMsNyBAQCBzdGF0aWMgdm9pZCBzaWduYWxfc2V0dGluZ3Moc3RydWN0
IHByaV9jb250ZXh0ICpjdHgsIGNvbnN0IGNoYXIgKnByb3AsCiAJREJ1c01lc3NhZ2UgKnNpZ25h
bDsKIAlEQnVzTWVzc2FnZUl0ZXIgaXRlcjsKIAlzdHJ1Y3QgY29udGV4dF9zZXR0aW5ncyAqc2V0
dGluZ3M7CisJY29uc3QgY2hhciAqaW50ZXJmYWNlOwogCiAJc2lnbmFsID0gZGJ1c19tZXNzYWdl
X25ld19zaWduYWwocGF0aCwKIAkJCQkJT0ZPTk9fQ09OTkVDVElPTl9DT05URVhUX0lOVEVSRkFD
RSwKQEAgLTQ5MiwxMiArNDk1LDE1IEBAIHN0YXRpYyB2b2lkIHNpZ25hbF9zZXR0aW5ncyhzdHJ1
Y3QgcHJpX2NvbnRleHQgKmN0eCwgY29uc3QgY2hhciAqcHJvcCwKIAlkYnVzX21lc3NhZ2VfaXRl
cl9pbml0X2FwcGVuZChzaWduYWwsICZpdGVyKTsKIAlkYnVzX21lc3NhZ2VfaXRlcl9hcHBlbmRf
YmFzaWMoJml0ZXIsIERCVVNfVFlQRV9TVFJJTkcsICZwcm9wKTsKIAotCWlmIChjdHgtPmNvbnRl
eHRfZHJpdmVyKQorCWlmIChjdHgtPmNvbnRleHRfZHJpdmVyKSB7CiAJCXNldHRpbmdzID0gY3R4
LT5jb250ZXh0X2RyaXZlci0+c2V0dGluZ3M7Ci0JZWxzZQorCQlpbnRlcmZhY2UgPSBjdHgtPmNv
bnRleHRfZHJpdmVyLT5pbnRlcmZhY2U7CisJfSBlbHNlIHsKIAkJc2V0dGluZ3MgPSBOVUxMOwor
CQlpbnRlcmZhY2UgPSBOVUxMOworCX0KIAotCWFwcGVuZChzZXR0aW5ncywgJml0ZXIpOworCWFw
cGVuZChzZXR0aW5ncywgaW50ZXJmYWNlLCAmaXRlcik7CiAJZ19kYnVzX3NlbmRfbWVzc2FnZShj
b25uLCBzaWduYWwpOwogfQogCkBAIC02ODAsMTggKzY4NiwxNiBAQCBzdGF0aWMgdm9pZCBwcmlf
c2V0cHJveHkoY29uc3QgY2hhciAqaW50ZXJmYWNlLCBjb25zdCBjaGFyICpwcm94eSkKIHN0YXRp
YyB2b2lkIHByaV9yZXNldF9jb250ZXh0X3NldHRpbmdzKHN0cnVjdCBwcmlfY29udGV4dCAqY3R4
KQogewogCXN0cnVjdCBjb250ZXh0X3NldHRpbmdzICpzZXR0aW5nczsKLQljaGFyICppbnRlcmZh
Y2U7CisJY29uc3QgY2hhciAqaW50ZXJmYWNlOwogCWdib29sZWFuIHNpZ25hbF9pcHY0OwogCWdi
b29sZWFuIHNpZ25hbF9pcHY2OwogCiAJaWYgKGN0eC0+Y29udGV4dF9kcml2ZXIgPT0gTlVMTCkK
IAkJcmV0dXJuOwogCisJaW50ZXJmYWNlID0gY3R4LT5jb250ZXh0X2RyaXZlci0+aW50ZXJmYWNl
OwogCXNldHRpbmdzID0gY3R4LT5jb250ZXh0X2RyaXZlci0+c2V0dGluZ3M7CiAKLQlpbnRlcmZh
Y2UgPSBzZXR0aW5ncy0+aW50ZXJmYWNlOwotCXNldHRpbmdzLT5pbnRlcmZhY2UgPSBOVUxMOwot
CiAJc2lnbmFsX2lwdjQgPSBzZXR0aW5ncy0+aXB2NCAhPSBOVUxMOwogCXNpZ25hbF9pcHY2ID0g
c2V0dGluZ3MtPmlwdjYgIT0gTlVMTDsKIApAQCAtNzA4LDggKzcxMiw2IEBAIHN0YXRpYyB2b2lk
IHByaV9yZXNldF9jb250ZXh0X3NldHRpbmdzKHN0cnVjdCBwcmlfY29udGV4dCAqY3R4KQogCX0K
IAogCXByaV9pZnVwZG93bihpbnRlcmZhY2UsIEZBTFNFKTsKLQotCWdfZnJlZShpbnRlcmZhY2Up
OwogfQogCiBzdGF0aWMgdm9pZCBwcmlfdXBkYXRlX21tc19jb250ZXh0X3NldHRpbmdzKHN0cnVj
dCBwcmlfY29udGV4dCAqY3R4KQpAQCAtNzI0LDEwICs3MjYsMTAgQEAgc3RhdGljIHZvaWQgcHJp
X3VwZGF0ZV9tbXNfY29udGV4dF9zZXR0aW5ncyhzdHJ1Y3QgcHJpX2NvbnRleHQgKmN0eCkKIAog
CURCRygicHJveHkgJXMgcG9ydCAldSIsIGN0eC0+cHJveHlfaG9zdCwgY3R4LT5wcm94eV9wb3J0
KTsKIAotCXByaV9zZXRfaXB2NF9hZGRyKHNldHRpbmdzLT5pbnRlcmZhY2UsIHNldHRpbmdzLT5p
cHY0LT5pcCk7CisJcHJpX3NldF9pcHY0X2FkZHIoZ2MtPmludGVyZmFjZSwgc2V0dGluZ3MtPmlw
djQtPmlwKTsKIAogCWlmIChjdHgtPnByb3h5X2hvc3QpCi0JCXByaV9zZXRwcm94eShzZXR0aW5n
cy0+aW50ZXJmYWNlLCBjdHgtPnByb3h5X2hvc3QpOworCQlwcmlfc2V0cHJveHkoZ2MtPmludGVy
ZmFjZSwgY3R4LT5wcm94eV9ob3N0KTsKIH0KIAogc3RhdGljIHZvaWQgYXBwZW5kX2NvbnRleHRf
cHJvcGVydGllcyhzdHJ1Y3QgcHJpX2NvbnRleHQgKmN0eCwKQEAgLTczOSw2ICs3NDEsNyBAQCBz
dGF0aWMgdm9pZCBhcHBlbmRfY29udGV4dF9wcm9wZXJ0aWVzKHN0cnVjdCBwcmlfY29udGV4dCAq
Y3R4LAogCWRidXNfYm9vbF90IHZhbHVlOwogCWNvbnN0IGNoYXIgKnN0cnZhbHVlOwogCXN0cnVj
dCBjb250ZXh0X3NldHRpbmdzICpzZXR0aW5nczsKKwljb25zdCBjaGFyICppbnRlcmZhY2U7CiAK
IAlvZm9ub19kYnVzX2RpY3RfYXBwZW5kKGRpY3QsICJOYW1lIiwgREJVU19UWVBFX1NUUklORywg
Jm5hbWUpOwogCkBAIC03NzUsMTMgKzc3OCwxNiBAQCBzdGF0aWMgdm9pZCBhcHBlbmRfY29udGV4
dF9wcm9wZXJ0aWVzKHN0cnVjdCBwcmlfY29udGV4dCAqY3R4LAogCQkJCQlEQlVTX1RZUEVfU1RS
SU5HLCAmc3RydmFsdWUpOwogCX0KIAotCWlmIChjdHgtPmNvbnRleHRfZHJpdmVyKQorCWlmIChj
dHgtPmNvbnRleHRfZHJpdmVyKSB7CiAJCXNldHRpbmdzID0gY3R4LT5jb250ZXh0X2RyaXZlci0+
c2V0dGluZ3M7Ci0JZWxzZQorCQlpbnRlcmZhY2UgPSBjdHgtPmNvbnRleHRfZHJpdmVyLT5pbnRl
cmZhY2U7CisJfSBlbHNlIHsKIAkJc2V0dGluZ3MgPSBOVUxMOworCQlpbnRlcmZhY2UgPSBOVUxM
OworCX0KIAotCWNvbnRleHRfc2V0dGluZ3NfYXBwZW5kX2lwdjRfZGljdChzZXR0aW5ncywgZGlj
dCk7Ci0JY29udGV4dF9zZXR0aW5nc19hcHBlbmRfaXB2Nl9kaWN0KHNldHRpbmdzLCBkaWN0KTsK
Kwljb250ZXh0X3NldHRpbmdzX2FwcGVuZF9pcHY0X2RpY3Qoc2V0dGluZ3MsIGludGVyZmFjZSwg
ZGljdCk7CisJY29udGV4dF9zZXR0aW5nc19hcHBlbmRfaXB2Nl9kaWN0KHNldHRpbmdzLCBpbnRl
cmZhY2UsIGRpY3QpOwogfQogCiBzdGF0aWMgREJ1c01lc3NhZ2UgKnByaV9nZXRfcHJvcGVydGll
cyhEQnVzQ29ubmVjdGlvbiAqY29ubiwKQEAgLTgzMCw4ICs4MzYsOCBAQCBzdGF0aWMgdm9pZCBw
cmlfYWN0aXZhdGVfY2FsbGJhY2soY29uc3Qgc3RydWN0IG9mb25vX2Vycm9yICplcnJvciwgdm9p
ZCAqZGF0YSkKIAlfX29mb25vX2RidXNfcGVuZGluZ19yZXBseSgmY3R4LT5wZW5kaW5nLAogCQkJ
CWRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihjdHgtPnBlbmRpbmcpKTsKIAotCWlmIChn
Yy0+c2V0dGluZ3MtPmludGVyZmFjZSAhPSBOVUxMKSB7Ci0JCXByaV9pZnVwZG93bihnYy0+c2V0
dGluZ3MtPmludGVyZmFjZSwgVFJVRSk7CisJaWYgKGdjLT5pbnRlcmZhY2UgIT0gTlVMTCkgewor
CQlwcmlfaWZ1cGRvd24oZ2MtPmludGVyZmFjZSwgVFJVRSk7CiAKIAkJaWYgKGN0eC0+dHlwZSA9
PSBPRk9OT19HUFJTX0NPTlRFWFRfVFlQRV9NTVMgJiYKIAkJCQlnYy0+c2V0dGluZ3MtPmlwdjQp
CkBAIC05MjIsOCArOTI4LDggQEAgc3RhdGljIHZvaWQgcHJpX3JlYWRfc2V0dGluZ3NfY2FsbGJh
Y2soY29uc3Qgc3RydWN0IG9mb25vX2Vycm9yICplcnJvciwKIAogCXByaV9jdHgtPmFjdGl2ZSA9
IFRSVUU7CiAKLQlpZiAoZ2MtPnNldHRpbmdzLT5pbnRlcmZhY2UgIT0gTlVMTCkgewotCQlwcmlf
aWZ1cGRvd24oZ2MtPnNldHRpbmdzLT5pbnRlcmZhY2UsIFRSVUUpOworCWlmIChnYy0+aW50ZXJm
YWNlICE9IE5VTEwpIHsKKwkJcHJpX2lmdXBkb3duKGdjLT5pbnRlcmZhY2UsIFRSVUUpOwogCiAJ
CXByaV9jb250ZXh0X3NpZ25hbF9zZXR0aW5ncyhwcmlfY3R4LCBnYy0+c2V0dGluZ3MtPmlwdjQg
IT0gTlVMTCwKIAkJCQkJCWdjLT5zZXR0aW5ncy0+aXB2NiAhPSBOVUxMKTsKQEAgLTE0MzMsNyAr
MTQzOSw3IEBAIHN0YXRpYyBnYm9vbGVhbiBjb250ZXh0X2RidXNfdW5yZWdpc3RlcihzdHJ1Y3Qg
cHJpX2NvbnRleHQgKmN0eCkKIAogCWlmIChjdHgtPmFjdGl2ZSA9PSBUUlVFKSB7CiAJCWNvbnN0
IGNoYXIgKmludGVyZmFjZSA9Ci0JCQljdHgtPmNvbnRleHRfZHJpdmVyLT5zZXR0aW5ncy0+aW50
ZXJmYWNlOworCQkJY3R4LT5jb250ZXh0X2RyaXZlci0+aW50ZXJmYWNlOwogCiAJCWlmIChjdHgt
PnR5cGUgPT0gT0ZPTk9fR1BSU19DT05URVhUX1RZUEVfTU1TKQogCQkJcHJpX3NldF9pcHY0X2Fk
ZHIoaW50ZXJmYWNlLCBOVUxMKTsKQEAgLTI4MDgsMTAgKzI4MTQsOCBAQCBlbnVtIG9mb25vX2dw
cnNfY29udGV4dF90eXBlIG9mb25vX2dwcnNfY29udGV4dF9nZXRfdHlwZSgKIHZvaWQgb2Zvbm9f
Z3Byc19jb250ZXh0X3NldF9pbnRlcmZhY2Uoc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2Ms
CiAJCQkJCWNvbnN0IGNoYXIgKmludGVyZmFjZSkKIHsKLQlzdHJ1Y3QgY29udGV4dF9zZXR0aW5n
cyAqc2V0dGluZ3MgPSBnYy0+c2V0dGluZ3M7Ci0KLQlnX2ZyZWUoc2V0dGluZ3MtPmludGVyZmFj
ZSk7Ci0Jc2V0dGluZ3MtPmludGVyZmFjZSA9IGdfc3RyZHVwKGludGVyZmFjZSk7CisJZ19mcmVl
KGdjLT5pbnRlcmZhY2UpOworCWdjLT5pbnRlcmZhY2UgPSBnX3N0cmR1cChpbnRlcmZhY2UpOwog
fQogCiB2b2lkIG9mb25vX2dwcnNfY29udGV4dF9zZXRfaXB2NF9hZGRyZXNzKHN0cnVjdCBvZm9u
b19ncHJzX2NvbnRleHQgKmdjLAotLSAKMi4xMy41Cgo=

--===============9136173577114798197==--

