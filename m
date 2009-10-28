Content-Type: multipart/mixed; boundary="===============8736178963332332443=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/3] Inline release_id in voicecall.c
Date: Wed, 28 Oct 2009 17:53:23 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B92521C@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <1256705946.5768.34.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8736178963332332443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
>>
>> +unsigned int at_util_alloc_next_id(unsigned int *id_list) +{
>> +       unsigned int i;
>> +
>> +       for (i =3D 1; i < sizeof(unsigned int) * 8; i++) {
>> +               if (*id_list & (0x1 << i))
>> +                       continue;
>> +
>> +               *id_list |=3D (0x1 << i);
>> +               return i;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +inline void at_util_release_id(unsigned int *id_list, unsigned int
>> id) +{
>> +       *id_list &=3D ~(0x1 << id);
>> +}
> =

> what is this? Don't use inline at all and let the compiler decide. I
> also don't really understand how you think this works. There is
> nothing to inline here.
> =

> And while at it. Drop the 0x1 stuff. Using 1 is much more readable.

Ok. I update the patch to remove inline and replace 0x1 by 1. The
update version is attached.

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua

--===============8736178963332332443==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Move-and-rename-alloc_next_id-and-release_id-into-at.patch"

RnJvbSAwMDNkMjVjNmE3N2Y4NzVkMWVmNTZjMTJkMDQ3OWY2ODhjZTE4NTZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuaHVhIFpoYW5nIDx6aGVuaHVhLnpoYW5nQGludGVsLmNv
bT4KRGF0ZTogVGh1LCAyOSBPY3QgMjAwOSAwMTo0MjozOSArMDgwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8zXSBNb3ZlIGFuZCByZW5hbWUgYWxsb2NfbmV4dF9pZCBhbmQgcmVsZWFzZV9pZCBpbnRvIGF0
dXRpbC5jCgotLS0KIGRyaXZlcnMvYXRtb2RlbS9hdHV0aWwuYyAgICB8ICAgMjAgKysrKysrKysr
KysrKysrKysrKysKIGRyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaCAgICB8ICAgIDIgKysKIGRyaXZl
cnMvYXRtb2RlbS92b2ljZWNhbGwuYyB8ICAgMjQgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAz
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwuYyBiL2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwu
YwppbmRleCA1Nzg1MjJmLi4yNmQwYzI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0bW9kZW0vYXR1
dGlsLmMKKysrIGIvZHJpdmVycy9hdG1vZGVtL2F0dXRpbC5jCkBAIC04MSwzICs4MSwyMyBAQCBn
aW50IGF0X3V0aWxfY2FsbF9jb21wYXJlKGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRlciBi
KQogCXJldHVybiAwOwogfQogCit1bnNpZ25lZCBpbnQgYXRfdXRpbF9hbGxvY19uZXh0X2lkKHVu
c2lnbmVkIGludCAqaWRfbGlzdCkKK3sKKwl1bnNpZ25lZCBpbnQgaTsKKworCWZvciAoaSA9IDE7
IGkgPCBzaXplb2YodW5zaWduZWQgaW50KSAqIDg7IGkrKykgeworCQlpZiAoKmlkX2xpc3QgJiAo
MSA8PCBpKSkKKwkJCWNvbnRpbnVlOworCisJCSppZF9saXN0IHw9ICgxIDw8IGkpOworCQlyZXR1
cm4gaTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKwordm9pZCBhdF91dGlsX3JlbGVhc2VfaWQodW5z
aWduZWQgaW50ICppZF9saXN0LCB1bnNpZ25lZCBpbnQgaWQpCit7CisJKmlkX2xpc3QgJj0gfigx
IDw8IGlkKTsKK30KKwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG1vZGVtL2F0dXRpbC5oIGIvZHJp
dmVycy9hdG1vZGVtL2F0dXRpbC5oCmluZGV4IGFiOWRiMDUuLjA0NDQ1NjEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaAorKysgYi9kcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmgK
QEAgLTIzLDYgKzIzLDggQEAgdm9pZCBkZWNvZGVfYXRfZXJyb3Ioc3RydWN0IG9mb25vX2Vycm9y
ICplcnJvciwgY29uc3QgY2hhciAqZmluYWwpOwogdm9pZCBkdW1wX3Jlc3BvbnNlKGNvbnN0IGNo
YXIgKmZ1bmMsIGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCk7CiBnaW50IGF0X3V0aWxf
Y2FsbF9jb21wYXJlX2J5X3N0YXR1cyhnY29uc3Rwb2ludGVyIGEsIGdjb25zdHBvaW50ZXIgYik7
CiBnaW50IGF0X3V0aWxfY2FsbF9jb21wYXJlKGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRl
ciBiKTsKK3Vuc2lnbmVkIGludCBhdF91dGlsX2FsbG9jX25leHRfaWQodW5zaWduZWQgaW50ICpp
ZF9saXN0KTsKK3ZvaWQgYXRfdXRpbF9yZWxlYXNlX2lkKHVuc2lnbmVkIGludCAqaWRfbGlzdCwg
dW5zaWduZWQgaW50IGlkKTsKIAogc3RydWN0IGNiX2RhdGEgewogCXZvaWQgKmNiOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdG1vZGVtL3ZvaWNlY2FsbC5jIGIvZHJpdmVycy9hdG1vZGVtL3ZvaWNl
Y2FsbC5jCmluZGV4IGYwYzhkOTMuLjA3MzM2MDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRtb2Rl
bS92b2ljZWNhbGwuYworKysgYi9kcml2ZXJzL2F0bW9kZW0vdm9pY2VjYWxsLmMKQEAgLTg5LDI2
ICs4OSw2IEBAIHN0YXRpYyBpbnQgY2xhc3NfdG9fY2FsbF90eXBlKGludCBjbHMpCiAJfQogfQog
Ci1zdGF0aWMgdW5zaWduZWQgaW50IGFsbG9jX25leHRfaWQoc3RydWN0IHZvaWNlY2FsbF9kYXRh
ICpkKQotewotCXVuc2lnbmVkIGludCBpOwotCi0JZm9yIChpID0gMTsgaSA8IHNpemVvZihkLT5p
ZF9saXN0KSAqIDg7IGkrKykgewotCQlpZiAoZC0+aWRfbGlzdCAmICgweDEgPDwgaSkpCi0JCQlj
b250aW51ZTsKLQotCQlkLT5pZF9saXN0IHw9ICgweDEgPDwgaSk7Ci0JCXJldHVybiBpOwotCX0K
LQotCXJldHVybiAwOwotfQotCi1zdGF0aWMgdm9pZCByZWxlYXNlX2lkKHN0cnVjdCB2b2ljZWNh
bGxfZGF0YSAqZCwgdW5zaWduZWQgaW50IGlkKQotewotCWQtPmlkX2xpc3QgJj0gfigweDEgPDwg
aWQpOwotfQotCiBzdGF0aWMgc3RydWN0IG9mb25vX2NhbGwgKmNyZWF0ZV9jYWxsKHN0cnVjdCB2
b2ljZWNhbGxfZGF0YSAqZCwgaW50IHR5cGUsCiAJCQkJCWludCBkaXJlY3Rpb24sIGludCBzdGF0
dXMsCiAJCQkJCWNvbnN0IGNoYXIgKm51bSwgaW50IG51bV90eXBlLCBpbnQgY2xpcCkKQEAgLTEy
MSw3ICsxMDEsNyBAQCBzdGF0aWMgc3RydWN0IG9mb25vX2NhbGwgKmNyZWF0ZV9jYWxsKHN0cnVj
dCB2b2ljZWNhbGxfZGF0YSAqZCwgaW50IHR5cGUsCiAJaWYgKCFjYWxsKQogCQlyZXR1cm4gTlVM
TDsKIAotCWNhbGwtPmlkID0gYWxsb2NfbmV4dF9pZChkKTsKKwljYWxsLT5pZCA9IGF0X3V0aWxf
YWxsb2NfbmV4dF9pZCgmZC0+aWRfbGlzdCk7CiAJY2FsbC0+dHlwZSA9IHR5cGU7CiAJY2FsbC0+
ZGlyZWN0aW9uID0gZGlyZWN0aW9uOwogCWNhbGwtPnN0YXR1cyA9IHN0YXR1czsKQEAgLTIzNSw3
ICsyMTUsNyBAQCBzdGF0aWMgdm9pZCBjbGNjX3BvbGxfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3Vs
dCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpCiAJCQkJb2Zvbm9fdm9pY2VjYWxsX2Rpc2Nv
bm5lY3RlZCh2Yywgb2MtPmlkLAogCQkJCQkJCQlyZWFzb24sIE5VTEwpOwogCi0JCQlyZWxlYXNl
X2lkKHZkLCBvYy0+aWQpOworCQkJYXRfdXRpbF9yZWxlYXNlX2lkKCZ2ZC0+aWRfbGlzdCwgb2Mt
PmlkKTsKIAogCQkJbyA9IG8tPm5leHQ7CiAJCX0gZWxzZSBpZiAobmMgJiYgKCFvYyB8fCAobmMt
PmlkIDwgb2MtPmlkKSkpIHsKLS0gCjEuNi4yLjUKCg==

--===============8736178963332332443==--

