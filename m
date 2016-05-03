Content-Type: multipart/mixed; boundary="===============5714236921531649740=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Tue, 03 May 2016 10:27:57 +0200
Message-ID: <5728610D.5020105@kerlink.fr>
In-Reply-To: <87a8k8p5rt.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5714236921531649740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B8rn,

Firstly, thank you for your previous patches which help me a lot.

On 02/05/2016 22:24, Bj=C3=B8rn Mork wrote:
> Martin Chaplet <m.chaplet@kerlink.fr> writes:
>
>> +# Sierra MC73xx (wwan0 is buggy,
> I suspect this is a raw-ip vs 802.3 issue. For example: wwan0 might be
> configured for raw-ip if firmware autoconnect is enabled. You should be
> able to detect this with a QMI_WDA "Get Data Format" request.
>
> In general, both interfaces 8 and 10 are usable on these modems.

You are so right !

However, WDA service is not yet supported in qmimodem.
So I think we can keep the interface matching on QMI interface no 10 for
now because  using interface 8 will imply changing its default link
layer at each boot.

What's your opinion ?

Best regards,

Martin

--===============5714236921531649740==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRm
LTgiIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgPC9oZWFkPgogIDxib2R5IGJnY29sb3I9
IiNGRkZGRkYiIHRleHQ9IiMxMDZmOWMiPgogICAgSGkgQmrDuHJuLDxicj4KICAgIDxicj4KICAg
IEZpcnN0bHksIHRoYW5rIHlvdSBmb3IgeW91ciBwcmV2aW91cyBwYXRjaGVzIHdoaWNoIGhlbHAg
bWUgYSBsb3QuPGJyPgogICAgPGJyPgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5P
biAwMi8wNS8yMDE2IDIyOjI0LCBCasO4cm4gTW9yayB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAg
IDxibG9ja3F1b3RlIGNpdGU9Im1pZDo4N2E4azhwNXJ0LmZzZkBuZW1pLm1vcmsubm8iIHR5cGU9
ImNpdGUiPgogICAgICA8cHJlIHdyYXA9IiI+TWFydGluIENoYXBsZXQgPGEgY2xhc3M9Im1vei10
eHQtbGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOm0uY2hhcGxldEBrZXJsaW5rLmZyIj4mbHQ7
bS5jaGFwbGV0QGtlcmxpbmsuZnImZ3Q7PC9hPiB3cml0ZXM6Cgo8L3ByZT4KICAgICAgPGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgPHByZSB3cmFwPSIiPisjIFNpZXJyYSBNQzczeHgg
KHd3YW4wIGlzIGJ1Z2d5LAo8L3ByZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8cHJlIHdy
YXA9IiI+Ckkgc3VzcGVjdCB0aGlzIGlzIGEgcmF3LWlwIHZzIDgwMi4zIGlzc3VlLiBGb3IgZXhh
bXBsZTogd3dhbjAgbWlnaHQgYmUKY29uZmlndXJlZCBmb3IgcmF3LWlwIGlmIGZpcm13YXJlIGF1
dG9jb25uZWN0IGlzIGVuYWJsZWQuIFlvdSBzaG91bGQgYmUKYWJsZSB0byBkZXRlY3QgdGhpcyB3
aXRoIGEgUU1JX1dEQSAiR2V0IERhdGEgRm9ybWF0IiByZXF1ZXN0LgoKSW4gZ2VuZXJhbCwgYm90
aCBpbnRlcmZhY2VzIDggYW5kIDEwIGFyZSB1c2FibGUgb24gdGhlc2UgbW9kZW1zLjwvcHJlPgog
ICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgWW91IGFyZSBzbyByaWdodCAhPGJyPgogICAg
PGJyPgogICAgSG93ZXZlciwgV0RBIHNlcnZpY2UgaXMgbm90IHlldCBzdXBwb3J0ZWQgaW4gcW1p
bW9kZW0uPGJyPgogICAgU28gSSB0aGluayB3ZSBjYW4ga2VlcCB0aGUgaW50ZXJmYWNlIG1hdGNo
aW5nIG9uIFFNSSBpbnRlcmZhY2Ugbm8gMTAKICAgIGZvciBub3cgYmVjYXVzZcKgIHVzaW5nIGlu
dGVyZmFjZSA4IHdpbGwgaW1wbHkgY2hhbmdpbmcgaXRzIGRlZmF1bHQKICAgIGxpbmsgbGF5ZXIg
YXQgZWFjaCBib290Ljxicj4KICAgIDxicj4KICAgIFdoYXQncyB5b3VyIG9waW5pb24gPzxicj4K
ICAgIDxicj4KICAgIEJlc3QgcmVnYXJkcyw8YnI+CiAgICA8YnI+CiAgICBNYXJ0aW48YnI+CiAg
PC9ib2R5Pgo8L2h0bWw+Cg==

--===============5714236921531649740==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEtHRVVBQW9KRU1KT2oxZU15ZGkva29FUC9ST3JDZmVM
MW9QSFBQRzRKTjRPcVdCZwpPYXJ4eWVJRmRVR0dGRE03NHNrYlpKWHlGbjliZ3NTRnRzZXhBeDdi
MzFuQ1lCSGNHZ0ZKbm90STgyOE9XRlZGCndNYzVLVlhVZ3pxbnhZWmtDaERCUTd0S2ptdVAydkRw
L1A1d1ZoZEVjaTdSVndkRjNnekNzOWhlT0VDK1BWNEQKcXRhSThXVW5VY0pYdURrSE1QMUhBWVlS
ZnFuQ3pXSTBRT21JemtkTG1rbHRtRS9HajlwV0k3N3g4RjQ0aWNwWQovVXl4SFg2dFQ0OEFQYWNH
WlA3aDdvRDBQSWQzOUNCaWozYy9FVCtZL2NhSFpVTjZhWjVUbGhOVXMvYnR1MmZyClVwTlRrRkhR
TmJWNHc4aHE1RSs2NUJGQ3EvZzlXdnVWLzV1SXNQeHR5ZjY0dE4vTmpyNFRXN09CbmlodHovS2QK
ZlE0RTB5K3RBQ1dEUnpURmlKVklCQm5LdWdnV3RsQ3c1emMvdHdGRnVmZHc5dnpweXoyZ2FHeURp
R0Rwb2lZaAordDJaNVNvUVlsMExtTTEvaHJCclJVRkdFV2pldHZndkhoTzVadW16c2x5bHBNTmRO
MU1sbWJRTzhqU0dQQUpLCnRvQWc1V1pvcG5xdWYwR3IzdTBUTnliZjNvWWRBVkoyTGxPbDFXZzZY
aG1pYUFFUCt6aUhlZkpFSG1FQlBLWnUKZnB6N0JWZmNRRDZIMlFZblpHTmR5ZWN5SjhhMDVOYm5Y
VTJEcWkzSTRNZEUzT0V2TkF1dGRNOTdzNVc4cmNpTQo5ZjgwQm1PK0ZsK3MrYmZWOWNZMDIwbWxU
Yk9iZDliTnlvOUZQdllQNEFzZnVGUk9rNzE3UVV5WTZmbjZwR2JYCmh1UlI2OGlFWUo5RUhITitI
RHh2Cj02dDdOCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============5714236921531649740==--

