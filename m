Content-Type: multipart/mixed; boundary="===============7917756257559324894=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: Build Breakage
Date: Thu, 20 Aug 2009 09:54:05 +0200
Message-ID: <04e4946b74e6f2a60004f86ed23a02d2@chewa.net>
In-Reply-To: <200908191959.39030.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7917756257559324894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2009 19:59:37 -0500, Denis Kenzior <denkenz@gmail.com>
wrote:
> The latest gisi changes break the build:
> =

> pep.c: In function =E2=80=98g_isi_pep_create=E2=80=99:
> pep.c:80: error: =E2=80=98SOCK_NONBLOCK=E2=80=99 undeclared (first use in=
 this
> function)
> pep.c:80: error: (Each undeclared identifier is reported only once
> pep.c:80: error: for each function it appears in.)
> pep.c:80: error: =E2=80=98SOCK_CLOEXEC=E2=80=99 undeclared (first use in =
this
> function)
> make[2]: *** [pep.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> =

> SOCK_NONBLOCK and SOCK_CLOEXEC are only available on kernel >=3D 2.6.28 &
> glibc >=3D 2.9.

Attached patch should fix it.

-- =

R=C3=A9mi Denis-Courmont

--===============7917756257559324894==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gisi-PEP-use-more-portable-non-blocking-and-close.patch"

RnJvbSAzYWIyNDAyZWJjNDEyMDRhNTM5NDdhZWFkNDczOWZmOTJjMWQ0NmZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/Uj1DMz1BOW1pPTIwRGVuaXMtQ291cm1vbnQ/
PSA8cmVtaS5kZW5pcy1jb3VybW9udEBub2tpYS5jb20+CkRhdGU6IFRodSwgMjAgQXVnIDIwMDkg
MTA6NTI6NTcgKzAzMDAKU3ViamVjdDogW1BBVENIXSBnaXNpOiBQRVA6IHVzZSBtb3JlIHBvcnRh
YmxlIG5vbi1ibG9ja2luZyBhbmQgY2xvc2Utb24tZXhlYwoKLS0tCiBnaXNpL3BlcC5jIHwgICAg
NSArKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZ2lzaS9wZXAuYyBiL2dpc2kvcGVwLmMKaW5kZXggODljNmE4MC4uYWJm
ZTEwNiAxMDA2NDQKLS0tIGEvZ2lzaS9wZXAuYworKysgYi9naXNpL3BlcC5jCkBAIC03NywxMCAr
NzcsMTMgQEAgR0lzaVBFUCAqZ19pc2lfcGVwX2NyZWF0ZShHSXNpTW9kZW0gKm1vZGVtKQogCXVu
c2lnbmVkIGlmaSA9IGdfaXNpX21vZGVtX2luZGV4KG1vZGVtKTsKIAljaGFyIGJ1ZltJRl9OQU1F
U0laRV07CiAKLQlmZCA9IHNvY2tldChQRl9QSE9ORVQsIFNPQ0tfU0VRUEFDS0VUfFNPQ0tfTk9O
QkxPQ0t8U09DS19DTE9FWEVDLCAwKTsKKwlmZCA9IHNvY2tldChQRl9QSE9ORVQsIFNPQ0tfU0VR
UEFDS0VULCAwKTsKIAlpZiAoZmQgPT0gLTEpCiAJCXJldHVybiBOVUxMOwogCisJZmNudGwoZmQs
IEZfU0VURkQsIEZEX0NMT0VYRUMpOworCWZjbnRsKGZkLCBGX1NFVEZMLCBPX05PTkJMT0NLfGZj
bnRsKGZkLCBGX0dFVEZMKSk7CisKIAlpZiAoaWZfaW5kZXh0b25hbWUoaWZpLCBidWYpID09IE5V
TEwgfHwKIAkgICAgc2V0c29ja29wdChmZCwgU09MX1NPQ0tFVCwgU09fQklORFRPREVWSUNFLCBi
dWYsIElGX05BTUVTSVpFKSkKIAkJZ290byBlcnJvcjsKLS0gCjEuNi4wLjQKCg==

--===============7917756257559324894==--

