Content-Type: multipart/mixed; boundary="===============6789613387006423846=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Sat, 12 May 2018 16:19:32 +0200
Message-ID: <20180512161842.7a68dc38@lazus.yip>
In-Reply-To: <40c47311-04c7-20ab-7bf9-0228e2ce85fe@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6789613387006423846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

nice to hear, somebody else is using it.

The voicecall driver needs to be refactored as Denis already pointed
out on the mailinglist before it can go upstream.

The original idea of the voice_generated.c/h files was to create a
prototype how qmi generated files should look like and then write a
code generator for it, as the other qmi related projects already do.

I'ven't yet took a closer look on your patches together with modems and
a gsm network. Hopefully I can do it next week together with the
required refactoring for upstream.

Best,
lynxis
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============6789613387006423846==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxyMjkvUUFDZ2tRd3A2ZHBxRGYKaGdUa1FSQUF2YUVrcXMxZTY3
K2cwSUFCdkxtcjFBRzFybVgzeHFuWTM3cDNmMmE5VnpLeGpJWTAvYUNiamFLMAp2bEQzZnpKK2xB
TkVwdS9GT2t3S2JSNTEraTU4M0t3dFNQYUxKeENWR2ttRkxlZExlckR1cUFkUWc0SUFFSWk3CjZj
QkY5UnBWSVgzei91c2p0L2VUT1l2MDlzZTQwTnd4ZjdmV3RxQ2h4N2pINUJOdEtqYSt6SVhOYmdL
RWFnS0IKNDZFdEVaVmh4Wk45aVNveTZXclVJZ1FJaXI0Q3RjR1hhbTU4eUpjRlNwUmwvQlJFUVd5
UmxqY09OMHV2dzN4VAo1MUtGQlhDMGU3VHRBRVdKQXF2SDEyKzFZSFFyQXgwOXhjbFAxTmY3bitT
Q0pwK3hhRzNHSlJPNm5jVDJkTGIwCjc4aUpoY2JvUVZBdUJ1RnVGUzlFTHZSa1dmSGJjUm1uSDR5
eGNiSGZoNURRdW45Mm10MVVHeGNoYThVc2F3T1MKZmdnS3Jxb3ljT2hoNkRWU05lMzBKUC9GaDE2
WTk3cUtySGlsKzFyNXdVb0pEOGpRYlpvd3JkRDVNYXFSNFNaYQplSVZ1NFMzTDN6SkZRY2NldndS
MUpKWDJTckNRcXRUaVZMalh2ZnVLRzRvQ1F0SWZsVzdmT0F4VlRRYkFMZWlRCitLejQ5aUlnbXBN
QVpjM2k1cFNqSFN5QWdONWEyL09XNXBTN1Z1bDFKOXpGaEk0emYzdi9VNTM0a2liY1BTdHAKd3Az
Y2QzaFlHYnhaTDRzcGU5VEx3cW5MWml3Uzc2Q09uY0lZL1ExQnBYdDN5ZXZMWVdudlBZWktJblNq
R21YUwphZ3NSZmdVcWNsZXZQNnR3MW1wOHdJVmFDblV2am9HYlhWeFpCU1F5dkRBbjJNTWVSK1U9
Cj10bDc3Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============6789613387006423846==--

