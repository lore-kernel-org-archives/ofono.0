Content-Type: multipart/mixed; boundary="===============8668315486343406428=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH v2 3/3] Revert "gprs: _cid_activated is an 'attaching'
 state"
Date: Wed, 21 Aug 2019 17:55:38 +0200
Message-ID: <CAHB-Pjn7nJf9shc4NwJVq6jvwgX95hUwdGnoYxjOwHVS7NpgSg@mail.gmail.com>
In-Reply-To: <4a96c48e-91aa-0948-0dbc-d0fe8a7d3310@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8668315486343406428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Den ons 21 aug. 2019 kl 08:01 skrev Jonas Bonn <jonas@norrbonn.se>:

> Hi Richard,
>
> On 20/08/2019 17:56, richard.rojfors(a)gmail.com wrote:
> > From: Richard R=C3=B6jfors <richard@puffinpack.se>
> >
> > This reverts commit 1fd419e5b4b3a87673f8e0219edb0f3ed9fca774.
>
> This patch is fine and certainly necessary in the context of this
> series.  Posting it as a 'revert', however, is a bit unsavoury.
>
> A reverted patch implies that it was somehow wrong or inappropriate.
> That's not the case here.  This code has become superfluous in the face
> of other changes that have been made in the tree.
>

I agree, this did not introduce any obvious bug, but the other revert did.


>
> Just squash these two revert patches into one "forward looking" patch.
> The fact that the change effectively constitutes a 'revert' is moot.
>

For me it doesn't matter its the same effect.

Denis, whats your opinion?
I think you have the final say.

--Richard

--===============8668315486343406428==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBKb25hcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gb25zIDIxIGF1Zy4g
MjAxOSBrbCAwODowMSBza3JldiBKb25hcyBCb25uICZsdDs8YSBocmVmPSJtYWlsdG86am9uYXNA
bm9ycmJvbm4uc2UiPmpvbmFzQG5vcnJib25uLnNlPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5I
aSBSaWNoYXJkLDxicj4KPGJyPgpPbiAyMC8wOC8yMDE5IDE3OjU2LCA8YSBocmVmPSJtYWlsdG86
cmljaGFyZC5yb2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9qZm9y
c0BnbWFpbC5jb208L2E+IHdyb3RlOjxicj4KJmd0OyBGcm9tOiBSaWNoYXJkIFLDtmpmb3JzICZs
dDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBwdWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFuayI+
cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IFRoaXMgcmV2
ZXJ0cyBjb21taXQgMWZkNDE5ZTViNGIzYTg3NjczZjhlMDIxOWVkYjBmM2VkOWZjYTc3NC48YnI+
Cjxicj4KVGhpcyBwYXRjaCBpcyBmaW5lIGFuZCBjZXJ0YWlubHkgbmVjZXNzYXJ5IGluIHRoZSBj
b250ZXh0IG9mIHRoaXMgPGJyPgpzZXJpZXMuwqAgUG9zdGluZyBpdCBhcyBhICYjMzk7cmV2ZXJ0
JiMzOTssIGhvd2V2ZXIsIGlzIGEgYml0IHVuc2F2b3VyeS48YnI+Cjxicj4KQSByZXZlcnRlZCBw
YXRjaCBpbXBsaWVzIHRoYXQgaXQgd2FzIHNvbWVob3cgd3Jvbmcgb3IgaW5hcHByb3ByaWF0ZS4g
PGJyPgpUaGF0JiMzOTtzIG5vdCB0aGUgY2FzZSBoZXJlLsKgIFRoaXMgY29kZSBoYXMgYmVjb21l
IHN1cGVyZmx1b3VzIGluIHRoZSBmYWNlIDxicj4Kb2Ygb3RoZXIgY2hhbmdlcyB0aGF0IGhhdmUg
YmVlbiBtYWRlIGluIHRoZSB0cmVlLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj5JIGFncmVlLCB0aGlzIGRpZCBub3QgaW50cm9kdWNlIGFueSBvYnZpb3VzIGJ1ZywgYnV0IHRo
ZSBvdGhlciByZXZlcnQgZGlkLjxicj7CoDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KSnVzdCBzcXVh
c2ggdGhlc2UgdHdvIHJldmVydCBwYXRjaGVzIGludG8gb25lICZxdW90O2ZvcndhcmQgbG9va2lu
ZyZxdW90OyBwYXRjaC4gPGJyPgpUaGUgZmFjdCB0aGF0IHRoZSBjaGFuZ2UgZWZmZWN0aXZlbHkg
Y29uc3RpdHV0ZXMgYSAmIzM5O3JldmVydCYjMzk7IGlzIG1vb3QuPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PkZvciBtZSBpdCBkb2VzbiYjMzk7dCBtYXR0ZXIgaXRzIHRoZSBz
YW1lIGVmZmVjdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRlbmlzLCB3aGF0cyB5b3VyIG9w
aW5pb24/PC9kaXY+PGRpdj5JIHRoaW5rIHlvdSBoYXZlIHRoZSBmaW5hbCBzYXkuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj4tLVJpY2hhcmTCoDxicj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============8668315486343406428==--

