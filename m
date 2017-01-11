Content-Type: multipart/mixed; boundary="===============2891013912292086541=="
MIME-Version: 1.0
From: Naveen Kumar Danturi <naveendanturi@gmail.com>
Subject: Regarding multiple APN support in ofono/connman
Date: Wed, 11 Jan 2017 13:39:16 -0600
Message-ID: <CAN3FBZa__Ki3eCsedpFr9zQucKmVUs=pB3jPeNJPMmmnV==EbQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2891013912292086541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ofono team,
Is there a support in ofono for multiple PDN connections in parallel ? If
so what interfaces/API's it exposes to connman to manage multiple APN's ?
If so, I have these 2 questions :

a)  How ofono/connman able to construct / destruct routing tables on data
connections for multiple APNs and makes sure that IP traffic goes to the
right IP interface/APN ?

b)How ofono/connman ensures that domain name searches are performed via
right IP interface/APN to the right name server. Provide mechanism to keep
track of name servers associated with each APN ? I believe Linux only
provides a mechanism for a single APN via /etc/resolv.con

c) Is it configurable from upper layers to ensure that if IPV6 is available
then IPV6 routing and name discovery is used ?

Probably some of these Questions may come under connman context adding here
just in case if anyone has experience with it?



Thanks,
Naveen

--===============2891013912292086541==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgT2Zvbm8gdGVhbSw8ZGl2PklzIHRoZXJlIGEgc3VwcG9ydCBpbiBv
Zm9ubyBmb3IgbXVsdGlwbGUgUEROIGNvbm5lY3Rpb25zIGluIHBhcmFsbGVsID8gSWYgc28gd2hh
dCBpbnRlcmZhY2VzL0FQSSYjMzk7cyBpdCBleHBvc2VzIHRvIGNvbm5tYW4gdG8gbWFuYWdlIG11
bHRpcGxlIEFQTiYjMzk7cyA/IElmIHNvLCBJIGhhdmUgdGhlc2UgMiBxdWVzdGlvbnMgOjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+YSkgwqBIb3cgb2Zvbm8vY29ubm1hbiBhYmxlIHRvIGNvbnN0
cnVjdCAvIGRlc3RydWN0IHJvdXRpbmcgdGFibGVzIG9uIGRhdGEgY29ubmVjdGlvbnMgZm9yIG11
bHRpcGxlIEFQTnMgYW5kIG1ha2VzIHN1cmUgdGhhdCBJUCB0cmFmZmljIGdvZXMgdG8gdGhlIHJp
Z2h0IElQIGludGVyZmFjZS9BUE4gPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YilIb3cgb2Zv
bm8vY29ubm1hbiBlbnN1cmVzIHRoYXQgZG9tYWluIG5hbWUgc2VhcmNoZXMgYXJlIHBlcmZvcm1l
ZCB2aWEgcmlnaHQgSVAgaW50ZXJmYWNlL0FQTiB0byB0aGUgcmlnaHQgbmFtZSBzZXJ2ZXIuIFBy
b3ZpZGUgbWVjaGFuaXNtIHRvIGtlZXAgdHJhY2sgb2YgbmFtZSBzZXJ2ZXJzIGFzc29jaWF0ZWQg
d2l0aCBlYWNoIEFQTiA/IEkgYmVsaWV2ZSBMaW51eCBvbmx5IHByb3ZpZGVzIGEgbWVjaGFuaXNt
IGZvciBhIHNpbmdsZSBBUE4gdmlhIC9ldGMvcmVzb2x2LmNvbjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+YykgSXMgaXQgY29uZmlndXJhYmxlIGZyb20gdXBwZXIgbGF5ZXJzIHRvIGVuc3VyZSB0
aGF0IGlmIElQVjYgaXMgYXZhaWxhYmxlIHRoZW4gSVBWNiByb3V0aW5nIGFuZCBuYW1lIGRpc2Nv
dmVyeSBpcyB1c2VkID88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlByb2JhYmx5IHNvbWUgb2Yg
dGhlc2UgUXVlc3Rpb25zIG1heSBjb21lIHVuZGVyIGNvbm5tYW4gY29udGV4dCBhZGRpbmcgaGVy
ZSBqdXN0IGluIGNhc2UgaWYgYW55b25lIGhhcyBleHBlcmllbmNlIHdpdGggaXQ/PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9k
aXY+PGRpdj5OYXZlZW48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48L2Rpdj4K

--===============2891013912292086541==--

