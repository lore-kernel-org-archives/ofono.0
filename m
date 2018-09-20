Content-Type: multipart/mixed; boundary="===============1190620920677052391=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] ril driver: commented out pragma\n\ngcc 4.8.4 rejects the
 line:\n#pragma GCC diagnostic ignored "-Wrestrict"\nand this breaks the
 default compilation.\nsince they may be needed for other compilers,
 \nI have just commented them out with '//', so that they stand out.
Date: Thu, 20 Sep 2018 06:02:05 +0200
Message-ID: <CAKSBH7FtMQw_uMdKY4E+XYnJQT6Ax2N5uGjy_vkxAzYzgzMWJA@mail.gmail.com>
In-Reply-To: <1537416045-10187-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1190620920677052391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

please ignore this. the commit message was wrongly formatted for some
reason.

On Thu, Sep 20, 2018 at 6:00 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> ---
>  drivers/rilmodem/call-forwarding.c      | 2 +-
>  drivers/rilmodem/network-registration.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rilmodem/call-forwarding.c
> b/drivers/rilmodem/call-forwarding.c
> index 4aff4d3..0bdab3f 100644
> --- a/drivers/rilmodem/call-forwarding.c
> +++ b/drivers/rilmodem/call-forwarding.c
> @@ -38,7 +38,7 @@
>  #include <ofono/call-forwarding.h>
>  #include "common.h"
>
> -#pragma GCC diagnostic ignored "-Wrestrict"
> +//#pragma GCC diagnostic ignored "-Wrestrict"
>
>  #include "gril.h"
>
> diff --git a/drivers/rilmodem/network-registration.c
> b/drivers/rilmodem/network-registration.c
> index 809b3bc..9895c6d 100644
> --- a/drivers/rilmodem/network-registration.c
> +++ b/drivers/rilmodem/network-registration.c
> @@ -37,7 +37,7 @@
>  #include <ofono/modem.h>
>  #include <ofono/netreg.h>
>
> -#pragma GCC diagnostic ignored "-Wrestrict"
> +//#pragma GCC diagnostic ignored "-Wrestrict"
>
>  #include <gril/gril.h>
>
> --
> 1.9.1
>
>

--===============1190620920677052391==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+cGxlYXNlIGlnbm9yZSB0aGlzLiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2Fz
IHdyb25nbHkgZm9ybWF0dGVkIGZvciBzb21lIHJlYXNvbi48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDIwLCAyMDE4IGF0IDY6MDAg
QU0gR2lhY2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNv
bSI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPi0tLTxicj4KwqBkcml2ZXJzL3JpbG1v
ZGVtL2NhbGwtZm9yd2FyZGluZy5jwqAgwqAgwqAgfCAyICstPGJyPgrCoGRyaXZlcnMvcmlsbW9k
ZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYyB8IDIgKy08YnI+CsKgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJyPgo8YnI+CmRpZmYgLS1naXQgYS9kcml2
ZXJzL3JpbG1vZGVtL2NhbGwtZm9yd2FyZGluZy5jIGIvZHJpdmVycy9yaWxtb2RlbS9jYWxsLWZv
cndhcmRpbmcuYzxicj4KaW5kZXggNGFmZjRkMy4uMGJkYWIzZiAxMDA2NDQ8YnI+Ci0tLSBhL2Ry
aXZlcnMvcmlsbW9kZW0vY2FsbC1mb3J3YXJkaW5nLmM8YnI+CisrKyBiL2RyaXZlcnMvcmlsbW9k
ZW0vY2FsbC1mb3J3YXJkaW5nLmM8YnI+CkBAIC0zOCw3ICszOCw3IEBAPGJyPgrCoCNpbmNsdWRl
ICZsdDtvZm9uby9jYWxsLWZvcndhcmRpbmcuaCZndDs8YnI+CsKgI2luY2x1ZGUgJnF1b3Q7Y29t
bW9uLmgmcXVvdDs8YnI+Cjxicj4KLSNwcmFnbWEgR0NDIGRpYWdub3N0aWMgaWdub3JlZCAmcXVv
dDstV3Jlc3RyaWN0JnF1b3Q7PGJyPgorLy8jcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQg
JnF1b3Q7LVdyZXN0cmljdCZxdW90Ozxicj4KPGJyPgrCoCNpbmNsdWRlICZxdW90O2dyaWwuaCZx
dW90Ozxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9yaWxtb2RlbS9uZXR3b3JrLXJlZ2lz
dHJhdGlvbi5jIGIvZHJpdmVycy9yaWxtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jPGJyPgpp
bmRleCA4MDliM2JjLi45ODk1YzZkIDEwMDY0NDxicj4KLS0tIGEvZHJpdmVycy9yaWxtb2RlbS9u
ZXR3b3JrLXJlZ2lzdHJhdGlvbi5jPGJyPgorKysgYi9kcml2ZXJzL3JpbG1vZGVtL25ldHdvcmst
cmVnaXN0cmF0aW9uLmM8YnI+CkBAIC0zNyw3ICszNyw3IEBAPGJyPgrCoCNpbmNsdWRlICZsdDtv
Zm9uby9tb2RlbS5oJmd0Ozxicj4KwqAjaW5jbHVkZSAmbHQ7b2Zvbm8vbmV0cmVnLmgmZ3Q7PGJy
Pgo8YnI+Ci0jcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQgJnF1b3Q7LVdyZXN0cmljdCZx
dW90Ozxicj4KKy8vI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBpZ25vcmVkICZxdW90Oy1XcmVzdHJp
Y3QmcXVvdDs8YnI+Cjxicj4KwqAjaW5jbHVkZSAmbHQ7Z3JpbC9ncmlsLmgmZ3Q7PGJyPgo8YnI+
Ci0tIDxicj4KMS45LjE8YnI+Cjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============1190620920677052391==--

