Content-Type: multipart/mixed; boundary="===============8053422701963437026=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: crash after SimManager.ResetPin()
Date: Fri, 23 Dec 2011 01:28:44 -0600
Message-ID: <4EF42DAC.9080204@gmail.com>
In-Reply-To: <CAHiDW_FOzBG8vHfJ3M=wX8OxG1eMc6+-t+qdz2n9PyWr0C7f-A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8053422701963437026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 12/23/2011 12:48 PM, Kukkonen, Jussi wrote:
> Hi all,
> =

> I consistently get a crash when calling SimManager.ResetPin ("puk",
> puk, new_pin). Before this I've called ChangePin()  with wrong pin
> three times.to get "PinRequired=3Dpuk" property change.
> =

> This is a huawei E1550 USB modem.
> =


Can you please try the following patch?

Regards,
-Denis

--===============8053422701963437026==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sim-Fix-not-creating-simfs-context-in-some-cases.patch"

PkZyb20gNzY0YWI0MDE3ZGVjNjEwMDZlZTc5MzZkNDFlNDA5MGQ1ODExMDIxOCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IEZyaSwgMjMgRGVjIDIwMTEgMDE6Mjc6MTkgLTA2MDAKU3ViamVjdDogW1BBVENIXSBzaW06
IEZpeCBub3QgY3JlYXRpbmcgc2ltZnMgY29udGV4dCBpbiBzb21lIGNhc2VzCgotLS0KIHNyYy9z
aW0uYyB8ICAgIDggKysrLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9zaW0uYyBiL3NyYy9zaW0uYwppbmRleCBk
YWU4MjRkLi40NDEyZGI4IDEwMDY0NAotLS0gYS9zcmMvc2ltLmMKKysrIGIvc3JjL3NpbS5jCkBA
IC0xNzMyLDYgKzE3MzIsOCBAQCBzdGF0aWMgdm9pZCBzaW1fZWZwaGFzZV9yZWFkX2NiKGludCBv
aywgaW50IGxlbmd0aCwgaW50IHJlY29yZCwKIAogc3RhdGljIHZvaWQgc2ltX2luaXRpYWxpemVf
YWZ0ZXJfcGluKHN0cnVjdCBvZm9ub19zaW0gKnNpbSkKIHsKKwlzaW0tPmNvbnRleHQgPSBvZm9u
b19zaW1fY29udGV4dF9jcmVhdGUoc2ltKTsKKwogCW9mb25vX3NpbV9yZWFkKHNpbS0+Y29udGV4
dCwgU0lNX0VGUEhBU0VfRklMRUlELAogCQkJT0ZPTk9fU0lNX0ZJTEVfU1RSVUNUVVJFX1RSQU5T
UEFSRU5ULAogCQkJc2ltX2VmcGhhc2VfcmVhZF9jYiwgc2ltKTsKQEAgLTE5MzMsMTIgKzE5MzUs
OCBAQCBza2lwX2VmcGw6CiAJCQkJCQkmc2ltLT5sYW5ndWFnZV9wcmVmcyk7CiAKIAkvKiBQcm9j
ZWVkIHdpdGggc2ltIGluaXRpYWxpemF0aW9uIGlmIHdlJ3JlIG5vdCBtZXJlbHkgdXBkYXRpbmcg
Ki8KLQlpZiAoIXNpbS0+bGFuZ3VhZ2VfcHJlZnNfdXBkYXRlKSB7Ci0JCWlmIChzaW0tPmNvbnRl
eHQgPT0gTlVMTCkKLQkJCXNpbS0+Y29udGV4dCA9IG9mb25vX3NpbV9jb250ZXh0X2NyZWF0ZShz
aW0pOwotCisJaWYgKCFzaW0tPmxhbmd1YWdlX3ByZWZzX3VwZGF0ZSkKIAkJX19vZm9ub19zaW1f
cmVjaGVja19waW4oc2ltKTsKLQl9CiAKIAlzaW0tPmxhbmd1YWdlX3ByZWZzX3VwZGF0ZSA9IEZB
TFNFOwogfQotLSAKMS43LjMuNAoK

--===============8053422701963437026==--

