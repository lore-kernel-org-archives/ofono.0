Content-Type: multipart/mixed; boundary="===============0091970823825273173=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gobi/qmi: Fix invalid memory access
Date: Thu, 11 May 2017 14:45:25 -0500
Message-ID: <61d4226a-d9f1-8c38-f599-dceb73b17131@gmail.com>
In-Reply-To: <20170511165006.24333-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0091970823825273173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/11/2017 11:50 AM, Pau Espin Pedrol wrote:
> Fixes following issue announced by valgrind:
>
> ofonod[2870]: plugins/gobi.c:shutdown_cb()
> ofonod[2870]: src/modem.c:modem_change_state() old state: 0, new state: 0
> =3D=3D2870=3D=3D Invalid read of size 8
> =3D=3D2870=3D=3D    at 0x453ADE: shutdown_destroy (qmi.c:1254)
> =3D=3D2870=3D=3D    by 0x508A717: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DB8B: g_main_context_dispatch (in /lib/x86_64=
-linux-gnu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-g=
nu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
> =3D=3D2870=3D=3D  Address 0x6a07518 is 152 bytes inside a block of size 1=
68 free'd
> =3D=3D2870=3D=3D    at 0x4C29E90: free (vg_replace_malloc.c:473)
> =3D=3D2870=3D=3D    by 0x4532FF: qmi_device_unref (qmi.c:1003)
> =3D=3D2870=3D=3D    by 0x45E09B: shutdown_cb (gobi.c:120)
> =3D=3D2870=3D=3D    by 0x453B68: shutdown_callback (qmi.c:1268)
> =3D=3D2870=3D=3D    by 0x508E612: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DB6C: g_main_context_dispatch (in /lib/x86_64=
-linux-gnu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-g=
nu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
> =3D=3D2870=3D=3D
> =3D=3D2870=3D=3D Invalid write of size 4
> =3D=3D2870=3D=3D    at 0x453B09: shutdown_destroy (qmi.c:1257)
> =3D=3D2870=3D=3D    by 0x508A717: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DB8B: g_main_context_dispatch (in /lib/x86_64=
-linux-gnu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-g=
nu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
> =3D=3D2870=3D=3D  Address 0x6a07520 is 160 bytes inside a block of size 1=
68 free'd
> =3D=3D2870=3D=3D    at 0x4C29E90: free (vg_replace_malloc.c:473)
> =3D=3D2870=3D=3D    by 0x4532FF: qmi_device_unref (qmi.c:1003)
> =3D=3D2870=3D=3D    by 0x45E09B: shutdown_cb (gobi.c:120)
> =3D=3D2870=3D=3D    by 0x453B68: shutdown_callback (qmi.c:1268)
> =3D=3D2870=3D=3D    by 0x508E612: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DB6C: g_main_context_dispatch (in /lib/x86_64=
-linux-gnu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2=
.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-g=
nu/libglib-2.0.so.0.4200.1)
> =3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
> =3D=3D2870=3D=3D
> ---
>  drivers/qmimodem/qmi.c | 3 ++-
>  plugins/gobi.c         | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Please refer to our patch submission guidelines, see HACKING, =

'Submitting patches'.

>
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 80c6adef..07daee9b 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1251,10 +1251,11 @@ static void shutdown_destroy(gpointer user_data)
>  {
>  	struct qmi_device *device =3D user_data;
>
> +	device->shutdown_source =3D 0;
> +
>  	if (device->shutdown_destroy)
>  		device->shutdown_destroy(device->shutdown_user_data);
>
> -	device->shutdown_source =3D 0;
>  }
>
>  static gboolean shutdown_callback(gpointer user_data)
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index a4985990..44c9c3ec 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -132,7 +132,7 @@ static void shutdown_device(struct ofono_modem *modem)
>  	qmi_service_unref(data->dms);
>  	data->dms =3D NULL;
>
> -	qmi_device_shutdown(data->device, shutdown_cb, modem, NULL);
> +	qmi_device_shutdown(data->device, NULL, modem, shutdown_cb);

Semantically this is quite wrong.  The destroy callback is used if the =

user data has been newly allocated.  It should be NULL otherwise.  The =

next time someone goes to use this API (in a semantically usual way), =

the bug will again appear.

Anyway, the sequence of events is roughly:

1. timeout fires
2. glib calls timeout callback (e.g. shutdown_callback) which in turn =

calls shutdown_func (gobi shutdown_cb) which in turn calls =

qmi_device_unref()
3. qmi_device_unref calls g_source_remove, which doesn't call the =

destroy callback (it is blocked)
4. qmi_device_unref then frees the memory used by device
5. glib then calls the source destroy callback (e.g. shutdown_destroy) =

which results in just freed memory being used.

>  }
>
>  static void power_reset_cb(struct qmi_result *result, void *user_data)
>

Please try the attached patch.

Regards,
-Denis

--===============0091970823825273173==
Content-Type: text/x-diff
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-qmi-Fix-invalid-memory-access.patch"

PkZyb20gMmQ2YzRmOWQwMjE1MmEzYTM5MDdkZGI5M2UyYTVkMjc5MWExNTcxMCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMTEgTWF5IDIwMTcgMTQ6NDE6NDMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBxbWk6
IEZpeCBpbnZhbGlkIG1lbW9yeSBhY2Nlc3MKCldoZW4gcW1pX2RldmljZV9zaHV0ZG93biBpcyB1
c2VkIGFuZCB0aGUgY2FsbGJhY2sgcHJvdmlkZWQgdXRpbGl6ZXMKcW1pX2RldmljZV91bnJlZiwg
YW4gYWNjZXNzIGludG8gYWxyZWFkeSBmcmVlZCBtZW1vcnkgaXMgdHJpZ2dlcmVkLgoKU2VxdWVu
Y2Ugb2YgZXZlbnRzIGlzOgoKMS4gdGltZW91dCBmaXJlcwoyLiBnbGliIGNhbGxzIHRpbWVvdXQg
Y2FsbGJhY2sgKGUuZy4gc2h1dGRvd25fY2FsbGJhY2spIHdoaWNoIGluIHR1cm4KY2FsbHMgc2h1
dGRvd25fZnVuYyAoZ29iaSBzaHV0ZG93bl9jYikgd2hpY2ggaW4gdHVybiBjYWxscwpxbWlfZGV2
aWNlX3VucmVmKCkKMy4gcW1pX2RldmljZV91bnJlZiBjYWxscyBnX3NvdXJjZV9yZW1vdmUsIHdo
aWNoIGRvZXNuJ3QgY2FsbCB0aGUKZGVzdHJveSBjYWxsYmFjayAoaXQgaXMgYmxvY2tlZCkKNC4g
cW1pX2RldmljZV91bnJlZiB0aGVuIGZyZWVzIHRoZSBtZW1vcnkgdXNlZCBieSBkZXZpY2UKNS4g
Z2xpYiB0aGVuIGNhbGxzIHRoZSBzb3VyY2UgZGVzdHJveSBjYWxsYmFjayAoZS5nLiBzaHV0ZG93
bl9kZXN0cm95KQp3aGljaCByZXN1bHRzIGluIGp1c3QgZnJlZWQgbWVtb3J5IGJlaW5nIHVzZWQu
CgpnbGliIGFwcGVhcnMgdG8gYWx3YXlzIGNhbGwgdGhlIGRlc3Ryb3kgY2FsbGJhY2ssIGV2ZW4g
aWYgdGhlIHNvdXJjZSBoYXMKYmVlbiByZW1vdmVkIHByZXZpb3VzbHkuICBTbyB0byB3b3JrIGFy
b3VuZCB0aGUgaXNzdWUsIGRlbGF5IHRoZSBhY3R1YWwKZ19mcmVlIHVudGlsIHRoZSBkZXN0cm95
IGNhbGxiYWNrIGlzIGludm9rZWQuCi0tLQogZHJpdmVycy9xbWltb2RlbS9xbWkuYyB8IDE0ICsr
KysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcW1pbW9kZW0vcW1pLmMgYi9kcml2ZXJzL3FtaW1v
ZGVtL3FtaS5jCmluZGV4IDgwYzZhZGUuLjMwMTIzNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcW1p
bW9kZW0vcW1pLmMKKysrIGIvZHJpdmVycy9xbWltb2RlbS9xbWkuYwpAQCAtNzMsNiArNzMsOCBA
QCBzdHJ1Y3QgcW1pX2RldmljZSB7CiAJdm9pZCAqc2h1dGRvd25fdXNlcl9kYXRhOwogCXFtaV9k
ZXN0cm95X2Z1bmNfdCBzaHV0ZG93bl9kZXN0cm95OwogCWd1aW50IHNodXRkb3duX3NvdXJjZTsK
Kwlib29sIHNodXR0aW5nX2Rvd24gOiAxOworCWJvb2wgZGVzdHJveWVkIDogMTsKIH07CiAKIHN0
cnVjdCBxbWlfc2VydmljZSB7CkBAIC0xMDAwLDcgKzEwMDIsMTAgQEAgdm9pZCBxbWlfZGV2aWNl
X3VucmVmKHN0cnVjdCBxbWlfZGV2aWNlICpkZXZpY2UpCiAJZ19mcmVlKGRldmljZS0+dmVyc2lv
bl9zdHIpOwogCWdfZnJlZShkZXZpY2UtPnZlcnNpb25fbGlzdCk7CiAKLQlnX2ZyZWUoZGV2aWNl
KTsKKwlpZiAoZGV2aWNlLT5zaHV0dGluZ19kb3duKQorCQlkZXZpY2UtPmRlc3Ryb3llZCA9IHRy
dWU7CisJZWxzZQorCQlnX2ZyZWUoZGV2aWNlKTsKIH0KIAogdm9pZCBxbWlfZGV2aWNlX3NldF9k
ZWJ1ZyhzdHJ1Y3QgcW1pX2RldmljZSAqZGV2aWNlLApAQCAtMTI1NSw2ICsxMjYwLDkgQEAgc3Rh
dGljIHZvaWQgc2h1dGRvd25fZGVzdHJveShncG9pbnRlciB1c2VyX2RhdGEpCiAJCWRldmljZS0+
c2h1dGRvd25fZGVzdHJveShkZXZpY2UtPnNodXRkb3duX3VzZXJfZGF0YSk7CiAKIAlkZXZpY2Ut
PnNodXRkb3duX3NvdXJjZSA9IDA7CisKKwlpZiAoZGV2aWNlLT5kZXN0cm95ZWQpCisJCWdfZnJl
ZShkZXZpY2UpOwogfQogCiBzdGF0aWMgZ2Jvb2xlYW4gc2h1dGRvd25fY2FsbGJhY2soZ3BvaW50
ZXIgdXNlcl9kYXRhKQpAQCAtMTI2NCw5ICsxMjcyLDEzIEBAIHN0YXRpYyBnYm9vbGVhbiBzaHV0
ZG93bl9jYWxsYmFjayhncG9pbnRlciB1c2VyX2RhdGEpCiAJaWYgKGRldmljZS0+cmVsZWFzZV91
c2VycyA+IDApCiAJCXJldHVybiBUUlVFOwogCisJZGV2aWNlLT5zaHV0dGluZ19kb3duID0gdHJ1
ZTsKKwogCWlmIChkZXZpY2UtPnNodXRkb3duX2Z1bmMpCiAJCWRldmljZS0+c2h1dGRvd25fZnVu
YyhkZXZpY2UtPnNodXRkb3duX3VzZXJfZGF0YSk7CiAKKwlkZXZpY2UtPnNodXR0aW5nX2Rvd24g
PSB0cnVlOworCiAJcmV0dXJuIEZBTFNFOwogfQogCi0tIAoyLjEwLjIKCg==

--===============0091970823825273173==--

