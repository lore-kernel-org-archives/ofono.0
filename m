Content-Type: multipart/mixed; boundary="===============0140692732093274542=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 19:15:27 +0200
Message-ID: <572396AF.601@kerlink.fr>
In-Reply-To: <57238FFF.8050601@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0140692732093274542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 29/04/2016 18:46, Martin Chaplet wrote:
>
>>
>> Does libqmi actually have low-level sim read capability?
>
> Yes, it seems so :
>
> $ qmicli -d /dev/cdc-wdm0 --help-uim
> UIM options
>  =

> --uim-read-transparent=3D[0xNNNN,0xNNNN,...]                             =
              =

> Read a transparent file given the file path
>  =

> --uim-get-file-attributes=3D[0xNNNN,0xNNNN,...]                          =
              =

> Get the attributes of a given file
>  =

> --uim-get-card-status                                                    =
            =

> Get card status
>  =

> --uim-reset                                                              =
            =

> Reset the service state
>   --uim-noop   =

>
> I'm not used to QMI but I will try to compare libqmi and ofono's
> read_transparent implementations.
>
>>
>> Another thing to try would be to implement read_imsi() method for
>> drivers/qmimodem/sim.c.  This should get you to the point where gprs
>> is initialized even if all low-level reads from the SIM fail.
>
> It seems a great idea.
>
>

It's an excellent idea !
Looking for read_imsi implementation, I found qmimodem-legacy which fit
prefectly to my modem.
After a few fix because first Sierra net interface is buggy (wwan0), I'm
now enable to use fully "Connman - ofono"  features

I will try to cleanup my work, find a way to force use of
qmimodem-legacy for this Sierra chip and submit all these modifications.

Thanks again Denis

Best regards,

Martin


--===============0140692732093274542==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIDxicj4KICAgIDxicj4K
ICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMjkvMDQvMjAxNiAxODo0NiwgTWFy
dGluIENoYXBsZXQKICAgICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZSBj
aXRlPSJtaWQ6NTcyMzhGRkYuODA1MDYwMUBrZXJsaW5rLmZyIiB0eXBlPSJjaXRlIj4KICAgICAg
PG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXdpbmRvd3MtMTI1MiIKICAgICAgICBo
dHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIGNp
dGU9Im1pZDo1NzIzODU1OS45MDQwNTA1QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+IDxicj4KICAg
ICAgICBEb2VzIGxpYnFtaSBhY3R1YWxseSBoYXZlIGxvdy1sZXZlbCBzaW0gcmVhZCBjYXBhYmls
aXR5PyA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBZZXMsIGl0IHNl
ZW1zIHNvIDo8YnI+CiAgICAgIDxicj4KICAgICAgJCBxbWljbGkgLWQgL2Rldi9jZGMtd2RtMCAt
LWhlbHAtdWltPGJyPgogICAgICBVSU0gb3B0aW9uczxicj4KICAgICAgoAogICAgICAtLXVpbS1y
ZWFkLXRyYW5zcGFyZW50PVsweE5OTk4sMHhOTk5OLC4uLl2goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgCgogICAgICBSZWFkIGEgdHJhbnNwYXJlbnQgZmlsZSBnaXZl
biB0aGUgZmlsZSBwYXRoPGJyPgogICAgICCgCiAgICAgIC0tdWltLWdldC1maWxlLWF0dHJpYnV0
ZXM9WzB4Tk5OTiwweE5OTk4sLi4uXaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAKCiAgICAgIEdldCB0aGUgYXR0cmlidXRlcyBvZiBhIGdpdmVuIGZpbGU8YnI+CiAgICAg
IKAKICAgICAgLS11aW0tZ2V0LWNhcmQtc3RhdHVzoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoAoKICAgICAgR2V0IGNhcmQgc3Rh
dHVzPGJyPgogICAgICCgCiAgICAgIC0tdWltLXJlc2V0oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAKCiAgICAg
IFJlc2V0IHRoZSBzZXJ2aWNlIHN0YXRlPGJyPgogICAgICCgIC0tdWltLW5vb3CgoKAgPGJyPgog
ICAgICA8YnI+CiAgICAgIEknbSBub3QgdXNlZCB0byBRTUkgYnV0IEkgd2lsbCB0cnkgdG8gY29t
cGFyZSBsaWJxbWkgYW5kIG9mb25vJ3MKICAgICAgcmVhZF90cmFuc3BhcmVudCBpbXBsZW1lbnRh
dGlvbnMuPGJyPgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIGNpdGU9Im1pZDo1NzIzODU1
OS45MDQwNTA1QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+IDxicj4KICAgICAgICBBbm90aGVyIHRo
aW5nIHRvIHRyeSB3b3VsZCBiZSB0byBpbXBsZW1lbnQgcmVhZF9pbXNpKCkgbWV0aG9kCiAgICAg
ICAgZm9yIGRyaXZlcnMvcW1pbW9kZW0vc2ltLmMuoCBUaGlzIHNob3VsZCBnZXQgeW91IHRvIHRo
ZSBwb2ludAogICAgICAgIHdoZXJlIGdwcnMgaXMgaW5pdGlhbGl6ZWQgZXZlbiBpZiBhbGwgbG93
LWxldmVsIHJlYWRzIGZyb20gdGhlCiAgICAgICAgU0lNIGZhaWwuIDxicj4KICAgICAgPC9ibG9j
a3F1b3RlPgogICAgICA8YnI+CiAgICAgIEl0IHNlZW1zIGEgZ3JlYXQgaWRlYS4gPGJyPgogICAg
ICA8YnI+CiAgICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj4KICAgIEl0J3MgYW4g
ZXhjZWxsZW50IGlkZWEgITxicj4KICAgIExvb2tpbmcgZm9yIHJlYWRfaW1zaSBpbXBsZW1lbnRh
dGlvbiwgSSBmb3VuZCBxbWltb2RlbS1sZWdhY3kgd2hpY2gKICAgIGZpdCBwcmVmZWN0bHkgdG8g
bXkgbW9kZW0uPGJyPgogICAgQWZ0ZXIgYSBmZXcgZml4IGJlY2F1c2UgZmlyc3QgU2llcnJhIG5l
dCBpbnRlcmZhY2UgaXMgYnVnZ3kgKHd3YW4wKSwKICAgIEknbSBub3cgZW5hYmxlIHRvIHVzZSBm
dWxseSAiQ29ubm1hbiAtIG9mb25vIqAgZmVhdHVyZXM8YnI+CiAgICA8YnI+CiAgICBJIHdpbGwg
dHJ5IHRvIGNsZWFudXAgbXkgd29yaywgZmluZCBhIHdheSB0byBmb3JjZSB1c2Ugb2YKICAgIHFt
aW1vZGVtLWxlZ2FjeSBmb3IgdGhpcyBTaWVycmEgY2hpcCBhbmQgc3VibWl0IGFsbCB0aGVzZQog
ICAgbW9kaWZpY2F0aW9ucy48YnI+CiAgICA8YnI+CiAgICBUaGFua3MgYWdhaW4gRGVuaXM8YnI+
CiAgICA8YnI+CiAgICBCZXN0IHJlZ2FyZHMsPGJyPgogICAgPGJyPgogICAgTWFydGluPGJyPgog
ICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============0140692732093274542==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEk1YXpBQW9KRU1KT2oxZU15ZGkvOVI0UUFKVjcyVEtC
VXdJckNjSUVKVHBrQmVicQpGMi9tTUN1YzBaSm5JQUNlYkk5R2wzWHEzSWt3bjlReUN0U1YyR1Aw
Qzh4MlJFSGZDcE5GOUEwYTMvTHBmY29oCmF1SnZLblF1WDFPM2Myd0xRdzRERThweGM1aEQ5TkMv
MVhjSW1tOUE2SExnN0ozaFdqb2ltUS82OXgrYVRVb0cKOUNtODdFeHAvd1ZHVjJvZ2pVb01wWENk
cVppNWZXa1dmRzRyYVNUQnhCeHQ0TTU3K0QzY3J6Qnl5VXE2blZmaApkSENTSXp0aTRKeHYyYlR0
SlAyVkVrWTJaa25yRDRHa1dhUGpaTmNmTVh5M1R2bFVBZ3JKei9lWWhZOVI2RzAvClBhSXQ2OE0v
VnFQZVh3Si9ERGVCNGNZMWRXeVlZQmlzK3BGWi9pQ0ZmVkZmOFF1ZzBrQXViS0RQN1JGai9hdDUK
V2NYb2ttNUV3ZEx2TWloYWovOGI1ZmhKQld2YlRCSWhHZFhHMWN1dXBxdWZsTTZRZlNUQ2c2alhq
c2tRbDRiMQpvZEEwU2FoOTMwYW9XQitOaVUvV1BlczdoQXdRY1A5MzhrYnVOcFpaa0czSktQTGxn
VklXaDRXYldZdUx4SG5OCmVZNDM4WUd4WTNYSnlTdnNjYmZVdWRMYmxlcnJkM0NaNVJXRlYxK0pH
eTBiTVZ3TngveTYwMnh4OFQxeXNJUjQKeEgrS2RQOGZLREVMaDlMMkhTcmVEUUdlVlFvdFphcmJr
S3prclpvaVNHTUc4OXBLbDBVRUZNVTdjaUJTSVBGRwozRms5QmhWYnhuSGw2SXNjb0s5US9TZDlQ
LzBBeXJLQXZvU3pTWFc4dng4cGJKU0ZPeWR2eHZkWEZkRHNKNjlaCklJUzJGbHo2R1Z3WnlUamha
d1FxCj1jNGFrCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============0140692732093274542==--

