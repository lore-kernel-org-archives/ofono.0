Content-Type: multipart/mixed; boundary="===============7170919096089481250=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Wed, 25 Sep 2019 08:40:49 +0200
Message-ID: <CAHB-PjnNh4x8EwyWX0MKNvUnRZLWta0BRjpVBRZaNkARRPzcBA@mail.gmail.com>
In-Reply-To: <20190924195533.GA10695@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7170919096089481250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Den tis 24 sep. 2019 kl 21:55 skrev Pavel Machek <pavel@ucw.cz>:

> On Tue 2019-09-24 18:01:26, Jonas Bonn wrote:
> > uBlox devices present their USB interfaces well before those interfaces
> > are ready to respond to any commands.  The documentation says to monitor
> > the 'greeting text' to detect readiness, but this 'greeting text' is not
> > actually specified for any device other than the TOBY L4.
>
> Collecting "greeting texts" from all the modems we want to support
> should not be hard, right?
>

I don't think that's a good idea. What if ofono is restated and the modem
is still running?

--Richard

--===============7170919096089481250==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+RGVuIHRpcyAyNCBzZXAuIDIwMTkga2wgMjE6
NTUgc2tyZXYgUGF2ZWwgTWFjaGVrICZsdDs8YSBocmVmPSJtYWlsdG86cGF2ZWxAdWN3LmN6Ij5w
YXZlbEB1Y3cuY3o8L2E+Jmd0Ozo8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij5PbiBUdWUgMjAxOS0wOS0yNCAxODowMToyNiwgSm9uYXMgQm9ubiB3cm90ZTo8YnI+CiZn
dDsgdUJsb3ggZGV2aWNlcyBwcmVzZW50IHRoZWlyIFVTQiBpbnRlcmZhY2VzIHdlbGwgYmVmb3Jl
IHRob3NlIGludGVyZmFjZXM8YnI+CiZndDsgYXJlIHJlYWR5IHRvIHJlc3BvbmQgdG8gYW55IGNv
bW1hbmRzLsKgIFRoZSBkb2N1bWVudGF0aW9uIHNheXMgdG8gbW9uaXRvcjxicj4KJmd0OyB0aGUg
JiMzOTtncmVldGluZyB0ZXh0JiMzOTsgdG8gZGV0ZWN0IHJlYWRpbmVzcywgYnV0IHRoaXMgJiMz
OTtncmVldGluZyB0ZXh0JiMzOTsgaXMgbm90PGJyPgomZ3Q7IGFjdHVhbGx5IHNwZWNpZmllZCBm
b3IgYW55IGRldmljZSBvdGhlciB0aGFuIHRoZSBUT0JZIEw0Ljxicj4KPGJyPgpDb2xsZWN0aW5n
ICZxdW90O2dyZWV0aW5nIHRleHRzJnF1b3Q7IGZyb20gYWxsIHRoZSBtb2RlbXMgd2Ugd2FudCB0
byBzdXBwb3J0PGJyPgpzaG91bGQgbm90IGJlIGhhcmQsIHJpZ2h0Pzxicj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+PC9kaXY+PGRpdj5JIGRvbiYjMzk7dCB0aGluayB0aGF0JiMzOTtzIGEgZ29vZCBp
ZGVhLiBXaGF0IGlmIG9mb25vIGlzIHJlc3RhdGVkIGFuZCB0aGUgbW9kZW0gaXMgc3RpbGwgcnVu
bmluZz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0tUmljaGFyZDwvZGl2PjwvZGl2PjwvZGl2
Pgo=

--===============7170919096089481250==--

