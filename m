Content-Type: multipart/mixed; boundary="===============5691691355828567088=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] ublox: network-registration: Check ureg for tech also for
 L2 modems
Date: Wed, 25 Sep 2019 08:45:52 +0200
Message-ID: <CAHB-Pj=eCSmyuMOHyRGfJB8jqOVEZv+oXZEm0KQ7tuTqGe8oLQ@mail.gmail.com>
In-Reply-To: <b3aa0488-0ec9-54a8-ebc6-671969b810cb@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5691691355828567088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas

Den ons 25 sep. 2019 kl 06:05 skrev Jonas Bonn <jonas@norrbonn.se>:

>
> For the TOBY-L4, RAT changes won't trigger a CREG URC... for whatever
> reason, this command is so brittle that they needed to bypass it with a
> UREG command.  For the L2, they don't bother to document this, but it
> appears to suffer from the same deficiencies as the L4.  CGREG and
> friends appear to suffer from the same ailment... they don't have a firm
> grasp of the overall state so they return "unknown" as a fallback.
>

For CGREG unknown seems to be used when the modem is running LTE,
at least for L2, which kind of make sense I guess. Since cereg is what to be
used at that time.

But I also have a bad feeling about CREG and L2, most often CREG URC's are
sent,
but not always. And sometimes like here the CREG URC has the wrong tech.

I'm starting to think if we should also subscribe to UREG in netreg for
ublox,
but thats another commit ;-)

--Richard

--===============5691691355828567088==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBKb25hczwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkRlbiBvbnMgMjUgc2VwLiAy
MDE5IGtsIDA2OjA1IHNrcmV2IEpvbmFzIEJvbm4gJmx0OzxhIGhyZWY9Im1haWx0bzpqb25hc0Bu
b3JyYm9ubi5zZSI+am9uYXNAbm9ycmJvbm4uc2U8L2E+Jmd0Ozo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxi
cj4KRm9yIHRoZSBUT0JZLUw0LCBSQVQgY2hhbmdlcyB3b24mIzM5O3QgdHJpZ2dlciBhIENSRUcg
VVJDLi4uIGZvciB3aGF0ZXZlciA8YnI+CnJlYXNvbiwgdGhpcyBjb21tYW5kIGlzIHNvIGJyaXR0
bGUgdGhhdCB0aGV5IG5lZWRlZCB0byBieXBhc3MgaXQgd2l0aCBhIDxicj4KVVJFRyBjb21tYW5k
LsKgIEZvciB0aGUgTDIsIHRoZXkgZG9uJiMzOTt0IGJvdGhlciB0byBkb2N1bWVudCB0aGlzLCBi
dXQgaXQgPGJyPgphcHBlYXJzIHRvIHN1ZmZlciBmcm9tIHRoZSBzYW1lIGRlZmljaWVuY2llcyBh
cyB0aGUgTDQuwqAgQ0dSRUcgYW5kIDxicj4KZnJpZW5kcyBhcHBlYXIgdG8gc3VmZmVyIGZyb20g
dGhlIHNhbWUgYWlsbWVudC4uLiB0aGV5IGRvbiYjMzk7dCBoYXZlIGEgZmlybSA8YnI+CmdyYXNw
IG9mIHRoZSBvdmVyYWxsIHN0YXRlIHNvIHRoZXkgcmV0dXJuICZxdW90O3Vua25vd24mcXVvdDsg
YXMgYSBmYWxsYmFjay48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+Rm9yIENH
UkVHIHVua25vd24gc2VlbXMgdG8gYmUgdXNlZCB3aGVuIHRoZSBtb2RlbSBpcyBydW5uaW5nIExU
RSw8L2Rpdj48ZGl2PmF0IGxlYXN0IGZvciBMMiwgd2hpY2gga2luZCBvZiBtYWtlIHNlbnNlIEkg
Z3Vlc3MuIFNpbmNlIGNlcmVnIGlzIHdoYXQgdG8gYmU8L2Rpdj48ZGl2PnVzZWQgYXQgdGhhdCB0
aW1lLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QnV0IEkgYWxzbyBoYXZlIGEgYmFkIGZlZWxp
bmcgYWJvdXQgQ1JFRyBhbmQgTDIsIG1vc3Qgb2Z0ZW4gQ1JFRyBVUkMmIzM5O3MgYXJlIHNlbnQs
PC9kaXY+PGRpdj5idXQgbm90IGFsd2F5cy4gQW5kIHNvbWV0aW1lcyBsaWtlIGhlcmUgdGhlIENS
RUcgVVJDIGhhcyB0aGUgd3JvbmcgdGVjaC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5
O20gc3RhcnRpbmcgdG8gdGhpbmsgaWYgd2Ugc2hvdWxkIGFsc28gc3Vic2NyaWJlIHRvIFVSRUcg
aW4gbmV0cmVnIGZvciB1YmxveCw8L2Rpdj48ZGl2PmJ1dCB0aGF0cyBhbm90aGVyIGNvbW1pdCA7
LSk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0tUmljaGFyZMKgPC9kaXY+PC9kaXY+PC9kaXY+
Cg==

--===============5691691355828567088==--

