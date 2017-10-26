Content-Type: multipart/mixed; boundary="===============2014118021005613185=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: AW: Ofono 1.21 crashes with Sierra MC7455
Date: Thu, 26 Oct 2017 12:43:26 +0200
Message-ID: <ba9c9e78-c3f6-a784-ba83-47357d029c18@kerlink.fr>
In-Reply-To: <7dfa1e1d-9070-b6d8-a304-0d278edbdf1e@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2014118021005613185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> Seems to be this:
>
> i)=C2=A0 When the modem is first powered on, service discovery takes some =

> time (more than 5 seconds)
> ii)=C2=A0 The service discovery timeout fires before the QMI request =

> returns so discover_reply gets called before discover_callback and =

> things get cleaned up
> iii)=C2=A0 Then the QMI request returns and discover_callback gets called =

> even though the request has timed out in ii)
>
> ...and this is where things go wrong because the userdata pointer to =

> discover_callback is probably no longer valid.
>
> How do we handle the QMI request returning a _late_ response, i.e. =

> after it technically has timed out?=C2=A0 I'll dig a bit more...
>
> /Jonas

Hi Jonas,

When I look at my personal patches, it seems I've already seen that. =

Please find attached the patch I currently have in my setup on this subject.

Christophe





--===============2014118021005613185==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0014-qmi-remove-request-when-it-timeouts.patch"

PkZyb20gMTU2NjZjOTBkMjBlZTc0ODFkMDE4MGE4MjQ2YzUzZTVhMjlkNWJjZCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogQ2hyaXN0b3BoZSBSb25jbyA8Yy5yb25jb0BrZXJsaW5rLmZy
PgpEYXRlOiBXZWQsIDI3IFNlcCAyMDE3IDEwOjM4OjUwICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
cW1pOiByZW1vdmUgcmVxdWVzdCB3aGVuIGl0IHRpbWVvdXRzCgpXaGVuIG1vZGVtIGRvZXMgbm90
IGFuc3dlciBvciBhbnN3ZXJzIHNsb3dseSB0byBhIGRpc2NvdmVyeSByZXF1ZXN0LAphIHRpbWVv
dXQgb2NjdXJzLgpJbiB0aW1lb3V0IGNhbGxiYWNrLCByZXF1ZXN0IHNob3VsZCBiZSByZW1vdmVk
IGZyb20gcXVldWVzIHRvIGF2b2lkCnRyZWF0aW5nIGFuc3dlciBpZiBpdCBhcnJpdmVzIGxhdGVy
LgotLS0KIGRyaXZlcnMvcW1pbW9kZW0vcW1pLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3FtaW1vZGVtL3FtaS5jIGIvZHJpdmVycy9xbWltb2RlbS9xbWkuYwppbmRleCBjNTM4Y2I5
Li42NTI2M2QyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3FtaW1vZGVtL3FtaS5jCisrKyBiL2RyaXZl
cnMvcW1pbW9kZW0vcW1pLmMKQEAgLTEwNzMsNiArMTA3Myw3IEBAIHN0cnVjdCBkaXNjb3Zlcl9k
YXRhIHsKIAlxbWlfZGlzY292ZXJfZnVuY190IGZ1bmM7CiAJdm9pZCAqdXNlcl9kYXRhOwogCXFt
aV9kZXN0cm95X2Z1bmNfdCBkZXN0cm95OworCXVpbnQ4X3QgdGlkOwogCWd1aW50IHRpbWVvdXQ7
CiB9OwogCkBAIC0xMTgxLDE0ICsxMTgyLDM4IEBAIHN0YXRpYyBnYm9vbGVhbiBkaXNjb3Zlcl9y
ZXBseShncG9pbnRlciB1c2VyX2RhdGEpCiB7CiAJc3RydWN0IGRpc2NvdmVyX2RhdGEgKmRhdGEg
PSB1c2VyX2RhdGE7CiAJc3RydWN0IHFtaV9kZXZpY2UgKmRldmljZSA9IGRhdGEtPmRldmljZTsK
Kwl1bnNpZ25lZCBpbnQgdGlkID0gKHVuc2lnbmVkIGludCkoZGF0YS0+dGlkKTsKKwlHTGlzdCAq
bGlzdDsKKwlzdHJ1Y3QgcW1pX3JlcXVlc3QgKnJlcSA9IE5VTEw7CiAKIAlkYXRhLT50aW1lb3V0
ID0gMDsKIAorCS8qIHJlbW92ZSByZXF1ZXN0IGZyb20gcXVldWVzICovCisJaWYgKHRpZCAhPSAw
KSB7CisJCWxpc3QgPSBnX3F1ZXVlX2ZpbmRfY3VzdG9tKGRldmljZS0+cmVxX3F1ZXVlLAorCQkJ
CUdVSU5UX1RPX1BPSU5URVIodGlkKSwgX19yZXF1ZXN0X2NvbXBhcmUpOworCisJCWlmIChsaXN0
KSB7CisJCQlyZXEgPSBsaXN0LT5kYXRhOworCQkJZ19xdWV1ZV9kZWxldGVfbGluayhkZXZpY2Ut
PnJlcV9xdWV1ZSwgbGlzdCk7CisJCX0gZWxzZSB7CisJCQlsaXN0ID0gZ19xdWV1ZV9maW5kX2N1
c3RvbShkZXZpY2UtPmNvbnRyb2xfcXVldWUsCisJCQkJR1VJTlRfVE9fUE9JTlRFUih0aWQpLCBf
X3JlcXVlc3RfY29tcGFyZSk7CisKKwkJCWlmIChsaXN0KSB7CisJCQkJcmVxID0gbGlzdC0+ZGF0
YTsKKwkJCQlnX3F1ZXVlX2RlbGV0ZV9saW5rKGRldmljZS0+Y29udHJvbF9xdWV1ZSwKKwkJCQkJ
CQkJbGlzdCk7CisJCQl9CisJCX0KKwl9CisKIAlpZiAoZGF0YS0+ZnVuYykKIAkJZGF0YS0+ZnVu
YyhkZXZpY2UtPnZlcnNpb25fY291bnQsCiAJCQkJZGV2aWNlLT52ZXJzaW9uX2xpc3QsIGRhdGEt
PnVzZXJfZGF0YSk7CiAKIAlfX3FtaV9kZXZpY2VfZGlzY292ZXJ5X2NvbXBsZXRlKGRhdGEtPmRl
dmljZSwgJmRhdGEtPnN1cGVyKTsKKwlfX3JlcXVlc3RfZnJlZShyZXEsIE5VTEwpOwogCiAJcmV0
dXJuIEZBTFNFOwogfQpAQCAtMTIzNCw2ICsxMjU5LDcgQEAgYm9vbCBxbWlfZGV2aWNlX2Rpc2Nv
dmVyKHN0cnVjdCBxbWlfZGV2aWNlICpkZXZpY2UsIHFtaV9kaXNjb3Zlcl9mdW5jX3QgZnVuYywK
IAogCWhkci0+dHlwZSA9IDB4MDA7CiAJaGRyLT50cmFuc2FjdGlvbiA9IGRldmljZS0+bmV4dF9j
b250cm9sX3RpZCsrOworCWRhdGEtPnRpZCA9IGhkci0+dHJhbnNhY3Rpb247CiAKIAlfX3JlcXVl
c3Rfc3VibWl0KGRldmljZSwgcmVxLCBoZHItPnRyYW5zYWN0aW9uKTsKIAotLSAKMi43LjQKCg==

--===============2014118021005613185==--

