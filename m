Content-Type: multipart/mixed; boundary="===============3220252485440331457=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: connmand[186]: Online check failed but running dhclient manually
 fixes this issue
Date: Tue, 05 Sep 2017 16:46:24 +0200
Message-ID: <20170905164624.290cc274@lazus.yip>
In-Reply-To: <11ad24fd-f5f9-fa4c-6be5-90ac6a9ff74f@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3220252485440331457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Aug 2017 12:47:28 +0200
Daniel Wagner <wagi@monom.org> wrote:

> >    Bus 001 Device 003: ID 1bc7:1201 Telit Wireless Solutions  =

> =

> Here is a compile tested 'fix'. I don't know if this works and\
> obviously it doesn't follow the coding guide lines for this
> project. If you could test this and report back the outcome
> that would be really helpful. Then I can create a proper
> patch for Denis.

I can confirm this bug with an quectel ec20 using the firmware
EC20EQAR02A13E2G  1  [Jul  5 2017 10:49:17].

To reproduce using ofono w/o connman. linux 4.12.8
- call ofono "../context1 Active true"
- set the ip by hand. No ping response.
- using dhcpcd. Ping responses.

The `ip addr show` looks the same, except the interface has now an ipv6
link local address. Is this is problem of modern LTE cards?
Could be raw-ip or 802.3 encapsulations the problem?

Regards,
lynxis

--===============3220252485440331457==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxtdXVNQUFDZ2tRd3A2ZHBxRGYKaGdTWlpRLy9TbEp0WDJGWmg4
OVVxTmlxeEFvMW5URG9yRk9CKytMUENqR0tVaGlvZWl4TU5SSUt3b2RwVGxEWQozYjVjK2IwbEVF
a3N2Z0doRzR5T2g2YkFtU0hERlJQaEpZOGdKMWFwbXd1YytoWDZBc2M5azNUaUtvQnlUZlRaCm5r
S3hpRjJpNUFzVmEwMGNmSHBLMWhPdkRGZWRPNGNIakM0bzFWM0ZaNm1Ga2I5VzAyNjBYOWM5bENh
a09FTXIKM2plQVFFYkNBMUs1M211Y09YOU0zNlZEWFc2TDlhU2tDN2VWcDV6aVpFVnNtbWRiWm1t
NGc2cHNuQ08vdmJ6TAp2bytiWDlFbXBnL1llU0xCaW4yOVVVNmxBVTliTTJaM29tM2V4b2h5c3pZ
V0RvSU5jaDRrUkpkbEJ6OHhCckE2CmwvMUNQRlJZUmpDL3UvZjlPeXNtQmYvaThrSC9rdVN0Nk52
RFZsK2Z6eDFNdTZuMGNTR2xqaSs2VlRvaGhNdngKaE9rUFk1SE1LaTFJbUJPOHJOaVlTcEsrRith
ait3bDZleEFJQnhwUHdRL0xKczhZaEtLK2xrc2R3NE9zTHZrMgpjcnlJWEtMZ3VKcW9KMVNodEh2
UEdyaGxKUmZQZEViRnZhQkZHSHZTVUFXZlVyVmdiNFRINTVXL1BQL0NTZGlHCjRaNnBKeU1FQlk4
aXBsYkpOK21GNnVYazdiMGdQSUVodHJKdmd5eXNDZ1N3K0lIc3I3Z0JLeDZ5QU8vYTN4SUsKdU1B
ajJLbE1RT1M0djlyS0FWQ1JPb01uOGJMeHN4OW9qd0MwcWVLQ201Ui9ZSE80WE9rZVJqNVIxM0wr
a1p2cQorcStUM0FaREVTWjRTSktJZVo4RXVXR0NrbXlONWxwZ0szMTdXZFM4YlZJNUtSVU8yczQ9
Cj1OajczCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============3220252485440331457==--

