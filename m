Content-Type: multipart/mixed; boundary="===============4097394225743753368=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [PATCH 3/4] doc: detail PinRetries property
Date: Tue, 21 Dec 2010 13:18:42 +0530
Message-ID: <AANLkTik8MdXWCzokoHfo4PvC2kA0HEf0rBLfMXcrgKM2@mail.gmail.com>
In-Reply-To: <1292882198-13736-3-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4097394225743753368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue, Dec 21, 2010 at 3:26 AM, Lucas De Marchi <
lucas.demarchi@profusion.mobi> wrote:

> ---
>  doc/sim-api.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/doc/sim-api.txt b/doc/sim-api.txt
> index d4d2b1b..c7d1faa 100644
> --- a/doc/sim-api.txt
> +++ b/doc/sim-api.txt
> @@ -145,3 +145,13 @@ Properties boolean Present [readonly]
>
>                        If BDN is enabled, oFono halts the SIM
> initialization
>                        procedure and only emergency calls are allowed.
> +
> +               byte PinRetries [readonly]
> +
> +                       Contains the retry counter for the current requir=
ed
> +                       pin. This counter is tipically decremented whenev=
er
> a
> +                       call to EnterPin() fails.
> +
> +                       E.g.: if PinRequired is equal "puk", this property
> +                       contains the number of times EnterPin can be call=
ed
> +                       with a wrong puk.
>
Does this property also mention how many retries are possible when the user
enters a wrong PUK for unblocking the sim pin.

Thanks,
Sankar.

> --
> 1.7.3.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============4097394225743753368==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgTHVjYXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVHVlLCBEZWMgMjEs
IDIwMTAgYXQgMzoyNiBBTSwgTHVjYXMgRGUgTWFyY2hpIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEg
aHJlZj0ibWFpbHRvOmx1Y2FzLmRlbWFyY2hpQHByb2Z1c2lvbi5tb2JpIj5sdWNhcy5kZW1hcmNo
aUBwcm9mdXNpb24ubW9iaTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAy
MDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+
Ci0tLTxicj4KoGRvYy9zaW0tYXBpLnR4dCB8IKAgMTAgKysrKysrKysrKzxicj4KoDEgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+Cjxicj4KZGlmZiAt
LWdpdCBhL2RvYy9zaW0tYXBpLnR4dCBiL2RvYy9zaW0tYXBpLnR4dDxicj4KaW5kZXggZDRkMmIx
Yi4uYzdkMWZhYSAxMDA2NDQ8YnI+Ci0tLSBhL2RvYy9zaW0tYXBpLnR4dDxicj4KKysrIGIvZG9j
L3NpbS1hcGkudHh0PGJyPgpAQCAtMTQ1LDMgKzE0NSwxMyBAQCBQcm9wZXJ0aWVzIGJvb2xlYW4g
UHJlc2VudCBbcmVhZG9ubHldPGJyPgo8YnI+CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoElmIEJE
TiBpcyBlbmFibGVkLCBvRm9ubyBoYWx0cyB0aGUgU0lNIGluaXRpYWxpemF0aW9uPGJyPgogoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKBwcm9jZWR1cmUgYW5kIG9ubHkgZW1lcmdlbmN5IGNhbGxzIGFy
ZSBhbGxvd2VkLjxicj4KKzxicj4KKyCgIKAgoCCgIKAgoCCgIGJ5dGUgUGluUmV0cmllcyBbcmVh
ZG9ubHldPGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBDb250YWlucyB0aGUgcmV0
cnkgY291bnRlciBmb3IgdGhlIGN1cnJlbnQgcmVxdWlyZWQ8YnI+CisgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIHBpbi4gVGhpcyBjb3VudGVyIGlzIHRpcGljYWxseSBkZWNyZW1lbnRlZCB3aGVuZXZl
ciBhPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBjYWxsIHRvIEVudGVyUGluKCkgZmFpbHMu
PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBFLmcuOiBpZiBQaW5SZXF1aXJlZCBp
cyBlcXVhbCAmcXVvdDtwdWsmcXVvdDssIHRoaXMgcHJvcGVydHk8YnI+CisgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIGNvbnRhaW5zIHRoZSBudW1iZXIgb2YgdGltZXMgRW50ZXJQaW4gY2FuIGJlIGNh
bGxlZDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgd2l0aCBhIHdyb25nIHB1ay48YnI+PC9i
bG9ja3F1b3RlPjxkaXY+RG9lcyB0aGlzIHByb3BlcnR5IGFsc28gbWVudGlvbiBob3cgbWFueSBy
ZXRyaWVzIGFyZSBwb3NzaWJsZSB3aGVuIHRoZSB1c2VyIGVudGVycyBhIHdyb25nIFBVSyBmb3Ig
dW5ibG9ja2luZyB0aGUgc2ltIHBpbi48YnI+PGJyPlRoYW5rcyw8YnI+U2Fua2FyLjxicj48L2Rp
dj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBh
ZGRpbmctbGVmdDogMWV4OyI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLTxicj4KMS43LjMuNDxi
cj4KPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxi
cj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3Jn
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3Jn
L2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9s
aXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============4097394225743753368==--

