Content-Type: multipart/mixed; boundary="===============1498641688860046292=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: org.ofono.AllowedAccessPoints not found on the interface_list
Date: Fri, 07 Feb 2020 11:09:31 -0600
Message-ID: <2a7b4b63-4c0a-edbd-57a9-6b4f63198b98@gmail.com>
In-Reply-To: <CAA=hcWRwwH6FTgDsuP3a1gLpfHuYgrmyAMJmAoHfih9VLLJKuA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1498641688860046292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JH,

On 1/24/20 6:49 PM, JH wrote:
> Hi,
> =

> I am running ofono for SARA-R4 Modem, systemd show many following
> messages, does it need be concerned?
> =

> Interface org.ofono.AllowedAccessPoints not found on the interface_list
> =


This error message should be benign.  See if the attached patch quiets =

this down for you.

Regards,
-Denis

--===============1498641688860046292==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-allowed-apns-Do-not-try-to-unregister-unnecessarily.patch"

RnJvbSA4ZTc4ZDRkYmE1ZDU0YjRiMTE3NWE1Mzk3M2NlYjZmODI5YzIyYmZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCA3IEZlYiAyMDIwIDExOjA2OjMyIC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gYWxsb3dl
ZC1hcG5zOiBEbyBub3QgdHJ5IHRvIHVucmVnaXN0ZXIgdW5uZWNlc3NhcmlseQoKYWxsb3dlZC1h
cG5zIHBsdWdpbiB3aWxsIHRyeSB0byB1cmVnaXN0ZXIgdGhlIEFsbG93ZWRBY2Nlc3NQb2ludHMK
aW50ZXJmYWNlIHdoZW5ldmVyIHRoZSBzaW0gc3RhdGUgY2hhbmdlcywgZXZlbiB3aGVuIG5vdCBy
ZWdpc3RlcmVkLgpUaGlzIHJlc3VsdHMgaW4gdGhlIChiZW5pZ24pIGVycm9yIGJlaW5nIHByaW50
ZWQgaW5zaWRlCm9mb25vX21vZGVtX3JlbW92ZV9pbnRlcmZhY2U6CgpJbnRlcmZhY2Ugb3JnLm9m
b25vLkFsbG93ZWRBY2Nlc3NQb2ludHMgbm90IGZvdW5kIG9uIHRoZSBpbnRlcmZhY2VfbGlzdAot
LS0KIHBsdWdpbnMvYWxsb3dlZC1hcG5zLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3BsdWdpbnMvYWxsb3dlZC1hcG5zLmMgYi9wbHVn
aW5zL2FsbG93ZWQtYXBucy5jCmluZGV4IGIyMjJiOTFjLi4xOTkyMDJiNSAxMDA2NDQKLS0tIGEv
cGx1Z2lucy9hbGxvd2VkLWFwbnMuYworKysgYi9wbHVnaW5zL2FsbG93ZWQtYXBucy5jCkBAIC01
Miw2ICs1Miw3IEBAIHN0cnVjdCBhbGxvd2VkX2FwbnNfY3R4IHsKIAlzdHJ1Y3Qgb2Zvbm9fc2lt
X2NvbnRleHQgKnNpbV9jb250ZXh0OwogCURCdXNNZXNzYWdlICpwZW5kaW5nOwogCURCdXNNZXNz
YWdlICpyZXBseTsKKwlib29sIHJlZ2lzdGVyZWQ7CiB9OwogCiBzdGF0aWMgdm9pZCBjb250ZXh0
X2Rlc3Ryb3koZ3BvaW50ZXIgZGF0YSkKQEAgLTE2Miw2ICsxNjMsOSBAQCBzdGF0aWMgdm9pZCBz
aW1fc3RhdGVfd2F0Y2goZW51bSBvZm9ub19zaW1fc3RhdGUgbmV3X3N0YXRlLCB2b2lkICpkYXRh
KQogCURCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9fZGJ1c19nZXRfY29ubmVjdGlvbigpOwog
CiAJaWYgKG5ld19zdGF0ZSAhPSBPRk9OT19TSU1fU1RBVEVfUkVBRFkpIHsKKwkJaWYgKCFjdHgt
PnJlZ2lzdGVyZWQpCisJCQlyZXR1cm47CisKIAkJZ19kYnVzX3VucmVnaXN0ZXJfaW50ZXJmYWNl
KGNvbm4sCiAJCQkJb2Zvbm9fbW9kZW1fZ2V0X3BhdGgoY3R4LT5tb2RlbSksCiAJCQkJQUxMT1dF
RF9BQ0NFU1NfUE9JTlRTX0lOVEVSRkFDRSk7CkBAIC0xNjksNiArMTczLDcgQEAgc3RhdGljIHZv
aWQgc2ltX3N0YXRlX3dhdGNoKGVudW0gb2Zvbm9fc2ltX3N0YXRlIG5ld19zdGF0ZSwgdm9pZCAq
ZGF0YSkKIAkJb2Zvbm9fbW9kZW1fcmVtb3ZlX2ludGVyZmFjZShjdHgtPm1vZGVtLAogCQkJCUFM
TE9XRURfQUNDRVNTX1BPSU5UU19JTlRFUkZBQ0UpOwogCisJCWN0eC0+cmVnaXN0ZXJlZCA9IGZh
bHNlOwogCQlyZXR1cm47CiAJfQogCkBAIC0xODMsNiArMTg4LDcgQEAgc3RhdGljIHZvaWQgc2lt
X3N0YXRlX3dhdGNoKGVudW0gb2Zvbm9fc2ltX3N0YXRlIG5ld19zdGF0ZSwgdm9pZCAqZGF0YSkK
IAkJcmV0dXJuOwogCX0KIAorCWN0eC0+cmVnaXN0ZXJlZCA9IHRydWU7CiAJb2Zvbm9fbW9kZW1f
YWRkX2ludGVyZmFjZShjdHgtPm1vZGVtLAogCQkJQUxMT1dFRF9BQ0NFU1NfUE9JTlRTX0lOVEVS
RkFDRSk7CiB9Ci0tIAoyLjIxLjAKCg==

--===============1498641688860046292==--

