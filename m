Content-Type: multipart/mixed; boundary="===============1742537455921433966=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 19 Feb 2020 10:06:03 +0100
Message-ID: <CAHB-Pjkwr25o88UT7jdFjxi3VyYVsM3Spsk-DVpQahYCa4v0DA@mail.gmail.com>
In-Reply-To: <CAKSBH7EfS9ni98WPMzMzbs_e3dOBKfLgWtFbAp=S3yU0kpCgAA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1742537455921433966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giancinto,

Den tis 18 feb. 2020 kl 20:27 skrev Giacinto Cifelli <gciofono@gmail.com>:

> Hi Richard,
>
> On Tue, Feb 18, 2020 at 10:19 AM Richard R=C3=B6jfors
> <richard.rojfors@gmail.com> wrote:
> >
> > Hi,
> >
> > Ofono (at least for ublox) is always powering off the radio during star=
t.
> > This can of course be handy of programmatic reasons to bring the modem
> to a known state.
> > Some configuration requires the radio to be turned off;  for instance
> the LTE auto connect APN. But on the other hand these are stored in
> non-volatile memory and could be configured before hand.
> >
> > The big drawback with turning it off is that it might take time to
> register again when the radio is on. I have seen it taking more than 10
> minutes in extreme cases.
> >
> > In embedded systems this can be a big issue.
> >
> > I'm thinking of adding a configuration option to keep the radio on
> during start.
> >
> > Whats the general thought about this?
>
> my opinion would be to keep it like that.
> it can generate several headaches for several use cases, and break
> existing code.
>

Yes I agree that the startup sequence will change, which is risky, but
it would be an option for people knowing what they are doing.


> for example when the SIM could change as compared with the previous
> boot.


When using this option you should know what you are doing. As I said you
might need to write settings to non-volatile memory since runtime changes
might not apply. And a SIM wont just change in environments where this
option should be used.


> Then it becomes much harder to recover from this situation.
> it would be better to be able to boot the modem in airplane mode,
> directly, so that there is no flip-flop effect.
>

That could be an option, but that will cost up to several seconds of time.
In the systems I'm talking about the boot loader might kick the modem
running to get it registered as quickly as possible.


>
> In any case I have never observed 10 minutes.
>

This is not the regular case. But I have observed this.


> If this really happens, either the signal is so low that in any case
> the link will be pretty unstable, or the stack needs debugging.
>

I contacted the FAE's from the vendor regarding this. I guess they
want to keep the work load down, but their major complaint was
the way ofono turns off the radio. And even if they would fix their
bugs there will be modems in the field that behaves like this.
But regardless; 10min is a super long time, even if its just
seconds to save, that could be of importance...


I'm not sure its a good idea to introduce this. I need to,
but I wanted to check if there was an interest in the general public.

--Richard

--===============1742537455921433966==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBHaWFuY2ludG8sPC9kaXY+PGJyPjxkaXYgY2xhc3M9Imdt
YWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+RGVuIHRpcyAxOCBm
ZWIuIDIwMjAga2wgMjA6Mjcgc2tyZXYgR2lhY2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmdjaW9mb25vQGdtYWlsLmNvbSI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDs6PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij5IaSBSaWNoYXJkLDxicj4KPGJyPgpPbiBUdWUsIEZlYiAxOCwgMjAyMCBhdCAx
MDoxOSBBTSBSaWNoYXJkIFLDtmpmb3JzPGJyPgombHQ7PGEgaHJlZj0ibWFpbHRvOnJpY2hhcmQu
cm9qZm9yc0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5yaWNoYXJkLnJvamZvcnNAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7PGJyPgomZ3Q7IEhpLDxicj4KJmd0Ozxicj4KJmd0
OyBPZm9ubyAoYXQgbGVhc3QgZm9yIHVibG94KSBpcyBhbHdheXMgcG93ZXJpbmcgb2ZmIHRoZSBy
YWRpbyBkdXJpbmcgc3RhcnQuPGJyPgomZ3Q7IFRoaXMgY2FuIG9mIGNvdXJzZSBiZSBoYW5keSBv
ZiBwcm9ncmFtbWF0aWMgcmVhc29ucyB0byBicmluZyB0aGUgbW9kZW0gdG8gYSBrbm93biBzdGF0
ZS48YnI+CiZndDsgU29tZSBjb25maWd1cmF0aW9uIHJlcXVpcmVzIHRoZSByYWRpbyB0byBiZSB0
dXJuZWQgb2ZmO8KgIGZvciBpbnN0YW5jZSB0aGUgTFRFIGF1dG8gY29ubmVjdCBBUE4uIEJ1dCBv
biB0aGUgb3RoZXIgaGFuZCB0aGVzZSBhcmUgc3RvcmVkIGluIG5vbi12b2xhdGlsZSBtZW1vcnkg
YW5kIGNvdWxkIGJlIGNvbmZpZ3VyZWQgYmVmb3JlIGhhbmQuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRo
ZSBiaWcgZHJhd2JhY2sgd2l0aCB0dXJuaW5nIGl0IG9mZiBpcyB0aGF0IGl0IG1pZ2h0IHRha2Ug
dGltZSB0byByZWdpc3RlciBhZ2FpbiB3aGVuIHRoZSByYWRpbyBpcyBvbi4gSSBoYXZlIHNlZW4g
aXQgdGFraW5nIG1vcmUgdGhhbiAxMCBtaW51dGVzIGluIGV4dHJlbWUgY2FzZXMuPGJyPgomZ3Q7
PGJyPgomZ3Q7IEluIGVtYmVkZGVkIHN5c3RlbXMgdGhpcyBjYW4gYmUgYSBiaWcgaXNzdWUuPGJy
PgomZ3Q7PGJyPgomZ3Q7IEkmIzM5O20gdGhpbmtpbmcgb2YgYWRkaW5nIGEgY29uZmlndXJhdGlv
biBvcHRpb24gdG8ga2VlcCB0aGUgcmFkaW8gb24gZHVyaW5nIHN0YXJ0Ljxicj4KJmd0Ozxicj4K
Jmd0OyBXaGF0cyB0aGUgZ2VuZXJhbCB0aG91Z2h0IGFib3V0IHRoaXM/PGJyPgo8YnI+Cm15IG9w
aW5pb24gd291bGQgYmUgdG8ga2VlcCBpdCBsaWtlIHRoYXQuPGJyPgppdCBjYW4gZ2VuZXJhdGUg
c2V2ZXJhbCBoZWFkYWNoZXMgZm9yIHNldmVyYWwgdXNlIGNhc2VzLCBhbmQgYnJlYWs8YnI+CmV4
aXN0aW5nIGNvZGUuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlllcyBJIGFn
cmVlIHRoYXQgdGhlIHN0YXJ0dXAgc2VxdWVuY2Ugd2lsbCBjaGFuZ2UsIHdoaWNoIGlzIHJpc2t5
LCBidXQ8L2Rpdj48ZGl2Pml0IHdvdWxkIGJlIGFuIG9wdGlvbiBmb3IgcGVvcGxlIGtub3dpbmcg
d2hhdCB0aGV5IGFyZSBkb2luZy48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpmb3IgZXhhbXBs
ZSB3aGVuIHRoZSBTSU0gY291bGQgY2hhbmdlIGFzIGNvbXBhcmVkIHdpdGggdGhlIHByZXZpb3Vz
PGJyPgpib290LjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PldoZW4gdXNpbmcgdGhp
cyBvcHRpb24geW91IHNob3VsZCBrbm93IHdoYXQgeW91IGFyZSBkb2luZy4gQXMgSSBzYWlkIHlv
dTwvZGl2PjxkaXY+bWlnaHQgbmVlZCB0byB3cml0ZSBzZXR0aW5ncyB0byBub24tdm9sYXRpbGUg
bWVtb3J5IHNpbmNlIHJ1bnRpbWUgY2hhbmdlczwvZGl2PjxkaXY+bWlnaHQgbm90IGFwcGx5LiBB
bmQgYSBTSU0gd29udCBqdXN0IGNoYW5nZSBpbiBlbnZpcm9ubWVudHMgd2hlcmUgdGhpczwvZGl2
PjxkaXY+b3B0aW9uIHNob3VsZCBiZSB1c2VkLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+IFRo
ZW4gaXQgYmVjb21lcyBtdWNoIGhhcmRlciB0byByZWNvdmVyIGZyb20gdGhpcyBzaXR1YXRpb24u
PGJyPgppdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYmUgYWJsZSB0byBib290IHRoZSBtb2RlbSBpbiBh
aXJwbGFuZSBtb2RlLDxicj4KZGlyZWN0bHksIHNvIHRoYXQgdGhlcmUgaXMgbm8gZmxpcC1mbG9w
IGVmZmVjdC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhdCBjb3VsZCBi
ZSBhbiBvcHRpb24sIGJ1dCB0aGF0IHdpbGwgY29zdCB1cCB0byBzZXZlcmFsIHNlY29uZHMgb2Yg
dGltZS48L2Rpdj48ZGl2PkluIHRoZSBzeXN0ZW1zIEkmIzM5O20gdGFsa2luZyBhYm91dCB0aGUg
Ym9vdCBsb2FkZXIgbWlnaHQga2ljayB0aGUgbW9kZW08L2Rpdj48ZGl2PnJ1bm5pbmcgdG8gZ2V0
IGl0IHJlZ2lzdGVyZWQgYXMgcXVpY2tseSBhcyBwb3NzaWJsZS48L2Rpdj48ZGl2PsKgPC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPgo8YnI+CkluIGFueSBjYXNlIEkgaGF2ZSBuZXZlciBvYnNlcnZlZCAxMCBtaW51dGVz
Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzIGlzIG5vdCB0aGUgcmVn
dWxhciBjYXNlLiBCdXQgSSBoYXZlIG9ic2VydmVkIHRoaXMuPC9kaXY+PGRpdj7CoDwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij4KSWYgdGhpcyByZWFsbHkgaGFwcGVucywgZWl0aGVyIHRoZSBzaWduYWwgaXMgc28gbG93
IHRoYXQgaW4gYW55IGNhc2U8YnI+CnRoZSBsaW5rIHdpbGwgYmUgcHJldHR5IHVuc3RhYmxlLCBv
ciB0aGUgc3RhY2sgbmVlZHMgZGVidWdnaW5nLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGNvbnRhY3RlZCB0aGUgRkFFJiMzOTtzIGZyb20gdGhlIHZlbmRvciByZWdhcmRp
bmcgdGhpcy4gSSBndWVzcyB0aGV5PC9kaXY+PGRpdj53YW50IHRvIGtlZXAgdGhlIHdvcmsgbG9h
ZCBkb3duLCBidXQgdGhlaXIgbWFqb3IgY29tcGxhaW50IHdhczwvZGl2PjxkaXY+dGhlIHdheSBv
Zm9ubyB0dXJucyBvZmYgdGhlIHJhZGlvLiBBbmQgZXZlbiBpZiB0aGV5IHdvdWxkIGZpeCB0aGVp
cjwvZGl2PjxkaXY+YnVncyB0aGVyZSB3aWxsIGJlIG1vZGVtcyBpbiB0aGUgZmllbGQgdGhhdCBi
ZWhhdmVzIGxpa2UgdGhpcy48L2Rpdj48ZGl2PkJ1dCByZWdhcmRsZXNzOyAxMG1pbiBpcyBhIHN1
cGVyIGxvbmcgdGltZSwgZXZlbiBpZiBpdHMganVzdDwvZGl2PjxkaXY+c2Vjb25kcyB0byBzYXZl
LCB0aGF0IGNvdWxkIGJlIG9mIGltcG9ydGFuY2UuLi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20gbm90IHN1cmUgaXRzIGEgZ29vZCBpZGVhIHRvIGludHJv
ZHVjZSB0aGlzLiBJIG5lZWQgdG8sPC9kaXY+PGRpdj5idXQgSSB3YW50ZWQgdG8gY2hlY2sgaWYg
dGhlcmUgd2FzIGFuIGludGVyZXN0IGluIHRoZSBnZW5lcmFsIHB1YmxpYy48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pi0tUmljaGFyZDwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============1742537455921433966==--

