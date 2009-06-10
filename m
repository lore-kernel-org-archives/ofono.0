Content-Type: multipart/mixed; boundary="===============8171337862635553909=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MNC/MCC as string?
Date: Wed, 10 Jun 2009 12:41:59 -0500
Message-ID: <9b1cac640906101041g48ca9b8dv1b9f50d0c843381d@mail.gmail.com>
In-Reply-To: <200906101942.02477.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8171337862635553909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

Well, the point is that leading zeroes are meaningful (much like with phone
> numbers in fact). The API, not just the implementation, must distinguish
> network "xy" from network "0xy", so that manual selection remains
> unambiguous.
> A D-Bus string is probably nicer to use than an integer using ISI's BCD
> scheme


I understand perfectly.  But remember, oFono does not expose the user to
such details.  Manual registration is accomplished by using Register()
method (with no arguments) of the NetworkOperator interface.  The internal
storage representation is never exposed.  Thus it doesn't matter whether
internally it is a string or short, etc.

The attributes are really only for informational purposes only.  The user
would not base his decision on the mcc/mnc, but on the operator name.

So before we start changing the D-Bus APIs, we need to answer these two
questions:
  - Can a country/administrative domain have both 001 and 01 MNCs such that
the use of string for the MNC is actually necessary.
  - What does the user find easier to use, a string or a short?

Regards,
-Denis

--===============8171337862635553909==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgUmVtaSw8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIw
NCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij5X
ZWxsLCB0aGUgcG9pbnQgaXMgdGhhdCBsZWFkaW5nIHplcm9lcyBhcmUgbWVhbmluZ2Z1bCAobXVj
aCBsaWtlIHdpdGggcGhvbmU8YnI+CgpudW1iZXJzIGluIGZhY3QpLiBUaGUgQVBJLCBub3QganVz
dCB0aGUgaW1wbGVtZW50YXRpb24sIG11c3QgZGlzdGluZ3Vpc2g8YnI+Cm5ldHdvcmsgJnF1b3Q7
eHkmcXVvdDsgZnJvbSBuZXR3b3JrICZxdW90OzB4eSZxdW90Oywgc28gdGhhdCBtYW51YWwgc2Vs
ZWN0aW9uIHJlbWFpbnMgdW5hbWJpZ3VvdXMuPGJyPgpBIEQtQnVzIHN0cmluZyBpcyBwcm9iYWJs
eSBuaWNlciB0byB1c2UgdGhhbiBhbiBpbnRlZ2VyIHVzaW5nIElTSSYjMzk7cyBCQ0Q8YnI+CnNj
aGVtZTxmb250IGNvbG9yPSIjODg4ODg4Ij48L2ZvbnQ+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPkkg
dW5kZXJzdGFuZCBwZXJmZWN0bHkuoCBCdXQgcmVtZW1iZXIsIG9Gb25vIGRvZXMgbm90IGV4cG9z
ZSB0aGUgdXNlciB0byBzdWNoIGRldGFpbHMuoCBNYW51YWwgcmVnaXN0cmF0aW9uIGlzIGFjY29t
cGxpc2hlZCBieSB1c2luZyBSZWdpc3RlcigpIG1ldGhvZCAod2l0aCBubyBhcmd1bWVudHMpIG9m
IHRoZSBOZXR3b3JrT3BlcmF0b3IgaW50ZXJmYWNlLqAgVGhlIGludGVybmFsIHN0b3JhZ2UgcmVw
cmVzZW50YXRpb24gaXMgbmV2ZXIgZXhwb3NlZC6gIFRodXMgaXQgZG9lc24mIzM5O3QgbWF0dGVy
IHdoZXRoZXIgaW50ZXJuYWxseSBpdCBpcyBhIHN0cmluZyBvciBzaG9ydCwgZXRjLjxicj4KPGJy
PlRoZSBhdHRyaWJ1dGVzIGFyZSByZWFsbHkgb25seSBmb3IgaW5mb3JtYXRpb25hbCBwdXJwb3Nl
cyBvbmx5LqAgVGhlIHVzZXIgd291bGQgbm90IGJhc2UgaGlzIGRlY2lzaW9uIG9uIHRoZSBtY2Mv
bW5jLCBidXQgb24gdGhlIG9wZXJhdG9yIG5hbWUuoCA8YnI+PGJyPlNvIGJlZm9yZSB3ZSBzdGFy
dCBjaGFuZ2luZyB0aGUgRC1CdXMgQVBJcywgd2UgbmVlZCB0byBhbnN3ZXIgdGhlc2UgdHdvIHF1
ZXN0aW9uczo8YnI+CqAgLSBDYW4gYSBjb3VudHJ5L2FkbWluaXN0cmF0aXZlIGRvbWFpbiBoYXZl
IGJvdGggMDAxIGFuZCAwMSBNTkNzIHN1Y2ggdGhhdCB0aGUgdXNlIG9mIHN0cmluZyBmb3IgdGhl
IE1OQyBpcyBhY3R1YWxseSBuZWNlc3NhcnkuPGJyPqAgLSBXaGF0IGRvZXMgdGhlIHVzZXIgZmlu
ZCBlYXNpZXIgdG8gdXNlLCBhIHN0cmluZyBvciBhIHNob3J0Pzxicj48YnI+UmVnYXJkcyw8YnI+
LURlbmlzPGJyPgo8L2Rpdj48L2Rpdj4K

--===============8171337862635553909==--

