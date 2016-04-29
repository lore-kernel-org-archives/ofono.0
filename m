Content-Type: multipart/mixed; boundary="===============9058679863224160298=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 17:53:45 +0200
Message-ID: <57238389.7000408@kerlink.fr>
In-Reply-To: <57238150.4050901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9058679863224160298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 29/04/2016 17:44, Denis Kenzior wrote:
>
>>
>> This card is mainly QMI but also have Diag, NMEA and AT interfaces
>> (ttyUSB). I think that's why he did it in setup_sierra.
>>
>
> What is the AT interface capable of?  Can this modem be driven using
> AT commands instead?  Would certainly be easier to debug.

All main commands are available ( ETSI) but I don't think PPP can be used.
Additionnaly, it's a 4G modem, using PPP layer instead QMI will reduce
performances, isn't it ?

Do you mean I can use an "hybrid" mode using modem management through AT
and network through QMI ?

>
>>>
>>> Your modem doesn't seem to want to read anything from the SIM.  So
>>> that is why your gprs isn't showing up.
>>>
>>> Do you have a SIM in there or a PIN set?
>>
>>
>> OK, so I understand that Data feature is detected by scanning SIM
>> capabilities + chip capabilities (UMTS, LTE, ...)
>> Am I right ?
>
> Sort of.  oFono is a full telephony stack, so we expect the basics to
> be provided.  IMSI availability tells us that the SIM has been
> initialized to the point that it is useable.  E.g. PIN has been
> unlocked/entered.
>
OK, I see.
>>
>> My SIM doesn't have PIN and I can use Standard QMI tools (libqmi) to
>> bring up a connection.
>> I will so investigate around SIM QMI requests / replies.
>
> Are sim operations supported / working on this modem with libqmi?
Yes.
Please find few tests below

$ qmicli -d /dev/cdc-wdm0 --dms-uim-get-imsi   =

[/dev/cdc-wdm0] UIM IMSI retrieved:
        IMSI: '208103790757141'

$ qmicli -d /dev/cdc-wdm0 --dms-uim-get-state
[/dev/cdc-wdm0] UIM state retrieved:
        State: 'initialization-completed'

$ qmicli -d /dev/cdc-wdm0 --dms-uim-get-pin-status
[/dev/cdc-wdm0] PIN status retrieved successfully
[/dev/cdc-wdm0] PIN1:
        Status: disabled
        Verify: 3
        Unblock: 10
[/dev/cdc-wdm0] PIN2:
        Status: enabled-not-verified
        Verify: 2
        Unblock: 10


>
> Regards,
> -Denis
>


--===============9058679863224160298==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIDxicj4KICAgIDxicj4K
ICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMjkvMDQvMjAxNiAxNzo0NCwgRGVu
aXMgS2VuemlvcgogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9ja3F1b3RlIGNp
dGU9Im1pZDo1NzIzODE1MC40MDUwOTAxQGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+PGJyPgogICAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAgICAgVGhpcyBjYXJk
IGlzIG1haW5seSBRTUkgYnV0IGFsc28gaGF2ZSBEaWFnLCBOTUVBIGFuZCBBVAogICAgICAgIGlu
dGVyZmFjZXMKICAgICAgICA8YnI+CiAgICAgICAgKHR0eVVTQikuIEkgdGhpbmsgdGhhdCdzIHdo
eSBoZSBkaWQgaXQgaW4gc2V0dXBfc2llcnJhLgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAg
ICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBXaGF0IGlzIHRoZSBBVCBpbnRlcmZh
Y2UgY2FwYWJsZSBvZj+gIENhbiB0aGlzIG1vZGVtIGJlIGRyaXZlbgogICAgICB1c2luZyBBVCBj
b21tYW5kcyBpbnN0ZWFkP6AgV291bGQgY2VydGFpbmx5IGJlIGVhc2llciB0byBkZWJ1Zy4KICAg
ICAgPGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgQWxsIG1haW4gY29tbWFuZHMg
YXJlIGF2YWlsYWJsZSAoCiAgICA8bWV0YSBodHRwLWVxdWl2PSJjb250ZW50LXR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsKICAgICAgY2hhcnNldD13aW5kb3dzLTEyNTIiPgogICAgRVRTSSkgYnV0
IEkgZG9uJ3QgdGhpbmsgUFBQIGNhbiBiZSB1c2VkLjxicj4KICAgIEFkZGl0aW9ubmFseSwgaXQn
cyBhIDRHIG1vZGVtLCB1c2luZyBQUFAgbGF5ZXIgaW5zdGVhZCBRTUkgd2lsbAogICAgcmVkdWNl
IHBlcmZvcm1hbmNlcywgaXNuJ3QgaXQgPzxicj4KICAgIDxicj4KICAgIERvIHlvdSBtZWFuIEkg
Y2FuIHVzZSBhbiAiaHlicmlkIiBtb2RlIHVzaW5nIG1vZGVtIG1hbmFnZW1lbnQKICAgIHRocm91
Z2ggQVQgYW5kIG5ldHdvcmsgdGhyb3VnaCBRTUkgPzxicj4KICAgIDxicj4KICAgIDxibG9ja3F1
b3RlIGNpdGU9Im1pZDo1NzIzODE1MC40MDUwOTAxQGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+CiAg
ICAgIDxicj4KICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBZb3VyIG1vZGVtIGRvZXNu
J3Qgc2VlbSB0byB3YW50IHRvIHJlYWQgYW55dGhpbmcgZnJvbSB0aGUKICAgICAgICAgIFNJTS6g
IFNvCiAgICAgICAgICA8YnI+CiAgICAgICAgICB0aGF0IGlzIHdoeSB5b3VyIGdwcnMgaXNuJ3Qg
c2hvd2luZyB1cC4KICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAgICAgICAgIERvIHlv
dSBoYXZlIGEgU0lNIGluIHRoZXJlIG9yIGEgUElOIHNldD8KICAgICAgICAgIDxicj4KICAgICAg
ICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAgICAgICBPSywgc28g
SSB1bmRlcnN0YW5kIHRoYXQgRGF0YSBmZWF0dXJlIGlzIGRldGVjdGVkIGJ5IHNjYW5uaW5nCiAg
ICAgICAgU0lNCiAgICAgICAgPGJyPgogICAgICAgIGNhcGFiaWxpdGllcyArIGNoaXAgY2FwYWJp
bGl0aWVzIChVTVRTLCBMVEUsIC4uLikKICAgICAgICA8YnI+CiAgICAgICAgQW0gSSByaWdodCA/
CiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4KICAgICAgU29ydCBv
Zi6gIG9Gb25vIGlzIGEgZnVsbCB0ZWxlcGhvbnkgc3RhY2ssIHNvIHdlIGV4cGVjdCB0aGUgYmFz
aWNzCiAgICAgIHRvIGJlIHByb3ZpZGVkLqAgSU1TSSBhdmFpbGFiaWxpdHkgdGVsbHMgdXMgdGhh
dCB0aGUgU0lNIGhhcyBiZWVuCiAgICAgIGluaXRpYWxpemVkIHRvIHRoZSBwb2ludCB0aGF0IGl0
IGlzIHVzZWFibGUuoCBFLmcuIFBJTiBoYXMgYmVlbgogICAgICB1bmxvY2tlZC9lbnRlcmVkLgog
ICAgICA8YnI+CiAgICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4KICAgIE9LLCBJIHNlZS48YnI+
CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6NTcyMzgxNTAuNDA1MDkwMUBnbWFpbC5jb20iIHR5
cGU9ImNpdGUiPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAg
ICAgICAgTXkgU0lNIGRvZXNuJ3QgaGF2ZSBQSU4gYW5kIEkgY2FuIHVzZSBTdGFuZGFyZCBRTUkg
dG9vbHMKICAgICAgICAobGlicW1pKSB0bwogICAgICAgIDxicj4KICAgICAgICBicmluZyB1cCBh
IGNvbm5lY3Rpb24uCiAgICAgICAgPGJyPgogICAgICAgIEkgd2lsbCBzbyBpbnZlc3RpZ2F0ZSBh
cm91bmQgU0lNIFFNSSByZXF1ZXN0cyAvIHJlcGxpZXMuCiAgICAgICAgPGJyPgogICAgICA8L2Js
b2NrcXVvdGU+CiAgICAgIDxicj4KICAgICAgQXJlIHNpbSBvcGVyYXRpb25zIHN1cHBvcnRlZCAv
IHdvcmtpbmcgb24gdGhpcyBtb2RlbSB3aXRoIGxpYnFtaT8KICAgICAgPGJyPgogICAgPC9ibG9j
a3F1b3RlPgogICAgWWVzLjxicj4KICAgIFBsZWFzZSBmaW5kIGZldyB0ZXN0cyBiZWxvdzxicj4K
ICAgIDxicj4KICAgIDxmb250IGZhY2U9IkNvdXJpZXIgTmV3LCBDb3VyaWVyLCBtb25vc3BhY2Ui
PiQgcW1pY2xpIC1kCiAgICAgIC9kZXYvY2RjLXdkbTAgLS1kbXMtdWltLWdldC1pbXNpoKCgIDxi
cj4KICAgICAgWy9kZXYvY2RjLXdkbTBdIFVJTSBJTVNJIHJldHJpZXZlZDo8YnI+CiAgICAgIKCg
oKCgoKAgSU1TSTogJzIwODEwMzc5MDc1NzE0MSc8YnI+CiAgICAgIDxicj4KICAgICAgJCBxbWlj
bGkgLWQgL2Rldi9jZGMtd2RtMCAtLWRtcy11aW0tZ2V0LXN0YXRlPGJyPgogICAgICBbL2Rldi9j
ZGMtd2RtMF0gVUlNIHN0YXRlIHJldHJpZXZlZDo8YnI+CiAgICAgIKCgoKCgoKAgU3RhdGU6ICdp
bml0aWFsaXphdGlvbi1jb21wbGV0ZWQnPGJyPgogICAgICA8YnI+CiAgICAgICQgcW1pY2xpIC1k
IC9kZXYvY2RjLXdkbTAgLS1kbXMtdWltLWdldC1waW4tc3RhdHVzPGJyPgogICAgICBbL2Rldi9j
ZGMtd2RtMF0gUElOIHN0YXR1cyByZXRyaWV2ZWQgc3VjY2Vzc2Z1bGx5PGJyPgogICAgICBbL2Rl
di9jZGMtd2RtMF0gUElOMTo8YnI+CiAgICAgIKCgoKCgoKAgU3RhdHVzOiBkaXNhYmxlZDxicj4K
ICAgICAgoKCgoKCgoCBWZXJpZnk6IDM8YnI+CiAgICAgIKCgoKCgoKAgVW5ibG9jazogMTA8YnI+
CiAgICAgIFsvZGV2L2NkYy13ZG0wXSBQSU4yOjxicj4KICAgICAgoKCgoKCgoCBTdGF0dXM6IGVu
YWJsZWQtbm90LXZlcmlmaWVkPGJyPgogICAgICCgoKCgoKCgIFZlcmlmeTogMjxicj4KICAgICAg
oKCgoKCgoCBVbmJsb2NrOiAxMDwvZm9udD48YnI+CiAgICA8YnI+CiAgICA8YnI+CiAgICA8Ymxv
Y2txdW90ZSBjaXRlPSJtaWQ6NTcyMzgxNTAuNDA1MDkwMUBnbWFpbC5jb20iIHR5cGU9ImNpdGUi
PgogICAgICA8YnI+CiAgICAgIFJlZ2FyZHMsCiAgICAgIDxicj4KICAgICAgLURlbmlzCiAgICAg
IDxicj4KICAgICAgPGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogIDwvYm9keT4KPC9o
dG1sPgo=

--===============9058679863224160298==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEk0T0pBQW9KRU1KT2oxZU15ZGkvTzNFUCtnTTJKaUdw
aXgwY2NPWU9ZRnpBcEw1UwpBeHowbm0yeGlxNzNEWHFOUGxQUjVadU5Wb3hXanIraFdpSFpwNjl5
UVhOQmp4cWVmOExickxTRjM1cW1GYlBPCnFaMjl2dzN0UXU1Uk4raXZqR1d0dElwK3g0SjFMblht
emZKcFQrSC9LMVNhNU43NmVob1E5Q01BbVMzcHhrR0IKTWZtR1l5T1hZdENiK0FXOGpBSEhrTXNC
cEFQMkhsSVZ6S2NEd2J1Y1Z3bnFGbkY4a0pwS1FROXZUZlBTcnNSOQp0RWdTNDhKZENEY3hxTGFF
b0dMWTZUaWNhSU9uY2R2dUZXcUxiZGh2WVpubnZ4ajVjYUdReC9oT0k2NzA0VmMyCnlvM25tbmxv
akNES085a2FMNGJ2NVp2QzF0NlJWc1BPQkEyQWw0ZlFnelcvK0F2Y29qUjFITDJiTG8wNkV4ZGEK
Y1kwRGUwMjB6WFB2c25BMG5DRk9FRThPNDNPcmZxYkxiWXhuMXRpSFlnV1JsbFVZd1A5aFduSG5H
Q2FUVE4rcQo1dGwydzlWVEo4N1NkbEx1SmUrdkFYTkxMMjRLWm5mTGJ2SHYydjZpNGxXWmJzL1JE
bkZ6Y0xDT0poRmFvQ0ZaCkhQTWxwMlR6Ylh4UHJRTnhTTVlYeDRUQmRMTHFyK3JRa2s4RzM3NHJy
eWR1Nll2SHFPam9mRXAyMnhCZXE5TFUKVWQ2cTVHelhoUmN1aHVwc200eWZwcHZyVTBzWXFPcGJl
d2srUUxRalNIM3JMMmNrSVY3OUkxTEo3Wm1SNFNtUwpzcVVMejFBQ3llYmZaZ2ZDUlh2Y3I0c1o2
eHgvMStNUXI5RmtRREJ3WDEwRlp6aTRqR2U1VlFMaEF2dEJDcWxmClJFckl5cUNBY0syT29sVWpS
UmkrCj1WY0d6Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============9058679863224160298==--

