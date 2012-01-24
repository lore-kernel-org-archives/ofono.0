Content-Type: multipart/mixed; boundary="===============4061400975471909048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: crash when unplugged modem when it was still initializing
Date: Tue, 24 Jan 2012 11:35:56 -0600
Message-ID: <4F1EEBFC.1020203@gmail.com>
In-Reply-To: <CAHiDW_E10MmuxyvO3v9vXzCsA8A49WPULS=Q3C-pL4G98eRjmA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4061400975471909048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/24/2012 03:33 PM, Jussi Kukkonen wrote:
> On Tue, Jan 24, 2012 at 11:19 PM, Jussi Kukkonen
> <jussi.kukkonen@intel.com> wrote:
>> Hi,
>> I happened to unplug my dongle quite soon after starting ofono. It
>> promptly aborted.
> =

> and it just happened again with no relation to unplugging devices or
> starting ofonod s othose were red herrings. In fact I hadn't touched
> anything for a moment: connmand and ofonod were both running.
> =


Try the following patch.

Regards,
-Denis

--===============4061400975471909048==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sim-Fix-crash-due-to-uninitialized-spn_watch.patch"

PkZyb20gNDNjYjk4YjcxMzRjZmY3NjVlMTBkYjJjOTQ0MDI2OTVmNzk1YjhmZiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFR1ZSwgMjQgSmFuIDIwMTIgMTE6MzM6MTYgLTA2MDAKU3ViamVjdDogW1BBVENIXSBzaW06
IEZpeCBjcmFzaCBkdWUgdG8gdW5pbml0aWFsaXplZCBzcG5fd2F0Y2gKCi0tLQogc3JjL3NpbS5j
IHwgICAgOCArKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3NpbS5jIGIvc3JjL3NpbS5jCmluZGV4IDcwM2Uw
ZGIuLmViMjVlMDcgMTAwNjQ0Ci0tLSBhL3NyYy9zaW0uYworKysgYi9zcmMvc2ltLmMKQEAgLTI1
MzAsNiArMjUzMCwxNCBAQCBzdGF0aWMgdm9pZCBzaW1fc3BuX2Nsb3NlKHN0cnVjdCBvZm9ub19z
aW0gKnNpbSkKIAlfX29mb25vX3dhdGNobGlzdF9mcmVlKHNpbS0+c3BuX3dhdGNoZXMpOwogCXNp
bS0+c3BuX3dhdGNoZXMgPSBOVUxMOwogCisJLyoKKwkgKiBXZSBoYXZlIG5vdCBpbml0aWFsaXpl
ZCBTUE4gbG9naWMgYXQgYWxsIHlldCwgZWl0aGVyIGJlY2F1c2UKKwkgKiBubyBuZXRyZWcgLyBn
cHJzIGF0b20gaGFzIGJlZW4gbmVlZGVkIG9yIHdlIGhhdmUgbm90IHJlYWNoZWQgdGhlCisJICog
cG9zdF9zaW0gc3RhdGUKKwkgKi8KKwlpZiAoc2ltLT5lZl9zcG5fd2F0Y2ggPT0gMCkKKwkJcmV0
dXJuOworCiAJb2Zvbm9fc2ltX3JlbW92ZV9maWxlX3dhdGNoKHNpbS0+Y29udGV4dCwgc2ltLT5l
Zl9zcG5fd2F0Y2gpOwogCXNpbS0+ZWZfc3BuX3dhdGNoID0gMDsKIAotLSAKMS43LjMuNAoK

--===============4061400975471909048==--

