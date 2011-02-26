Content-Type: multipart/mixed; boundary="===============8114256516523317499=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: Re: ofono crash (setting offline while connected)
Date: Sat, 26 Feb 2011 11:21:03 +0530
Message-ID: <AANLkTinXKYT0=DbhwtB5kXdu8fR=Of5zfp2Sh9xaDhXk@mail.gmail.com>
In-Reply-To: <4D6695F7.2080607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8114256516523317499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I tried several things but no luck. Here I am attaching the backtrace as you
suggested. What I found is, ofono crashes on
`ofono_gprs_context_remove(data->gc)` call when `linktop_disconnect` was
called second time. I am still not sure why `linktop_disconnect` is being
called twice in this case.

Regards
--
Amit Mendapara

On Thu, Feb 24, 2011 at 11:01 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Amit,
>
> On 02/23/2011 11:07 PM, Amit Mendapara wrote:
> > Hi,
> >
> > While testing the Linktop driver I observed that ofono is crashing if I
> > try to set modem offline while it is connected (using
> > test/offline-modem.py script). After some debugging, I found that
> > `linktop_disconnect` function is being called twice (see the attached
> > debug log).
> >
> > What could be the reason here? I have seen some hack in mbm driver (in
> > mbm_disconnect) having `reopen_callback`. I have tried this but then
> > having another crash (this time when creating gprs context). Anyone,
> > please clarify how to deal with the issue properly?
>
> Some of these modems HUP the tty for x seconds.  So if you try to open
> them too fast, they will be HUPed again, leading to various issues.
>
> When posting backtraces, please give them directly from gdb, or use the
> backtrace script to 'prettify' them.  e.g.:
>
> test/backtrace src/ofonod your_log
>
> Regards,
> -Denis
>

--===============8114256516523317499==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5JIHRyaWVkIHNldmVyYWwgdGhpbmdzIGJ1dCBu
byBsdWNrLiBIZXJlIEkgYW0gYXR0YWNoaW5nIHRoZSBiYWNrdHJhY2UgYXMgeW91IHN1Z2dlc3Rl
ZC4gV2hhdCBJIGZvdW5kIGlzLCBvZm9ubyBjcmFzaGVzIG9uIGBvZm9ub19ncHJzX2NvbnRleHRf
cmVtb3ZlKGRhdGEtJmd0O2djKWAgY2FsbCB3aGVuIGBsaW5rdG9wX2Rpc2Nvbm5lY3RgIHdhcyBj
YWxsZWQgc2Vjb25kIHRpbWUuIEkgYW0gc3RpbGwgbm90IHN1cmUgd2h5IGBsaW5rdG9wX2Rpc2Nv
bm5lY3RgIGlzIGJlaW5nIGNhbGxlZCB0d2ljZSBpbiB0aGlzIGNhc2UuPC9kaXY+CjxkaXY+PGJy
PjwvZGl2PjxkaXY+UmVnYXJkczwvZGl2PjxkaXY+LS08L2Rpdj48ZGl2PkFtaXQgTWVuZGFwYXJh
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gVGh1LCBGZWIgMjQsIDIwMTEgYXQg
MTE6MDEgUE0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWls
dG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdy
b3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPkhp
IEFtaXQsPGJyPgo8ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KT24gMDIvMjMv
MjAxMSAxMTowNyBQTSwgQW1pdCBNZW5kYXBhcmEgd3JvdGU6PGJyPgomZ3Q7IEhpLDxicj4KJmd0
Ozxicj4KJmd0OyBXaGlsZSB0ZXN0aW5nIHRoZSBMaW5rdG9wIGRyaXZlciBJIG9ic2VydmVkIHRo
YXQgb2Zvbm8gaXMgY3Jhc2hpbmcgaWYgSTxicj4KJmd0OyB0cnkgdG8gc2V0IG1vZGVtIG9mZmxp
bmUgd2hpbGUgaXQgaXMgY29ubmVjdGVkICh1c2luZzxicj4KJmd0OyB0ZXN0L29mZmxpbmUtbW9k
ZW0ucHkgc2NyaXB0KS4gQWZ0ZXIgc29tZSBkZWJ1Z2dpbmcsIEkgZm91bmQgdGhhdDxicj4KJmd0
OyBgbGlua3RvcF9kaXNjb25uZWN0YCBmdW5jdGlvbiBpcyBiZWluZyBjYWxsZWQgdHdpY2UgKHNl
ZSB0aGUgYXR0YWNoZWQ8YnI+CiZndDsgZGVidWcgbG9nKS48YnI+CiZndDs8YnI+CiZndDsgV2hh
dCBjb3VsZCBiZSB0aGUgcmVhc29uIGhlcmU/IEkgaGF2ZSBzZWVuIHNvbWUgaGFjayBpbiBtYm0g
ZHJpdmVyIChpbjxicj4KJmd0OyBtYm1fZGlzY29ubmVjdCkgaGF2aW5nIGByZW9wZW5fY2FsbGJh
Y2tgLiBJIGhhdmUgdHJpZWQgdGhpcyBidXQgdGhlbjxicj4KJmd0OyBoYXZpbmcgYW5vdGhlciBj
cmFzaCAodGhpcyB0aW1lIHdoZW4gY3JlYXRpbmcgZ3BycyBjb250ZXh0KS4gQW55b25lLDxicj4K
Jmd0OyBwbGVhc2UgY2xhcmlmeSBob3cgdG8gZGVhbCB3aXRoIHRoZSBpc3N1ZSBwcm9wZXJseT88
YnI+Cjxicj4KPC9kaXY+PC9kaXY+U29tZSBvZiB0aGVzZSBtb2RlbXMgSFVQIHRoZSB0dHkgZm9y
IHggc2Vjb25kcy4goFNvIGlmIHlvdSB0cnkgdG8gb3Blbjxicj4KdGhlbSB0b28gZmFzdCwgdGhl
eSB3aWxsIGJlIEhVUGVkIGFnYWluLCBsZWFkaW5nIHRvIHZhcmlvdXMgaXNzdWVzLjxicj4KPGJy
PgpXaGVuIHBvc3RpbmcgYmFja3RyYWNlcywgcGxlYXNlIGdpdmUgdGhlbSBkaXJlY3RseSBmcm9t
IGdkYiwgb3IgdXNlIHRoZTxicj4KYmFja3RyYWNlIHNjcmlwdCB0byAmIzM5O3ByZXR0aWZ5JiMz
OTsgdGhlbS4goGUuZy46PGJyPgo8YnI+CnRlc3QvYmFja3RyYWNlIHNyYy9vZm9ub2QgeW91cl9s
b2c8YnI+Cjxicj4KUmVnYXJkcyw8YnI+Cjxmb250IGNvbG9yPSIjODg4ODg4Ij4tRGVuaXM8YnI+
CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============8114256516523317499==
Content-Type: text/x-log
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="backtrace.log"

LS0tLS0tLS0gYmFja3RyYWNlIC0tLS0tLS0tClswXTogX19vZm9ub19hdG9tX2ZyZWUoKSBbbW9k
ZW0uYzozMzZdClsxXTogbGlua3RvcF9kaXNjb25uZWN0KCkgW2xpbmt0b3AuYzoxNDddClsyXTog
bWFpbigpIFttYWluLmM6MjQ1XQpbM106IF9zdGFydCgpIFtsb2NhdGlvbi1yZXBvcnRpbmcuYzow
XQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K

--===============8114256516523317499==--

