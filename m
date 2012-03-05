Content-Type: multipart/mixed; boundary="===============3825011510684653183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] emulator: Fix for PTS test TC_AG_TWC_BV_02_I
Date: Mon, 05 Mar 2012 14:01:18 -0600
Message-ID: <4F551B8E.9020300@gmail.com>
In-Reply-To: <1330436037-18377-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3825011510684653183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 02/28/2012 07:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> RING event should only be sent when callsetup indicator is set to
> Incoming and there is no active call.
> =

> If call indicator is set to inactive while callsetup is
> already set to Incoming (waiting call has generated +CCWA),
> RING event should be sent after all calls' state have been updated.
> =

> As state of calls are updated one by one, generating multiple calls
> to ofono_emulator_set_indicator(), do not call notify_ring() just
> after call indicator went from active/held to inactive (only start
> ring timer).
> In ring_timer(), in case of a call in waiting state, just exit and
> wait for next timeout.
> ---
>  src/emulator.c |   21 +++++++++++----------
>  1 files changed, 11 insertions(+), 10 deletions(-)

It seems like you're covering up the symptoms, not really addressing the
real issue.  The logic we have right now is mostly correct, we're just
not handling the CHLD=3D1 case properly.  Can you try the attached patch
and see if it makes the PTS test case pass?

Regards,
-Denis

--===============3825011510684653183==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-emulator-Fix-PTS-test-case-TC_AG_TWC_BV_02_I.patch"

PkZyb20gMzhlMDk2NWZiMWZkNDE1NmY3YTNiMjU3OGU5YTgzZTUyOGJkMzk3MyBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgNSBNYXIgMjAxMiAxMzo1ODoyNiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGVtdWxh
dG9yOiBGaXggUFRTIHRlc3QgY2FzZSBUQ19BR19UV0NfQlZfMDJfSQoKLS0tCiBzcmMvZW11bGF0
b3IuYyB8ICAgMTcgKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvZW11bGF0b3IuYyBiL3Ny
Yy9lbXVsYXRvci5jCmluZGV4IDI2MmU3ODIuLjM4NzkwNDkgMTAwNjQ0Ci0tLSBhL3NyYy9lbXVs
YXRvci5jCisrKyBiL3NyYy9lbXVsYXRvci5jCkBAIC00MjAsMTQgKzQyMCw2IEBAIHN0YXRpYyBn
Ym9vbGVhbiBub3RpZnlfcmluZyh2b2lkICp1c2VyX2RhdGEpCiAJCXJldHVybiBUUlVFOwogCiAJ
YyA9IGZpbmRfY2FsbF93aXRoX3N0YXR1cyhlbSwgQ0FMTF9TVEFUVVNfSU5DT01JTkcpOwotCi0J
LyoKLQkgKiBJbiBjYXNlIG9mIHdhaXRpbmcgY2FsbCBiZWNvbWluZyBhbiBpbmNvbWluZyBjYWxs
LCBjYWxsIHN0YXR1cwotCSAqIGNoYW5nZSBtYXkgbm90IGhhdmUgYmVlbiBkb25lIHlldCwgc28g
dHJ5IHRvIGZpbmQgd2FpdGluZyBjYWxsIHRvbwotCSAqLwotCWlmIChjID09IE5VTEwpCi0JCWMg
PSBmaW5kX2NhbGxfd2l0aF9zdGF0dXMoZW0sIENBTExfU1RBVFVTX1dBSVRJTkcpOwotCiAJaWYg
KGMgPT0gTlVMTCkKIAkJcmV0dXJuIFRSVUU7CiAKQEAgLTEyMTksNiArMTIxMSwxMyBAQCB2b2lk
IG9mb25vX2VtdWxhdG9yX3NldF9pbmRpY2F0b3Ioc3RydWN0IG9mb25vX2VtdWxhdG9yICplbSwK
IAl9CiAKIAkvKgorCSAqIEluIGNhc2Ugb2Ygd2FpdGluZyBjYWxsIGJlY29taW5nIGFuIGluY29t
aW5nIGNhbGwsIGNhbGwgc3RhdHVzCisJICogY2hhbmdlIG1heSBub3QgaGF2ZSBiZWVuIGRvbmUg
eWV0LCBzbyBkbyBub3RoaW5nCisJICovCisJaWYgKGZpbmRfY2FsbF93aXRoX3N0YXR1cyhlbSwg
Q0FMTF9TVEFUVVNfV0FJVElORykgIT0gTlVMTCkKKwkJcmV0dXJuOworCisJLyoKIAkgKiBSaW5n
IHRpbWVyIHNob3VsZCBiZSBzdGFydGVkIHdoZW46CiAJICogLSBjYWxsc2V0dXAgaW5kaWNhdG9y
IGlzIHNldCB0byBJbmNvbWluZyBhbmQgdGhlcmUgaXMgbm8gYWN0aXZlIGNhbGwKIAkgKiAgIChu
b3QgYSB3YWl0aW5nIGNhbGwpCkBAIC0xMjI3LDggKzEyMjYsNiBAQCB2b2lkIG9mb25vX2VtdWxh
dG9yX3NldF9pbmRpY2F0b3Ioc3RydWN0IG9mb25vX2VtdWxhdG9yICplbSwKIAkgKiBJbiB0aG9z
ZSBjYXNlcywgYSBmaXJzdCBSSU5HIHNob3VsZCBiZSBzZW50IGp1c3QgYWZ0ZXIgdGhlICtDSUVW
CiAJICogUmluZyB0aW1lciBzaG91bGQgYmUgc3RvcHBlZCBmb3IgYWxsIG90aGVyIHZhbHVlcyBv
ZiBjYWxsc2V0dXAKIAkgKi8KLQlpZiAod2FpdGluZykKLQkJcmV0dXJuOwogCiAJLyogQ2FsbCBz
dGF0ZSB3ZW50IGZyb20gYWN0aXZlL2hlbGQgKyB3YWl0aW5nIC0+IGluY29taW5nICovCiAJaWYg
KGNhbGwgJiYgdmFsdWUgPT0gT0ZPTk9fRU1VTEFUT1JfQ0FMTF9JTkFDVElWRSAmJgotLSAKMS43
LjMuNAoK

--===============3825011510684653183==--

