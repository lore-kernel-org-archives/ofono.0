Content-Type: multipart/mixed; boundary="===============1596079389969683987=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Implement writing EF-MBDN on SetProperty or Enhanced
 Voicemail IE.
Date: Wed, 05 Aug 2009 18:33:49 +0200
Message-ID: <fb249edb0908050933v78a979abrcde608cf71f00ef7@mail.gmail.com>
In-Reply-To: <1249456120-10263-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1596079389969683987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/5 Andrzej Zaborowski <andrew.zaborowski@intel.com>:
> I've not tested this on a real SIM yet.

It needs the attached fix since the record numbers passed to the
plugin are now 1-based.

Regards

--===============1596079389969683987==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-record-number-in-at_sim_update_record.patch"

RnJvbSAyYjY4OWJlMGM4Y2ViYzc3MzY3OWE2MGE0MTAzY2ZmMjliNmIyOWQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogV2VkLCA1IEF1ZyAyMDA5IDExOjI1OjIxICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gRml4IHJlY29yZCBudW1iZXIgaW4gYXRfc2ltX3VwZGF0ZV9yZWNvcmQuCgotLS0K
IGRyaXZlcnMvYXRtb2RlbS9zaW0uYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtb2RlbS9z
aW0uYyBiL2RyaXZlcnMvYXRtb2RlbS9zaW0uYwppbmRleCA3NDhjZjZhLi45MGYwMmUyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2F0bW9kZW0vc2ltLmMKKysrIGIvZHJpdmVycy9hdG1vZGVtL3NpbS5j
CkBAIC0zMjEsNyArMzIxLDcgQEAgc3RhdGljIHZvaWQgYXRfc2ltX3VwZGF0ZV9yZWNvcmQoc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSwgaW50IGZpbGVpZCwKIAkJZ290byBlcnJvcjsKIAogCWxl
biA9IHNwcmludGYoYnVmLCAiQVQrQ1JTTT0yMjAsJWksJWksNCwlaSwiLCBmaWxlaWQsCi0JCQly
ZWNvcmQgKyAxLCBsZW5ndGgpOworCQkJcmVjb3JkLCBsZW5ndGgpOwogCiAJZm9yICg7IGxlbmd0
aDsgbGVuZ3RoLS0pCiAJCWxlbiArPSBzcHJpbnRmKGJ1ZiArIGxlbiwgIiUwMmhoeCIsICp2YWx1
ZSsrKTsKLS0gCjEuNi4xCgo=

--===============1596079389969683987==--

