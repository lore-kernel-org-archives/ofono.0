Content-Type: multipart/mixed; boundary="===============9105409455158219119=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 19 Feb 2020 11:41:09 +0100
Message-ID: <CAHB-Pjm6HLEcobwDnS5sgvg6vL_FxemUGZb4mcp82UmbDLO-SQ@mail.gmail.com>
In-Reply-To: <CAKSBH7H9tb3fZuOhNbF04Wnx542m8uCyAy4R9SPy2XVoLWL4Vw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9105409455158219119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giancinto

Den ons 19 feb. 2020 kl 11:05 skrev Giacinto Cifelli <gciofono@gmail.com>:

> Hi Richard,
>
> On Wed, Feb 19, 2020 at 10:06 AM Richard R=C3=B6jfors
> <richard.rojfors@gmail.com> wrote:
> >
> > Hi Giancinto,
> >
> > Den tis 18 feb. 2020 kl 20:27 skrev Giacinto Cifelli <gciofono@gmail.=
com
> >:
> >>
> >> Hi Richard,
> >>
> >> On Tue, Feb 18, 2020 at 10:19 AM Richard R=C3=B6jfors
> >> <richard.rojfors@gmail.com> wrote:
> >> >
> >> > Hi,
> >> >
> >> > Ofono (at least for ublox) is always powering off the radio during
> start.
> >> > This can of course be handy of programmatic reasons to bring the
> modem to a known state.
> >> > Some configuration requires the radio to be turned off;  for instance
> the LTE auto connect APN. But on the other hand these are stored in
> non-volatile memory and could be configured before hand.
> >> >
> >> > The big drawback with turning it off is that it might take time to
> register again when the radio is on. I have seen it taking more than 10
> minutes in extreme cases.
> >> >
> >> > In embedded systems this can be a big issue.
> >> >
> >> > I'm thinking of adding a configuration option to keep the radio on
> during start.
> >> >
> >> > Whats the general thought about this?
> >>
> >> my opinion would be to keep it like that.
> >> it can generate several headaches for several use cases, and break
> >> existing code.
> >
> >
> > Yes I agree that the startup sequence will change, which is risky, but
> > it would be an option for people knowing what they are doing.
> >
> >>
> >> for example when the SIM could change as compared with the previous
> >> boot.
> >
> >
> > When using this option you should know what you are doing. As I said you
> > might need to write settings to non-volatile memory since runtime chang=
es
> > might not apply. And a SIM wont just change in environments where this
> > option should be used.
> >
> >>
> >> Then it becomes much harder to recover from this situation.
> >> it would be better to be able to boot the modem in airplane mode,
> >> directly, so that there is no flip-flop effect.
> >
> >
> > That could be an option, but that will cost up to several seconds of
> time.
> > In the systems I'm talking about the boot loader might kick the modem
> > running to get it registered as quickly as possible.
> >
> >>
> >>
> >> In any case I have never observed 10 minutes.
> >
> >
> > This is not the regular case. But I have observed this.
> >
> >>
> >> If this really happens, either the signal is so low that in any case
> >> the link will be pretty unstable, or the stack needs debugging.
> >
> >
> > I contacted the FAE's from the vendor regarding this. I guess they
> > want to keep the work load down, but their major complaint was
> > the way ofono turns off the radio. And even if they would fix their
> > bugs there will be modems in the field that behaves like this.
> > But regardless; 10min is a super long time, even if its just
> > seconds to save, that could be of importance...
> >
> >
> > I'm not sure its a good idea to introduce this. I need to,
> > but I wanted to check if there was an interest in the general public.
>
> trying is quite easy. In plugins/ublox.c, there are 2 occurrencies of
> "AT+CFUN=3D4":
>  -> change both of them to "AT+CFUN=3D1".
>   (I am not sure whether this will produce an error in case the modem
> is already in CFUN:1, but it is worth trying).
>

Yeah I have done this for a while. The question was not how to do it,
just if there was an interest to get this kind of code upstreamed.

FYI;
It did not work out of the box at that point, since it triggered some
race conditions. These could happen anyway so they are fixed in
upstream ofono.


>
> If you are satisfied, then you can make it conditional with an
>      if (getenv("OFONO_UBLOX_NO_CFUN_FLIP"))
>

That could be a "simple" way of adding the switch.

--Richard

--===============9105409455158219119==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBHaWFuY2ludG88L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gb25zIDE5IGZl
Yi4gMjAyMCBrbCAxMTowNSBza3JldiBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWls
dG86Z2Npb2Zvbm9AZ21haWwuY29tIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0Ozo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPkhpIFJpY2hhcmQsPGJyPgo8YnI+Ck9uIFdlZCwgRmViIDE5LCAyMDIwIGF0IDEw
OjA2IEFNIFJpY2hhcmQgUsO2amZvcnM8YnI+CiZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZC5y
b2pmb3JzQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnJpY2hhcmQucm9qZm9yc0BnbWFpbC5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDs8YnI+CiZndDsgSGkgR2lhbmNpbnRvLDxicj4KJmd0
Ozxicj4KJmd0OyBEZW4gdGlzIDE4IGZlYi4gMjAyMCBrbCAyMDoyNyBza3JldiBHaWFjaW50byBD
aWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDs6PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZn
dDsgSGkgUmljaGFyZCw8YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBPbiBUdWUsIEZlYiAxOCwg
MjAyMCBhdCAxMDoxOSBBTSBSaWNoYXJkIFLDtmpmb3JzPGJyPgomZ3Q7Jmd0OyAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOnJpY2hhcmQucm9qZm9yc0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yaWNo
YXJkLnJvamZvcnNAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7Jmd0OyAmZ3Q7PGJy
PgomZ3Q7Jmd0OyAmZ3Q7IEhpLDxicj4KJmd0OyZndDsgJmd0Ozxicj4KJmd0OyZndDsgJmd0OyBP
Zm9ubyAoYXQgbGVhc3QgZm9yIHVibG94KSBpcyBhbHdheXMgcG93ZXJpbmcgb2ZmIHRoZSByYWRp
byBkdXJpbmcgc3RhcnQuPGJyPgomZ3Q7Jmd0OyAmZ3Q7IFRoaXMgY2FuIG9mIGNvdXJzZSBiZSBo
YW5keSBvZiBwcm9ncmFtbWF0aWMgcmVhc29ucyB0byBicmluZyB0aGUgbW9kZW0gdG8gYSBrbm93
biBzdGF0ZS48YnI+CiZndDsmZ3Q7ICZndDsgU29tZSBjb25maWd1cmF0aW9uIHJlcXVpcmVzIHRo
ZSByYWRpbyB0byBiZSB0dXJuZWQgb2ZmO8KgIGZvciBpbnN0YW5jZSB0aGUgTFRFIGF1dG8gY29u
bmVjdCBBUE4uIEJ1dCBvbiB0aGUgb3RoZXIgaGFuZCB0aGVzZSBhcmUgc3RvcmVkIGluIG5vbi12
b2xhdGlsZSBtZW1vcnkgYW5kIGNvdWxkIGJlIGNvbmZpZ3VyZWQgYmVmb3JlIGhhbmQuPGJyPgom
Z3Q7Jmd0OyAmZ3Q7PGJyPgomZ3Q7Jmd0OyAmZ3Q7IFRoZSBiaWcgZHJhd2JhY2sgd2l0aCB0dXJu
aW5nIGl0IG9mZiBpcyB0aGF0IGl0IG1pZ2h0IHRha2UgdGltZSB0byByZWdpc3RlciBhZ2FpbiB3
aGVuIHRoZSByYWRpbyBpcyBvbi4gSSBoYXZlIHNlZW4gaXQgdGFraW5nIG1vcmUgdGhhbiAxMCBt
aW51dGVzIGluIGV4dHJlbWUgY2FzZXMuPGJyPgomZ3Q7Jmd0OyAmZ3Q7PGJyPgomZ3Q7Jmd0OyAm
Z3Q7IEluIGVtYmVkZGVkIHN5c3RlbXMgdGhpcyBjYW4gYmUgYSBiaWcgaXNzdWUuPGJyPgomZ3Q7
Jmd0OyAmZ3Q7PGJyPgomZ3Q7Jmd0OyAmZ3Q7IEkmIzM5O20gdGhpbmtpbmcgb2YgYWRkaW5nIGEg
Y29uZmlndXJhdGlvbiBvcHRpb24gdG8ga2VlcCB0aGUgcmFkaW8gb24gZHVyaW5nIHN0YXJ0Ljxi
cj4KJmd0OyZndDsgJmd0Ozxicj4KJmd0OyZndDsgJmd0OyBXaGF0cyB0aGUgZ2VuZXJhbCB0aG91
Z2h0IGFib3V0IHRoaXM/PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgbXkgb3BpbmlvbiB3b3Vs
ZCBiZSB0byBrZWVwIGl0IGxpa2UgdGhhdC48YnI+CiZndDsmZ3Q7IGl0IGNhbiBnZW5lcmF0ZSBz
ZXZlcmFsIGhlYWRhY2hlcyBmb3Igc2V2ZXJhbCB1c2UgY2FzZXMsIGFuZCBicmVhazxicj4KJmd0
OyZndDsgZXhpc3RpbmcgY29kZS48YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgWWVzIEkgYWdy
ZWUgdGhhdCB0aGUgc3RhcnR1cCBzZXF1ZW5jZSB3aWxsIGNoYW5nZSwgd2hpY2ggaXMgcmlza3ks
IGJ1dDxicj4KJmd0OyBpdCB3b3VsZCBiZSBhbiBvcHRpb24gZm9yIHBlb3BsZSBrbm93aW5nIHdo
YXQgdGhleSBhcmUgZG9pbmcuPGJyPgomZ3Q7PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgZm9y
IGV4YW1wbGUgd2hlbiB0aGUgU0lNIGNvdWxkIGNoYW5nZSBhcyBjb21wYXJlZCB3aXRoIHRoZSBw
cmV2aW91czxicj4KJmd0OyZndDsgYm9vdC48YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgV2hl
biB1c2luZyB0aGlzIG9wdGlvbiB5b3Ugc2hvdWxkIGtub3cgd2hhdCB5b3UgYXJlIGRvaW5nLiBB
cyBJIHNhaWQgeW91PGJyPgomZ3Q7IG1pZ2h0IG5lZWQgdG8gd3JpdGUgc2V0dGluZ3MgdG8gbm9u
LXZvbGF0aWxlIG1lbW9yeSBzaW5jZSBydW50aW1lIGNoYW5nZXM8YnI+CiZndDsgbWlnaHQgbm90
IGFwcGx5LiBBbmQgYSBTSU0gd29udCBqdXN0IGNoYW5nZSBpbiBlbnZpcm9ubWVudHMgd2hlcmUg
dGhpczxicj4KJmd0OyBvcHRpb24gc2hvdWxkIGJlIHVzZWQuPGJyPgomZ3Q7PGJyPgomZ3Q7Jmd0
Ozxicj4KJmd0OyZndDsgVGhlbiBpdCBiZWNvbWVzIG11Y2ggaGFyZGVyIHRvIHJlY292ZXIgZnJv
bSB0aGlzIHNpdHVhdGlvbi48YnI+CiZndDsmZ3Q7IGl0IHdvdWxkIGJlIGJldHRlciB0byBiZSBh
YmxlIHRvIGJvb3QgdGhlIG1vZGVtIGluIGFpcnBsYW5lIG1vZGUsPGJyPgomZ3Q7Jmd0OyBkaXJl
Y3RseSwgc28gdGhhdCB0aGVyZSBpcyBubyBmbGlwLWZsb3AgZWZmZWN0Ljxicj4KJmd0Ozxicj4K
Jmd0Ozxicj4KJmd0OyBUaGF0IGNvdWxkIGJlIGFuIG9wdGlvbiwgYnV0IHRoYXQgd2lsbCBjb3N0
IHVwIHRvIHNldmVyYWwgc2Vjb25kcyBvZiB0aW1lLjxicj4KJmd0OyBJbiB0aGUgc3lzdGVtcyBJ
JiMzOTttIHRhbGtpbmcgYWJvdXQgdGhlIGJvb3QgbG9hZGVyIG1pZ2h0IGtpY2sgdGhlIG1vZGVt
PGJyPgomZ3Q7IHJ1bm5pbmcgdG8gZ2V0IGl0IHJlZ2lzdGVyZWQgYXMgcXVpY2tseSBhcyBwb3Nz
aWJsZS48YnI+CiZndDs8YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0Ozxicj4KJmd0OyZndDsgSW4g
YW55IGNhc2UgSSBoYXZlIG5ldmVyIG9ic2VydmVkIDEwIG1pbnV0ZXMuPGJyPgomZ3Q7PGJyPgom
Z3Q7PGJyPgomZ3Q7IFRoaXMgaXMgbm90IHRoZSByZWd1bGFyIGNhc2UuIEJ1dCBJIGhhdmUgb2Jz
ZXJ2ZWQgdGhpcy48YnI+CiZndDs8YnI+CiZndDsmZ3Q7PGJyPgomZ3Q7Jmd0OyBJZiB0aGlzIHJl
YWxseSBoYXBwZW5zLCBlaXRoZXIgdGhlIHNpZ25hbCBpcyBzbyBsb3cgdGhhdCBpbiBhbnkgY2Fz
ZTxicj4KJmd0OyZndDsgdGhlIGxpbmsgd2lsbCBiZSBwcmV0dHkgdW5zdGFibGUsIG9yIHRoZSBz
dGFjayBuZWVkcyBkZWJ1Z2dpbmcuPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IEkgY29udGFj
dGVkIHRoZSBGQUUmIzM5O3MgZnJvbSB0aGUgdmVuZG9yIHJlZ2FyZGluZyB0aGlzLiBJIGd1ZXNz
IHRoZXk8YnI+CiZndDsgd2FudCB0byBrZWVwIHRoZSB3b3JrIGxvYWQgZG93biwgYnV0IHRoZWly
IG1ham9yIGNvbXBsYWludCB3YXM8YnI+CiZndDsgdGhlIHdheSBvZm9ubyB0dXJucyBvZmYgdGhl
IHJhZGlvLiBBbmQgZXZlbiBpZiB0aGV5IHdvdWxkIGZpeCB0aGVpcjxicj4KJmd0OyBidWdzIHRo
ZXJlIHdpbGwgYmUgbW9kZW1zIGluIHRoZSBmaWVsZCB0aGF0IGJlaGF2ZXMgbGlrZSB0aGlzLjxi
cj4KJmd0OyBCdXQgcmVnYXJkbGVzczsgMTBtaW4gaXMgYSBzdXBlciBsb25nIHRpbWUsIGV2ZW4g
aWYgaXRzIGp1c3Q8YnI+CiZndDsgc2Vjb25kcyB0byBzYXZlLCB0aGF0IGNvdWxkIGJlIG9mIGlt
cG9ydGFuY2UuLi48YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7bSBub3Qgc3VyZSBp
dHMgYSBnb29kIGlkZWEgdG8gaW50cm9kdWNlIHRoaXMuIEkgbmVlZCB0byw8YnI+CiZndDsgYnV0
IEkgd2FudGVkIHRvIGNoZWNrIGlmIHRoZXJlIHdhcyBhbiBpbnRlcmVzdCBpbiB0aGUgZ2VuZXJh
bCBwdWJsaWMuPGJyPgo8YnI+CnRyeWluZyBpcyBxdWl0ZSBlYXN5LiBJbiBwbHVnaW5zL3VibG94
LmMsIHRoZXJlIGFyZSAyIG9jY3VycmVuY2llcyBvZjxicj4KJnF1b3Q7QVQrQ0ZVTj00JnF1b3Q7
Ojxicj4KwqAtJmd0OyBjaGFuZ2UgYm90aCBvZiB0aGVtIHRvICZxdW90O0FUK0NGVU49MSZxdW90
Oy48YnI+CsKgIChJIGFtIG5vdCBzdXJlIHdoZXRoZXIgdGhpcyB3aWxsIHByb2R1Y2UgYW4gZXJy
b3IgaW4gY2FzZSB0aGUgbW9kZW08YnI+CmlzIGFscmVhZHkgaW4gQ0ZVTjoxLCBidXQgaXQgaXMg
d29ydGggdHJ5aW5nKS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVhaCBJ
IGhhdmUgZG9uZSB0aGlzIGZvciBhIHdoaWxlLiBUaGUgcXVlc3Rpb24gd2FzIG5vdCBob3cgdG8g
ZG8gaXQsPC9kaXY+PGRpdj5qdXN0IGlmIHRoZXJlIHdhcyBhbiBpbnRlcmVzdCB0byBnZXQgdGhp
cyBraW5kIG9mIGNvZGUgdXBzdHJlYW1lZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkZZSTs8
L2Rpdj48ZGl2Pkl0IGRpZCBub3Qgd29yayBvdXQgb2YgdGhlIGJveCBhdCB0aGF0IHBvaW50LCBz
aW5jZSBpdCB0cmlnZ2VyZWQgc29tZTwvZGl2PjxkaXY+cmFjZSBjb25kaXRpb25zLiBUaGVzZSBj
b3VsZCBoYXBwZW4gYW55d2F5IHNvIHRoZXkgYXJlIGZpeGVkIGluwqA8L2Rpdj48ZGl2PnVwc3Ry
ZWFtIG9mb25vLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CklmIHlvdSBhcmUg
c2F0aXNmaWVkLCB0aGVuIHlvdSBjYW4gbWFrZSBpdCBjb25kaXRpb25hbCB3aXRoIGFuPGJyPgrC
oCDCoCDCoGlmIChnZXRlbnYoJnF1b3Q7T0ZPTk9fVUJMT1hfTk9fQ0ZVTl9GTElQJnF1b3Q7KSk8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhdCBjb3VsZCBiZSBhICZxdW90
O3NpbXBsZSZxdW90OyB3YXkgb2YgYWRkaW5nIHRoZSBzd2l0Y2guPC9kaXY+PGRpdj7CoDwvZGl2
PjxkaXY+LS1SaWNoYXJkwqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============9105409455158219119==--

