Content-Type: multipart/mixed; boundary="===============3284918136883277657=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] gemaltomodem: added Gemalto-specific gprs-context
 atom....
Date: Tue, 25 Sep 2018 05:46:02 +0200
Message-ID: <CAKSBH7HyuqA43CM90uPZqE1oXUdYvon4cVGMONwh348DX+ftGQ@mail.gmail.com>
In-Reply-To: <e7b07f59-78a2-0d26-1007-7be05d1d1f6f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3284918136883277657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Sep 24, 2018 at 10:50 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> >     So until the GPRS_AUTH_METHOD_NONE is actually introduced, you might
> >     want to just get this upstream with the existing enumeration.  E.g.
> >     just
> >     assume that if username & password is empty, the auth method is non=
e.
> >
> >
> > I have pushed the new method NONE again, and I prefer to wait until it
> > is taken.
> >
> > The current solution is really a non-documented hack.
> > Checking whether user&password are empty to change the type of
> > authentication goes against the caller settings.
> > It is better to give an error so that there is a chance to have good
> > settings.
> >
>
> The issue is that you haven't properly addressed all the points that
> arise from adding a new enumeration.  You're touching something that
> essentially affects every driver and not updating these properly.  So
> take your pick, but nothing is going upstream until either this patch
> fits into the old framework, or the new framework is ready...
>

Actually I have. But I am gong to re-send the relevant patches I have
already sent all together again, with some more verbose explanation.
Admittedly, I have looked into atmodem, mbimmodem, qmimodem, and a few
others, but I will check all of them before re-submitting.
qmi is already defaulting to AUTH_NONE internally if not PAP and not CHAP.
for mbim I have a similar patch, atmodem checks that it is one of {PAP,
CHAP} and does an error if not. So it doesn't need update. Also for PPP the
specification clearly says that it only takes the two methods (even if it
doesn't mention that if user or pwd are empty it goes to NONE).



> >     Fundamentally, your context activation has succeeded or it didn't.
> The
> >     DHCP operation is purely local between the modem and the host.  No
> >     other
> >     vendor in the world has this weird setup that you do.  So I don't
> >     really
> >     know what to tell you here as this ^SWWAN interaction is
> fundamentally
> >     broken and it can't go upstream in this form.
> >
> >     Can ^SWWAN support static ip reporting instead of DHCP?  That would
> be
> >     preferred anyway as DHCP is slow and unneeded.
> >
> >
> > This is a discussion about how Gemalto products work.
> >
> > Admittedly, there are a few models, in the high-volume low-price range
> > (already deployed),
> > that won't return from AT^SWWAN until a DHCP exchange is performed, as
> > per Sebastian's comment above.
> >
>
> Can firmware be fixed / upgraded on these?


No, too many on the field, and nobody is willing to change A change needs
re-certifications around the world,
for both Gemalto and the customers, with the risk of new certification
rules that will require even more changes.

Unfortunately it is for these low-end models that the customers expect to
have a ready-made framework,
in order to have also limited costs on software development.

> The rest (which are the large majority) of the modules would allow a
>
> 'standard' treatment, but also work with the code above.
>
> So why don't we enable sane ones for now and deal with the insane ones
> later?
>

I can do this, but I need to know what options I have in the code.
If there is no way out, it means we have to maintain an out-of-tree branch.


> >
> > As per DHCP vs static, we have both, depending on the module.
> >
> > Just for information, I have stepped upon networks *requiring* DHCP:
> > in this kind of networks, an MBIM module that would normally return a
> > static settings,
> > returns 0x00 in the "IPv4 configuration Available" field in of the
> > IP_CONFIGURATION answer,
> > instead of the usual 0x0F (address, gateway, dns, mtu).
> > So, it looks like that DHCP has to be considered as a valid alternative
> > also in this case.
>
> This is fine.  You just set the IP configuration method accordingly.  We
> already have a few examples where the gprs_context driver might choose
> one or the other depending on whether support for a given command
> exists.  This can be extended to support cases where the network
> requires DHCP.  Which by the way is completely weird for cases such as
> PPP where no concept of DHCP really exists and your address has to be
> obtained by the time the context is activated.  So I wouldn't mind some
> extra details on what is *actually* going on here under the hood.
>
> >
> > We cannot change every module and every network to fit our wishes.
> >
> > Back to the code, I don't see a solution at the moment other than that
> one.
> > I can add an 'if' to filter only the models that need it, but cannot
> > remove it completely.
> > And this code would be specific for the driver, I don't see why it
> > couldn't go upstream.
>
> So I would filter these models out from this driver.  Or see if they can
> work with PPP based driver and we can deal with these later.
>

I have tried PPP on these models, it is accepted but fails. So no PPP
either.

Regards,
> -Denis
>

--===============3284918136883277657==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gTW9uLCBTZXAgMjQsIDIwMTggYXQgMTA6NTAgUE0gRGVuaXMgS2Vu
emlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgR2lhY2ludG8sPGJyPgo8YnI+CiZn
dDvCoCDCoCDCoFNvIHVudGlsIHRoZSBHUFJTX0FVVEhfTUVUSE9EX05PTkUgaXMgYWN0dWFsbHkg
aW50cm9kdWNlZCwgeW91IG1pZ2h0PGJyPgomZ3Q7wqAgwqAgwqB3YW50IHRvIGp1c3QgZ2V0IHRo
aXMgdXBzdHJlYW0gd2l0aCB0aGUgZXhpc3RpbmcgZW51bWVyYXRpb24uwqAgRS5nLjxicj4KJmd0
O8KgIMKgIMKganVzdDxicj4KJmd0O8KgIMKgIMKgYXNzdW1lIHRoYXQgaWYgdXNlcm5hbWUgJmFt
cDsgcGFzc3dvcmQgaXMgZW1wdHksIHRoZSBhdXRoIG1ldGhvZCBpcyBub25lLjxicj4KJmd0OyA8
YnI+CiZndDsgPGJyPgomZ3Q7IEkgaGF2ZSBwdXNoZWQgdGhlIG5ldyBtZXRob2QgTk9ORSBhZ2Fp
biwgYW5kIEkgcHJlZmVyIHRvIHdhaXQgdW50aWwgaXQgPGJyPgomZ3Q7IGlzIHRha2VuLjxicj4K
Jmd0OyA8YnI+CiZndDsgVGhlIGN1cnJlbnQgc29sdXRpb24gaXMgcmVhbGx5IGEgbm9uLWRvY3Vt
ZW50ZWQgaGFjay48YnI+CiZndDsgQ2hlY2tpbmcgd2hldGhlciB1c2VyJmFtcDtwYXNzd29yZCBh
cmUgZW1wdHkgdG8gY2hhbmdlIHRoZSB0eXBlIG9mIDxicj4KJmd0OyBhdXRoZW50aWNhdGlvbiBn
b2VzIGFnYWluc3QgdGhlwqBjYWxsZXIgc2V0dGluZ3MuPGJyPgomZ3Q7IEl0IGlzIGJldHRlciB0
byBnaXZlIGFuIGVycm9yIHNvIHRoYXQgdGhlcmUgaXMgYSBjaGFuY2UgdG8gaGF2ZSBnb29kIDxi
cj4KJmd0OyBzZXR0aW5ncy48YnI+CiZndDsgPGJyPgo8YnI+ClRoZSBpc3N1ZSBpcyB0aGF0IHlv
dSBoYXZlbiYjMzk7dCBwcm9wZXJseSBhZGRyZXNzZWQgYWxsIHRoZSBwb2ludHMgdGhhdCA8YnI+
CmFyaXNlIGZyb20gYWRkaW5nIGEgbmV3IGVudW1lcmF0aW9uLsKgIFlvdSYjMzk7cmUgdG91Y2hp
bmcgc29tZXRoaW5nIHRoYXQgPGJyPgplc3NlbnRpYWxseSBhZmZlY3RzIGV2ZXJ5IGRyaXZlciBh
bmQgbm90IHVwZGF0aW5nIHRoZXNlIHByb3Blcmx5LsKgIFNvIDxicj4KdGFrZSB5b3VyIHBpY2ss
IGJ1dCBub3RoaW5nIGlzIGdvaW5nIHVwc3RyZWFtIHVudGlsIGVpdGhlciB0aGlzIHBhdGNoIDxi
cj4KZml0cyBpbnRvIHRoZSBvbGQgZnJhbWV3b3JrLCBvciB0aGUgbmV3IGZyYW1ld29yayBpcyBy
ZWFkeS4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5BY3R1YWxseSBJIGhh
dmUuIEJ1dCBJIGFtIGdvbmcgdG8gcmUtc2VuZCB0aGUgcmVsZXZhbnQgcGF0Y2hlcyBJIGhhdmUg
YWxyZWFkeSBzZW50IGFsbCB0b2dldGhlciBhZ2Fpbiwgd2l0aCBzb21lIG1vcmUgdmVyYm9zZSBl
eHBsYW5hdGlvbi48L2Rpdj48ZGl2PkFkbWl0dGVkbHksIEkgaGF2ZSBsb29rZWQgaW50byBhdG1v
ZGVtLCBtYmltbW9kZW0sIHFtaW1vZGVtLCBhbmQgYSBmZXcgb3RoZXJzLCBidXQgSSB3aWxsIGNo
ZWNrIGFsbCBvZiB0aGVtIGJlZm9yZSByZS1zdWJtaXR0aW5nLjwvZGl2PjxkaXY+cW1pIGlzIGFs
cmVhZHkgZGVmYXVsdGluZyB0byBBVVRIX05PTkUgaW50ZXJuYWxseSBpZiBub3QgUEFQIGFuZCBu
b3QgQ0hBUC48L2Rpdj48ZGl2PmZvciBtYmltIEkgaGF2ZSBhIHNpbWlsYXIgcGF0Y2gsIGF0bW9k
ZW0gY2hlY2tzIHRoYXQgaXQgaXMgb25lIG9mIHtQQVAsIENIQVB9IGFuZCBkb2VzIGFuIGVycm9y
IGlmIG5vdC4gU28gaXQgZG9lc24mIzM5O3QgbmVlZCB1cGRhdGUuIEFsc28gZm9yIFBQUCB0aGUg
c3BlY2lmaWNhdGlvbiBjbGVhcmx5IHNheXMgdGhhdCBpdCBvbmx5IHRha2VzIHRoZSB0d28gbWV0
aG9kcyAoZXZlbiBpZiBpdCBkb2VzbiYjMzk7dCBtZW50aW9uIHRoYXQgaWYgdXNlciBvciBwd2Qg
YXJlIGVtcHR5IGl0IGdvZXMgdG8gTk9ORSkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4mZ3Q7
wqAgwqAgwqBGdW5kYW1lbnRhbGx5LCB5b3VyIGNvbnRleHQgYWN0aXZhdGlvbiBoYXMgc3VjY2Vl
ZGVkIG9yIGl0IGRpZG4mIzM5O3QuwqAgVGhlPGJyPgomZ3Q7wqAgwqAgwqBESENQIG9wZXJhdGlv
biBpcyBwdXJlbHkgbG9jYWwgYmV0d2VlbiB0aGUgbW9kZW0gYW5kIHRoZSBob3N0LsKgIE5vPGJy
PgomZ3Q7wqAgwqAgwqBvdGhlcjxicj4KJmd0O8KgIMKgIMKgdmVuZG9yIGluIHRoZSB3b3JsZCBo
YXMgdGhpcyB3ZWlyZCBzZXR1cCB0aGF0IHlvdSBkby7CoCBTbyBJIGRvbiYjMzk7dDxicj4KJmd0
O8KgIMKgIMKgcmVhbGx5PGJyPgomZ3Q7wqAgwqAgwqBrbm93IHdoYXQgdG8gdGVsbCB5b3UgaGVy
ZSBhcyB0aGlzIF5TV1dBTiBpbnRlcmFjdGlvbiBpcyBmdW5kYW1lbnRhbGx5PGJyPgomZ3Q7wqAg
wqAgwqBicm9rZW4gYW5kIGl0IGNhbiYjMzk7dCBnbyB1cHN0cmVhbSBpbiB0aGlzIGZvcm0uPGJy
PgomZ3Q7IDxicj4KJmd0O8KgIMKgIMKgQ2FuIF5TV1dBTiBzdXBwb3J0IHN0YXRpYyBpcCByZXBv
cnRpbmcgaW5zdGVhZCBvZiBESENQP8KgIFRoYXQgd291bGQgYmU8YnI+CiZndDvCoCDCoCDCoHBy
ZWZlcnJlZCBhbnl3YXkgYXMgREhDUCBpcyBzbG93IGFuZCB1bm5lZWRlZC48YnI+CiZndDsgPGJy
PgomZ3Q7IDxicj4KJmd0OyBUaGlzIGlzIGEgZGlzY3Vzc2lvbiBhYm91dCBob3cgR2VtYWx0byBw
cm9kdWN0cyB3b3JrLjxicj4KJmd0OyA8YnI+CiZndDsgQWRtaXR0ZWRseSwgdGhlcmUgYXJlIGEg
ZmV3IG1vZGVscywgaW4gdGhlIGhpZ2gtdm9sdW1lIGxvdy1wcmljZSByYW5nZSA8YnI+CiZndDsg
KGFscmVhZHkgZGVwbG95ZWQpLDxicj4KJmd0OyB0aGF0IHdvbiYjMzk7dCByZXR1cm4gZnJvbSBB
VF5TV1dBTiB1bnRpbCBhIERIQ1AgZXhjaGFuZ2UgaXMgcGVyZm9ybWVkLCBhcyA8YnI+CiZndDsg
cGVyIFNlYmFzdGlhbiYjMzk7cyBjb21tZW50IGFib3ZlLjxicj4KJmd0OyA8YnI+Cjxicj4KQ2Fu
IGZpcm13YXJlIGJlIGZpeGVkIC8gdXBncmFkZWQgb24gdGhlc2U/PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+Tm8sIHRvbyBtYW55IG9uIHRoZSBmaWVsZCwgYW5kIG5vYm9keSBpcyB3
aWxsaW5nIHRvIGNoYW5nZSBBIGNoYW5nZSBuZWVkcyByZS1jZXJ0aWZpY2F0aW9ucyBhcm91bmQg
dGhlIHdvcmxkLDwvZGl2PjxkaXY+Zm9yIGJvdGggR2VtYWx0byBhbmQgdGhlIGN1c3RvbWVycywg
d2l0aCB0aGUgcmlzayBvZiBuZXcgY2VydGlmaWNhdGlvbiBydWxlcyB0aGF0IHdpbGwgcmVxdWly
ZSBldmVuIG1vcmUgY2hhbmdlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlVuZm9ydHVuYXRl
bHkgaXQgaXMgZm9yIHRoZXNlIGxvdy1lbmQgbW9kZWxzIHRoYXQgdGhlIGN1c3RvbWVycyBleHBl
Y3QgdG8gaGF2ZSBhIHJlYWR5LW1hZGUgZnJhbWV3b3JrLDwvZGl2PjxkaXY+aW4gb3JkZXIgdG8g
aGF2ZSBhbHNvIGxpbWl0ZWQgY29zdHMgb24gc29mdHdhcmUgZGV2ZWxvcG1lbnQuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
Jmd0OyBUaGUgcmVzdCAod2hpY2ggYXJlIHRoZSBsYXJnZSBtYWpvcml0eSkgb2YgdGhlIG1vZHVs
ZXMgd291bGQgYWxsb3cgYcKgPGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KJmd0OyAmIzM5O3N0YW5kYXJkJiMzOTsgdHJlYXRtZW50
LCBidXQgYWxzbyB3b3JrIHdpdGggdGhlIGNvZGUgYWJvdmUuPGJyPgo8YnI+ClNvIHdoeSBkb24m
IzM5O3Qgd2UgZW5hYmxlIHNhbmUgb25lcyBmb3Igbm93IGFuZCBkZWFsIHdpdGggdGhlIGluc2Fu
ZSBvbmVzIDxicj4KbGF0ZXI/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkg
Y2FuIGRvIHRoaXMsIGJ1dCBJIG5lZWQgdG8ga25vdyB3aGF0IG9wdGlvbnMgSSBoYXZlIGluIHRo
ZSBjb2RlLjwvZGl2PjxkaXY+SWYgdGhlcmUgaXMgbm8gd2F5IG91dCwgaXQgbWVhbnMgd2UgaGF2
ZSB0byBtYWludGFpbiBhbiBvdXQtb2YtdHJlZSBicmFuY2guwqA8L2Rpdj48ZGl2PsKgPGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPiZndDsgPGJy
PgomZ3Q7IEFzIHBlciBESENQIHZzIHN0YXRpYywgd2UgaGF2ZSBib3RoLCBkZXBlbmRpbmcgb24g
dGhlIG1vZHVsZS48YnI+CiZndDsgPGJyPgomZ3Q7IEp1c3QgZm9yIGluZm9ybWF0aW9uLCBJIGhh
dmUgc3RlcHBlZCB1cG9uIG5ldHdvcmtzICpyZXF1aXJpbmcqIERIQ1A6PGJyPgomZ3Q7IGluIHRo
aXMga2luZCBvZiBuZXR3b3JrcywgYW4gTUJJTSBtb2R1bGUgdGhhdCB3b3VsZCBub3JtYWxseSBy
ZXR1cm4gYSA8YnI+CiZndDsgc3RhdGljIHNldHRpbmdzLDxicj4KJmd0OyByZXR1cm5zIDB4MDAg
aW4gdGhlICZxdW90O0lQdjQgY29uZmlndXJhdGlvbiBBdmFpbGFibGUmcXVvdDsgZmllbGQgaW4g
b2YgdGhlIDxicj4KJmd0OyBJUF9DT05GSUdVUkFUSU9OIGFuc3dlciw8YnI+CiZndDsgaW5zdGVh
ZCBvZiB0aGUgdXN1YWwgMHgwRiAoYWRkcmVzcywgZ2F0ZXdheSwgZG5zLCBtdHUpLjxicj4KJmd0
OyBTbywgaXQgbG9va3MgbGlrZSB0aGF0IERIQ1AgaGFzIHRvIGJlIGNvbnNpZGVyZWQgYXMgYSB2
YWxpZCBhbHRlcm5hdGl2ZSA8YnI+CiZndDsgYWxzbyBpbiB0aGlzIGNhc2UuPGJyPgo8YnI+ClRo
aXMgaXMgZmluZS7CoCBZb3UganVzdCBzZXQgdGhlIElQIGNvbmZpZ3VyYXRpb24gbWV0aG9kIGFj
Y29yZGluZ2x5LsKgIFdlIDxicj4KYWxyZWFkeSBoYXZlIGEgZmV3IGV4YW1wbGVzIHdoZXJlIHRo
ZSBncHJzX2NvbnRleHQgZHJpdmVyIG1pZ2h0IGNob29zZSA8YnI+Cm9uZSBvciB0aGUgb3RoZXIg
ZGVwZW5kaW5nIG9uIHdoZXRoZXIgc3VwcG9ydCBmb3IgYSBnaXZlbiBjb21tYW5kIDxicj4KZXhp
c3RzLsKgIFRoaXMgY2FuIGJlIGV4dGVuZGVkIHRvIHN1cHBvcnQgY2FzZXMgd2hlcmUgdGhlIG5l
dHdvcmsgPGJyPgpyZXF1aXJlcyBESENQLsKgIFdoaWNoIGJ5IHRoZSB3YXkgaXMgY29tcGxldGVs
eSB3ZWlyZCBmb3IgY2FzZXMgc3VjaCBhcyA8YnI+ClBQUCB3aGVyZSBubyBjb25jZXB0IG9mIERI
Q1AgcmVhbGx5IGV4aXN0cyBhbmQgeW91ciBhZGRyZXNzIGhhcyB0byBiZSA8YnI+Cm9idGFpbmVk
IGJ5IHRoZSB0aW1lIHRoZSBjb250ZXh0IGlzIGFjdGl2YXRlZC7CoCBTbyBJIHdvdWxkbiYjMzk7
dCBtaW5kIHNvbWUgPGJyPgpleHRyYSBkZXRhaWxzIG9uIHdoYXQgaXMgKmFjdHVhbGx5KiBnb2lu
ZyBvbiBoZXJlIHVuZGVyIHRoZSBob29kLjxicj4KPGJyPgomZ3Q7IDxicj4KJmd0OyBXZSBjYW5u
b3QgY2hhbmdlIGV2ZXJ5IG1vZHVsZSBhbmQgZXZlcnkgbmV0d29yayB0byBmaXQgb3VyIHdpc2hl
cy48YnI+CiZndDsgPGJyPgomZ3Q7IEJhY2sgdG8gdGhlIGNvZGUsIEkgZG9uJiMzOTt0IHNlZSBh
IHNvbHV0aW9uIGF0IHRoZSBtb21lbnQgb3RoZXIgdGhhbiB0aGF0IG9uZS48YnI+CiZndDsgSSBj
YW4gYWRkIGFuICYjMzk7aWYmIzM5OyB0byBmaWx0ZXIgb25seSB0aGUgbW9kZWxzIHRoYXQgbmVl
ZCBpdCwgYnV0IGNhbm5vdCA8YnI+CiZndDsgcmVtb3ZlIGl0IGNvbXBsZXRlbHkuPGJyPgomZ3Q7
IEFuZCB0aGlzIGNvZGUgd291bGQgYmUgc3BlY2lmaWMgZm9yIHRoZSBkcml2ZXIsIEkgZG9uJiMz
OTt0IHNlZSB3aHkgaXQgPGJyPgomZ3Q7IGNvdWxkbiYjMzk7dCBnbyB1cHN0cmVhbS48YnI+Cjxi
cj4KU28gSSB3b3VsZCBmaWx0ZXIgdGhlc2UgbW9kZWxzIG91dCBmcm9tIHRoaXMgZHJpdmVyLsKg
IE9yIHNlZSBpZiB0aGV5IGNhbiA8YnI+Cndvcmsgd2l0aCBQUFAgYmFzZWQgZHJpdmVyIGFuZCB3
ZSBjYW4gZGVhbCB3aXRoIHRoZXNlIGxhdGVyLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGhhdmUgdHJpZWQgUFBQIG9uIHRoZXNlIG1vZGVscywgaXQgaXMgYWNjZXB0ZWQg
YnV0IGZhaWxzLiBTbyBubyBQUFAgZWl0aGVyLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPlJlZ2FyZHMsPGJyPgotRGVuaXM8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+wqA8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============3284918136883277657==--

