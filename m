Content-Type: multipart/mixed; boundary="===============0453925590987028697=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 18:58:54 +0200
Message-ID: <CAKSBH7FArA-k3LVpH7qkAFO3dYcqs8-Ftj5f1d7Y6-uau8ir-g@mail.gmail.com>
In-Reply-To: <15b88dc7-f0bc-67c7-3963-5339f4c45613@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0453925590987028697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 6:54 PM Slava Monich <slava.monich@jolla.com> wro=
te:

> On 19/09/18 19:32, Denis Kenzior wrote:
> > Hi Slava,
> >
> >> Anything in include is external API. We do maintain not just
> >> out-of-tree, but binary plugins. Backward (binary!) compatibility a
> >> must for us. Please do not break it.
> >
> > That is why we have 'OFONO_API_SUBJECT_TO_CHANGE' as a reminder. We
> > mean it.  D-Bus API is stable, we never made any guarantees about the
> > internal APIs.
> >
>
> I understand that! It makes things easier for you guys.
>
> But we had to avoid certain compile-time dependencies in ofono, and a
> straightforward (and perhaps the only) way to achieve that was to use
> binary plugins. For us plugin API is not subject to change (plugins
> don't necessarily get upgraded together with ofono), meaning more
> changes between our fork and upstream in case if upstream breaks it,
> more maintenance work and more room for errors. Obviously, I would like
> to keep differences to a minimum.
>
> I'm just humbly asking - if there's a way to keep plugin API backward
> compatible, please do it that way. There is at least one person in the
> world who would appreciate it.
>
>
Hi Slava,

this special case will not be backward compatible.
This enum for the authentication methods is handled through switch/cases in
the code, and some of them miss default. so an additional value will give
an unpredictable behavior (depending also on how the switch has been
optimized by the compiler).

Do you think it still makes sense to add an OFONO_GPRS_AUTH_METHOD_ANY ?
It looks like Denis will not take it anyway if it is not explained clearly
what it is for and how it is used. I have to say, I cannot see its benefit
either.


> Cheers,
> -Slava
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


BR,
Giacinto

--===============0453925590987028697==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgNjo1NCBQTSBTbGF2YSBNb25pY2ggJmx0Ozxh
IGhyZWY9Im1haWx0bzpzbGF2YS5tb25pY2hAam9sbGEuY29tIj5zbGF2YS5tb25pY2hAam9sbGEu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPk9uIDE5LzA5LzE4IDE5OjMyLCBEZW5pcyBLZW56aW9yIHdyb3RlOjxi
cj4KJmd0OyBIaSBTbGF2YSw8YnI+CiZndDs8YnI+CiZndDsmZ3Q7IEFueXRoaW5nIGluIGluY2x1
ZGUgaXMgZXh0ZXJuYWwgQVBJLiBXZSBkbyBtYWludGFpbiBub3QganVzdCA8YnI+CiZndDsmZ3Q7
IG91dC1vZi10cmVlLCBidXQgYmluYXJ5IHBsdWdpbnMuIEJhY2t3YXJkIChiaW5hcnkhKSBjb21w
YXRpYmlsaXR5IGEgPGJyPgomZ3Q7Jmd0OyBtdXN0IGZvciB1cy4gUGxlYXNlIGRvIG5vdCBicmVh
ayBpdC48YnI+CiZndDs8YnI+CiZndDsgVGhhdCBpcyB3aHkgd2UgaGF2ZSAmIzM5O09GT05PX0FQ
SV9TVUJKRUNUX1RPX0NIQU5HRSYjMzk7IGFzIGEgcmVtaW5kZXIuIFdlIDxicj4KJmd0OyBtZWFu
IGl0LsKgIEQtQnVzIEFQSSBpcyBzdGFibGUsIHdlIG5ldmVyIG1hZGUgYW55IGd1YXJhbnRlZXMg
YWJvdXQgdGhlIDxicj4KJmd0OyBpbnRlcm5hbCBBUElzLjxicj4KJmd0Ozxicj4KPGJyPgpJIHVu
ZGVyc3RhbmQgdGhhdCEgSXQgbWFrZXMgdGhpbmdzIGVhc2llciBmb3IgeW91IGd1eXMuPGJyPgo8
YnI+CkJ1dCB3ZSBoYWQgdG8gYXZvaWQgY2VydGFpbiBjb21waWxlLXRpbWUgZGVwZW5kZW5jaWVz
IGluIG9mb25vLCBhbmQgYSA8YnI+CnN0cmFpZ2h0Zm9yd2FyZCAoYW5kIHBlcmhhcHMgdGhlIG9u
bHkpIHdheSB0byBhY2hpZXZlIHRoYXQgd2FzIHRvIHVzZSA8YnI+CmJpbmFyeSBwbHVnaW5zLiBG
b3IgdXMgcGx1Z2luIEFQSSBpcyBub3Qgc3ViamVjdCB0byBjaGFuZ2UgKHBsdWdpbnMgPGJyPgpk
b24mIzM5O3QgbmVjZXNzYXJpbHkgZ2V0IHVwZ3JhZGVkIHRvZ2V0aGVyIHdpdGggb2Zvbm8pLCBt
ZWFuaW5nIG1vcmUgPGJyPgpjaGFuZ2VzIGJldHdlZW4gb3VyIGZvcmsgYW5kIHVwc3RyZWFtIGlu
IGNhc2UgaWYgdXBzdHJlYW0gYnJlYWtzIGl0LCA8YnI+Cm1vcmUgbWFpbnRlbmFuY2Ugd29yayBh
bmQgbW9yZSByb29tIGZvciBlcnJvcnMuIE9idmlvdXNseSwgSSB3b3VsZCBsaWtlIDxicj4KdG8g
a2VlcCBkaWZmZXJlbmNlcyB0byBhIG1pbmltdW0uPGJyPgo8YnI+CkkmIzM5O20ganVzdCBodW1i
bHkgYXNraW5nIC0gaWYgdGhlcmUmIzM5O3MgYSB3YXkgdG8ga2VlcCBwbHVnaW4gQVBJIGJhY2t3
YXJkIDxicj4KY29tcGF0aWJsZSwgcGxlYXNlIGRvIGl0IHRoYXQgd2F5LiBUaGVyZSBpcyBhdCBs
ZWFzdCBvbmUgcGVyc29uIGluIHRoZSA8YnI+CndvcmxkIHdobyB3b3VsZCBhcHByZWNpYXRlIGl0
Ljxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkhpIFNsYXZhLDwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+dGhpcyBzcGVjaWFsIGNhc2Ugd2lsbCBub3QgYmUgYmFja3dh
cmQgY29tcGF0aWJsZS48L2Rpdj48ZGl2PlRoaXMgZW51bSBmb3IgdGhlIGF1dGhlbnRpY2F0aW9u
IG1ldGhvZHMgaXMgaGFuZGxlZCB0aHJvdWdoIHN3aXRjaC9jYXNlcyBpbiB0aGUgY29kZSwgYW5k
IHNvbWUgb2YgdGhlbSBtaXNzIGRlZmF1bHQuIHNvIGFuIGFkZGl0aW9uYWwgdmFsdWUgd2lsbCBn
aXZlIGFuIHVucHJlZGljdGFibGUgYmVoYXZpb3IgKGRlcGVuZGluZyBhbHNvIG9uIGhvdyB0aGUg
c3dpdGNoIGhhcyBiZWVuIG9wdGltaXplZCBieSB0aGUgY29tcGlsZXIpLjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+RG8geW91IHRoaW5rIGl0IHN0aWxsIG1ha2VzIHNlbnNlIHRvIGFkZCBhbiBP
Rk9OT19HUFJTX0FVVEhfTUVUSE9EX0FOWSA/PC9kaXY+PGRpdj5JdCBsb29rcyBsaWtlIERlbmlz
IHdpbGwgbm90IHRha2UgaXQgYW55d2F5IGlmIGl0IGlzIG5vdCBleHBsYWluZWQgY2xlYXJseSB3
aGF0IGl0IGlzIGZvciBhbmQgaG93IGl0IGlzIHVzZWQuIEkgaGF2ZSB0byBzYXksIEkgY2Fubm90
IHNlZSBpdHMgYmVuZWZpdCBlaXRoZXIuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFw
eCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpDaGVlcnMsPGJyPgotU2xhdmE8YnI+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBt
YWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0i
X2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9m
b25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9h
PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkJSLDxicj5HaWFjaW50bzwvZGl2Pjxk
aXY+wqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============0453925590987028697==--

