Content-Type: multipart/mixed; boundary="===============1657084514712483475=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: build fail with --disable-atmodem
Date: Wed, 01 Jun 2011 10:35:15 +0300
Message-ID: <1306913715.18038.3071.camel@tucson>
In-Reply-To: <0LM300AW9KJAISM0@mailout4.samsung.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1657084514712483475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-06-01 at 05:57 +0000, ext =EC=98=A4=EC=9D=B8=ED=98=B8 wrote:
> i tried to compile with --disable-atmodem, an error occurred.
> =

> please help what to do. (i want only isimodem)
> =

> - without --disable-atmodem, compile success.

I sent a patch on 24.3. that fixes the issue. Gatchat is now required to
build core, but gets disabled along with atmodem.

Maybe Marcel or Denis could take a look at that patch (reattaching it
here).

Cheers,
Aki

--===============1657084514712483475==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-build-Add-gatchat-to-core-sources.patch"

PkZyb20gMTkyMGI4MTNhNGRiMTIwZjBkNjY5MmU5ZDRkODZmM2ZlMzEzYTI2MyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogQWtpIE5pZW1pIDxha2kubmllbWlAbm9raWEuY29tPgpEYXRl
OiBUaHUsIDI0IE1hciAyMDExIDE3OjMwOjEyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYnVpbGQ6
IEFkZCBnYXRjaGF0IHRvIGNvcmUgc291cmNlcwpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNo
YXJzZXQ9InV0Zi04IgpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpPdGhlcndpc2Us
IC0tZGlzYWJsZS1hdG1vZGVtIGJyZWFrcyBidWlsZC4KLS0tCiBNYWtlZmlsZS5hbSB8ICAgIDkg
KysrKy0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZS5hbSBiL01ha2VmaWxlLmFtCmluZGV4IGIwY2JjZDcu
LjM5ZDg5NjIgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLmFtCisrKyBiL01ha2VmaWxlLmFtCkBAIC0x
NTQsOCArMTU0LDcgQEAgZW5kaWYKIAogaWYgQVRNT0RFTQogYnVpbHRpbl9tb2R1bGVzICs9IGF0
bW9kZW0KLWJ1aWx0aW5fc291cmNlcyArPSAkKGdhdGNoYXRfc291cmNlcykgXAotCQkJCWRyaXZl
cnMvYXRtb2RlbS9hdG1vZGVtLmggXAorYnVpbHRpbl9zb3VyY2VzICs9IGRyaXZlcnMvYXRtb2Rl
bS9hdG1vZGVtLmggXAogCQkJCWRyaXZlcnMvYXRtb2RlbS9hdG1vZGVtLmMgXAogCQkJCWRyaXZl
cnMvYXRtb2RlbS9jYWxsLXNldHRpbmdzLmMgXAogCQkJCWRyaXZlcnMvYXRtb2RlbS9zbXMuYyBc
CkBAIC0zNjUsOSArMzY0LDkgQEAgYnVpbHRpbl9zb3VyY2VzICs9IHBsdWdpbnMvcHVzaC1ub3Rp
ZmljYXRpb24uYwogCiBzYmluX1BST0dSQU1TID0gc3JjL29mb25vZAogCi1zcmNfb2Zvbm9kX1NP
VVJDRVMgPSAkKGdkYnVzX3NvdXJjZXMpICQoYnVpbHRpbl9zb3VyY2VzKSBzcmMvb2Zvbm8udmVy
IFwKLQkJCXNyYy9tYWluLmMgc3JjL29mb25vLmggc3JjL2xvZy5jIHNyYy9wbHVnaW4uYyBcCi0J
CQlzcmMvbW9kZW0uYyBzcmMvY29tbW9uLmggc3JjL2NvbW1vbi5jIFwKK3NyY19vZm9ub2RfU09V
UkNFUyA9ICQoZ2RidXNfc291cmNlcykgJChidWlsdGluX3NvdXJjZXMpICQoZ2F0Y2hhdF9zb3Vy
Y2VzKSBcCisJCQlzcmMvb2Zvbm8udmVyIHNyYy9tYWluLmMgc3JjL29mb25vLmggc3JjL2xvZy5j
IFwKKwkJCXNyYy9wbHVnaW4uYyBzcmMvbW9kZW0uYyBzcmMvY29tbW9uLmggc3JjL2NvbW1vbi5j
IFwKIAkJCXNyYy9tYW5hZ2VyLmMgc3JjL2RidXMuYyBzcmMvdXRpbC5oIHNyYy91dGlsLmMgXAog
CQkJc3JjL25ldHdvcmsuYyBzcmMvdm9pY2VjYWxsLmMgc3JjL3Vzc2QuYyBzcmMvc21zLmMgXAog
CQkJc3JjL2NhbGwtc2V0dGluZ3MuYyBzcmMvY2FsbC1mb3J3YXJkaW5nLmMgXAotLSAKMS43LjEK
Cg==

--===============1657084514712483475==--

