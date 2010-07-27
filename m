Content-Type: multipart/mixed; boundary="===============7108770877526084826=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 10:47:39 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528AA1DA4@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1280198371-2401-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7108770877526084826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Zhenhua Zhang wrote:
> Huawei modem closes the modem port after PPP disconnect. So the
> channel =

> of gatchat is NULL in ppp_disconnect. In such case, we should not
> resume =

> the chat and call disconnect function when removing the context.
> Secondly, before removing the gprs context, we should reply the
> pending =

> DBus message to the client.
> ---
>  drivers/atmodem/gprs-context.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c
> b/drivers/atmodem/gprs-context.c =

> index fea80b0..e2f291a 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -88,11 +88,22 @@ static void ppp_disconnect(GAtPPPDisconnectReason
>  reason, gpointer user_data) {
>  	struct ofono_gprs_context *gc =3D user_data;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtIO *io =3D g_at_chat_get_io(gcd->chat);
> =

>  	DBG("");
> =

>  	g_at_ppp_unref(gcd->ppp);
>  	gcd->ppp =3D NULL;
> +
> +	if (g_at_io_get_channel(io) =3D=3D NULL) {
> +		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
> +					NULL, NULL, NULL, gcd->cb_data);
> +		gcd->active_context =3D 0;
> +		gcd->state =3D STATE_IDLE;
> +		g_at_chat_resume(gcd->chat);
> +		return;
> +	}
> +
>  	g_at_chat_resume(gcd->chat);
> =

>  	switch (gcd->state) {
> @@ -257,7 +268,7 @@ static void at_gprs_context_remove(struct
> ofono_gprs_context *gc) =

> =

>  	DBG("");
> =

> -	if (gcd->state !=3D STATE_IDLE) {
> +	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
>  		g_at_ppp_unref(gcd->ppp);
>  		g_at_chat_resume(gcd->chat);
>  	}

Could you try my fix for this busy loop issue? It is not perfect but at lea=
st work for me.
The problem is: in ppp_disconnect, after g_at_chat_resume(), the gprs conte=
xt has
been removed and recreated, so the rest gc and gcd are totally wrong.

Btw, I still meet the kernel warning or even Ubuntu crash after activate/de=
activate gprs
context multiple times on E1552. Do you see such problem? the kernel dmesg =
is
attached for reference.

Regards,
Zhenhua

--===============7108770877526084826==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="E1552_dmesg.txt"

SnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTA5M10gLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3
LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDExMDZdIFdBUk5JTkc6IGF0IC9idWlsZC9idWlsZGQv
bGludXgtMi42LjMyL2RyaXZlcnMvdXNiL3NlcmlhbC91c2Itc2VyaWFsLmM6NDA2IHNlcmlhbF93
cml0ZV9yb29tKzB4NzUvMHg4MCBbdXNic2VyaWFsXSgpCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3
LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDExMDhdIEhhcmR3YXJlIG5hbWU6IDc2NjFCTDQKSnVs
IDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTExMF0gTW9kdWxl
cyBsaW5rZWQgaW46IG5sc191dGY4IGlzb2ZzIG9wdGlvbiB1c2JzZXJpYWwgdXNiX3N0b3JhZ2Ug
YWVzX2k1ODYgYWVzX2dlbmVyaWMgaGlkcCByZmNvbW0gcHBkZXYgc2NvIGJuZXAgbDJjYXAgYmlu
Zm10X21pc2Mgc25kX2hkYV9jb2RlY19hbmFsb2cgZmJjb24gdGlsZWJsaXQgZm9udCBiaXRibGl0
IHNvZnRjdXJzb3IgdmdhMTZmYiB2Z2FzdGF0ZSBqb3lkZXYgc25kX2hkYV9pbnRlbCBzbmRfaGRh
X2NvZGVjIHNuZF9od2RlcCBzbmRfcGNtX29zcyBzbmRfbWl4ZXJfb3NzIHRoaW5rcGFkX2FjcGkg
c25kX3BjbSBzbmRfc2VxX2R1bW15IHNuZF9zZXFfb3NzIHNuZF9zZXFfbWlkaSBzbmRfcmF3bWlk
aSBzbmRfc2VxX21pZGlfZXZlbnQgYXJjNCBzbmRfc2VxIHBjbWNpYSBpd2xhZ24gc25kX3RpbWVy
IGl3bGNvcmUgc25kX3NlcV9kZXZpY2UgaTkxNSBkcm1fa21zX2hlbHBlciBzbmQgbWFjODAyMTEg
ZHJtIHV2Y3ZpZGVvIHZpZGVvZGV2IHY0bDFfY29tcGF0IGJ0dXNiIGJsdWV0b290aCBudnJhbSB5
ZW50YV9zb2NrZXQgcnNyY19ub25zdGF0aWMgc2RoY2lfcGNpIHNkaGNpIGxlZF9jbGFzcyByaWNv
aF9tbWMgcGNtY2lhX2NvcmUgcHNtb3VzZSBzZXJpb19yYXcgY2ZnODAyMTEgaW50ZWxfYWdwIGFn
cGdhcnQgaTJjX2FsZ29fYml0IHZpZGVvIG91dHB1dCBzb3VuZGNvcmUgc25kX3BhZ2VfYWxsb2Mg
bHAgcGFycG9ydCB1c2JoaWQgaGlkIG9oY2kxMzk0IGllZWUxMzk0IGUxMDAwZQpKdWwgMjcgMTA6
MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMTg3XSBQaWQ6IDI1MTMsIGNv
bW06IG9mb25vZCBUYWludGVkOiBHICAgICAgICBXICAyLjYuMzItMjEtZ2VuZXJpYyAjMzItVWJ1
bnR1Ckp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDExODld
IENhbGwgVHJhY2U6Ckp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5
OS4zMDExOTZdICBbPGMwMTRjM2QyPl0gd2Fybl9zbG93cGF0aF9jb21tb24rMHg3Mi8weGEwCkp1
bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyMDBdICBbPGZk
YWFhNzM1Pl0gPyBzZXJpYWxfd3JpdGVfcm9vbSsweDc1LzB4ODAgW3VzYnNlcmlhbF0KSnVsIDI3
IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTIwNF0gIFs8ZmRhYWE3
MzU+XSA/IHNlcmlhbF93cml0ZV9yb29tKzB4NzUvMHg4MCBbdXNic2VyaWFsXQpKdWwgMjcgMTA6
MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMjA4XSAgWzxjMDE0YzQxYT5d
IHdhcm5fc2xvd3BhdGhfbnVsbCsweDFhLzB4MjAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9i
aWxlIGtlcm5lbDogWyAgNTk5LjMwMTIxMV0gIFs8ZmRhYWE3MzU+XSBzZXJpYWxfd3JpdGVfcm9v
bSsweDc1LzB4ODAgW3VzYnNlcmlhbF0KSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtl
cm5lbDogWyAgNTk5LjMwMTIxNl0gIFs8YzAzYjgzMWQ+XSB0dHlfd3JpdGVfcm9vbSsweDFkLzB4
MjAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTIxOV0g
IFs8YzAzYjYxMjc+XSBuX3R0eV9wb2xsKzB4MTc3LzB4MTkwCkp1bCAyNyAxMDoxMzoxNyB6emhh
bjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyMjJdICBbPGMwM2IyMWY5Pl0gdHR5X3BvbGwr
MHg2OS8weDgwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4z
MDEyMjZdICBbPGMwNThiNWU4Pl0gPyBfc3Bpbl9sb2NrX2lycSsweDE4LzB4MjAKSnVsIDI3IDEw
OjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTIyOV0gIFs8YzAzYjVmYjA+
XSA/IG5fdHR5X3BvbGwrMHgwLzB4MTkwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBr
ZXJuZWw6IFsgIDU5OS4zMDEyMzJdICBbPGMwMjE3MjdiPl0gZG9fcG9sbCsweGRiLzB4MjMwCkp1
bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyMzZdICBbPGMw
MjE3ZDU2Pl0gZG9fc3lzX3BvbGwrMHgxMzYvMHgxZjAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTct
bW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTIzOV0gIFs8YzAyMTdhZTA+XSA/IF9fcG9sbHdhaXQr
MHgwLzB4ZTAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMw
MTI0Ml0gIFs8YzAyMTdiYzA+XSA/IHBvbGx3YWtlKzB4MC8weDYwCkp1bCAyNyAxMDoxMzoxNyB6
emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyNDRdICBbPGMwMjE3YmMwPl0gPyBwb2xs
d2FrZSsweDAvMHg2MApKdWwgMjcgMTA6MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1
OTkuMzAxMjQ3XSAgWzxjMDIxN2JjMD5dID8gcG9sbHdha2UrMHgwLzB4NjAKSnVsIDI3IDEwOjEz
OjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTI1MF0gIFs8YzAyMTdiYzA+XSA/
IHBvbGx3YWtlKzB4MC8weDYwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6
IFsgIDU5OS4zMDEyNTNdICBbPGMwMjE3YmMwPl0gPyBwb2xsd2FrZSsweDAvMHg2MApKdWwgMjcg
MTA6MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMjU1XSAgWzxjMDIxN2Jj
MD5dID8gcG9sbHdha2UrMHgwLzB4NjAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtl
cm5lbDogWyAgNTk5LjMwMTI1OF0gIFs8YzAyMTdiYzA+XSA/IHBvbGx3YWtlKzB4MC8weDYwCkp1
bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyNjFdICBbPGMw
MjE3YmMwPl0gPyBwb2xsd2FrZSsweDAvMHg2MApKdWwgMjcgMTA6MTM6MTcgenpoYW4xNy1tb2Jp
bGUga2VybmVsOiBbICA1OTkuMzAxMjY1XSAgWzxjMDRiMzg2NT5dID8gc29ja19zZW5kbXNnKzB4
ZTUvMHgxMTAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMw
MTI2OV0gIFs8YzAxNjc3NDA+XSA/IGF1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDAvMHg1MApK
dWwgMjcgMTA6MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMjcyXSAgWzxj
MDRiMzg2NT5dID8gc29ja19zZW5kbXNnKzB4ZTUvMHgxMTAKSnVsIDI3IDEwOjEzOjE3IHp6aGFu
MTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTI3Nl0gIFs8YzAzNTMyYmQ+XSA/IGNvcHlfZnJv
bV91c2VyKzB4M2QvMHgxMzAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDog
WyAgNTk5LjMwMTI3OV0gIFs8YzA0YmM4OGE+XSA/IHZlcmlmeV9pb3ZlYysweDVhLzB4YTAKSnVs
IDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTI4Ml0gIFs8YzA0
YjQxYWQ+XSA/IHN5c19zZW5kbXNnKzB4MTVkLzB4MjkwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3
LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyODVdICBbPGMwNThiNWU4Pl0gPyBfc3Bpbl9sb2Nr
X2lycSsweDE4LzB4MjAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAg
NTk5LjMwMTI4OV0gIFs8YzAxNjNmZjI+XSA/IGZsdXNoX3dvcmsrMHg1Mi8weGEwCkp1bCAyNyAx
MDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEyOTJdICBbPGMwM2I2ZDgz
Pl0gPyBuX3R0eV9yZWFkKzB4MmYzLzB4NzIwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmls
ZSBrZXJuZWw6IFsgIDU5OS4zMDEyOTVdICBbPGMwM2I2NTgwPl0gPyBuX3R0eV93cml0ZSsweDAv
MHgyNzAKSnVsIDI3IDEwOjEzOjE3IHp6aGFuMTctbW9iaWxlIGtlcm5lbDogWyAgNTk5LjMwMTI5
OV0gIFs8YzAzYjljNGQ+XSA/IHR0eV9sZGlzY19kZXJlZisweGQvMHgxMApKdWwgMjcgMTA6MTM6
MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMzAyXSAgWzxjMDNiMjMyZD5dID8g
dHR5X3JlYWQrMHg4ZC8weGMwCkp1bCAyNyAxMDoxMzoxNyB6emhhbjE3LW1vYmlsZSBrZXJuZWw6
IFsgIDU5OS4zMDEzMDRdICBbPGMwM2I2YTkwPl0gPyBuX3R0eV9yZWFkKzB4MC8weDcyMApKdWwg
MjcgMTA6MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMzA4XSAgWzxjMDRi
NDdjYz5dID8gc3lzX3NvY2tldGNhbGwrMHhjYy8weDI4MApKdWwgMjcgMTA6MTM6MTcgenpoYW4x
Ny1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAxMzExXSAgWzxjMDIxN2Y4OT5dIHN5c19wb2xsKzB4
NTkvMHhjMApKdWwgMjcgMTA6MTM6MTcgenpoYW4xNy1tb2JpbGUga2VybmVsOiBbICA1OTkuMzAx
MzE0XSAgWzxjMDEwMzNlYz5dIHN5c2NhbGxfY2FsbCsweDcvMHhiCkp1bCAyNyAxMDoxMzoxNyB6
emhhbjE3LW1vYmlsZSBrZXJuZWw6IFsgIDU5OS4zMDEzMTZdIC0tLVsgZW5kIHRyYWNlIGRkZmY3
MmQ1YjBiNjk2MTYgXS0tLQoK

--===============7108770877526084826==--

