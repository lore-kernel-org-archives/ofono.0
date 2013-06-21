Content-Type: multipart/mixed; boundary="===============0419800572075470638=="
MIME-Version: 1.0
From: Yang TengChou <threefure@hotmail.com>
Subject: RE: CDMA voicecall driver
Date: Sat, 22 Jun 2013 01:49:31 +0800
Message-ID: <BAY164-W70E71C721A282EC7D6CA4A58F0@phx.gbl>
In-Reply-To: <51C4783D.4030704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0419800572075470638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Date: Fri, 21 Jun 2013 10:58:53 -0500
> From: denkenz(a)gmail.com
> To: ofono(a)ofono.org
> Subject: Re: CDMA voicecall driver
> =

> Hi,
> =

> On 06/19/2013 07:24 PM, TengChou Yang wrote:
> > Hi all,
> > I am currently working on Sierra modem (MC5728V). Looks like CDMA is not
> > fully supported for the voicecall yet.
> > What I see from ofono master branch there are only probe, remove, dial,
> > hangup had been implemented. I am working
> > on other's method step by step. I am wondering is it worth it to change
> > the dbus service path from org.ofono.cdma.voicecallmanager
> =

> Err, that is not a dbus service path.  The service path is always the =

> same, org.ofono.  What you're referring to is the dbus interface name.
> =

Thanks for the correction, I was referring to interface name.
> > to org.ofono.voicecallmanager? In this case, application doesn't need to
> > care about it's GSM modem or CDMA modem,
> > what they need to do is connecting to the same dbus path.
> =

> No, the API has been specifically designed to separate CDMA and GSM =

> details.  There are too many differences in the two systems and their =

> respective capabilities to mash them together.
They do have a lot of differences but not in dbus method layer. For example=
, ofono_voicecall_driver has methods like dial, answer, hangup all, hold_al=
l_active...etc, I believe cdma will have almost same methods like GSM. When=
 we are using them in application layer, we will call the same method name =
but different kind of modem driver.I am wondering why ofono created two dif=
ferent interface name and providethe same call method?
> =

> Regards,
> -Denis
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
 		 	   		 =20

--===============0419800572075470638==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+DQo8aGVhZD4NCjxzdHlsZT48IS0tDQouaG1tZXNzYWdlIFANCnsNCm1hcmdpbjowcHg7
DQpwYWRkaW5nOjBweA0KfQ0KYm9keS5obW1lc3NhZ2UNCnsNCmZvbnQtc2l6ZTogMTJwdDsNCmZv
bnQtZmFtaWx5OrdzstOp+sXpDQp9DQotLT48L3N0eWxlPjwvaGVhZD4NCjxib2R5IGNsYXNzPSdo
bW1lc3NhZ2UnPjxkaXYgZGlyPSdsdHInPkhpIERlbmlzLDxicj48YnI+PGRpdj4mZ3Q7IERhdGU6
IEZyaSwgMjEgSnVuIDIwMTMgMTA6NTg6NTMgLTA1MDA8YnI+Jmd0OyBGcm9tOiBkZW5rZW56QGdt
YWlsLmNvbTxicj4mZ3Q7IFRvOiBvZm9ub0BvZm9uby5vcmc8YnI+Jmd0OyBTdWJqZWN0OiBSZTog
Q0RNQSB2b2ljZWNhbGwgZHJpdmVyPGJyPiZndDsgPGJyPiZndDsgSGksPGJyPiZndDsgPGJyPiZn
dDsgT24gMDYvMTkvMjAxMyAwNzoyNCBQTSwgVGVuZ0Nob3UgWWFuZyB3cm90ZTo8YnI+Jmd0OyAm
Z3Q7IEhpIGFsbCw8YnI+Jmd0OyAmZ3Q7IEkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24gU2llcnJh
IG1vZGVtIChNQzU3MjhWKS4gTG9va3MgbGlrZSBDRE1BIGlzIG5vdDxicj4mZ3Q7ICZndDsgZnVs
bHkgc3VwcG9ydGVkIGZvciB0aGUgdm9pY2VjYWxsIHlldC48YnI+Jmd0OyAmZ3Q7IFdoYXQgSSBz
ZWUgZnJvbSBvZm9ubyBtYXN0ZXIgYnJhbmNoIHRoZXJlIGFyZSBvbmx5IHByb2JlLCByZW1vdmUs
IGRpYWwsPGJyPiZndDsgJmd0OyBoYW5ndXAgaGFkIGJlZW4gaW1wbGVtZW50ZWQuIEkgYW0gd29y
a2luZzxicj4mZ3Q7ICZndDsgb24gb3RoZXIncyBtZXRob2Qgc3RlcCBieSBzdGVwLiBJIGFtIHdv
bmRlcmluZyBpcyBpdCB3b3J0aCBpdCB0byBjaGFuZ2U8YnI+Jmd0OyAmZ3Q7IHRoZSBkYnVzIHNl
cnZpY2UgcGF0aCBmcm9tIG9yZy5vZm9uby5jZG1hLnZvaWNlY2FsbG1hbmFnZXI8YnI+Jmd0OyA8
YnI+Jmd0OyBFcnIsIHRoYXQgaXMgbm90IGEgZGJ1cyBzZXJ2aWNlIHBhdGguICBUaGUgc2Vydmlj
ZSBwYXRoIGlzIGFsd2F5cyB0aGUgPGJyPiZndDsgc2FtZSwgb3JnLm9mb25vLiAgV2hhdCB5b3Un
cmUgcmVmZXJyaW5nIHRvIGlzIHRoZSBkYnVzIGludGVyZmFjZSBuYW1lLjxicj4mZ3Q7Jm5ic3A7
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgZm9yIHRoZSBjb3JyZWN0aW9uLCBJIHdh
cyByZWZlcnJpbmcgdG8gaW50ZXJmYWNlIG5hbWUuPC9kaXY+PGRpdj48YnI+Jmd0OyAmZ3Q7IHRv
IG9yZy5vZm9uby52b2ljZWNhbGxtYW5hZ2VyPyBJbiB0aGlzIGNhc2UsIGFwcGxpY2F0aW9uIGRv
ZXNuJ3QgbmVlZCB0bzxicj4mZ3Q7ICZndDsgY2FyZSBhYm91dCBpdCdzIEdTTSBtb2RlbSBvciBD
RE1BIG1vZGVtLDxicj4mZ3Q7ICZndDsgd2hhdCB0aGV5IG5lZWQgdG8gZG8gaXMgY29ubmVjdGlu
ZyB0byB0aGUgc2FtZSBkYnVzIHBhdGguPGJyPiZndDsgPGJyPiZndDsgTm8sIHRoZSBBUEkgaGFz
IGJlZW4gc3BlY2lmaWNhbGx5IGRlc2lnbmVkIHRvIHNlcGFyYXRlIENETUEgYW5kIEdTTSA8YnI+
Jmd0OyBkZXRhaWxzLiAgVGhlcmUgYXJlIHRvbyBtYW55IGRpZmZlcmVuY2VzIGluIHRoZSB0d28g
c3lzdGVtcyBhbmQgdGhlaXIgPGJyPiZndDsgcmVzcGVjdGl2ZSBjYXBhYmlsaXRpZXMgdG8gbWFz
aCB0aGVtIHRvZ2V0aGVyLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhleSBkbyBoYXZlIGEg
bG90IG9mIGRpZmZlcmVuY2VzIGJ1dCBub3QgaW4gZGJ1cyBtZXRob2QgbGF5ZXIuPHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZTogMTJwdDsiPiZuYnNwO0ZvciBleGFtcGxlLCZuYnNwOzwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEycHQ7Ij5vZm9ub192b2ljZWNhbGxfZHJp
dmVyJm5ic3A7PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEycHQ7Ij5oYXMgbWV0aG9k
cyBsaWtlIGRpYWwsJm5ic3A7PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEycHQ7Ij5h
bnN3ZXIsIGhhbmd1cCBhbGwsIGhvbGRfYWxsX2FjdGl2ZS4uLmV0YywmbmJzcDs8L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMnB0OyI+SSBiZWxpZXZlIGNkbWEmbmJz
cDs8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTogMTJwdDsiPndpbGwgaGF2ZSBhbG1vc3Qg
c2FtZSZuYnNwOzwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMnB0OyI+bWV0aG9kcyZu
YnNwOzwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMnB0OyI+bGlrZSBHU00uIFdoZW4g
d2UgYXJlIHVzaW5nIHRoZW0gaW4mbmJzcDs8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOiAxMnB0OyI+YXBwbGljYXRpb24mbmJzcDs8L3NwYW4+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZTogMTJwdDsiPmxheWVyLCB3ZSB3aWxsIGNhbGwgdGhlJm5ic3A7PC9zcGFuPjxzcGFu
IHN0eWxlPSJmb250LXNpemU6IDEycHQ7Ij5zYW1lIG1ldGhvZCBuYW1lIGJ1dCBkaWZmZXJlbnQg
a2luZCBvZiBtb2RlbSBkcml2ZXIuPC9zcGFuPjwvZGl2PjxkaXY+SSBhbSB3b25kZXJpbmcgd2h5
IG9mb25vIGNyZWF0ZWQgdHdvIGRpZmZlcmVudCBpbnRlcmZhY2UgbmFtZSBhbmQgcHJvdmlkZTwv
ZGl2PjxkaXY+dGhlIHNhbWUgY2FsbCBtZXRob2Q/PC9kaXY+PGRpdj48YnI+Jmd0OyA8YnI+Jmd0
OyBSZWdhcmRzLDxicj4mZ3Q7IC1EZW5pczxicj4mZ3Q7IDxicj4mZ3Q7IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPiZndDsgb2Zvbm8gbWFpbGluZyBs
aXN0PGJyPiZndDsgb2Zvbm9Ab2Zvbm8ub3JnPGJyPiZndDsgaHR0cHM6Ly9saXN0cy5vZm9uby5v
cmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzxicj48L2Rpdj4gCQkgCSAgIAkJICA8L2Rpdj48L2Jv
ZHk+DQo8L2h0bWw+
--===============0419800572075470638==--

