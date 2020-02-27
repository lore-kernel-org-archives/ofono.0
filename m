Content-Type: multipart/mixed; boundary="===============6019449221630518616=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: Extending driver
Date: Thu, 27 Feb 2020 08:39:22 +0000
Message-ID: <
 <AM0PR10MB205195275D56585B8C981A8196EB0@AM0PR10MB2051.EURPRD10.PROD.OUTLOOK.COM>>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6019449221630518616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In earlier projects we have copied/renamed and extended modem drivers with =
our own changes in ofono. But now we have a new project where we're thinkin=
g of extending the qmimodem driver, but I feel that there must be a nicer w=
ay to to this than copy/rename. We probably only want to change a few thing=
s and maybe add an extra interface or two. Is there a better way to design =
this in ofono and only extend the files we want to change?

--===============6019449221630518616==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+IFAge21hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjA7fSA8L3N0
eWxlPgo8L2hlYWQ+Cjxib2R5IGRpcj0ibHRyIj4KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IENh
bGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29s
b3I6IHJnYigwLCAwLCAwKTsiPgo8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFy
aWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1
NSwgMjU1KTsgZGlzcGxheTogaW5saW5lICFpbXBvcnRhbnQiPkluIGVhcmxpZXIgcHJvamVjdHMg
d2UgaGF2ZSBjb3BpZWQvcmVuYW1lZCBhbmQgZXh0ZW5kZWQgbW9kZW0gZHJpdmVycyB3aXRoIG91
ciBvd24gY2hhbmdlcyBpbiBvZm9uby4gQnV0IG5vdyB3ZSBoYXZlIGEgbmV3IHByb2plY3QKIHdo
ZXJlIHdlJ3JlIHRoaW5raW5nIG9mIGV4dGVuZGluZyB0aGUgcW1pbW9kZW0gZHJpdmVyLCBidXQg
SSBmZWVsIHRoYXQgdGhlcmUgbXVzdCBiZSBhIG5pY2VyIHdheSB0byB0byB0aGlzIHRoYW4gY29w
eS9yZW5hbWUuIFdlIHByb2JhYmx5IG9ubHkgd2FudCB0byBjaGFuZ2UgYSBmZXcgdGhpbmdzIGFu
ZCBtYXliZSBhZGQgYW4gZXh0cmEgaW50ZXJmYWNlIG9yIHR3by4gSXMgdGhlcmUgYSBiZXR0ZXIg
d2F5IHRvIGRlc2lnbiB0aGlzIGluIG9mb25vCiBhbmQgb25seSBleHRlbmQgdGhlIGZpbGVzIHdl
IHdhbnQgdG8gY2hhbmdlPzwvc3Bhbj48YnI+CjwvZGl2Pgo8L2JvZHk+CjwvaHRtbD4K

--===============6019449221630518616==--

