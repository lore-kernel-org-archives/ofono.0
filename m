Content-Type: multipart/mixed; boundary="===============2241243148530748921=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: how to handle ofono_netreg_status_notify() without valid LAC or
 cellid or status
Date: Thu, 07 Sep 2017 22:49:15 +0200
Message-ID: <20170907224900.1cf64d44@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2241243148530748921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've noticed when using a Quectel EC20 (qmimodem) sometimes I see a LAC
and a cellid, sometimes I do not.
After looking into it, the problems lies in the ofono plugin api or in
the qmimodem driver. I'm unsure where I should fix this issue.

The problem:

The qmimodem notifies ofono about any change of lac, ci, tech or status.
But the qmimodem will only include those items which have been
changed, not all. But ofono doesn't allow only to update one single
item, only all of them at the same time.
 =

void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
                        int lac, int ci, int tech)
If lac or ci is `-1` it seems to mean invalid (TODO: create a define or
enum)

So how to fix this?

a) when something change, do another call to get all values from the
modem

b) extend the ofono api to allow `#define NO_CHANGE -2` for lac ci
tech, status

c) unlikely: buffer the old values in the driver/qmimodem code

d) ??

Regards,
Alexander

-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============2241243148530748921==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxteHNNc0FDZ2tRd3A2ZHBxRGYKaGdSM3JCQUF6NEh2OThjamYy
Tkt0R095NjFJOGh0a0ZMTFFoN1YzQk1qUmVnM2NwQTNVVTRLMXJ3ZDFDUGRaSgpVV2NSNnFiTGNz
TGxMOXpDNUlEb1Y4ZTd2NFliSDJRaEM3RTg4M0JjYkkyY2pPaG5tK1VGUVhDMHpFZE5kbkUwCnNI
blhybDRsME1GdStwWmRYc3lmZ3ljTTBSTDVDczFycUpyQ2lPMzU0elc5QlNGY1RvNzVsalRLMHJR
aGZKOFgKZXZxNGYrQ2lFMUw2R0hnS0plZVFnalV3aTU0NitLTGlsRGNiT1lpSXlIQllNY0d1eVRY
MmszWW1xQWlremZGYgpma240OHhCVU1Damtqd1lBbDJ0b3ZWN3E5U2Q4Z2lTSGUwZVRTTXRwK3hL
L2RrOVJwYm1KZ0NWVGtNL0JXNEI3CnEvVHAyb0xuZUZvWm5zL0c1MzBra1Bzc3UxV2oraGQvKytG
OEFCcHZkV0xSWVBCV2tubG5BYjIwM2ZPYVB6Ri8KYTlPTjlROE5XcUZySFYrZlJtRGtDOEEzMitO
cU11dnEyc3YzSFlTUjdqaGprbGZzdDdaaHRlWWpCemUyN1VMZwphSk1XRHFjM3NYUnlWQVZQVzZQ
cHo5WXpLWHlPbGZNQTA3TS9LWW5pQ253K1JvQzFUWEtUNWJCZFF6cHhlQnJVCjl4YmxGVkErV2dh
bkVmNWhpVE1rdlNZTzk0WlNadGRYN0VhUkxZWFhCZ1lwTVcwYlZYZC9VZFJlMUFKaDY1K3oKc3ls
dURYYlR0eFZhYms3Wm1QdW8vZ29EWXN6UXI3aUF5cGpCSjlSYUJOS0RsTUJIUXB0Y083SE55Wk5Y
eENNTgpQODVSMzNvZm9sb0hSd05SRytkblVWUlN4RXdiMGY5QS9jV3ZNdWVhRjJ4cG14N2pqOHM9
Cj1jeWlqCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============2241243148530748921==--

