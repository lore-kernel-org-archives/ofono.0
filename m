Content-Type: multipart/mixed; boundary="===============2874078680848145312=="
MIME-Version: 1.0
From: Marko Lindqvist <cazfi74@gmail.com>
Subject: [PATCH] Fix build with automake-1.13
Date: Sat, 12 Jan 2013 11:22:39 +0200
Message-ID: <CAF6bG8eQqF+s1VECb_1fEZHxkdnaDccF0ku0OL0vrQWitJM6jg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2874078680848145312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Automake-1.13 removed long obsolete AM_CONFIG_HEADER completely (
http://lists.gnu.org/archive/html/automake/2012-12/msg00038.html ) and
errors out upon seeing it.

Attached patch replaces it with proper AC_CONFIG_HEADERS.

 I'm not subscribed to mailing list.

----

I'm mass-submitting automake-1.13 fixes. Please see what you can do so
I don't need to do the same when automake-1.14 comes out:
http://cazfi.livejournal.com/195108.html


 - ML

--===============2874078680848145312==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="obsolete_automake_macros.patch"

ZGlmZiAtTnVyZCBvZm9uby0xLjEyL2NvbmZpZ3VyZS5hYyBvZm9uby0xLjEyL2NvbmZpZ3VyZS5h
YwotLS0gb2Zvbm8tMS4xMi9jb25maWd1cmUuYWMJMjAxMi0xMi0xOSAyMToyODo0NC4wMDAwMDAw
MDAgKzAyMDAKKysrIG9mb25vLTEuMTIvY29uZmlndXJlLmFjCTIwMTMtMDEtMTIgMTE6MTg6NDAu
NjgxNDEwNzU3ICswMjAwCkBAIC0yLDcgKzIsNyBAQAogQUNfSU5JVChvZm9ubywgMS4xMikKIAog
QU1fSU5JVF9BVVRPTUFLRShbZm9yZWlnbiBzdWJkaXItb2JqZWN0cyBjb2xvci10ZXN0c10pCi1B
TV9DT05GSUdfSEVBREVSKGNvbmZpZy5oKQorQUNfQ09ORklHX0hFQURFUlMoY29uZmlnLmgpCiAK
IG00X2lmZGVmKFtBTV9TSUxFTlRfUlVMRVNdLCBbQU1fU0lMRU5UX1JVTEVTKFt5ZXNdKV0pCiAK

--===============2874078680848145312==--

