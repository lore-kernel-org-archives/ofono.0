Content-Type: multipart/mixed; boundary="===============4153332442401048897=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 22:48:46 +0200
Message-ID: <l2tfb249edb1004201348re351d92bre2347973abd7d9c3@mail.gmail.com>
In-Reply-To: <201004201521.08399.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4153332442401048897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 20 April 2010 22:21, Denis Kenzior <denkenz@gmail.com> wrote:
>> Rereading the etsi ts102.221 the "Le" field in the Envelope APDU
>> (11.2.2.2) is not explictly defined "not present", instead it says
>> "empty or maximum length of expected data". =C2=A0It doesn't say what the
>> default value is when empty so I conclude it's safer to have the field
>> present or the card may think it's not allowed to send any response at
>> all -- depending on the implementer's interpretation of the spec.
>>
>> 10.1.6 says the field is the maximum respose length expected, but then
>> some commands suggest it should be the exact length wanted and some
>> make the field obligatory.
>
> So I re-read that part of the spec, and I can see why we might want it.
> However, this quote seemed rather interesting: "Le set to '00' indicates =
that
> the terminal expects to receive at most the maximum number of bytes, i.e.=
 256,
> in the response ADPU. The UICC may return any number of bytes in the rang=
e 1
> to 256."
>
> Shouldn't that 'FF' be changed to '00'? =C2=A0Also, you might want to inc=
lude the
> relevant passage or Spec/Section reference in this code so we don't wonder
> where it came from in the future.

Attached patch adds a comment and changes the FF to 00.  I guess it is
largely theoretical right now.  The issue again with "any number of
bytes in the range 1 to 256" is that this prohibits an empty response,
which we want to allow too :)   Maybe this should be a parameter of
driver->envelope()

Best regards

--===============4153332442401048897==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0012-Comment-on-the-Le-field-in-ENVELOPE-apdu.patch"

RnJvbSA3OGNkM2I0ODgyNjQ3YTZjNDJmNTM1NzJkZTE0MjNkMTE0NjRlMzQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbT4KRGF0ZTogVHVlLCAyMCBBcHIgMjAxMCAwOTo0Mzo0MCArMDIwMApTdWJqZWN0
OiBDb21tZW50IG9uIHRoZSBMZSBmaWVsZCBpbiBFTlZFTE9QRSBhcGR1LgoKLS0tCiBkcml2ZXJz
L2F0bW9kZW0vc3RrLmMgfCAgIDE0ICsrKysrKysrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG1v
ZGVtL3N0ay5jIGIvZHJpdmVycy9hdG1vZGVtL3N0ay5jCmluZGV4IDhjZmY0YTIuLmNjMDJhOGUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRtb2RlbS9zdGsuYworKysgYi9kcml2ZXJzL2F0bW9kZW0v
c3RrLmMKQEAgLTEwNyw3ICsxMDcsMTkgQEAgc3RhdGljIHZvaWQgYXRfc3RrX2VudmVsb3BlKHN0
cnVjdCBvZm9ub19zdGsgKnN0aywgaW50IGxlbmd0aCwKIAlmb3IgKDsgbGVuZ3RoOyBsZW5ndGgt
LSkKIAkJbGVuICs9IHNwcmludGYoYnVmICsgbGVuLCAiJTAyaGhYIiwgKmNvbW1hbmQrKyk7CiAK
LQlsZW4gKz0gc3ByaW50ZihidWYgKyBsZW4sICJGRiIpOworCS8qIFdlIGFwcGVuZCB0aGUgIkxl
IiBmaWVsZC4gIEVUU0kgdHMxMDIuMjIxIGlzIG5vdCB2ZXJ5IGNsZWFyCisJICogb24gd2hldGhl
ciBpdCdzIG1hbmRhdG9yeSwgc28gc3RheSBvbiB0aGUgc2FmZSBzaWRlLgorCSAqIFJlbGV2YW50
IHNlY3Rpb25zOgorCSAqIDEwLjEuNiBkZWZpbmVzICJMZSIgYXMgb3B0aW9uYWwsIGRvZXNuJ3Qg
c2F5IHdoZXRoZXIgYWJzZW5jZQorCSAqIG1lYW5zIG5vIGFuc3dlciBpcyB3YW50ZWQgb3Igb25s
eSB0aGF0IGl0IGNhbiBoYXZlIGFueQorCSAqIGxlbmd0aC4gIElmIHByZXNlbnQgdGhlIHJlc3Bv
bnNlIGRhdGEgc2hvdWxkIGNvbnNpc3Qgb2YgTGUgYnl0ZXMuCisJICogVGhlbiBzdWdnZXN0cyAi
MDAiIGFsbG93cyBhbnkgbGVuZ3RoIGJldHdlZW4gMSBhbmQgMjU2IGJ5dGVzLgorCSAqIDExLjIu
Mi4yIHNheXMgIkxlIiBjYW4gYmUgImVtcHR5IiBidXQgYWdhaW4gZG9lc24ndCBzYXkgd2hhdAor
CSAqIHZhbHVlIGlzIGFzc3VtZWQgaW4gdGhpcyBjYXNlLiAgSWYgbm90ICJlbXB0eSIgdGhlIHJl
c3BvbnNlCisJICogc2hvdWxkIGNvbnNpc3Qgb2YgTGUgb3IgZmV3ZXIgYnl0ZXMuICBUaGlzIHN1
Z2dlc3RzIHdlIHNob3VsZAorCSAqIHVzZSAiRkYiIGFzIHRoZSB2YWx1ZS4KKwkgKi8KKwlsZW4g
Kz0gc3ByaW50ZihidWYgKyBsZW4sICIwMCIpOwogCiAJcmV0ID0gZ19hdF9jaGF0X3NlbmQoc2Qt
PmNoYXQsIGJ1ZiwgY3NpbV9wcmVmaXgsCiAJCQkJYXRfY3NpbV9lbnZlbG9wZV9jYiwgY2JkLCBn
X2ZyZWUpOwotLSAKMS42LjEKCg==

--===============4153332442401048897==--

