Content-Type: multipart/mixed; boundary="===============4184951551052004634=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [PATCH v2] Skip unsolicied CREG/CGREG correctly while checking
 GPRS attach status
Date: Sat, 11 Dec 2010 23:08:15 +0800
Message-ID: <AANLkTinzX7ENN6u_nHtaiptVR8-Kus7AxcbsVKZcPctY@mail.gmail.com>
In-Reply-To: <4D03901D.9060105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4184951551052004634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Dec 11, 2010 at 10:52 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Tonny,
>
> > In your proposed patch, it bypass the unsolicited response only if the
> > 2nd number after +CGREG: is not single digit, however if the lac is
> > single digit, we will still get the wrong state number.
>
> The lac is given as a 2 byte number and should always be printed as four
> hexadecimal letters.  If this is not the case, then you should have a
> serious talk with your vendor.
>

Well, if this (i.e. lac are 4 hex-digits) is the case, then I totally agree
with you that it could ignore unsolicited response properly in
at_util_parse_reg() for my case.  Thank you so much for the coach :)

Best Regards,
Tonny

--===============4184951551052004634==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gU2F0LCBEZWMgMTEs
IDIwMTAgYXQgMTA6NTIgUE0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4OyI+CkhpIFRvbm55LDxicj4KPGRpdiBjbGFzcz0iaW0iPjxicj4KJmd0OyBJbiB5b3VyIHBy
b3Bvc2VkIHBhdGNoLCBpdCBieXBhc3MgdGhlIHVuc29saWNpdGVkIHJlc3BvbnNlIG9ubHkgaWYg
dGhlPGJyPgomZ3Q7IDJuZCBudW1iZXIgYWZ0ZXIgK0NHUkVHOiBpcyBub3Qgc2luZ2xlIGRpZ2l0
LCBob3dldmVyIGlmIHRoZSBsYWMgaXM8YnI+CiZndDsgc2luZ2xlIGRpZ2l0LCB3ZSB3aWxsIHN0
aWxsIGdldCB0aGUgd3Jvbmcgc3RhdGUgbnVtYmVyLjxicj4KPGJyPgo8L2Rpdj5UaGUgbGFjIGlz
IGdpdmVuIGFzIGEgMiBieXRlIG51bWJlciBhbmQgc2hvdWxkIGFsd2F5cyBiZSBwcmludGVkIGFz
IGZvdXI8YnI+CmhleGFkZWNpbWFsIGxldHRlcnMuIKBJZiB0aGlzIGlzIG5vdCB0aGUgY2FzZSwg
dGhlbiB5b3Ugc2hvdWxkIGhhdmUgYTxicj4Kc2VyaW91cyB0YWxrIHdpdGggeW91ciB2ZW5kb3Iu
PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PldlbGwsIGlmIHRoaXMgKGkuZS4g
bGFjIGFyZSA0IGhleC1kaWdpdHMpIGlzIHRoZSBjYXNlLCB0aGVuIEkgdG90YWxseSBhZ3JlZSB3
aXRoIHlvdSB0aGF0IGl0IGNvdWxkIGlnbm9yZSB1bnNvbGljaXRlZCByZXNwb25zZSBwcm9wZXJs
eSBpbiBhdF91dGlsX3BhcnNlX3JlZygpIGZvciBteSBjYXNlLiCgVGhhbmsgeW91IHNvIG11Y2gg
Zm9yIHRoZSBjb2FjaCA6KTwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgUmVnYXJkcyw8
L2Rpdj48ZGl2PlRvbm55PC9kaXY+PC9kaXY+Cg==

--===============4184951551052004634==--

