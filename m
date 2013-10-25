Content-Type: multipart/mixed; boundary="===============3311998521574718578=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: huawei cdc_ncm devices
Date: Fri, 25 Oct 2013 16:48:34 +0200
Message-ID: <CABvLYuDvL=JszrahRwzwdnOTKbomWzG7dsgajzkVTL-uEc1VNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3311998521574718578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

i'm trying to add support for the Huawei E3276 using a cdc_ncm interface.
To activate the pdp context for this device i need to send:
1. AT^NDISDUP=3D1,1
2. wait for an unsollicited reply ^NDISSTAT:
3. start a dhcp client on the wwanX interface

The huaweimodem gprs-context driver already implement AT^NDISDUP, but is
trying to get the ip address with AT^DHCP?. However this driver is not
being used.

Can i remove the code to send and handle AT^DHCP?, and replace with
^NDISSTAT?
Or should i keep it and add checks to see which at commands are supported?

thanks,
Cedric

--===============3311998521574718578==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksoDxkaXY+PGJyPjwvZGl2PjxkaXY+aSYjMzk7bSB0cnlpbmcgdG8g
YWRkIHN1cHBvcnQgZm9yIHRoZSBIdWF3ZWkgRTMyNzYgdXNpbmcgYSBjZGNfbmNtIGludGVyZmFj
ZS48L2Rpdj48ZGl2PlRvIGFjdGl2YXRlIHRoZSBwZHAgY29udGV4dCBmb3IgdGhpcyBkZXZpY2Ug
aSBuZWVkIHRvIHNlbmQ6PC9kaXY+PGRpdj4xLiBBVF5ORElTRFVQPTEsMTwvZGl2PjxkaXY+CjIu
IHdhaXQgZm9yIGFuIHVuc29sbGljaXRlZCByZXBseSBeTkRJU1NUQVQ6oDwvZGl2PjxkaXY+My4g
c3RhcnQgYSBkaGNwIGNsaWVudCBvbiB0aGUgd3dhblggaW50ZXJmYWNlPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5UaGUgaHVhd2VpbW9kZW0gZ3Bycy1jb250ZXh0IGRyaXZlciBhbHJlYWR5IGlt
cGxlbWVudCBBVF5ORElTRFVQLCBidXQgaXMgdHJ5aW5nIHRvIGdldCB0aGUgaXAgYWRkcmVzcyB3
aXRoIEFUXkRIQ1A/LiBIb3dldmVyIHRoaXMgZHJpdmVyIGlzIG5vdCBiZWluZyB1c2VkLjwvZGl2
Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkNhbiBpIHJlbW92ZSB0aGUgY29kZSB0byBzZW5kIGFuZCBo
YW5kbGUgQVReREhDUD8sIGFuZCByZXBsYWNlIHdpdGggXk5ESVNTVEFUPzwvZGl2PjxkaXY+T3Ig
c2hvdWxkIGkga2VlcCBpdCBhbmQgYWRkIGNoZWNrcyB0byBzZWUgd2hpY2ggYXQgY29tbWFuZHMg
YXJlIHN1cHBvcnRlZD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnRoYW5rcyw8L2Rpdj4KPGRp
dj5DZWRyaWM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============3311998521574718578==--

