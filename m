Content-Type: multipart/mixed; boundary="===============0530191895912913839=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 16:27:33 +0100
Message-ID: <20180301162733.298f3eef@lazus.yip>
In-Reply-To: <e10fa5c9-24ea-3af8-651f-2f43a49670e7@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0530191895912913839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

thanks for your patch.
I'm actually having problem from time to time with ofono (quectel
ec 20) when using LTE. Ofono has 2 contexts allocated, but it says
it's detached to packet switched.

I hope your patch is fixing this.

In the LTE atom, you're setting the profile 1.
Does it really have to be profile 1. Is the profile 1 a special profile
which should not be removed?! Or how is it ensured, this can not be
removed?

I'm also asking, because ofono/qmi doesn't really support ipv4, ipv6 and
dual contexts. For this we need to manage exactly those profiles and
use them when starting the contexts. Atm requesting an ipv4
context can result in requesting a Dual context depending if the
network (SGSN/GGSN) supports it.

Best,
lynxis
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============0530191895912913839==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxxWUcrVUFDZ2tRd3A2ZHBxRGYKaGdRZ3dBLy9jLzM0UGk4VEJt
cytZbFVXbW9rcEFpUXdaQ09vT0dhZ3VCcVcwNm1xRjdqbFFZcG5GYkxMYzhHKwpONlpPbkRiVmVF
R3dudnh3UVF0SWJSdmpqdlZrUzdIdTJYeXZHUUZMNElXdU5jQXVxdHhXbllXbmRDWHFUT0hJCmxy
L3BNYzd1a3I3WXVRdU1NdzVRdmp6TW9BY1RsNHlBVzIydWJQTjRiWXF2MzJrYTZ0aUIzRUkzbncr
UEl5aHoKUkxlSjBNTG5jVUg0WjRKRGxlVjZ3bXhKaEloYVEwb2R0SmM5QUtBQm1lRVpjN3I2Y2xi
MEpHZXlWeFg0cWx0WApxL1lsODBaelBOUE9GYnd1Yk4zbjFUaVk4U0JRZzhqWmZ5WGU5aHFEQlZu
Q2dQQUdhdkEyaVd4ZnBkNkxKdG51CmRzc1RvbjRUR2hRQVMzUm51ZkpReWxnNk5tcUJ6ZlI4clo0
UUFOeVZYUVZoejFZSHdsOVNDZm9jVnNZYVUxdGIKelpPL2Jlc2ZtaUppNXlzVWs4NGVWVCt2T2F5
RndEbDIrSWlwVk5ERTZza2dWNWkzRS9QS083dnUwN3VoYjlUNApqaTZ1UVVlcmRrTDZHaTFOclFG
RjZmMXc4dnNLK2toTVNpOEJnbUQ0U2RHL3R6WXVITzUzOStUMzF5OFc5eEJKCkVqWjRFNG9TV2FG
QTJLSTlMbDZmSjAzRkR6bW90L3pNekdPSmRQenA1MzJ1RXhxUXQvbVZnaEpZbEFmQndlR2kKVDZN
V1JrWUtrejlZSU1LTU1YQU5JUnlFZFZnR1cxcXg5d21BR21hY2RCSEI5Tml1OEFSKytlQzVieDF0
V3BVVQpmQlZybXQ2bDRDZFBPMkxma1hXaHhaYWV1VkNVN0tJOTlIcWlsbTJoN1gvZmhxZWtyUlE9
Cj1DNzgrCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============0530191895912913839==--

