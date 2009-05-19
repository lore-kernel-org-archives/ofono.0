Content-Type: multipart/mixed; boundary="===============5914648824486793444=="
MIME-Version: 1.0
From: Vince Corning <mashplayr@gmail.com>
Subject: Media Control
Date: Wed, 20 May 2009 06:34:28 +0800
Message-ID: <8f9d9e260905191534h36631167nbf834da9b4334f13@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5914648824486793444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Access to AT Commands to merge or fork the GSM audio stream and access to
commands to open microphone and/or speakers would be very helpful.  AT
command access to set up sensors and request copy of sensor data would also
be helpful.

- Vince

On Wed, May 20, 2009 at 3:00 AM, <ofono-request@ofono.org> wrote:

> Send ofono mailing list submissions to
>        ofono(a)ofono.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        http://lists.ofono.org/listinfo/ofono
> or, via email, send a message with subject or body 'help' to
>        ofono-request(a)ofono.org
>
> You can reach the person managing the list at
>        ofono-owner(a)ofono.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of ofono digest..."
>
>
> Today's Topics:
>
>   1. Call Control, Media Control, Documentation (Vince Corning)
>   2. Re: Call Control, Media Control, Documentation (Denis Kenzior)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 19 May 2009 12:45:34 +0800
> From: Vince Corning <mashplayr@gmail.com>
> To: ofono(a)ofono.org
> Subject: Call Control, Media Control, Documentation
> Message-ID:
>        <8f9d9e260905182145t2a371590w54e73e97c610ef51@mail.gmail.com>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>
> Hello from a newbie,
>
> I'm interested in finding out more about ofono's call control and media
> control capabilities.  From the high level diagram, it looks like call
> control is included, but what about media control (ex. record call, ASR,
> TTS, play music to call, open microphone, play music to speaker)
>
> Any pointer to documentation and supported hardware/os would be
> appreciated...
>
> Thanks,
>
> Vince
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> http://lists.ofono.org/pipermail/ofono/attachments/20090519/b1eabac1/atta=
chment-0001.html
> >
>
> ------------------------------
>
> Message: 2
> Date: Tue, 19 May 2009 10:07:15 -0500
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: Call Control, Media Control, Documentation
> Message-ID: <200905191007.16848.denkenz@gmail.com>
> Content-Type: Text/Plain;  charset=3D"us-ascii"
>
> Hi Vince,
>
> On Monday 18 May 2009 23:45:34 Vince Corning wrote:
> > Hello from a newbie,
> >
> > I'm interested in finding out more about ofono's call control and media
> > control capabilities.  From the high level diagram, it looks like call
> > control is included, but what about media control (ex. record call, ASR,
> > TTS, play music to call, open microphone, play music to speaker)
>
> These parts are generally extremely specific to the particulars of the
> hardware.  Currently we're not planning to support any of the things you
> mentioned in the oFono D-Bus APIs.
>
> The encapsulation of audio driver/hardware/implementation should ideally =
be
> in
> another subsystem anyway.  Something like PulseAudio for instance.  Of
> course
> to support certain platforms we will need some way of integrating with the
> audio policy framework (e.g. sending vendor-specific at commands related =
to
> audio.)  We haven't really figured out the details here yet...
>
> >
> > Any pointer to documentation and supported hardware/os would be
> > appreciated...
>
> No hardware is officially supported yet.
>
> >
> > Thanks,
> >
> > Vince
>
> Regards,
> -Denis
>
>
> ------------------------------
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>
> End of ofono Digest, Vol 1, Issue 5
> ***********************************
>

--===============5914648824486793444==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

RGVuaXMsPGJyPjxicj5BY2Nlc3MgdG8gQVQgQ29tbWFuZHMgdG8gbWVyZ2Ugb3IgZm9yayB0aGUg
R1NNIGF1ZGlvIHN0cmVhbSBhbmQgYWNjZXNzIHRvIGNvbW1hbmRzIHRvIG9wZW4gbWljcm9waG9u
ZSBhbmQvb3Igc3BlYWtlcnMgd291bGQgYmUgdmVyeSBoZWxwZnVsLqAgQVQgY29tbWFuZCBhY2Nl
c3MgdG8gc2V0IHVwIHNlbnNvcnMgYW5kIHJlcXVlc3QgY29weSBvZiBzZW5zb3IgZGF0YSB3b3Vs
ZCBhbHNvIGJlIGhlbHBmdWwuPGJyPgo8YnI+LSBWaW5jZTxicj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPk9uIFdlZCwgTWF5IDIwLCAyMDA5IGF0IDM6MDAgQU0sICA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpvZm9uby1yZXF1ZXN0QG9mb25vLm9yZyI+b2Zvbm8tcmVx
dWVzdEBvZm9uby5vcmc8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0
LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpT
ZW5kIG9mb25vIG1haWxpbmcgbGlzdCBzdWJtaXNzaW9ucyB0bzxicj4KIKAgoCCgIKA8YSBocmVm
PSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YnI+ClRv
IHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2aWEgdGhlIFdvcmxkIFdpZGUgV2ViLCB2aXNpdDxi
cj4KIKAgoCCgIKA8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25v
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwv
YT48YnI+Cm9yLCB2aWEgZW1haWwsIHNlbmQgYSBtZXNzYWdlIHdpdGggc3ViamVjdCBvciBib2R5
ICYjMzk7aGVscCYjMzk7IHRvPGJyPgogoCCgIKAgoDxhIGhyZWY9Im1haWx0bzpvZm9uby1yZXF1
ZXN0QG9mb25vLm9yZyI+b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+PGJyPgo8YnI+CllvdSBj
YW4gcmVhY2ggdGhlIHBlcnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4KIKAgoCCgIKA8YSBo
cmVmPSJtYWlsdG86b2Zvbm8tb3duZXJAb2Zvbm8ub3JnIj5vZm9uby1vd25lckBvZm9uby5vcmc8
L2E+PGJyPgo8YnI+CldoZW4gcmVwbHlpbmcsIHBsZWFzZSBlZGl0IHlvdXIgU3ViamVjdCBsaW5l
IHNvIGl0IGlzIG1vcmUgc3BlY2lmaWM8YnI+CnRoYW4gJnF1b3Q7UmU6IENvbnRlbnRzIG9mIG9m
b25vIGRpZ2VzdC4uLiZxdW90Ozxicj4KPGJyPgo8YnI+ClRvZGF5JiMzOTtzIFRvcGljczo8YnI+
Cjxicj4KIKAgMS4gQ2FsbCBDb250cm9sLCBNZWRpYSBDb250cm9sLCBEb2N1bWVudGF0aW9uIChW
aW5jZSBDb3JuaW5nKTxicj4KIKAgMi4gUmU6IENhbGwgQ29udHJvbCwgTWVkaWEgQ29udHJvbCwg
RG9jdW1lbnRhdGlvbiAoRGVuaXMgS2Vuemlvcik8YnI+Cjxicj4KPGJyPgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPgo8YnI+Ck1lc3NhZ2U6IDE8YnI+CkRhdGU6IFR1ZSwgMTkgTWF5IDIwMDkgMTI6NDU6MzQg
KzA4MDA8YnI+CkZyb206IFZpbmNlIENvcm5pbmcgJmx0OzxhIGhyZWY9Im1haWx0bzptYXNocGxh
eXJAZ21haWwuY29tIj5tYXNocGxheXJAZ21haWwuY29tPC9hPiZndDs8YnI+ClRvOiA8YSBocmVm
PSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgpTdWJqZWN0
OiBDYWxsIENvbnRyb2wsIE1lZGlhIENvbnRyb2wsIERvY3VtZW50YXRpb248YnI+Ck1lc3NhZ2Ut
SUQ6PGJyPgogoCCgIKAgoCZsdDs8YSBocmVmPSJtYWlsdG86OGY5ZDllMjYwOTA1MTgyMTQ1dDJh
MzcxNTkwdzU0ZTczZTk3YzYxMGVmNTFAbWFpbC5nbWFpbC5jb20iPjhmOWQ5ZTI2MDkwNTE4MjE0
NXQyYTM3MTU5MHc1NGU3M2U5N2M2MTBlZjUxQG1haWwuZ21haWwuY29tPC9hPiZndDs8YnI+CkNv
bnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVvdDtpc28tODg1OS0xJnF1b3Q7PGJy
Pgo8YnI+CkhlbGxvIGZyb20gYSBuZXdiaWUsPGJyPgo8YnI+CkkmIzM5O20gaW50ZXJlc3RlZCBp
biBmaW5kaW5nIG91dCBtb3JlIGFib3V0IG9mb25vJiMzOTtzIGNhbGwgY29udHJvbCBhbmQgbWVk
aWE8YnI+CmNvbnRyb2wgY2FwYWJpbGl0aWVzLiCgRnJvbSB0aGUgaGlnaCBsZXZlbCBkaWFncmFt
LCBpdCBsb29rcyBsaWtlIGNhbGw8YnI+CmNvbnRyb2wgaXMgaW5jbHVkZWQsIGJ1dCB3aGF0IGFi
b3V0IG1lZGlhIGNvbnRyb2wgKGV4LiByZWNvcmQgY2FsbCwgQVNSLDxicj4KVFRTLCBwbGF5IG11
c2ljIHRvIGNhbGwsIG9wZW4gbWljcm9waG9uZSwgcGxheSBtdXNpYyB0byBzcGVha2VyKTxicj4K
PGJyPgpBbnkgcG9pbnRlciB0byBkb2N1bWVudGF0aW9uIGFuZCBzdXBwb3J0ZWQgaGFyZHdhcmUv
b3Mgd291bGQgYmU8YnI+CmFwcHJlY2lhdGVkLi4uPGJyPgo8YnI+ClRoYW5rcyw8YnI+Cjxicj4K
VmluY2U8YnI+Ci0tLS0tLS0tLS0tLS0tIG5leHQgcGFydCAtLS0tLS0tLS0tLS0tLTxicj4KQW4g
SFRNTCBhdHRhY2htZW50IHdhcyBzY3J1YmJlZC4uLjxicj4KVVJMOiAmbHQ7PGEgaHJlZj0iaHR0
cDovL2xpc3RzLm9mb25vLm9yZy9waXBlcm1haWwvb2Zvbm8vYXR0YWNobWVudHMvMjAwOTA1MTkv
YjFlYWJhYzEvYXR0YWNobWVudC0wMDAxLmh0bWwiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlz
dHMub2Zvbm8ub3JnL3BpcGVybWFpbC9vZm9uby9hdHRhY2htZW50cy8yMDA5MDUxOS9iMWVhYmFj
MS9hdHRhY2htZW50LTAwMDEuaHRtbDwvYT4mZ3Q7PGJyPgoKPGJyPgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KTWVzc2FnZTogMjxicj4KRGF0ZTogVHVlLCAxOSBNYXkg
MjAwOSAxMDowNzoxNSAtMDUwMDxicj4KRnJvbTogRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgpU
bzogPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxi
cj4KU3ViamVjdDogUmU6IENhbGwgQ29udHJvbCwgTWVkaWEgQ29udHJvbCwgRG9jdW1lbnRhdGlv
bjxicj4KTWVzc2FnZS1JRDogJmx0OzxhIGhyZWY9Im1haWx0bzoyMDA5MDUxOTEwMDcuMTY4NDgu
ZGVua2VuekBnbWFpbC5jb20iPjIwMDkwNTE5MTAwNy4xNjg0OC5kZW5rZW56QGdtYWlsLmNvbTwv
YT4mZ3Q7PGJyPgpDb250ZW50LVR5cGU6IFRleHQvUGxhaW47IKBjaGFyc2V0PSZxdW90O3VzLWFz
Y2lpJnF1b3Q7PGJyPgo8YnI+CkhpIFZpbmNlLDxicj4KPGJyPgpPbiBNb25kYXkgMTggTWF5IDIw
MDkgMjM6NDU6MzQgVmluY2UgQ29ybmluZyB3cm90ZTo8YnI+CiZndDsgSGVsbG8gZnJvbSBhIG5l
d2JpZSw8YnI+CiZndDs8YnI+CiZndDsgSSYjMzk7bSBpbnRlcmVzdGVkIGluIGZpbmRpbmcgb3V0
IG1vcmUgYWJvdXQgb2Zvbm8mIzM5O3MgY2FsbCBjb250cm9sIGFuZCBtZWRpYTxicj4KJmd0OyBj
b250cm9sIGNhcGFiaWxpdGllcy4goEZyb20gdGhlIGhpZ2ggbGV2ZWwgZGlhZ3JhbSwgaXQgbG9v
a3MgbGlrZSBjYWxsPGJyPgomZ3Q7IGNvbnRyb2wgaXMgaW5jbHVkZWQsIGJ1dCB3aGF0IGFib3V0
IG1lZGlhIGNvbnRyb2wgKGV4LiByZWNvcmQgY2FsbCwgQVNSLDxicj4KJmd0OyBUVFMsIHBsYXkg
bXVzaWMgdG8gY2FsbCwgb3BlbiBtaWNyb3Bob25lLCBwbGF5IG11c2ljIHRvIHNwZWFrZXIpPGJy
Pgo8YnI+ClRoZXNlIHBhcnRzIGFyZSBnZW5lcmFsbHkgZXh0cmVtZWx5IHNwZWNpZmljIHRvIHRo
ZSBwYXJ0aWN1bGFycyBvZiB0aGU8YnI+CmhhcmR3YXJlLiCgQ3VycmVudGx5IHdlJiMzOTtyZSBu
b3QgcGxhbm5pbmcgdG8gc3VwcG9ydCBhbnkgb2YgdGhlIHRoaW5ncyB5b3U8YnI+Cm1lbnRpb25l
ZCBpbiB0aGUgb0Zvbm8gRC1CdXMgQVBJcy48YnI+Cjxicj4KVGhlIGVuY2Fwc3VsYXRpb24gb2Yg
YXVkaW8gZHJpdmVyL2hhcmR3YXJlL2ltcGxlbWVudGF0aW9uIHNob3VsZCBpZGVhbGx5IGJlIGlu
PGJyPgphbm90aGVyIHN1YnN5c3RlbSBhbnl3YXkuIKBTb21ldGhpbmcgbGlrZSBQdWxzZUF1ZGlv
IGZvciBpbnN0YW5jZS4goE9mIGNvdXJzZTxicj4KdG8gc3VwcG9ydCBjZXJ0YWluIHBsYXRmb3Jt
cyB3ZSB3aWxsIG5lZWQgc29tZSB3YXkgb2YgaW50ZWdyYXRpbmcgd2l0aCB0aGU8YnI+CmF1ZGlv
IHBvbGljeSBmcmFtZXdvcmsgKGUuZy4gc2VuZGluZyB2ZW5kb3Itc3BlY2lmaWMgYXQgY29tbWFu
ZHMgcmVsYXRlZCB0bzxicj4KYXVkaW8uKSCgV2UgaGF2ZW4mIzM5O3QgcmVhbGx5IGZpZ3VyZWQg
b3V0IHRoZSBkZXRhaWxzIGhlcmUgeWV0Li4uPGJyPgo8YnI+CiZndDs8YnI+CiZndDsgQW55IHBv
aW50ZXIgdG8gZG9jdW1lbnRhdGlvbiBhbmQgc3VwcG9ydGVkIGhhcmR3YXJlL29zIHdvdWxkIGJl
PGJyPgomZ3Q7IGFwcHJlY2lhdGVkLi4uPGJyPgo8YnI+Ck5vIGhhcmR3YXJlIGlzIG9mZmljaWFs
bHkgc3VwcG9ydGVkIHlldC48YnI+Cjxicj4KJmd0Ozxicj4KJmd0OyBUaGFua3MsPGJyPgomZ3Q7
PGJyPgomZ3Q7IFZpbmNlPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cjxicj4KPGJy
PgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxi
cj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxi
cj4KPGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8
YnI+Cjxicj4KRW5kIG9mIG9mb25vIERpZ2VzdCwgVm9sIDEsIElzc3VlIDU8YnI+CioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============5914648824486793444==--

