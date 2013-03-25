Content-Type: multipart/mixed; boundary="===============3065477615587302020=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: Re: [PATCH v3 00/13] Add support for BlueZ 5 Profile1 API to dundee
Date: Mon, 25 Mar 2013 11:43:09 -0300
Message-ID: <CAG7KCRHHKkd6jStROGh+-6R8ff-6-vsj+E8E8D0J4kLm++djKg@mail.gmail.com>
In-Reply-To: <514EF237.3050801@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3065477615587302020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sun, Mar 24, 2013 at 9:31 AM, Daniel Wagner <wagi@monom.org> wrote:

> Hi Paulo,
>
> I have pushed all patches except patch #3. "dun_gw: Add BlueZ 5 version"
> from Fr=C3=A9d=C3=A9ric just added recently the definition for DUN_GW_UUI=
D.
> Obviously, I needed to update your patches to use DUN_GW_UUID instead of
> DUN_UUID. The bluez4.c file also uses DUN_GW_UUID as identifier.
>
> Thanks a lot,
> daniel
>

Actually, DUN profile is "asymmetric": it doesn't have an UUID for each
role, they share the same UUID [1]. The only way to distinguish the current
role is to specify it when registering the profile with
bt_register_profile_with_role function.

Specifying the role when registering a DUN profile is important because
only GW should expose a SDP record.

[1]
https://www.bluetooth.org/Technical/AssignedNumbers/service_discovery.htm

Cheers,
Paulo Borges

--===============3065477615587302020==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGFuaWVsLDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFN1biwgTWFyIDI0
LCAyMDEzIGF0IDk6MzEgQU0sIERhbmllbCBXYWduZXIgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86d2FnaUBtb25vbS5vcmciIHRhcmdldD0iX2JsYW5rIj53YWdpQG1vbm9tLm9y
ZzwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+CgpIaSBQYXVsbyw8YnI+Cjxicj4KSSBoYXZlIHB1c2hlZCBhbGwgcGF0
Y2hlcyBleGNlcHQgcGF0Y2ggIzMuICZxdW90O2R1bl9ndzogQWRkIEJsdWVaIDUgdmVyc2lvbiZx
dW90OyBmcm9tIEZy6WTpcmljIGp1c3QgYWRkZWQgcmVjZW50bHkgdGhlIGRlZmluaXRpb24gZm9y
IERVTl9HV19VVUlELiBPYnZpb3VzbHksIEkgbmVlZGVkIHRvIHVwZGF0ZSB5b3VyIHBhdGNoZXMg
dG8gdXNlIERVTl9HV19VVUlEIGluc3RlYWQgb2YgRFVOX1VVSUQuIFRoZSBibHVlejQuYyBmaWxl
IGFsc28gdXNlcyBEVU5fR1dfVVVJRCBhcyBpZGVudGlmaWVyLjxicj4KCgo8YnI+ClRoYW5rcyBh
IGxvdCw8YnI+CmRhbmllbDxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48ZGl2PkFjdHVhbGx5
LCBEVU4gcHJvZmlsZSBpcyAmcXVvdDs8c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzcHgiPmFzeW1t
ZXRyaWMmcXVvdDs6IGl0IGRvZXNuJiMzOTt0IGhhdmUgYW4gVVVJRCBmb3IgZWFjaCByb2xlLCB0
aGV5IHNoYXJlIHRoZSBzYW1lIFVVSUQgWzFdLiBUaGUgb25seSB3YXkgdG8gZGlzdGluZ3Vpc2gg
dGhlIGN1cnJlbnQgcm9sZSBpcyB0byBzcGVjaWZ5IGl0IHdoZW4gcmVnaXN0ZXJpbmcgdGhlIHBy
b2ZpbGUgd2l0aCBidF9yZWdpc3Rlcl9wcm9maWxlX3dpdGhfcm9sZSBmdW5jdGlvbi48L3NwYW4+
PC9kaXY+Cgo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTNweCI+PGJyPjwvc3Bhbj48L2Rp
dj48ZGl2PlNwZWNpZnlpbmcgdGhlIHJvbGUgd2hlbiByZWdpc3RlcmluZyBhIERVTiBwcm9maWxl
IGlzIGltcG9ydGFudCBiZWNhdXNlIG9ubHkgR1cgc2hvdWxkIGV4cG9zZSBhIFNEUCByZWNvcmQu
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzcHgiPjxicj4KPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxM3B4Ij5bMV2gPC9zcGFuPjxhIGhyZWY9Imh0
dHBzOi8vd3d3LmJsdWV0b290aC5vcmcvVGVjaG5pY2FsL0Fzc2lnbmVkTnVtYmVycy9zZXJ2aWNl
X2Rpc2NvdmVyeS5odG0iIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5ibHVldG9vdGgub3Jn
L1RlY2huaWNhbC9Bc3NpZ25lZE51bWJlcnMvc2VydmljZV9kaXNjb3ZlcnkuaHRtPC9hPjwvZGl2
PgoKPGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzcHgiPjxicj48L3NwYW4+PC9kaXY+PGRp
dj5DaGVlcnMsPC9kaXY+PGRpdj5QYXVsbyBCb3JnZXM8L2Rpdj4K

--===============3065477615587302020==--

