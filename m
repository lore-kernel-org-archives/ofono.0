Content-Type: multipart/mixed; boundary="===============7177622180915970659=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] build: require glib >= 2.60
Date: Tue, 16 Feb 2021 18:31:54 +0900
Message-ID: <CAKnLNuQdXPXVYrcJpmvbH8U5xsSR54JT4KxmyNNHeXoaCnTncg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7177622180915970659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Build failure in the latest version has occurred with glib 2.56.4.

src/simutil.c: In function =E2=80=98validate_utf8_tlv=E2=80=99:
> src/simutil.c:779:9: error: implicit declaration of function
> =E2=80=98g_utf8_validate_len=E2=80=99; did you mean =E2=80=98g_utf8_valid=
ate=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   return g_utf8_validate_len((const char *)tlv + 2, len, NULL);
>          ^~~~~~~~~~~~~~~~~~~
>          g_utf8_validate
>

According to glib documentation, "g_utf8_validate_len" is supported since
2.60
So, I sent this patch.

Regards,
JongSeok Won

---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index d4efc8a8..f195c862 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,8 +63,8 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
  AC_MSG_ERROR(dynamic linking loader is required))

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
- AC_MSG_ERROR(GLib >=3D 2.32 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.60, dummy=3Dyes,
+ AC_MSG_ERROR(GLib >=3D 2.60 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 --

--===============7177622180915970659==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj48L2Rpdj48ZGl2PkJ1aWxkIGZhaWx1cmUgaW4gdGhlIGxhdGVz
dCB2ZXJzaW9uIGhhcyBvY2N1cnJlZCB3aXRoIGdsaWIgMi41Ni40LjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2PnNyYy9zaW11dGlsLmM6IEluIGZ1bmN0aW9uIOKAmHZhbGlkYXRlX3V0
ZjhfdGx24oCZOjxicj5zcmMvc2ltdXRpbC5jOjc3OTo5OgogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdfdXRmOF92YWxpZGF0ZV9sZW7igJk7IGRpZCB5b3UgCm1l
YW4g4oCYZ191dGY4X3ZhbGlkYXRl4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl08YnI+wqAgcmV0dXJuIGdfdXRmOF92YWxpZGF0ZV9sZW4oKGNvbnN0IGNoYXIgKil0
bHYgKyAyLCBsZW4sIE5VTEwpOzxicj7CoCDCoCDCoCDCoCDCoF5+fn5+fn5+fn5+fn5+fn5+fn48
YnI+wqAgwqAgwqAgwqAgwqBnX3V0ZjhfdmFsaWRhdGU8L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj5BY2NvcmRpbmcgdG8gZ2xpYiBkb2N1bWVudGF0aW9uLCAmcXVvdDtnX3V0
ZjhfdmFsaWRhdGVfbGVuJnF1b3Q7IGlzIHN1cHBvcnRlZCBzaW5jZSAyLjYwPC9kaXY+PGRpdj5T
bywgSSBzZW50IHRoaXMgcGF0Y2guPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJk
cyw8L2Rpdj48ZGl2PkpvbmdTZW9rIFdvbjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS0tPC9k
aXY+wqA8YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmln
dXJlLmFjPC9hPiB8IDQgKystLTxicj7CoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pPGJyPjxicj5kaWZmIC0tZ2l0IGEvPGEgaHJlZj0iaHR0cDovL2NvbmZp
Z3VyZS5hYyIgdGFyZ2V0PSJfYmxhbmsiPmNvbmZpZ3VyZS5hYzwvYT4gYi88YSBocmVmPSJodHRw
Oi8vY29uZmlndXJlLmFjIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlndXJlLmFjPC9hPjxicj5pbmRl
eCBkNGVmYzhhOC4uZjE5NWM4NjIgMTAwNjQ0PGJyPi0tLSBhLzxhIGhyZWY9Imh0dHA6Ly9jb25m
aWd1cmUuYWMiIHRhcmdldD0iX2JsYW5rIj5jb25maWd1cmUuYWM8L2E+PGJyPisrKyBiLzxhIGhy
ZWY9Imh0dHA6Ly9jb25maWd1cmUuYWMiIHRhcmdldD0iX2JsYW5rIj5jb25maWd1cmUuYWM8L2E+
PGJyPkBAIC02Myw4ICs2Myw4IEBAIEFDX0NIRUNLX0ZVTkMoc2lnbmFsZmQsIGR1bW15PXllcyw8
YnI+wqBBQ19DSEVDS19MSUIoZGwsIGRsb3BlbiwgZHVtbXk9eWVzLDxicj7CoAkJCUFDX01TR19F
UlJPUihkeW5hbWljIGxpbmtpbmcgbG9hZGVyIGlzIHJlcXVpcmVkKSk8YnI+wqA8YnI+LVBLR19D
SEVDS19NT0RVTEVTKEdMSUIsIGdsaWItMi4wICZndDs9IDIuMzIsIGR1bW15PXllcyw8YnI+LQkJ
CQlBQ19NU0dfRVJST1IoR0xpYiAmZ3Q7PSAyLjMyIGlzIHJlcXVpcmVkKSk8YnI+K1BLR19DSEVD
S19NT0RVTEVTKEdMSUIsIGdsaWItMi4wICZndDs9IDIuNjAsIGR1bW15PXllcyw8YnI+KwkJCQlB
Q19NU0dfRVJST1IoR0xpYiAmZ3Q7PSAyLjYwIGlzIHJlcXVpcmVkKSk8YnI+wqBBQ19TVUJTVChH
TElCX0NGTEFHUyk8YnI+wqBBQ19TVUJTVChHTElCX0xJQlMpPGZvbnQgY29sb3I9IiM4ODg4ODgi
Pjxicj7CoC0tPC9mb250PjwvZGl2Pgo=

--===============7177622180915970659==--

