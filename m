Content-Type: multipart/mixed; boundary="===============8565617526423881000=="
MIME-Version: 1.0
From: Fabio <fabio.tosetti@gmail.com>
Subject: Re: u-blox modem plugin: missing VoiceCallManager and MessageManager
 interfaces
Date: Tue, 08 Sep 2015 12:43:03 +0000
Message-ID: <CAJvjxsxgMBjBmkoMTyH9ufuvR+tedM9e4CFPs=XsgPNYTggSkw@mail.gmail.com>
In-Reply-To: <55ED9952.6050405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8565617526423881000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,
I've added the voicecall and sms atoms, respectively in the pre_sim and
post_sim functions.

The MessageManager works fine, but sometimes I don't get the
"MessageRemoved" notification, and the sms is delivered or not to the
recipient depending on some condition I can't understand.

I'm facing to some issues also with the VoiceCallManager: an "incoming"
(and answered) voicecall is never notified as "terminated" when the caller
phone hangs-up.

I will submit a patch when I solve these problems.
If someone have any idea, please let me know.

Regards,
FabioT


Il giorno lun 7 set 2015 alle ore 16:04 Denis Kenzior <denkenz@gmail.com>
ha scritto:

> Hi Fabio,
>
> On 09/07/2015 02:08 AM, Fabio wrote:
> > Hello,
> > I'm using the u-blox driver with a LISA-U200 modem: the modem is
> > correctly detected, registers to the network, connects to vodafone apn
> > and browses Internet.
> > My problem is that the VoiceCallManager and MessageManager interfaces
> > are not exposed, and I need to send sms and make calls.
>
> The current u-blox driver does not instantiate the voicecall or sms
> atoms.  Someone (that has access to these devices) will have to write
> supporting code to enable the missing features.  Patches are always
> welcome :)
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============8565617526423881000==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48c3BhbiBzdHlsZT0ibGluZS1oZWlnaHQ6MS41O2ZvbnQtc2l6
ZToxMy4ycHgiPkhlbGxvIERlbmlzLDwvc3Bhbj48L2Rpdj48c3BhbiBzdHlsZT0ibGluZS1oZWln
aHQ6MS41O2ZvbnQtc2l6ZToxMy4ycHgiPkkmIzM5O3ZlIGFkZGVkIHRoZSB2b2ljZWNhbGwgYW5k
IHNtcyBhdG9tcywgcmVzcGVjdGl2ZWx5IGluIHRoZSBwcmVfc2ltIGFuZCBwb3N0X3NpbSBmdW5j
dGlvbnMuPC9zcGFuPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMy4ycHg7bGluZS1oZWln
aHQ6MTkuOHB4Ij48YnI+PC9zcGFuPjxkaXY+VGhlIE1lc3NhZ2VNYW5hZ2VyIHdvcmtzIGZpbmUs
IGJ1dCBzb21ldGltZXMgSSBkb24mIzM5O3QgZ2V0IHRoZSAmcXVvdDtNZXNzYWdlUmVtb3ZlZCZx
dW90OyBub3RpZmljYXRpb24sIGFuZCB0aGUgc21zIGlzIGRlbGl2ZXJlZCBvciBub3QgdG8gdGhl
IHJlY2lwaWVudCBkZXBlbmRpbmcgb24gc29tZSBjb25kaXRpb24gSSBjYW4mIzM5O3QgdW5kZXJz
dGFuZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20gZmFjaW5nIHRvIHNvbWUgaXNz
dWVzIGFsc28gd2l0aCB0aGXCoDxzcGFuIHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVp
Z2h0OjE5LjhweCI+Vm9pY2VDYWxsTWFuYWdlcjogYW4gJnF1b3Q7aW5jb21pbmcmcXVvdDsgKGFu
ZCBhbnN3ZXJlZCkgdm9pY2VjYWxsIGlzIG5ldmVyIG5vdGlmaWVkIGFzICZxdW90O3Rlcm1pbmF0
ZWQmcXVvdDsgd2hlbiB0aGUgY2FsbGVyIHBob25lIGhhbmdzLXVwLjwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0OjE5LjhweCI+PGJyPjwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0
OjE5LjhweCI+SSB3aWxsIHN1Ym1pdCBhIHBhdGNoIHdoZW4gSSBzb2x2ZSB0aGVzZSBwcm9ibGVt
cy48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhl
aWdodDoxOS44cHgiPklmIHNvbWVvbmUgaGF2ZSBhbnkgaWRlYSwgcGxlYXNlIGxldCBtZSBrbm93
Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVp
Z2h0OjE5LjhweCI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTMuMnB4O2xpbmUtaGVpZ2h0OjE5LjhweCI+UmVnYXJkcyw8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjEzLjJweDtsaW5lLWhlaWdodDoxOS44cHgiPkZhYmlvVDwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTMuMnB4O2xpbmUtaGVpZ2h0OjE5
LjhweCI+PGJyPjwvc3Bhbj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYg
ZGlyPSJsdHIiPklsIGdpb3JubyBsdW4gNyBzZXQgMjAxNSBhbGxlIG9yZSAxNjowNCBEZW5pcyBL
ZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IGhhIHNjcml0dG86PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhpIEZhYmlvLDxicj4KPGJy
PgpPbiAwOS8wNy8yMDE1IDAyOjA4IEFNLCBGYWJpbyB3cm90ZTo8YnI+CiZndDsgSGVsbG8sPGJy
PgomZ3Q7IEkmIzM5O20gdXNpbmcgdGhlIHUtYmxveCBkcml2ZXIgd2l0aCBhIExJU0EtVTIwMCBt
b2RlbTogdGhlIG1vZGVtIGlzPGJyPgomZ3Q7IGNvcnJlY3RseSBkZXRlY3RlZCwgcmVnaXN0ZXJz
IHRvIHRoZSBuZXR3b3JrLCBjb25uZWN0cyB0byB2b2RhZm9uZSBhcG48YnI+CiZndDsgYW5kIGJy
b3dzZXMgSW50ZXJuZXQuPGJyPgomZ3Q7IE15IHByb2JsZW0gaXMgdGhhdCB0aGUgVm9pY2VDYWxs
TWFuYWdlciBhbmQgTWVzc2FnZU1hbmFnZXIgaW50ZXJmYWNlczxicj4KJmd0OyBhcmUgbm90IGV4
cG9zZWQsIGFuZCBJIG5lZWQgdG8gc2VuZCBzbXMgYW5kIG1ha2UgY2FsbHMuPGJyPgo8YnI+ClRo
ZSBjdXJyZW50IHUtYmxveCBkcml2ZXIgZG9lcyBub3QgaW5zdGFudGlhdGUgdGhlIHZvaWNlY2Fs
bCBvciBzbXM8YnI+CmF0b21zLsKgIFNvbWVvbmUgKHRoYXQgaGFzIGFjY2VzcyB0byB0aGVzZSBk
ZXZpY2VzKSB3aWxsIGhhdmUgdG8gd3JpdGU8YnI+CnN1cHBvcnRpbmcgY29kZSB0byBlbmFibGUg
dGhlIG1pc3NpbmcgZmVhdHVyZXMuwqAgUGF0Y2hlcyBhcmUgYWx3YXlzPGJyPgp3ZWxjb21lIDop
PGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhy
ZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5v
cmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3Rz
Lm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2PjwvZGl2Pgo=

--===============8565617526423881000==--

