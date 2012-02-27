Content-Type: multipart/mixed; boundary="===============3071002984357453955=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: [PATCH] add some length verification to avoid reading not owned memory
Date: Mon, 27 Feb 2012 10:21:15 +0100
Message-ID: <4F4B4B0B.7060606@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3071002984357453955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

while reading mmsd sources I stumbled over missing length
checks in src/push.c:mms_push_notify(). I didn't re-read
the entire source to prove overall ;)

Best regards,
Jens

--===============3071002984357453955==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-add-some-length-verification-to-avoid-reading-not-ow.patch"

PkZyb20gN2ZlMzMwODI1NTVmNDNkNmViNTJkMmJlYmIwYTljMzZmMGJjNGFkYyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogSmVucyBSZWhzYWNrIDxqcl9leHRlcm5AdmZuZXQuZGU+CkRh
dGU6IE1vbiwgMjcgRmViIDIwMTIgMTA6MTU6NDMgKzAxMDAKU3ViamVjdDogW1BBVENIXSBhZGQg
c29tZSBsZW5ndGggdmVyaWZpY2F0aW9uIHRvIGF2b2lkIHJlYWRpbmcgbm90IG93bmVkCiBtZW1v
cnkKCi0tLQogc3JjL3B1c2guYyB8ICAgIDggKysrKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9wdXNoLmMgYi9z
cmMvcHVzaC5jCmluZGV4IDZhNTQ5MDcuLjYxMDczNTIgMTAwNjQ0Ci0tLSBhL3NyYy9wdXNoLmMK
KysrIGIvc3JjL3B1c2guYwpAQCAtMzUxLDEzICszNTEsMTYgQEAgZ2Jvb2xlYW4gbW1zX3B1c2hf
bm90aWZ5KHVuc2lnbmVkIGNoYXIgKnBkdSwgdW5zaWduZWQgaW50IGxlbiwKIAkvKiBDb25zdW1l
IFRJRCBhbmQgVHlwZSAqLwogCW5yZWFkID0gMjsKIAotCWlmICh3c3BfZGVjb2RlX3VpbnR2YXIo
cGR1ICsgbnJlYWQsIGxlbiwKKwlpZiAod3NwX2RlY29kZV91aW50dmFyKHBkdSArIG5yZWFkLCBs
ZW4gLSBucmVhZCwKIAkJCQkJJmhlYWRlcnNsZW4sICZjb25zdW1lZCkgPT0gRkFMU0UpCiAJCXJl
dHVybiBGQUxTRTsKIAogCS8qIENvbnN1bWUgdWludHZhciBieXRlcyAqLwogCW5yZWFkICs9IGNv
bnN1bWVkOwogCisJLyogQ2hlY2sgaWYgY29udGVudCB0eXBlIGNvdWxkIGJlIHJlYWQgKi8KKwlp
ZiAoaGVhZGVyc2xlbiA+IChsZW4gLSBucmVhZCkpCisJCXJldHVybiBGQUxTRTsKIAkvKiBUcnkg
dG8gZGVjb2RlIGNvbnRlbnQtdHlwZSAqLwogCWlmICh3c3BfZGVjb2RlX2NvbnRlbnRfdHlwZShw
ZHUgKyBucmVhZCwgaGVhZGVyc2xlbiwgJmN0LAogCQkJJmNvbnN1bWVkLCAmcGFyYW1fbGVuKSA9
PSBGQUxTRSkKQEAgLTM3MCw2ICszNzMsOSBAQCBnYm9vbGVhbiBtbXNfcHVzaF9ub3RpZnkodW5z
aWduZWQgY2hhciAqcGR1LCB1bnNpZ25lZCBpbnQgbGVuLAogCWNvbnN1bWVkICs9IHBhcmFtX2xl
bjsKIAlucmVhZCArPSBjb25zdW1lZDsKIAorCS8qIENoZWNrIGlmIGFwcGxpY2F0aW9uX2lkIGNv
dWxkIGJlIHJlYWQgKi8KKwlpZiAoKGhlYWRlcnNsZW4gLSBjb25zdW1lZCkgPiAobGVuIC0gbnJl
YWQpKQorCQlyZXR1cm4gRkFMU0U7CiAJLyogUGFyc2UgaGVhZGVyIHRvIGRlY29kZSBhcHBsaWNh
dGlvbl9pZCAqLwogCXdzcF9oZWFkZXJfaXRlcl9pbml0KCZpdGVyLCBwZHUgKyBucmVhZCwgaGVh
ZGVyc2xlbiAtIGNvbnN1bWVkLCAwKTsKIAotLSAKMS43LjkuMQoK

--===============3071002984357453955==--

