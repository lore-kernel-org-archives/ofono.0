Content-Type: multipart/mixed; boundary="===============1951686085898566102=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: vendor models and options
Date: Sat, 15 Sep 2018 08:23:14 +0200
Message-ID: <CAKSBH7G1zTuDNVaqGNXSgcSpSjrH3N26dkiaMsoiTc1Rm+DY_w@mail.gmail.com>
In-Reply-To: <a89fd0a7-4cf7-5292-ffba-00422e0589f3@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1951686085898566102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Sep 14, 2018 at 6:01 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> So first of all, please stop top-posting on this mailing list.  All
> comments should be in-line.
>
>
understood.


> > enum gemalto_auth_type {
> > OV_GEMALTO_AUTH_CGAUTH =3D 0,
>
> CGAUTH is a release 11 feature and should be simply probed for in the
> gprs-context initialization procedure, similar to how we test for
> +CGDATA support.
>

> OV_GEMALTO_AUTH_SGAUTH_PWD_USER =3D 1,
> > OV_GEMALTO_AUTH_SGAUTH_USER_PWD =3D 2,
>
> You will need to explain the difference between SGAUTH 1 & 2 to me.  Is
> it the parameter order that is different between firmware versions?
> Can't these simply be queried properly using AT^SGAUTH=3D?
>
> > };
>
> yes, CGAUTH can be queried, but there is no fallback command in case it
fails, so it has to be pre-defined based on the model used.
No query commands would not return the name of the parameters, which in
this case is the only difference between username and password.



> So are you introducing a new gprs-context driver for gemalto or using
>
these for the 'atmodem' driver?
>
>
I am introducing a specific gprs-context for some models, using atmodem for
others, and mbim and qmi for other models.
I try to stick to gprs (not gprs-context) for most of them, because this is
pretty much the same for most of them. For some models that have a lot of
differences we are going to use specific atoms.
We use the same code for the lte atom as well, unless there is a way to
factorize it.

Just to explain the target, overall we are introducing support for more
than 50 models (not firmware versions, plain different models).
Historically, an entire family of models share the same USB enumeration,
despite the differences in hardware and software (for example for voice
support), so there will be about two dozen USB PID, but more models behind.

>
> > struct ov_gemalto {
> > enum gemalto_auth_type auth;
> > gboolean vts_with_quotes;
>
> Sheesh, your firmware guys somehow managed to screw up the VTS command
> syntax?  That command has been in there for 20 years...
>

and our Siemens/Cinterion/Gemalto from earlier than that.
For backward compatibility, model after model, we kept the pre-standard
syntax in some models, and introduced the standard one in other models
whenever possible.


>
> Anyhow, I strongly discourage you from modifying the atmodem voicecall.c
> driver.  Every vendor should have voice call state reporting commands
> that are far superior to the AT+CLCC polling we do in the 'atmodem'
> voicecall.c driver.  So it should be fairly trivial to probe for +VTS
> syntax there.
>
>
we already discussed this.
We do plan to have our own voicecall.c using URCs instead of polling, among
the rest.
We planned to do it a bit later, but I think you are right, we can already
clone the atmodem/voicecall for this change, then introducing the rest of
the changes later.


> Worst case you can use ofono_modem_set_* family to set a particular
> modem specific property which can be available to all atom drivers via
> ofono_modem_get_*.  So this VTS syntax can be handled that way.
>
> > };
> >
>
>
I think ofono_modem_set_*/ofono_modem_get_* is just what we need for the
two examples above (and others).


> <snip>
>
> >
> > and then change the *_create() functions to use 'struct
> > ofono_vendor_parameters *' instead of 'unsigned int vendor', with
> > default &ov_generic.
> >
> > In the example above, I have shown differences for the various Gemalto
> > authentication commands (3 options), that  cross with the options for
> VTS.
> > And then most of the settings are common for Gemalto models (currently
> > factored with the vendor=3DOFONO_VENDOR_CINTERION).
> > If  tomorrow I have to declare models for these simple settings, I have
> > to add at least 6 with the current system, and having a full driver just
> > because of these two AT commands seems needless.
>
> No, this is all completely unneeded as far as I'm concerned.  If you
> want to use +CGAUTH, then just probe it properly and don't pass a vendor
> at all.  The VTS stuff I already covered.
>
>
well, the point is that we need to use CGAUTH for some models, AND the rest
of the code selected with OFONO_VENDOR_CINTERION within the same atom.
But the aforementioned ofono_modem_set_*/ofono_modem_get_* is the mechanism
that we need.


> >
> > The code would be simplified because in general in a switch there will
> > be only 1 vendor, with the current system there would be 6.
> >
> > Is it ok if I update the code with this vendor system? I will have to
> > submit the entire tree, not by subdirectories, to have a consistent and
> > compiling commit.
> >
>
> Right now I'm completely unconvinced that such an invasive change is
> warranted.  So no, please don't do this.
>

After your comments, I am convinced as well that we don't need this.
You were also right that with an example we could explain each other better.


>
> Regards,
> -Denis
>

--===============1951686085898566102==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gRnJpLCBTZXAgMTQsIDIwMTggYXQgNjowMSBQTSBEZW5pcyBLZW56
aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgpTbyBmaXJzdCBvZiBhbGwsIHBs
ZWFzZSBzdG9wIHRvcC1wb3N0aW5nIG9uIHRoaXMgbWFpbGluZyBsaXN0LsKgIEFsbCA8YnI+CmNv
bW1lbnRzIHNob3VsZCBiZSBpbi1saW5lLjxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PnVuZGVyc3Rvb2QuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgomZ3Q7IGVudW0gZ2VtYWx0b19hdXRoX3R5cGUg
ezxicj4KJmd0OyBPVl9HRU1BTFRPX0FVVEhfQ0dBVVRIID0gMCw8YnI+Cjxicj4KQ0dBVVRIIGlz
IGEgcmVsZWFzZSAxMSBmZWF0dXJlIGFuZCBzaG91bGQgYmUgc2ltcGx5IHByb2JlZCBmb3IgaW4g
dGhlIDxicj4KZ3Bycy1jb250ZXh0IGluaXRpYWxpemF0aW9uIHByb2NlZHVyZSwgc2ltaWxhciB0
byBob3cgd2UgdGVzdCBmb3IgPGJyPgorQ0dEQVRBIHN1cHBvcnQuPGJyPsKgPC9ibG9ja3F1b3Rl
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgomZ3Q7IE9WX0dF
TUFMVE9fQVVUSF9TR0FVVEhfUFdEX1VTRVIgPSAxLDxicj4KJmd0OyBPVl9HRU1BTFRPX0FVVEhf
U0dBVVRIX1VTRVJfUFdEID0gMiw8YnI+Cjxicj4KWW91IHdpbGwgbmVlZCB0byBleHBsYWluIHRo
ZSBkaWZmZXJlbmNlIGJldHdlZW4gU0dBVVRIIDEgJmFtcDsgMiB0byBtZS7CoCBJcyA8YnI+Cml0
IHRoZSBwYXJhbWV0ZXIgb3JkZXIgdGhhdCBpcyBkaWZmZXJlbnQgYmV0d2VlbiBmaXJtd2FyZSB2
ZXJzaW9ucz8gPGJyPgpDYW4mIzM5O3QgdGhlc2Ugc2ltcGx5IGJlIHF1ZXJpZWQgcHJvcGVybHkg
dXNpbmcgQVReU0dBVVRIPT88YnI+Cjxicj4KJmd0OyB9Ozxicj4KPGJyPjwvYmxvY2txdW90ZT48
ZGl2PnllcywgQ0dBVVRIIGNhbiBiZSBxdWVyaWVkLCBidXQgdGhlcmUgaXMgbm8gZmFsbGJhY2sg
Y29tbWFuZCBpbiBjYXNlIGl0IGZhaWxzLCBzbyBpdCBoYXMgdG8gYmUgcHJlLWRlZmluZWQgYmFz
ZWQgb24gdGhlIG1vZGVsIHVzZWQuPC9kaXY+PGRpdj5ObyBxdWVyeSBjb21tYW5kcyB3b3VsZCBu
b3QgcmV0dXJuIHRoZSBuYW1lIG9mIHRoZSBwYXJhbWV0ZXJzLCB3aGljaCBpbiB0aGlzIGNhc2Ug
aXMgdGhlIG9ubHkgZGlmZmVyZW5jZSBiZXR3ZWVuIHVzZXJuYW1lIGFuZCBwYXNzd29yZC48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPgpTbyBhcmUgeW91IGludHJvZHVjaW5nIGEgbmV3IGdwcnMt
Y29udGV4dCBkcml2ZXIgZm9yIGdlbWFsdG8gb3IgdXNpbmcgPGJyPjwvYmxvY2txdW90ZT48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij50aGVzZSBmb3IgdGhlICYj
Mzk7YXRtb2RlbSYjMzk7IGRyaXZlcj88YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGFtIGludHJvZHVjaW5nIGEgc3BlY2lmaWMgZ3Bycy1jb250ZXh0IGZvciBzb21l
IG1vZGVscywgdXNpbmcgYXRtb2RlbSBmb3Igb3RoZXJzLCBhbmQgbWJpbSBhbmQgcW1pIGZvciBv
dGhlciBtb2RlbHMuPC9kaXY+PGRpdj48ZGl2PkkgdHJ5IHRvIHN0aWNrIHRvIGdwcnMgKG5vdCBn
cHJzLWNvbnRleHQpIGZvciBtb3N0IG9mIHRoZW0sIGJlY2F1c2UgdGhpcyBpcyBwcmV0dHkgbXVj
aCB0aGUgc2FtZSBmb3IgbW9zdCBvZiB0aGVtLiBGb3Igc29tZSBtb2RlbHMgdGhhdCBoYXZlIGEg
bG90IG9mIGRpZmZlcmVuY2VzIHdlIGFyZSBnb2luZyB0byB1c2Ugc3BlY2lmaWMgYXRvbXMuPC9k
aXY+PGRpdj5XZSB1c2UgdGhlIHNhbWUgY29kZSBmb3IgdGhlIGx0ZSBhdG9tIGFzIHdlbGwsIHVu
bGVzcyB0aGVyZSBpcyBhIHdheSB0byBmYWN0b3JpemUgaXQuPGJyPjwvZGl2PjxiciBjbGFzcz0i
Z21haWwtQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PC9kaXY+PGRpdj5KdXN0IHRvIGV4cGxh
aW4gdGhlIHRhcmdldCwgb3ZlcmFsbCB3ZSBhcmUgaW50cm9kdWNpbmcgc3VwcG9ydCBmb3IgbW9y
ZSB0aGFuIDUwIG1vZGVscyAobm90IGZpcm13YXJlIHZlcnNpb25zLCBwbGFpbiBkaWZmZXJlbnQg
bW9kZWxzKS48L2Rpdj48ZGl2Pkhpc3RvcmljYWxseSwgYW4gZW50aXJlIGZhbWlseSBvZiBtb2Rl
bHMgc2hhcmUgdGhlIHNhbWUgVVNCIGVudW1lcmF0aW9uLCBkZXNwaXRlIHRoZSBkaWZmZXJlbmNl
cyBpbiBoYXJkd2FyZSBhbmQgc29mdHdhcmUgKGZvciBleGFtcGxlIGZvciB2b2ljZSBzdXBwb3J0
KSwgc28gdGhlcmUgd2lsbCBiZSBhYm91dCB0d28gZG96ZW4gVVNCIFBJRCwgYnV0IG1vcmUgbW9k
ZWxzIGJlaGluZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4mZ3Q7IDxicj4KJmd0OyBzdHJ1Y3Qgb3ZfZ2VtYWx0byB7PGJy
PgomZ3Q7IGVudW0gZ2VtYWx0b19hdXRoX3R5cGUgYXV0aDs8YnI+CiZndDsgZ2Jvb2xlYW4gdnRz
X3dpdGhfcXVvdGVzOzxicj4KPGJyPgpTaGVlc2gsIHlvdXIgZmlybXdhcmUgZ3V5cyBzb21laG93
IG1hbmFnZWQgdG8gc2NyZXcgdXAgdGhlIFZUUyBjb21tYW5kIDxicj4Kc3ludGF4P8KgIFRoYXQg
Y29tbWFuZCBoYXMgYmVlbiBpbiB0aGVyZSBmb3IgMjAgeWVhcnMuLi48YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+YW5kIG91ciBTaWVtZW5zL0NpbnRlcmlvbi9HZW1hbHRvIGZy
b20gZWFybGllciB0aGFuIHRoYXQuPGJyPkZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBtb2Rl
bCBhZnRlciBtb2RlbCwgd2Uga2VwdCB0aGUgcHJlLXN0YW5kYXJkIHN5bnRheCBpbiBzb21lIG1v
ZGVscywgYW5kIGludHJvZHVjZWQgdGhlIHN0YW5kYXJkIG9uZSBpbiBvdGhlciBtb2RlbHMgd2hl
bmV2ZXIgcG9zc2libGUuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CkFueWhvdywgSSBzdHJvbmdseSBkaXNjb3VyYWdl
IHlvdSBmcm9tIG1vZGlmeWluZyB0aGUgYXRtb2RlbSB2b2ljZWNhbGwuYyA8YnI+CmRyaXZlci7C
oCBFdmVyeSB2ZW5kb3Igc2hvdWxkIGhhdmUgdm9pY2UgY2FsbCBzdGF0ZSByZXBvcnRpbmcgY29t
bWFuZHMgPGJyPgp0aGF0IGFyZSBmYXIgc3VwZXJpb3IgdG8gdGhlIEFUK0NMQ0MgcG9sbGluZyB3
ZSBkbyBpbiB0aGUgJiMzOTthdG1vZGVtJiMzOTsgPGJyPgp2b2ljZWNhbGwuYyBkcml2ZXIuwqAg
U28gaXQgc2hvdWxkIGJlIGZhaXJseSB0cml2aWFsIHRvIHByb2JlIGZvciArVlRTIDxicj4Kc3lu
dGF4IHRoZXJlLjxicj4KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PndlIGFs
cmVhZHkgZGlzY3Vzc2VkIHRoaXMuPC9kaXY+PGRpdj5XZSBkbyBwbGFuIHRvIGhhdmUgb3VyIG93
biB2b2ljZWNhbGwuYyB1c2luZyBVUkNzIGluc3RlYWQgb2YgcG9sbGluZywgYW1vbmcgdGhlIHJl
c3QuPC9kaXY+PGRpdj5XZSBwbGFubmVkIHRvIGRvIGl0IGEgYml0IGxhdGVyLCBidXQgSSB0aGlu
ayB5b3UgYXJlIHJpZ2h0LCB3ZSBjYW4gYWxyZWFkeSBjbG9uZSB0aGUgYXRtb2RlbS92b2ljZWNh
bGwgZm9yIHRoaXMgY2hhbmdlLCB0aGVuIGludHJvZHVjaW5nIHRoZSByZXN0IG9mIHRoZSBjaGFu
Z2VzIGxhdGVyLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+CldvcnN0IGNhc2UgeW91IGNhbiB1c2Ugb2Zvbm9fbW9kZW1f
c2V0XyogZmFtaWx5IHRvIHNldCBhIHBhcnRpY3VsYXIgPGJyPgptb2RlbSBzcGVjaWZpYyBwcm9w
ZXJ0eSB3aGljaCBjYW4gYmUgYXZhaWxhYmxlIHRvIGFsbCBhdG9tIGRyaXZlcnMgdmlhIDxicj4K
b2Zvbm9fbW9kZW1fZ2V0XyouwqAgU28gdGhpcyBWVFMgc3ludGF4IGNhbiBiZSBoYW5kbGVkIHRo
YXQgd2F5Ljxicj4KPGJyPgomZ3Q7IH07PGJyPgomZ3Q7IDxicj4KPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdGhpbmsgb2Zvbm9fbW9kZW1fc2V0Xyovb2Zvbm9fbW9kZW1f
Z2V0XyogaXMganVzdCB3aGF0IHdlIG5lZWQgZm9yIHRoZSB0d28gZXhhbXBsZXMgYWJvdmUgKGFu
ZCBvdGhlcnMpLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij4KJmx0O3NuaXAmZ3Q7PGJyPgo8YnI+CiZndDsgPGJyPgomZ3Q7IGFu
ZCB0aGVuIGNoYW5nZSB0aGUgKl9jcmVhdGUoKSBmdW5jdGlvbnMgdG8gdXNlICYjMzk7c3RydWN0
IDxicj4KJmd0OyBvZm9ub192ZW5kb3JfcGFyYW1ldGVycyAqJiMzOTsgaW5zdGVhZCBvZiAmIzM5
O3Vuc2lnbmVkIGludCB2ZW5kb3ImIzM5Oywgd2l0aCA8YnI+CiZndDsgZGVmYXVsdCAmYW1wO292
X2dlbmVyaWMuPGJyPgomZ3Q7IDxicj4KJmd0OyBJbiB0aGUgZXhhbXBsZSBhYm92ZSwgSSBoYXZl
IHNob3duIGRpZmZlcmVuY2VzIGZvciB0aGUgdmFyaW91cyBHZW1hbHRvIDxicj4KJmd0OyBhdXRo
ZW50aWNhdGlvbiBjb21tYW5kcyAoMyBvcHRpb25zKSwgdGhhdMKgIGNyb3NzIHdpdGggdGhlIG9w
dGlvbnMgZm9yIFZUUy48YnI+CiZndDsgQW5kIHRoZW4gbW9zdCBvZiB0aGUgc2V0dGluZ3MgYXJl
IGNvbW1vbiBmb3IgR2VtYWx0byBtb2RlbHMgKGN1cnJlbnRseSA8YnI+CiZndDsgZmFjdG9yZWQg
d2l0aCB0aGUgdmVuZG9yPU9GT05PX1ZFTkRPUl9DSU5URVJJT04pLjxicj4KJmd0OyBJZsKgIHRv
bW9ycm93IEkgaGF2ZSB0byBkZWNsYXJlIG1vZGVscyBmb3IgdGhlc2Ugc2ltcGxlIHNldHRpbmdz
LCBJIGhhdmUgPGJyPgomZ3Q7IHRvIGFkZCBhdCBsZWFzdCA2IHdpdGggdGhlIGN1cnJlbnQgc3lz
dGVtLCBhbmQgaGF2aW5nIGEgZnVsbCBkcml2ZXIganVzdCA8YnI+CiZndDsgYmVjYXVzZSBvZiB0
aGVzZSB0d28gQVQgY29tbWFuZHMgc2VlbXMgbmVlZGxlc3MuPGJyPgo8YnI+Ck5vLCB0aGlzIGlz
IGFsbCBjb21wbGV0ZWx5IHVubmVlZGVkIGFzIGZhciBhcyBJJiMzOTttIGNvbmNlcm5lZC7CoCBJ
ZiB5b3UgPGJyPgp3YW50IHRvIHVzZSArQ0dBVVRILCB0aGVuIGp1c3QgcHJvYmUgaXQgcHJvcGVy
bHkgYW5kIGRvbiYjMzk7dCBwYXNzIGEgdmVuZG9yIDxicj4KYXQgYWxsLsKgIFRoZSBWVFMgc3R1
ZmYgSSBhbHJlYWR5IGNvdmVyZWQuPGJyPgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+d2VsbCwgdGhlIHBvaW50IGlzIHRoYXQgd2UgbmVlZCB0byB1c2UgQ0dBVVRIIGZvciBz
b21lIG1vZGVscywgQU5EIHRoZSByZXN0IG9mIHRoZSBjb2RlIHNlbGVjdGVkIHdpdGggT0ZPTk9f
VkVORE9SX0NJTlRFUklPTiB3aXRoaW4gdGhlIHNhbWUgYXRvbS48L2Rpdj48ZGl2PkJ1dCB0aGUg
YWZvcmVtZW50aW9uZWQgb2Zvbm9fbW9kZW1fc2V0Xyovb2Zvbm9fbW9kZW1fZ2V0XyogaXMgdGhl
IG1lY2hhbmlzbSB0aGF0IHdlIG5lZWQuPGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KJmd0OyA8YnI+CiZndDsgVGhlIGNv
ZGUgd291bGQgYmUgc2ltcGxpZmllZCBiZWNhdXNlIGluIGdlbmVyYWwgaW4gYSBzd2l0Y2ggdGhl
cmUgd2lsbCA8YnI+CiZndDsgYmUgb25seSAxIHZlbmRvciwgd2l0aCB0aGUgY3VycmVudCBzeXN0
ZW0gdGhlcmUgd291bGQgYmUgNi48YnI+CiZndDsgPGJyPgomZ3Q7IElzIGl0IG9rIGlmIEkgdXBk
YXRlIHRoZSBjb2RlIHdpdGggdGhpcyB2ZW5kb3Igc3lzdGVtPyBJIHdpbGwgaGF2ZSB0byA8YnI+
CiZndDsgc3VibWl0IHRoZSBlbnRpcmUgdHJlZSwgbm90IGJ5IHN1YmRpcmVjdG9yaWVzLCB0byBo
YXZlIGEgY29uc2lzdGVudCBhbmQgPGJyPgomZ3Q7IGNvbXBpbGluZyBjb21taXQuPGJyPgomZ3Q7
IDxicj4KPGJyPgpSaWdodCBub3cgSSYjMzk7bSBjb21wbGV0ZWx5IHVuY29udmluY2VkIHRoYXQg
c3VjaCBhbiBpbnZhc2l2ZSBjaGFuZ2UgaXMgPGJyPgp3YXJyYW50ZWQuwqAgU28gbm8sIHBsZWFz
ZSBkb24mIzM5O3QgZG8gdGhpcy48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+
QWZ0ZXIgeW91ciBjb21tZW50cywgSSBhbSBjb252aW5jZWQgYXMgd2VsbCB0aGF0IHdlIGRvbiYj
Mzk7dCBuZWVkIHRoaXMuPC9kaXY+PGRpdj5Zb3Ugd2VyZSBhbHNvIHJpZ2h0IHRoYXQgd2l0aCBh
biBleGFtcGxlIHdlIGNvdWxkIGV4cGxhaW4gZWFjaCBvdGhlciBiZXR0ZXIuPC9kaXY+PGRpdj7C
oDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============1951686085898566102==--

