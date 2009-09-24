Content-Type: multipart/mixed; boundary="===============2046263630407084441=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [Patch]Unref GIOChannel in g_at_chat_new_from_tty
Date: Thu, 24 Sep 2009 11:22:22 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B3D5AEE@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2046263630407084441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is the patch to unref GIOChannel in g_at_chat_new_from_tty. If the =

GAtChat is created from g_at_chat_new, the reference count of channel is =

increased by g_io_add_watch_full(channel), so we need to unref it.

If GAtChat is failed to create, we also need to unref channel to free it.

Please review it.

Regards,
Zhenhua

--===============2046263630407084441==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Unref-GIOChannel-in-g_at_chat_new_from_tty.patch"

RnJvbSA2Y2UyYTUwZTcyNTIzOTU5ZWE4NzkwMjAxMTNhNDRjYzhkNzU1ZDhkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuaHVhIFpoYW5nIDx6aGVuaHVhLnpoYW5nQGludGVsLmNv
bT4KRGF0ZTogV2VkLCAyMyBTZXAgMjAwOSAxODo1NzoxNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IFVucmVmIEdJT0NoYW5uZWwgaW4gZ19hdF9jaGF0X25ld19mcm9tX3R0eQoKLS0tCiBnYXRjaGF0
L2dhdGNoYXQuYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0Y2hhdC5jIGIvZ2F0Y2hh
dC9nYXRjaGF0LmMKaW5kZXggNWIzYTIxNC4uODQwNzMzOCAxMDA2NDQKLS0tIGEvZ2F0Y2hhdC9n
YXRjaGF0LmMKKysrIGIvZ2F0Y2hhdC9nYXRjaGF0LmMKQEAgLTk4NCw2ICs5ODQsNyBAQCBHQXRD
aGF0ICpnX2F0X2NoYXRfbmV3X2Zyb21fdHR5KGNvbnN0IGNoYXIgKmRldmljZSwgR0F0U3ludGF4
ICpzeW50YXgpCiB7CiAJR0lPQ2hhbm5lbCAqY2hhbm5lbDsKIAlpbnQgZmQ7CisJR0F0Q2hhdCAq
Y2hhdDsKIAogCWZkID0gb3Blbl9kZXZpY2UoZGV2aWNlKTsKIAlpZiAoZmQgPCAwKQpAQCAtOTk1
LDcgKzk5Niw5IEBAIEdBdENoYXQgKmdfYXRfY2hhdF9uZXdfZnJvbV90dHkoY29uc3QgY2hhciAq
ZGV2aWNlLCBHQXRTeW50YXggKnN5bnRheCkKIAkJcmV0dXJuIE5VTEw7CiAJfQogCi0JcmV0dXJu
IGdfYXRfY2hhdF9uZXcoY2hhbm5lbCwgc3ludGF4KTsKKwljaGF0ID0gZ19hdF9jaGF0X25ldyhj
aGFubmVsLCBzeW50YXgpOworCWdfaW9fY2hhbm5lbF91bnJlZihjaGFubmVsKTsKKwlyZXR1cm4g
Y2hhdDsKIH0KIAogR0F0Q2hhdCAqZ19hdF9jaGF0X3JlZihHQXRDaGF0ICpjaGF0KQotLSAKMS42
LjEuMwoK

--===============2046263630407084441==--

