Content-Type: multipart/mixed; boundary="===============5265647193003939713=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 18:46:55 +0200
Message-ID: <57238FFF.8050601@kerlink.fr>
In-Reply-To: <57238559.9040505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5265647193003939713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 29/04/2016 18:01, Denis Kenzior wrote:
> Hi Martin,
>
> On 04/29/2016 10:53 AM, Martin Chaplet wrote:
>>
>>
>> On 29/04/2016 17:44, Denis Kenzior wrote:
>>>
>>>>
>>>> This card is mainly QMI but also have Diag, NMEA and AT interfaces
>>>> (ttyUSB). I think that's why he did it in setup_sierra.
>>>>
>>>
>>> What is the AT interface capable of?  Can this modem be driven using
>>> AT commands instead?  Would certainly be easier to debug.
>>
>> All main commands are available ( ETSI) but I don't think PPP can be
>> used.
>> Additionnaly, it's a 4G modem, using PPP layer instead QMI will reduce
>> performances, isn't it ?
>
> You definitely don't want ppp.  Besides, ppp requires 2 functional AT
> ports, and it looks like this card has just one.
>
> Does Sierra provide network management via vendor AT commands?

As the modem support FOTA auto update feature, I assume they must exist.
I will take a look at the manuals.

>
>>
>> Do you mean I can use an "hybrid" mode using modem management through AT
>> and network through QMI ?
>
> This is quite possible as well.
>
>>
>>>
>>>>>
>>>>> Your modem doesn't seem to want to read anything from the SIM.  So
>>>>> that is why your gprs isn't showing up.
>>>>>
>>>>> Do you have a SIM in there or a PIN set?
>>>>
>>>>
>>>> OK, so I understand that Data feature is detected by scanning SIM
>>>> capabilities + chip capabilities (UMTS, LTE, ...)
>>>> Am I right ?
>>>
>>> Sort of.  oFono is a full telephony stack, so we expect the basics to
>>> be provided.  IMSI availability tells us that the SIM has been
>>> initialized to the point that it is useable.  E.g. PIN has been
>>> unlocked/entered.
>>>
>> OK, I see.
>>>>
>>>> My SIM doesn't have PIN and I can use Standard QMI tools (libqmi) to
>>>> bring up a connection.
>>>> I will so investigate around SIM QMI requests / replies.
>>>
>>> Are sim operations supported / working on this modem with libqmi?
>> Yes.
>> Please find few tests below
>>
>> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-imsi
>> [/dev/cdc-wdm0] UIM IMSI retrieved:
>>          IMSI: '208103790757141'
>>
>> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-state
>> [/dev/cdc-wdm0] UIM state retrieved:
>>          State: 'initialization-completed'
>>
>> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-pin-status
>> [/dev/cdc-wdm0] PIN status retrieved successfully
>> [/dev/cdc-wdm0] PIN1:
>>          Status: disabled
>>          Verify: 3
>>          Unblock: 10
>> [/dev/cdc-wdm0] PIN2:
>>          Status: enabled-not-verified
>>          Verify: 2
>>          Unblock: 10
>>
>
> This looks to be in agreement with what oFono is obtaining from the
> drivers/qmimodem/sim.c driver.  However, qmi_read_transparent and
> qmi_read_record don't seem to be reporting proper values.
>
> Does libqmi actually have low-level sim read capability?

Yes, it seems so :

$ qmicli -d /dev/cdc-wdm0 --help-uim
UIM options
 =

--uim-read-transparent=3D[0xNNNN,0xNNNN,...]                               =
            =

Read a transparent file given the file path
 =

--uim-get-file-attributes=3D[0xNNNN,0xNNNN,...]                            =
            =

Get the attributes of a given file
 =

--uim-get-card-status                                                      =
          =

Get card status
 =

--uim-reset                                                                =
          =

Reset the service state
  --uim-noop   =


I'm not used to QMI but I will try to compare libqmi and ofono's
read_transparent implementations.

>
> Another thing to try would be to implement read_imsi() method for
> drivers/qmimodem/sim.c.  This should get you to the point where gprs
> is initialized even if all low-level reads from the SIM fail.

It seems a great idea.

Thanks a lot for you help Denis,

Best regards,

Martin


--===============5265647193003939713==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIEhpIERlbmlzPGJyPgog
ICAgPGJyPgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAyOS8wNC8yMDE2IDE4
OjAxLCBEZW5pcyBLZW56aW9yCiAgICAgIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2Nr
cXVvdGUgY2l0ZT0ibWlkOjU3MjM4NTU5LjkwNDA1MDVAZ21haWwuY29tIiB0eXBlPSJjaXRlIj5I
aQogICAgICBNYXJ0aW4sCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBPbiAwNC8yOS8yMDE2
IDEwOjUzIEFNLCBNYXJ0aW4gQ2hhcGxldCB3cm90ZToKICAgICAgPGJyPgogICAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIE9uIDI5
LzA0LzIwMTYgMTc6NDQsIERlbmlzIEtlbnppb3Igd3JvdGU6CiAgICAgICAgPGJyPgogICAgICAg
IDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgPGJyPgogICAgICAgICAgPGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgVGhpcyBjYXJk
IGlzIG1haW5seSBRTUkgYnV0IGFsc28gaGF2ZSBEaWFnLCBOTUVBIGFuZCBBVAogICAgICAgICAg
ICBpbnRlcmZhY2VzCiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgKHR0eVVTQikuIEkgdGhp
bmsgdGhhdCdzIHdoeSBoZSBkaWQgaXQgaW4gc2V0dXBfc2llcnJhLgogICAgICAgICAgICA8YnI+
CiAgICAgICAgICAgIDxicj4KICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgIDxicj4K
ICAgICAgICAgIFdoYXQgaXMgdGhlIEFUIGludGVyZmFjZSBjYXBhYmxlIG9mP6AgQ2FuIHRoaXMg
bW9kZW0gYmUgZHJpdmVuCiAgICAgICAgICB1c2luZwogICAgICAgICAgPGJyPgogICAgICAgICAg
QVQgY29tbWFuZHMgaW5zdGVhZD+gIFdvdWxkIGNlcnRhaW5seSBiZSBlYXNpZXIgdG8gZGVidWcu
CiAgICAgICAgICA8YnI+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIDxicj4KICAgICAg
ICBBbGwgbWFpbiBjb21tYW5kcyBhcmUgYXZhaWxhYmxlICggRVRTSSkgYnV0IEkgZG9uJ3QgdGhp
bmsgUFBQCiAgICAgICAgY2FuIGJlIHVzZWQuCiAgICAgICAgPGJyPgogICAgICAgIEFkZGl0aW9u
bmFseSwgaXQncyBhIDRHIG1vZGVtLCB1c2luZyBQUFAgbGF5ZXIgaW5zdGVhZCBRTUkgd2lsbAog
ICAgICAgIHJlZHVjZQogICAgICAgIDxicj4KICAgICAgICBwZXJmb3JtYW5jZXMsIGlzbid0IGl0
ID8KICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBZb3Ug
ZGVmaW5pdGVseSBkb24ndCB3YW50IHBwcC6gIEJlc2lkZXMsIHBwcCByZXF1aXJlcyAyIGZ1bmN0
aW9uYWwKICAgICAgQVQgcG9ydHMsIGFuZCBpdCBsb29rcyBsaWtlIHRoaXMgY2FyZCBoYXMganVz
dCBvbmUuCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBEb2VzIFNpZXJyYSBwcm92aWRlIG5l
dHdvcmsgbWFuYWdlbWVudCB2aWEgdmVuZG9yIEFUIGNvbW1hbmRzPwogICAgICA8YnI+CiAgICA8
L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBBcyB0aGUgbW9kZW0gc3VwcG9ydCBGT1RBIGF1dG8g
dXBkYXRlIGZlYXR1cmUsIEkgYXNzdW1lIHRoZXkgbXVzdAogICAgZXhpc3QuPGJyPgogICAgSSB3
aWxsIHRha2UgYSBsb29rIGF0IHRoZSBtYW51YWxzLjxicj4KICAgIDxicj4KICAgIDxibG9ja3F1
b3RlIGNpdGU9Im1pZDo1NzIzODU1OS45MDQwNTA1QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+CiAg
ICAgIDxicj4KICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgPGJyPgogICAg
ICAgIERvIHlvdSBtZWFuIEkgY2FuIHVzZSBhbiAiaHlicmlkIiBtb2RlIHVzaW5nIG1vZGVtIG1h
bmFnZW1lbnQKICAgICAgICB0aHJvdWdoIEFUCiAgICAgICAgPGJyPgogICAgICAgIGFuZCBuZXR3
b3JrIHRocm91Z2ggUU1JID8KICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAg
PGJyPgogICAgICBUaGlzIGlzIHF1aXRlIHBvc3NpYmxlIGFzIHdlbGwuCiAgICAgIDxicj4KICAg
ICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAg
ICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICA8Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
CiAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgIFlvdXIgbW9kZW0gZG9lc24ndCBzZWVt
IHRvIHdhbnQgdG8gcmVhZCBhbnl0aGluZyBmcm9tIHRoZQogICAgICAgICAgICAgIFNJTS6gIFNv
CiAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgIHRoYXQgaXMgd2h5IHlvdXIgZ3BycyBp
c24ndCBzaG93aW5nIHVwLgogICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICA8YnI+CiAg
ICAgICAgICAgICAgRG8geW91IGhhdmUgYSBTSU0gaW4gdGhlcmUgb3IgYSBQSU4gc2V0PwogICAg
ICAgICAgICAgIDxicj4KICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICA8YnI+
CiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgT0ssIHNvIEkgdW5kZXJzdGFuZCB0aGF0IERh
dGEgZmVhdHVyZSBpcyBkZXRlY3RlZCBieQogICAgICAgICAgICBzY2FubmluZyBTSU0KICAgICAg
ICAgICAgPGJyPgogICAgICAgICAgICBjYXBhYmlsaXRpZXMgKyBjaGlwIGNhcGFiaWxpdGllcyAo
VU1UUywgTFRFLCAuLi4pCiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgQW0gSSByaWdodCA/
CiAgICAgICAgICAgIDxicj4KICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgIDxicj4K
ICAgICAgICAgIFNvcnQgb2YuoCBvRm9ubyBpcyBhIGZ1bGwgdGVsZXBob255IHN0YWNrLCBzbyB3
ZSBleHBlY3QgdGhlCiAgICAgICAgICBiYXNpY3MgdG8KICAgICAgICAgIDxicj4KICAgICAgICAg
IGJlIHByb3ZpZGVkLqAgSU1TSSBhdmFpbGFiaWxpdHkgdGVsbHMgdXMgdGhhdCB0aGUgU0lNIGhh
cyBiZWVuCiAgICAgICAgICA8YnI+CiAgICAgICAgICBpbml0aWFsaXplZCB0byB0aGUgcG9pbnQg
dGhhdCBpdCBpcyB1c2VhYmxlLqAgRS5nLiBQSU4gaGFzCiAgICAgICAgICBiZWVuCiAgICAgICAg
ICA8YnI+CiAgICAgICAgICB1bmxvY2tlZC9lbnRlcmVkLgogICAgICAgICAgPGJyPgogICAgICAg
ICAgPGJyPgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICBPSywgSSBzZWUuCiAgICAgICAg
PGJyPgogICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgTXkgU0lNIGRvZXNu
J3QgaGF2ZSBQSU4gYW5kIEkgY2FuIHVzZSBTdGFuZGFyZCBRTUkgdG9vbHMKICAgICAgICAgICAg
KGxpYnFtaSkgdG8KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICBicmluZyB1cCBhIGNvbm5l
Y3Rpb24uCiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgSSB3aWxsIHNvIGludmVzdGlnYXRl
IGFyb3VuZCBTSU0gUU1JIHJlcXVlc3RzIC8gcmVwbGllcy4KICAgICAgICAgICAgPGJyPgogICAg
ICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgPGJyPgogICAgICAgICAgQXJlIHNpbSBvcGVy
YXRpb25zIHN1cHBvcnRlZCAvIHdvcmtpbmcgb24gdGhpcyBtb2RlbSB3aXRoCiAgICAgICAgICBs
aWJxbWk/CiAgICAgICAgICA8YnI+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIFllcy4K
ICAgICAgICA8YnI+CiAgICAgICAgUGxlYXNlIGZpbmQgZmV3IHRlc3RzIGJlbG93CiAgICAgICAg
PGJyPgogICAgICAgIDxicj4KICAgICAgICAkIHFtaWNsaSAtZCAvZGV2L2NkYy13ZG0wIC0tZG1z
LXVpbS1nZXQtaW1zaQogICAgICAgIDxicj4KICAgICAgICBbL2Rldi9jZGMtd2RtMF0gVUlNIElN
U0kgcmV0cmlldmVkOgogICAgICAgIDxicj4KICAgICAgICCgoKCgoKCgoCBJTVNJOiAnMjA4MTAz
NzkwNzU3MTQxJwogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgJCBxbWljbGkgLWQg
L2Rldi9jZGMtd2RtMCAtLWRtcy11aW0tZ2V0LXN0YXRlCiAgICAgICAgPGJyPgogICAgICAgIFsv
ZGV2L2NkYy13ZG0wXSBVSU0gc3RhdGUgcmV0cmlldmVkOgogICAgICAgIDxicj4KICAgICAgICCg
oKCgoKCgoCBTdGF0ZTogJ2luaXRpYWxpemF0aW9uLWNvbXBsZXRlZCcKICAgICAgICA8YnI+CiAg
ICAgICAgPGJyPgogICAgICAgICQgcW1pY2xpIC1kIC9kZXYvY2RjLXdkbTAgLS1kbXMtdWltLWdl
dC1waW4tc3RhdHVzCiAgICAgICAgPGJyPgogICAgICAgIFsvZGV2L2NkYy13ZG0wXSBQSU4gc3Rh
dHVzIHJldHJpZXZlZCBzdWNjZXNzZnVsbHkKICAgICAgICA8YnI+CiAgICAgICAgWy9kZXYvY2Rj
LXdkbTBdIFBJTjE6CiAgICAgICAgPGJyPgogICAgICAgIKCgoKCgoKCgIFN0YXR1czogZGlzYWJs
ZWQKICAgICAgICA8YnI+CiAgICAgICAgoKCgoKCgoKAgVmVyaWZ5OiAzCiAgICAgICAgPGJyPgog
ICAgICAgIKCgoKCgoKCgIFVuYmxvY2s6IDEwCiAgICAgICAgPGJyPgogICAgICAgIFsvZGV2L2Nk
Yy13ZG0wXSBQSU4yOgogICAgICAgIDxicj4KICAgICAgICCgoKCgoKCgoCBTdGF0dXM6IGVuYWJs
ZWQtbm90LXZlcmlmaWVkCiAgICAgICAgPGJyPgogICAgICAgIKCgoKCgoKCgIFZlcmlmeTogMgog
ICAgICAgIDxicj4KICAgICAgICCgoKCgoKCgoCBVbmJsb2NrOiAxMAogICAgICAgIDxicj4KICAg
ICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgogICAgICBUaGlzIGxvb2tz
IHRvIGJlIGluIGFncmVlbWVudCB3aXRoIHdoYXQgb0Zvbm8gaXMgb2J0YWluaW5nIGZyb20KICAg
ICAgdGhlIGRyaXZlcnMvcW1pbW9kZW0vc2ltLmMgZHJpdmVyLqAgSG93ZXZlciwgcW1pX3JlYWRf
dHJhbnNwYXJlbnQKICAgICAgYW5kIHFtaV9yZWFkX3JlY29yZCBkb24ndCBzZWVtIHRvIGJlIHJl
cG9ydGluZyBwcm9wZXIgdmFsdWVzLgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgRG9lcyBs
aWJxbWkgYWN0dWFsbHkgaGF2ZSBsb3ctbGV2ZWwgc2ltIHJlYWQgY2FwYWJpbGl0eT8KICAgICAg
PGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgWWVzLCBpdCBzZWVtcyBzbyA6PGJy
PgogICAgPGJyPgogICAgJCBxbWljbGkgLWQgL2Rldi9jZGMtd2RtMCAtLWhlbHAtdWltPGJyPgog
ICAgVUlNIG9wdGlvbnM8YnI+CiAgICCgCiAgICAtLXVpbS1yZWFkLXRyYW5zcGFyZW50PVsweE5O
Tk4sMHhOTk5OLC4uLl2goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
CiAgICBSZWFkIGEgdHJhbnNwYXJlbnQgZmlsZSBnaXZlbiB0aGUgZmlsZSBwYXRoPGJyPgogICAg
oAogICAgLS11aW0tZ2V0LWZpbGUtYXR0cmlidXRlcz1bMHhOTk5OLDB4Tk5OTiwuLi5doKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoAogICAgR2V0IHRoZSBhdHRyaWJ1dGVz
IG9mIGEgZ2l2ZW4gZmlsZTxicj4KICAgIKAKICAgIC0tdWltLWdldC1jYXJkLXN0YXR1c6CgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAKICAgIEdldCBjYXJkIHN0YXR1czxicj4KICAgIKAKICAgIC0tdWltLXJlc2V0oKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKAKICAgIFJlc2V0IHRoZSBzZXJ2aWNlIHN0YXRlPGJyPgogICAgoCAtLXVpbS1ub29w
oKCgIDxicj4KICAgIDxicj4KICAgIEknbSBub3QgdXNlZCB0byBRTUkgYnV0IEkgd2lsbCB0cnkg
dG8gY29tcGFyZSBsaWJxbWkgYW5kIG9mb25vJ3MKICAgIHJlYWRfdHJhbnNwYXJlbnQgaW1wbGVt
ZW50YXRpb25zLjxicj4KICAgIDxicj4KICAgIDxibG9ja3F1b3RlIGNpdGU9Im1pZDo1NzIzODU1
OS45MDQwNTA1QGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+CiAgICAgIDxicj4KICAgICAgQW5vdGhl
ciB0aGluZyB0byB0cnkgd291bGQgYmUgdG8gaW1wbGVtZW50IHJlYWRfaW1zaSgpIG1ldGhvZCBm
b3IKICAgICAgZHJpdmVycy9xbWltb2RlbS9zaW0uYy6gIFRoaXMgc2hvdWxkIGdldCB5b3UgdG8g
dGhlIHBvaW50IHdoZXJlCiAgICAgIGdwcnMgaXMgaW5pdGlhbGl6ZWQgZXZlbiBpZiBhbGwgbG93
LWxldmVsIHJlYWRzIGZyb20gdGhlIFNJTSBmYWlsLgogICAgICA8YnI+CiAgICA8L2Jsb2NrcXVv
dGU+CiAgICA8YnI+CiAgICBJdCBzZWVtcyBhIGdyZWF0IGlkZWEuIDxicj4KICAgIDxicj4KICAg
IFRoYW5rcyBhIGxvdCBmb3IgeW91IGhlbHAgRGVuaXMsPGJyPgogICAgPGJyPgogICAgQmVzdCBy
ZWdhcmRzLDxicj4KICAgIDxicj4KICAgIE1hcnRpbjxicj4KICAgIDxicj4KICA8L2JvZHk+Cjwv
aHRtbD4K

--===============5265647193003939713==--

