Content-Type: multipart/mixed; boundary="===============2100631226292704467=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: Option to not power off radio during start ofono
Date: Wed, 26 Feb 2020 11:25:24 +0100
Message-ID: <CAHB-Pjk3HMRu0NWaz5TnSFRfNyrzrVQ-2fUeR3oCZnPnCyCChA@mail.gmail.com>
In-Reply-To: <f81e13eb-6c7a-78ce-c4dd-2fc998cdbb96@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2100631226292704467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den ons 19 feb. 2020 kl 19:52 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 2/18/20 3:19 AM, Richard R=C3=B6jfors wrote:
> > Hi,
> >
> > Ofono (at least for ublox) is always powering off the radio during star=
t.
> > This can of course be handy of programmatic reasons to bring the modem
> > to a known state.
> > Some configuration requires the radio to be turned off;  for instance
> > the LTE auto connect APN. But on the other hand these are stored in
> > non-volatile memory and could be configured before hand.
>
> So by default we bring the device into airplane mode until the SIM card
> has been initialized.  Also, the policy decision of bringing the radio
> up / down was left to external services such as ConnMan.
>
> >
> > The big drawback with turning it off is that it might take time to
> > register again when the radio is on. I have seen it taking more than 10
> > minutes in extreme cases.
> >
>
> That's nuts.  Shouldn't take more than a few seconds?
>

I would assume so too, but that's what we have experienced.


>
> > In embedded systems this can be a big issue.
> >
>
> Indeed.
>
> > I'm thinking of adding a configuration option to keep the radio on
> > during start.
> >
> > Whats the general thought about this?
> >
>
> Not sure.  Are you certain that adding such low-level config options is
> the right approach?


I'm not sure thats why I started the discussion. The other suggestion
in this thread was to use some environment variable to pass the
information, maybe thats a better way?


>   Even documenting / explaining what and why this
> configuration option is there would be challenging I imagine.
>

Yes it will be. I think I'm convinced we should not have this
feature upstreams.

--Richard

--===============2100631226292704467==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5p
cyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9hdHRyIj5EZW4gb25zIDE5IGZlYi4gMjAyMCBrbCAxOTo1MiBza3JldiBEZW5pcyBL
ZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21h
aWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBSaWNoYXJkLDxicj4KPGJyPgpPbiAy
LzE4LzIwIDM6MTkgQU0sIFJpY2hhcmQgUsO2amZvcnMgd3JvdGU6PGJyPgomZ3Q7IEhpLDxicj4K
Jmd0OyA8YnI+CiZndDsgT2Zvbm8gKGF0IGxlYXN0IGZvciB1YmxveCkgaXMgYWx3YXlzIHBvd2Vy
aW5nIG9mZiB0aGUgcmFkaW8gZHVyaW5nIHN0YXJ0Ljxicj4KJmd0OyBUaGlzIGNhbiBvZiBjb3Vy
c2UgYmUgaGFuZHkgb2YgcHJvZ3JhbW1hdGljwqByZWFzb25zIHRvIGJyaW5nIHRoZSBtb2RlbSA8
YnI+CiZndDsgdG8gYSBrbm93biBzdGF0ZS48YnI+CiZndDsgU29tZSBjb25maWd1cmF0aW9uIHJl
cXVpcmVzIHRoZSByYWRpbyB0byBiZSB0dXJuZWQgb2ZmO8KgIGZvciBpbnN0YW5jZSA8YnI+CiZn
dDsgdGhlIExURSBhdXRvIGNvbm5lY3QgQVBOLiBCdXQgb24gdGhlIG90aGVywqBoYW5kIHRoZXNl
IGFyZSBzdG9yZWQgaW4gPGJyPgomZ3Q7IG5vbi12b2xhdGlsZSBtZW1vcnkgYW5kIGNvdWxkIGJl
IGNvbmZpZ3VyZWQgYmVmb3JlIGhhbmQuPGJyPgo8YnI+ClNvIGJ5IGRlZmF1bHQgd2UgYnJpbmcg
dGhlIGRldmljZSBpbnRvIGFpcnBsYW5lIG1vZGUgdW50aWwgdGhlIFNJTSBjYXJkIDxicj4KaGFz
IGJlZW4gaW5pdGlhbGl6ZWQuwqAgQWxzbywgdGhlIHBvbGljeSBkZWNpc2lvbiBvZiBicmluZ2lu
ZyB0aGUgcmFkaW8gPGJyPgp1cCAvIGRvd24gd2FzIGxlZnQgdG8gZXh0ZXJuYWwgc2VydmljZXMg
c3VjaCBhcyBDb25uTWFuLjxicj4KPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGUgYmlnIGRyYXdiYWNr
IHdpdGggdHVybmluZyBpdCBvZmYgaXMgdGhhdCBpdCBtaWdodCB0YWtlIHRpbWUgdG8gPGJyPgom
Z3Q7IHJlZ2lzdGVyIGFnYWluIHdoZW4gdGhlIHJhZGlvIGlzIG9uLiBJIGhhdmUgc2VlbiBpdCB0
YWtpbmcgbW9yZSB0aGFuIDEwIDxicj4KJmd0OyBtaW51dGVzIGluIGV4dHJlbWUgY2FzZXMuPGJy
PgomZ3Q7IDxicj4KPGJyPgpUaGF0JiMzOTtzIG51dHMuwqAgU2hvdWxkbiYjMzk7dCB0YWtlIG1v
cmUgdGhhbiBhIGZldyBzZWNvbmRzPzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj5JIHdvdWxkIGFzc3VtZSBzbyB0b28sIGJ1dCB0aGF0JiMzOTtzIHdoYXQgd2UgaGF2ZSBleHBl
cmllbmNlZC48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgSW4gZW1iZWRkZWQg
c3lzdGVtcyB0aGlzIGNhbiBiZSBhIGJpZyBpc3N1ZS48YnI+CiZndDsgPGJyPgo8YnI+CkluZGVl
ZC48YnI+Cjxicj4KJmd0OyBJJiMzOTttIHRoaW5raW5nIG9mIGFkZGluZyBhIGNvbmZpZ3VyYXRp
b24gb3B0aW9uIHRvIGtlZXAgdGhlIHJhZGlvIG9uIDxicj4KJmd0OyBkdXJpbmcgc3RhcnQuPGJy
PgomZ3Q7IDxicj4KJmd0OyBXaGF0cyB0aGUgZ2VuZXJhbCB0aG91Z2h0IGFib3V0IHRoaXM/PGJy
PgomZ3Q7IDxicj4KPGJyPgpOb3Qgc3VyZS7CoCBBcmUgeW91IGNlcnRhaW4gdGhhdCBhZGRpbmcg
c3VjaCBsb3ctbGV2ZWwgY29uZmlnIG9wdGlvbnMgaXMgPGJyPgp0aGUgcmlnaHQgYXBwcm9hY2g/
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBub3Qgc3VyZSB0aGF0cyB3
aHkgSSBzdGFydGVkIHRoZSBkaXNjdXNzaW9uLiBUaGUgb3RoZXIgc3VnZ2VzdGlvbjwvZGl2Pjxk
aXY+aW4gdGhpcyB0aHJlYWQgd2FzIHRvIHVzZSBzb21lIGVudmlyb25tZW50IHZhcmlhYmxlIHRv
IHBhc3MgdGhlPC9kaXY+PGRpdj5pbmZvcm1hdGlvbiwgbWF5YmUgdGhhdHMgYSBiZXR0ZXIgd2F5
PzwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQs
MjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+wqAgRXZlbiBkb2N1bWVudGluZyAvIGV4cGxhaW5p
bmcgd2hhdCBhbmQgd2h5IHRoaXMgPGJyPgpjb25maWd1cmF0aW9uIG9wdGlvbiBpcyB0aGVyZSB3
b3VsZCBiZSBjaGFsbGVuZ2luZyBJIGltYWdpbmUuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PlllcyBpdCB3aWxsIGJlLiBJIHRoaW5rIEkmIzM5O20gY29udmluY2VkIHdlIHNo
b3VsZCBub3QgaGF2ZSB0aGlzPC9kaXY+PGRpdj5mZWF0dXJlIHVwc3RyZWFtcy48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2Pi0tUmljaGFyZDwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============2100631226292704467==--

