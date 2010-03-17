Content-Type: multipart/mixed; boundary="===============4390024487612953048=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 01/11] Rename g_at_server_send_result
Date: Wed, 17 Mar 2010 22:38:49 +0800
Message-ID: <4BA0E979.1030004@intel.com>
In-Reply-To: <1268836241-4834-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4390024487612953048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On 03/17/2010 10:30 PM, Zhang, Zhenhua wrote:
> Rename it to g_at_server_send_final.
> ---
>   gatchat/gatserver.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>

Sorry, I forgot the first patch. Please review the first patch as =

attached. Otherwise, these patches could not be applied.

Thanks.
Zhenhua


--===============4390024487612953048==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Remove-old-server_parse_line.patch"

PkZyb20gNTg4MTI2MDc2ZTFmYzEwZjU3Yjc1YWZlNzM0ZDUxMDQ2YWI0NmQ2ZCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogWmhlbmh1YSBaaGFuZyA8emhlbmh1YS56aGFuZ0BpbnRlbC5j
b20+CkRhdGU6IFdlZCwgMTcgTWFyIDIwMTAgMTY6MzY6MjIgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBSZW1vdmUgb2xkIHNlcnZlcl9wYXJzZV9saW5lCgotLS0KIGdhdGNoYXQvZ2F0c2VydmVyLmMg
fCAgIDQ5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
IDEgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9nYXRjaGF0L2dhdHNlcnZlci5jIGIvZ2F0Y2hhdC9nYXRzZXJ2ZXIuYwppbmRleCAw
Nzk0NTFmLi43NTc3ZGUyIDEwMDY0NAotLS0gYS9nYXRjaGF0L2dhdHNlcnZlci5jCisrKyBiL2dh
dGNoYXQvZ2F0c2VydmVyLmMKQEAgLTE3Myw1NyArMTczLDggQEAgc3RhdGljIHZvaWQgZ19hdF9z
ZXJ2ZXJfc2VuZF9yZXN1bHQoR0F0U2VydmVyICpzZXJ2ZXIsIEdBdFNlcnZlclJlc3VsdCByZXN1
bHQpCiAJc2VuZF9jb21tb24oc2VydmVyLCBidWYsIE1JTihsZW4sIHNpemVvZihidWYpLTEpKTsK
IH0KIAotc3RhdGljIGlubGluZSBnYm9vbGVhbiBpc19hdF9jb21tYW5kX3ByZWZpeChjb25zdCBj
aGFyIGMpCi17Ci0Jc3dpdGNoIChjKSB7Ci0JY2FzZSAnKyc6Ci0JY2FzZSAnKic6Ci0JY2FzZSAn
ISc6Ci0JY2FzZSAnJSc6Ci0JCXJldHVybiBUUlVFOwotCWRlZmF1bHQ6Ci0JCXJldHVybiBGQUxT
RTsKLQl9Ci19Ci0KLXN0YXRpYyB2b2lkIHBhcnNlX2F0X2NvbW1hbmQoR0F0U2VydmVyICpzZXJ2
ZXIsIGNoYXIgKmJ1ZikKLXsKLQlnX2F0X3NlcnZlcl9zZW5kX3Jlc3VsdChzZXJ2ZXIsIEdfQVRf
U0VSVkVSX1JFU1VMVF9FUlJPUik7Ci19Ci0KLXN0YXRpYyB2b2lkIHBhcnNlX3YyNTBfc2V0dGlu
Z3MoR0F0U2VydmVyICpzZXJ2ZXIsIGNoYXIgKmJ1ZikKLXsKLQlnX2F0X3NlcnZlcl9zZW5kX3Jl
c3VsdChzZXJ2ZXIsIEdfQVRfU0VSVkVSX1JFU1VMVF9FUlJPUik7Ci19Ci0KIHN0YXRpYyB2b2lk
IHNlcnZlcl9wYXJzZV9saW5lKEdBdFNlcnZlciAqc2VydmVyLCBjaGFyICpsaW5lKQogewotCWdz
aXplIGkgPSAwOwotCWNoYXIgYzsKLQotCWlmIChsaW5lID09IE5VTEwpIHsKLQkJZ19hdF9zZXJ2
ZXJfc2VuZF9yZXN1bHQoc2VydmVyLCBHX0FUX1NFUlZFUl9SRVNVTFRfRVJST1IpOwotCQlnb3Rv
IGRvbmU7Ci0JfQotCi0JaWYgKGxpbmVbMF0gPT0gJ1wwJykgewotCQlnX2F0X3NlcnZlcl9zZW5k
X3Jlc3VsdChzZXJ2ZXIsIEdfQVRfU0VSVkVSX1JFU1VMVF9PSyk7Ci0JCWdvdG8gZG9uZTsKLQl9
Ci0KLQljID0gbGluZVtpXTsKLQkvKiBza2lwIHNlbWljb2xvbiAqLwotCWlmIChjID09ICc7JykK
LQkJYyA9IGxpbmVbKytpXTsKLQotCWlmIChpc19hdF9jb21tYW5kX3ByZWZpeChjKSB8fCBjID09
ICdBJyB8fCBjID09ICdEJyB8fCBjID09ICdIJykKLQkJcGFyc2VfYXRfY29tbWFuZChzZXJ2ZXIs
IGxpbmUgKyBpKTsKLQllbHNlIGlmIChnX2FzY2lpX2lzYWxwaGEoYykgfHwgYyA9PSAnJicpCi0J
CXBhcnNlX3YyNTBfc2V0dGluZ3Moc2VydmVyLCBsaW5lICsgaSk7Ci0JZWxzZQotCQlnX2F0X3Nl
cnZlcl9zZW5kX3Jlc3VsdChzZXJ2ZXIsIEdfQVRfU0VSVkVSX1JFU1VMVF9FUlJPUik7Ci0KLWRv
bmU6CiAJZ19mcmVlKGxpbmUpOwogfQogCi0tIAoxLjYuNi4xCgo=

--===============4390024487612953048==--

