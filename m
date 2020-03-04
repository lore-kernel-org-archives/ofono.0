Content-Type: multipart/mixed; boundary="===============8773289515802009163=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 17:51:05 +0000
Message-ID: <CABPh3UOAp1A37VAjrVYyuSb4fx9A=aONmHOyZRzQvFhwsVvc9A@mail.gmail.com>
In-Reply-To: <f7955968-0f4a-86b9-a2bb-a8a07e2c7070@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8773289515802009163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On Wed, 4 Mar 2020 at 17:11, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Nicola,
>
> No top posting please.
>
Ok sorry


> On 3/4/20 11:00 AM, nick83ola wrote:
> > Hi Giacinto,
> > We have a web application that is talking to connman and ofono over dbu=
s.
> > We present the user with the list and once is connected to a profile
> > connman remembers
> > it so if I connect again the same modem connman will remember it as a
> > favourite and automatically connect.
> > or at least is what I'm thinking of doing.
>
> If you're making the user choose, why not follow the advice I have
> already given Martin and others?  Just provision the context once
> if/when automatic provisioning fails.  This is how connman/ofono were
> designed to be used.  Any workarounds you introduce will just make your
> life harder.
>
In my case automatic provisioning always fails:
- the database has multiple entries for basically every operator/country
- also Ofono doesn;t expose a Dbus API to query the database
- so the current plugin is useless: it always provision the wrong settings

If I want to do it externally I have to reimplement the whole "quering
thedatabase logic", delete
all the automatic provisioned profile and setup custom ones.
So the provision plugin is basically useless.

> To automatically connect without the user I was thinking of

> > implementing what you said:
> > - retrieve "cellular" services from connman
> > - check if there are favourite services
> > - if there are not try one context one after the another
> >
> So method of elimination.  Doesn't sound elegant ;)
>

What is the more "elegant" solution in your opinion?


> > The main issue is that connman is not exposing the APN and data over
> > dbus and is not easy to identify also the context
> > which a service is referring to... the other indication is the name
> > So if I create something in ofono I don't know how connman will call
> it.... :-(
> >
>
> ConnMan was explicitly designed not to expose such details
>

mmm Those are details that are exposed in every connection manager that I
know of... see Android network settings for example
(maybe there's a reason??)


> Regards,
> -Denis
>

Regards
- Nicola

--===============8773289515802009163==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5uaXMsPGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgNCBN
YXIgMjAyMCBhdCAxNzoxMSwgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtl
bnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+SGkgTmljb2xhLDxicj4KPGJyPgpObyB0b3AgcG9zdGluZyBwbGVhc2UuPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pk9rIHNvcnJ5IDxicj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpPbiAz
LzQvMjAgMTE6MDAgQU0sIG5pY2s4M29sYSB3cm90ZTo8YnI+CiZndDsgSGkgR2lhY2ludG8sPGJy
PgomZ3Q7IFdlIGhhdmUgYSB3ZWIgYXBwbGljYXRpb24gdGhhdCBpcyB0YWxraW5nIHRvIGNvbm5t
YW4gYW5kIG9mb25vIG92ZXIgZGJ1cy48YnI+CiZndDsgV2UgcHJlc2VudCB0aGUgdXNlciB3aXRo
IHRoZSBsaXN0IGFuZCBvbmNlIGlzIGNvbm5lY3RlZCB0byBhIHByb2ZpbGU8YnI+CiZndDsgY29u
bm1hbiByZW1lbWJlcnM8YnI+CiZndDsgaXQgc28gaWYgSSBjb25uZWN0IGFnYWluIHRoZSBzYW1l
IG1vZGVtIGNvbm5tYW4gd2lsbCByZW1lbWJlciBpdCBhcyBhPGJyPgomZ3Q7IGZhdm91cml0ZSBh
bmQgYXV0b21hdGljYWxseSBjb25uZWN0Ljxicj4KJmd0OyBvciBhdCBsZWFzdCBpcyB3aGF0IEkm
IzM5O20gdGhpbmtpbmcgb2YgZG9pbmcuPGJyPgo8YnI+CklmIHlvdSYjMzk7cmUgbWFraW5nIHRo
ZSB1c2VyIGNob29zZSwgd2h5IG5vdCBmb2xsb3cgdGhlIGFkdmljZSBJIGhhdmUgPGJyPgphbHJl
YWR5IGdpdmVuIE1hcnRpbiBhbmQgb3RoZXJzP8KgIEp1c3QgcHJvdmlzaW9uIHRoZSBjb250ZXh0
IG9uY2UgPGJyPgppZi93aGVuIGF1dG9tYXRpYyBwcm92aXNpb25pbmcgZmFpbHMuwqAgVGhpcyBp
cyBob3cgY29ubm1hbi9vZm9ubyB3ZXJlIDxicj4KZGVzaWduZWQgdG8gYmUgdXNlZC7CoCBBbnkg
d29ya2Fyb3VuZHMgeW91IGludHJvZHVjZSB3aWxsIGp1c3QgbWFrZSB5b3VyIDxicj4KbGlmZSBo
YXJkZXIuPGJyPjwvYmxvY2txdW90ZT48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+SW4g
bXkgY2FzZSBhdXRvbWF0aWMgcHJvdmlzaW9uaW5nIGFsd2F5cyBmYWlsczo8L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9xdW90ZSI+LSB0aGUgZGF0YWJhc2UgaGFzIG11bHRpcGxlIGVudHJpZXMgZm9y
IGJhc2ljYWxseSBldmVyeSBvcGVyYXRvci9jb3VudHJ5PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPi0gYWxzbyBPZm9ubyBkb2Vzbjt0IGV4cG9zZSBhIERidXMgQVBJIHRvIHF1ZXJ5IHRo
ZSBkYXRhYmFzZTxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+LSBzbyB0aGUgY3Vy
cmVudCBwbHVnaW4gaXMgdXNlbGVzczogaXQgYWx3YXlzIHByb3Zpc2lvbiB0aGUgd3Jvbmcgc2V0
dGluZ3M8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PklmIEkgd2FudCB0byBkbyBpdCBleHRlcm5h
bGx5IEkgaGF2ZSB0byByZWltcGxlbWVudCB0aGUgd2hvbGUgJnF1b3Q7cXVlcmluZyB0aGVkYXRh
YmFzZSBsb2dpYyZxdW90OywgZGVsZXRlPC9kaXY+PGRpdj5hbGwgdGhlIGF1dG9tYXRpYyBwcm92
aXNpb25lZCBwcm9maWxlIGFuZCBzZXR1cCBjdXN0b20gb25lcy48L2Rpdj48ZGl2PlNvIHRoZSBw
cm92aXNpb24gcGx1Z2luIGlzIGJhc2ljYWxseSB1c2VsZXNzLjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj4mZ3Q7IFRvIGF1dG9tYXRpY2FsbHkgY29ubmVjdCB3aXRob3V0IHRoZSB1c2VyIEkgd2Fz
IHRoaW5raW5nIG9mPGJyPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KJmd0
OyBpbXBsZW1lbnRpbmcgd2hhdCB5b3Ugc2FpZDo8YnI+CiZndDsgLSByZXRyaWV2ZSAmcXVvdDtj
ZWxsdWxhciZxdW90OyBzZXJ2aWNlcyBmcm9tIGNvbm5tYW48YnI+CiZndDsgLSBjaGVjayBpZiB0
aGVyZSBhcmUgZmF2b3VyaXRlIHNlcnZpY2VzPGJyPgomZ3Q7IC0gaWYgdGhlcmUgYXJlIG5vdCB0
cnkgb25lIGNvbnRleHQgb25lIGFmdGVyIHRoZSBhbm90aGVyPGJyPgomZ3Q7IDxicj4KU28gbWV0
aG9kIG9mIGVsaW1pbmF0aW9uLsKgIERvZXNuJiMzOTt0IHNvdW5kIGVsZWdhbnQgOyk8YnI+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hhdCBpcyB0aGUgbW9yZSAmcXVvdDtlbGVn
YW50JnF1b3Q7IHNvbHV0aW9uIGluIHlvdXIgb3Bpbmlvbj88YnI+PC9kaXY+PGRpdj7CoDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KJmd0OyBUaGUgbWFpbiBpc3N1ZSBpcyB0aGF0IGNvbm5tYW4gaXMgbm90IGV4cG9z
aW5nIHRoZSBBUE4gYW5kIGRhdGEgb3Zlcjxicj4KJmd0OyBkYnVzIGFuZCBpcyBub3QgZWFzeSB0
byBpZGVudGlmeSBhbHNvIHRoZSBjb250ZXh0PGJyPgomZ3Q7IHdoaWNoIGEgc2VydmljZSBpcyBy
ZWZlcnJpbmcgdG8uLi4gdGhlIG90aGVyIGluZGljYXRpb24gaXMgdGhlIG5hbWU8YnI+CiZndDsg
U28gaWYgSSBjcmVhdGUgc29tZXRoaW5nIGluIG9mb25vIEkgZG9uJiMzOTt0IGtub3cgaG93IGNv
bm5tYW4gd2lsbCBjYWxsIGl0Li4uLiA6LSg8YnI+CiZndDsgPGJyPgo8YnI+CkNvbm5NYW4gd2Fz
IGV4cGxpY2l0bHkgZGVzaWduZWQgbm90IHRvIGV4cG9zZSBzdWNoIGRldGFpbHM8YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+bW1tIFRob3NlIGFyZSBkZXRhaWxzIHRoYXQgYXJl
IGV4cG9zZWQgaW4gZXZlcnkgY29ubmVjdGlvbiBtYW5hZ2VyIHRoYXQgSSBrbm93IG9mLi4uIHNl
ZSBBbmRyb2lkIG5ldHdvcmsgc2V0dGluZ3MgZm9yIGV4YW1wbGU8L2Rpdj4obWF5YmUgdGhlcmUm
IzM5O3MgYSByZWFzb24/Pyk8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+wqA8L2Rpdj48
L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+UmVnYXJkcyw8YnI+Ci1E
ZW5pczxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzPC9kaXY+PGRp
dj4tIE5pY29sYTxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============8773289515802009163==--

