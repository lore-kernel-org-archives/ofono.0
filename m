Content-Type: multipart/mixed; boundary="===============4871276239666848830=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: The way to install proper driver for 3G dongle in oFono
Date: Thu, 05 Jan 2012 17:17:48 +0100
Message-ID: <4F05CD2C.3010609@linux.intel.com>
In-Reply-To: <1325760266.6454.67.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4871276239666848830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>>>>>>>>>>>>>> and what about the case when the SIM card is present, but PI=
N locked?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> According to the result, it might be interesting to send AT=
I when the
>>>>>>>>>>>>>>> constructor plugin is probe by oFono.
>>>>>>>>>>>>>>> Thus with +GCAP info we can decide which driver to use.
>>>>>>>>>>>>>> Is sending +GCAP after ATI really a standard? Have we tried =
anything
>>>>>>>>>>>>>> else besides Huawei or ZTE?
>>>>>>>>>>>>> I tried with more dongles from different vendors, as attached=
 table.
>>>>>>>>>>>>> The scenarios include:
>>>>>>>>>>>>> With valid sim card, sim card PIN locked, no sim card, sim ca=
rd locked.
>>>>>>>>>>>>> N(ROM) in table indicates the SIM in ROM already.
>>>>>>>>>>>>> ATI command can always return GCAP content in all tests.
>>>>>>>>>>>> and what about other manufactures other than Huawei, ZTE and S=
peedUp?
>>>>>>>>>>>> What about Sierra, Ericsson etc.?
>>>>>>>>>>> Just checked Dell 5530 with Ericsson module,
>>>>>>>>>>> With SIM card or not, at+gcap can return +GCAP:+CGSM, +DS
>>>>>>>>>>> But the ATI only returns: D5530
>>>>>>>>>> I think it is clear that we need to do our homework here and pro=
perly
>>>>>>>>>> document the different manufacturers. Someone sending patches fo=
r our
>>>>>>>>>> doc/ directory?
>>>>>>>>> There're many vendors of 3G dongle..
>>>>>>>>> Huawei, ZTE (they share 70%+ of global market), Longcheer, Haier,=
 Sentar, Viton, D-link, SCV, BandRich, Strongrising.. (more than 30 vendors=
 in China)
>>>>>>>>> Sierra, Sony-Ericsson, Option, Novatel, Alcatel, Samsung, LG, Any=
Data, C-motech, Micromax...
>>>>>>>>> We can try with them step by step, but can we work out the 2 bigg=
est firstly?
>>>>>>>>> Looks ATI command can work for both Huawei and ZTE dongles.
>>>>>>>>>
>>>>>>>> I agree here, the work to be done over all manufacturers will be
>>>>>>>> fastidious and might require a lot of dongles that we don't have c=
urrently.
>>>>>>>> Maybe we could do as Ying An proposed as we are sure ATI works for
>>>>>>>> Huawei and ZTE (at least the ones we have).
>>>>>>>> However, conerning ZTE I haven't seen any CDMA dongle for the mome=
nt.
>>>>>>>>
>>>>>>>>>>>>>> Also you do realize that the GAtChat object and thus the fil=
e descriptor
>>>>>>>>>>>>>> is owned by the modem plugin. The plugin itself is the only =
one that
>>>>>>>>>>>>>> should do any kind of IO.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So if we require to run ATI first to identify if we are GSM =
or CDMA,
>>>>>>>>>>>>>> then this is a per modem manufacture specific detail. And we=
 rather add
>>>>>>>>>>>>>> a helper function like we did for CPIN polling that makes th=
is easier.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> In current code the 'driver' is hardcoded by comparing with v=
endor_list[].
>>>>>>>>>>>>> So if it possible to break the step into several:
>>>>>>>>>>>>> vendor_list[] in udevng just cares about vendor - by comparin=
g vendor ID
>>>>>>>>>> only,
>>>>>>>>>>>>> and add all possible drivers according to that vendor - (for =
example add
>>>>>>>>>>>>> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is pl=
ugged
>>>>>>>>>> in),
>>>>>>>>>>>>> and the probe interface in each driver does real probe work a=
s to issue
>>>>>>>>>>>>> ATI command to ensure only correct driver will be loaded?
>>>>>>>>>>>> As I said before, the only time IO can be started is when the =
->enable()
>>>>>>>>>>>> callback of the modem plugin is called. Not a second earlier.
>>>>>>>>>>> But if done after enable() called, from semantic aspect the cor=
rect driver has
>>>>>>>>>> been
>>>>>>>>>>> chosen. Indeed the probe() interface in each driver is not doin=
g something to
>>>>>>>>>> probe,
>>>>>>>>>>> then can the work be done in probe()? As set CFUN=3D1 then doin=
g some dongle
>>>>>>>>>> vendor
>>>>>>>>>>> specific work as query model or network mode by ATI, AT+GCAP co=
mmand,
>>>>>>>>>> etc..? After
>>>>>>>>>>> that disable dongle when quit probe()?
>>>>>>>>>> The probe() callback is for accepting the driver and allocating =
required
>>>>>>>>>> local data structures. It is not for IO. And as you can see it h=
as no
>>>>>>>>>> callback handling like enable() with set_powered().
>>>>>>>>>>
>>>>>>>>>> As I said before, no AT commands before enable() has been called=
. That
>>>>>>>>>> is how it is suppose to be. We are not changing this.
>>>>>>>> First, ATI command is working without sending AT+CFUN=3D1, we coul=
d keep
>>>>>>>> CFUN=3D1 into enable() as we do some vendor/modem type specific jo=
b there.
>>>>>>>>
>>>>>>>> Then vendor plugin can be chosen using udevng using Vendor ID, how=
ever
>>>>>>>> driver type (CDMA/GSM) can't lie on the Product ID. So it will be =
hard
>>>>>>>> to chose the right vendor plugin with right type.
>>>>>>>> And if we can't send AT command before enable() time we will face =
to bag
>>>>>>>> end e.g. :
>>>>>>>> For huawei plugin we send GSM specific AT command (AT^RFSWITCH) du=
ring
>>>>>>>> the enable() time.
>>>>>>>> We are also querying the sim state using polling mechanism that mi=
ght
>>>>>>>> fail for CDMA modems that is not using SIM.
>>>>>>>> What would you suggest here?
>>>>>>> as I said before, no AT commands before ->enable() callback from the
>>>>>>> core.
>>>>>>>
>>>>>>> The callback ->probe() is for accepting the modem driver binding and
>>>>>>> allocating modem specific data memory. The callback ->remove() is f=
or
>>>>>>> cleanup.
>>>>>>>
>>>>>>> The callbacks ->enable(), ->disable() and ->set_online() are the on=
ly IO
>>>>>>> entry points for every modem driver. And we need to keep it like th=
is.
>>>>>> Ok, so I suggest to do the ATI at the very beginning of ->enable() c=
allback.
>>>>> the first command has to be always ATE0 +CMEE=3D1 since otherwise you=
 a)
>>>>> can not use the permissive syntax parser and b) your error values will
>>>>> be useless.
>>>>>
>>>>> But yes, after that it is fine to send ATI.
>>>>>
>>>> Ok
>>>>
>>>>>> Then depending on the ATI answer:
>>>>>>         - tag the huawei modem data with GSM / CDMA type.
>>>>>>         - send the GSM / CDMA specific AT commands followed by AT+CF=
UN=3D1.
>>>>> What different commands depending on GSM or CDMA do you actually have?
>>>>>
>>>>> The AT^RFSWITCH=3D? is exactly designed to handle if that command is
>>>>> supported or not. There are plenty of GSM versions of the Huawei that=
 do
>>>>> not support AT^RFSWITCH. You do need to know if this is supported or
>>>>> not.
>>>> I see, so we can send AT^RFSWITCH for both type. If it is not supporte=
d,
>>>> it will be ignored using terminator and then use
>>>> default AT+CFUN=3D5.
>>>>
>>>>> Also we do not send AT+CFUN=3D1 in ->enable() callback. We bring the =
modem
>>>>> into offline mode. The only time you send AT+CFUN=3D1 is if you have
>>>>> hardware that does not support online/offline distinction. So if this=
 is
>>>>> true for Huawei CDMA modems, then the obvious questions is why that is
>>>>> the case? Or is this a bug with our CDMA support not supporting offli=
ne
>>>>> mode.
>>>>>
>>>> For the moment, CDMA modems are not using ->set_online() callback (it =
is
>>>> automatically set online into modem.c).
>>>> We will have to make some test to check AT+CFUN=3D5 is working on CDMA=
 modems.
>>> The Huawei GSM support is using ->set_online() callback. And so this
>>> means that you need it also for CDMA support. Otherwise you are back at
>>> square one.
>>>
>>> Actually you need to test the full CDMA support and if it can properly
>>> handle ->set_online() support. If not, then this needs fixing.
>>>
>>> Also I am still not seeing proper support for CDMA SIM atom. We need to
>>> stop hacking around here. The core functionality needs to be implemented
>>> first. Without it, the modem plugins can not function properly.
>>>
>>> So why are we wasting time with modem details here. If I remember
>>> correctly, Denis and I made it pretty clear that SIM atom and network
>>> registration atom is a fundamental requirement for CDMA support.
>> I agree we need SIM support for CDMA modem.
>> However we have no info about AT commands to manage the SIM  and its
>> file system from the vendor.
>> Every CDMA modems are Qualcomm based and their drivers are not open-sour=
ced.
>> Unless you have some specifications concerning CDMA drivers I don't
>> think we will be able to manage completely any SIM atom for CDMA modems.
> you need to make sure that the core modem state logic with transitions
> from pre_sim, post_sim and post_online in conjunction with set_online is
> working smoothly for CDMA. And of course not breaking GSM.
>
> I do not see how this can be done properly without having SIM atom
> support in place.

We can have 3 states in CDMA (specified in Huawei documentation):
1: Valid UIM card status
240: ROMSIM version
255: UIM card not exist

Currently the problem is we have some CDMA modems with ROMSIM e.g. =

embedded SIM.
When we send AT+CPIN? it answers CME ERROR Sim not inserted.

I discussed with Denis about this issue and he recommended me not to =

create SIM atom when status is ROMSIM version.

However we have some other dongles with UIM whose state is 1: Valid UIM =

card status.
They support some AT commands from "atmodem" drivers (AT+CPIN and =

AT+CIMI only) but none to read the file system.
All the dongles we have let are not PIN locked:
AT+CPIN? answer is +CPIN: READY.

If you want a SIM atom it could be used for PIN management only but as I =

told you I have met none for the moment.
Concerning ->set_online() callback, it can work without SIM atom but we =

have to modify it into the unified plugin.

Even with SIM atom for CDMA modems, we will never be able to read the =

UIM file system (AT+CRSM is not supported).
We can only expect some support from manufacturers to support UIM file =

system management.

Kind regards,
Guillaume


--===============4871276239666848830==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PUlTTy04ODU5LTEiCiAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgPC9oZWFk
PgogIDxib2R5IGJnY29sb3I9IiNmZmZmZmYiIHRleHQ9IiMwMDAwMDAiPgogICAgSGkgTWFyY2Vs
LDxicj4KICAgIDxicj4KICAgIDxibG9ja3F1b3RlIGNpdGU9Im1pZDoxMzI1NzYwMjY2LjY0NTQu
NjcuY2FtZWxAYWVvbmZsdXgiIHR5cGU9ImNpdGUiPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgIDxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAg
ICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj4KICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAg
ICAgICAgICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAg
ICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cHJl
IHdyYXA9IiI+YW5kIHdoYXQgYWJvdXQgdGhlIGNhc2Ugd2hlbiB0aGUgU0lNIGNhcmQgaXMgcHJl
c2VudCwgYnV0IFBJTiBsb2NrZWQ/Cgo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDxwcmUgd3JhcD0iIj5BY2NvcmRpbmcgdG8gdGhlIHJlc3VsdCwgaXQgbWlnaHQgYmUg
aW50ZXJlc3RpbmcgdG8gc2VuZCBBVEkgd2hlbiB0aGUKY29uc3RydWN0b3IgcGx1Z2luIGlzIHBy
b2JlIGJ5IG9Gb25vLgpUaHVzIHdpdGggK0dDQVAgaW5mbyB3ZSBjYW4gZGVjaWRlIHdoaWNoIGRy
aXZlciB0byB1c2UuCjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwvYmxv
Y2txdW90ZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+SXMg
c2VuZGluZyArR0NBUCBhZnRlciBBVEkgcmVhbGx5IGEgc3RhbmRhcmQ/IEhhdmUgd2UgdHJpZWQg
YW55dGhpbmcKZWxzZSBiZXNpZGVzIEh1YXdlaSBvciBaVEU/CjwvcHJlPgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDxwcmUgd3JhcD0iIj5JIHRyaWVkIHdpdGggbW9yZSBkb25nbGVzIGZyb20gZGlmZmVyZW50
IHZlbmRvcnMsIGFzIGF0dGFjaGVkIHRhYmxlLgpUaGUgc2NlbmFyaW9zIGluY2x1ZGU6CldpdGgg
dmFsaWQgc2ltIGNhcmQsIHNpbSBjYXJkIFBJTiBsb2NrZWQsIG5vIHNpbSBjYXJkLCBzaW0gY2Fy
ZCBsb2NrZWQuCk4oUk9NKSBpbiB0YWJsZSBpbmRpY2F0ZXMgdGhlIFNJTSBpbiBST00gYWxyZWFk
eS4KQVRJIGNvbW1hbmQgY2FuIGFsd2F5cyByZXR1cm4gR0NBUCBjb250ZW50IGluIGFsbCB0ZXN0
cy4KPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+YW5kIHdoYXQgYWJvdXQgb3RoZXIg
bWFudWZhY3R1cmVzIG90aGVyIHRoYW4gSHVhd2VpLCBaVEUgYW5kIFNwZWVkVXA/CldoYXQgYWJv
dXQgU2llcnJhLCBFcmljc3NvbiBldGMuPwo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAg
ICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPkp1
c3QgY2hlY2tlZCBEZWxsIDU1MzAgd2l0aCBFcmljc3NvbiBtb2R1bGUsCldpdGggU0lNIGNhcmQg
b3Igbm90LCBhdCtnY2FwIGNhbiByZXR1cm4gK0dDQVA6K0NHU00sICtEUwpCdXQgdGhlIEFUSSBv
bmx5IHJldHVybnM6IEQ1NTMwCjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2Nr
cXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxwcmUgd3JhcD0iIj5JIHRoaW5rIGl0IGlz
IGNsZWFyIHRoYXQgd2UgbmVlZCB0byBkbyBvdXIgaG9tZXdvcmsgaGVyZSBhbmQgcHJvcGVybHkK
ZG9jdW1lbnQgdGhlIGRpZmZlcmVudCBtYW51ZmFjdHVyZXJzLiBTb21lb25lIHNlbmRpbmcgcGF0
Y2hlcyBmb3Igb3VyCmRvYy8gZGlyZWN0b3J5Pwo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAg
IDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgICAgIDxwcmUgd3JhcD0iIj5UaGVyZSdy
ZSBtYW55IHZlbmRvcnMgb2YgM0cgZG9uZ2xlLi4KSHVhd2VpLCBaVEUgKHRoZXkgc2hhcmUgNzAl
KyBvZiBnbG9iYWwgbWFya2V0KSwgTG9uZ2NoZWVyLCBIYWllciwgU2VudGFyLCBWaXRvbiwgRC1s
aW5rLCBTQ1YsIEJhbmRSaWNoLCBTdHJvbmdyaXNpbmcuLiAobW9yZSB0aGFuIDMwIHZlbmRvcnMg
aW4gQ2hpbmEpClNpZXJyYSwgU29ueS1Fcmljc3NvbiwgT3B0aW9uLCBOb3ZhdGVsLCBBbGNhdGVs
LCBTYW1zdW5nLCBMRywgQW55RGF0YSwgQy1tb3RlY2gsIE1pY3JvbWF4Li4uCldlIGNhbiB0cnkg
d2l0aCB0aGVtIHN0ZXAgYnkgc3RlcCwgYnV0IGNhbiB3ZSB3b3JrIG91dCB0aGUgMiBiaWdnZXN0
IGZpcnN0bHk/Ckxvb2tzIEFUSSBjb21tYW5kIGNhbiB3b3JrIGZvciBib3RoIEh1YXdlaSBhbmQg
WlRFIGRvbmdsZXMuCgo8L3ByZT4KICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPkkgYWdyZWUgaGVyZSwgdGhlIHdvcmsgdG8g
YmUgZG9uZSBvdmVyIGFsbCBtYW51ZmFjdHVyZXJzIHdpbGwgYmUKZmFzdGlkaW91cyBhbmQgbWln
aHQgcmVxdWlyZSBhIGxvdCBvZiBkb25nbGVzIHRoYXQgd2UgZG9uJ3QgaGF2ZSBjdXJyZW50bHku
Ck1heWJlIHdlIGNvdWxkIGRvIGFzIFlpbmcgQW4gcHJvcG9zZWQgYXMgd2UgYXJlIHN1cmUgQVRJ
IHdvcmtzIGZvcgpIdWF3ZWkgYW5kIFpURSAoYXQgbGVhc3QgdGhlIG9uZXMgd2UgaGF2ZSkuCkhv
d2V2ZXIsIGNvbmVybmluZyBaVEUgSSBoYXZlbid0IHNlZW4gYW55IENETUEgZG9uZ2xlIGZvciB0
aGUgbW9tZW50LgoKPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSI+CiAgICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAg
ICAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPHByZSB3cmFwPSIiPkFsc28geW91IGRvIHJlYWxpemUgdGhhdCB0aGUgR0F0Q2hh
dCBvYmplY3QgYW5kIHRodXMgdGhlIGZpbGUgZGVzY3JpcHRvcgppcyBvd25lZCBieSB0aGUgbW9k
ZW0gcGx1Z2luLiBUaGUgcGx1Z2luIGl0c2VsZiBpcyB0aGUgb25seSBvbmUgdGhhdApzaG91bGQg
ZG8gYW55IGtpbmQgb2YgSU8uCgpTbyBpZiB3ZSByZXF1aXJlIHRvIHJ1biBBVEkgZmlyc3QgdG8g
aWRlbnRpZnkgaWYgd2UgYXJlIEdTTSBvciBDRE1BLAp0aGVuIHRoaXMgaXMgYSBwZXIgbW9kZW0g
bWFudWZhY3R1cmUgc3BlY2lmaWMgZGV0YWlsLiBBbmQgd2UgcmF0aGVyIGFkZAphIGhlbHBlciBm
dW5jdGlvbiBsaWtlIHdlIGRpZCBmb3IgQ1BJTiBwb2xsaW5nIHRoYXQgbWFrZXMgdGhpcyBlYXNp
ZXIuCgo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+SW4gY3VycmVudCBjb2Rl
IHRoZSAnZHJpdmVyJyBpcyBoYXJkY29kZWQgYnkgY29tcGFyaW5nIHdpdGggdmVuZG9yX2xpc3Rb
XS4KU28gaWYgaXQgcG9zc2libGUgdG8gYnJlYWsgdGhlIHN0ZXAgaW50byBzZXZlcmFsOgp2ZW5k
b3JfbGlzdFtdIGluIHVkZXZuZyBqdXN0IGNhcmVzIGFib3V0IHZlbmRvciAtIGJ5IGNvbXBhcmlu
ZyB2ZW5kb3IgSUQKPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVv
dGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICAg
ICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxwcmUgd3Jh
cD0iIj5vbmx5LAo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPmFuZCBhZGQgYWxsIHBv
c3NpYmxlIGRyaXZlcnMgYWNjb3JkaW5nIHRvIHRoYXQgdmVuZG9yIC0gKGZvciBleGFtcGxlIGFk
ZApXQ0RNQSwgQ0RNQTJrLCBURFNDRE1BLCBMVEUgLi4uZHJpdmVycyBpZiBIdWF3ZWkgZG9uZ2xl
IGlzIHBsdWdnZWQKPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVv
dGU+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICAg
ICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxwcmUgd3Jh
cD0iIj5pbiksCjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBl
PSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRl
Ij4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+YW5kIHRoZSBwcm9iZSBp
bnRlcmZhY2UgaW4gZWFjaCBkcml2ZXIgZG9lcyByZWFsIHByb2JlIHdvcmsgYXMgdG8gaXNzdWUK
QVRJIGNvbW1hbmQgdG8gZW5zdXJlIG9ubHkgY29ycmVjdCBkcml2ZXIgd2lsbCBiZSBsb2FkZWQ/
CjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPkFzIEkgc2FpZCBiZWZvcmUsIHRoZSBv
bmx5IHRpbWUgSU8gY2FuIGJlIHN0YXJ0ZWQgaXMgd2hlbiB0aGUgLSZndDtlbmFibGUoKQpjYWxs
YmFjayBvZiB0aGUgbW9kZW0gcGx1Z2luIGlzIGNhbGxlZC4gTm90IGEgc2Vjb25kIGVhcmxpZXIu
CjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAg
ICAgICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+QnV0IGlmIGRvbmUgYWZ0ZXIgZW5hYmxlKCkg
Y2FsbGVkLCBmcm9tIHNlbWFudGljIGFzcGVjdCB0aGUgY29ycmVjdCBkcml2ZXIgaGFzCjwvcHJl
PgogICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAg
ICAgICAgIDxwcmUgd3JhcD0iIj5iZWVuCjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICA8
YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgICAgICAgICAgICA8cHJlIHdy
YXA9IiI+Y2hvc2VuLiBJbmRlZWQgdGhlIHByb2JlKCkgaW50ZXJmYWNlIGluIGVhY2ggZHJpdmVy
IGlzIG5vdCBkb2luZyBzb21ldGhpbmcgdG8KPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgICAg
IDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPnByb2Jl
LAo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
CiAgICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPnRoZW4gY2FuIHRoZSB3b3Jr
IGJlIGRvbmUgaW4gcHJvYmUoKT8gQXMgc2V0IENGVU49MSB0aGVuIGRvaW5nIHNvbWUgZG9uZ2xl
CjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAg
ICAgICAgICAgICAgIDxwcmUgd3JhcD0iIj52ZW5kb3IKPC9wcmU+CiAgICAgICAgICAgICAgICAg
ICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAgICAgICAgICAg
IDxwcmUgd3JhcD0iIj5zcGVjaWZpYyB3b3JrIGFzIHF1ZXJ5IG1vZGVsIG9yIG5ldHdvcmsgbW9k
ZSBieSBBVEksIEFUK0dDQVAgY29tbWFuZCwKPC9wcmU+CiAgICAgICAgICAgICAgICAgICAgICAg
IDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPmV0Yy4u
PyBBZnRlcgo8L3ByZT4KICAgICAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPnRoYXQgZGlzYWJs
ZSBkb25nbGUgd2hlbiBxdWl0IHByb2JlKCk/CjwvcHJlPgogICAgICAgICAgICAgICAgICAgICAg
ICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgICAgICAgIDxwcmUgd3JhcD0iIj5UaGUg
cHJvYmUoKSBjYWxsYmFjayBpcyBmb3IgYWNjZXB0aW5nIHRoZSBkcml2ZXIgYW5kIGFsbG9jYXRp
bmcgcmVxdWlyZWQKbG9jYWwgZGF0YSBzdHJ1Y3R1cmVzLiBJdCBpcyBub3QgZm9yIElPLiBBbmQg
YXMgeW91IGNhbiBzZWUgaXQgaGFzIG5vCmNhbGxiYWNrIGhhbmRsaW5nIGxpa2UgZW5hYmxlKCkg
d2l0aCBzZXRfcG93ZXJlZCgpLgoKQXMgSSBzYWlkIGJlZm9yZSwgbm8gQVQgY29tbWFuZHMgYmVm
b3JlIGVuYWJsZSgpIGhhcyBiZWVuIGNhbGxlZC4gVGhhdAppcyBob3cgaXQgaXMgc3VwcG9zZSB0
byBiZS4gV2UgYXJlIG5vdCBjaGFuZ2luZyB0aGlzLgo8L3ByZT4KICAgICAgICAgICAgICAgICAg
ICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAg
ICAgICAgICAgICAgICAgPHByZSB3cmFwPSIiPkZpcnN0LCBBVEkgY29tbWFuZCBpcyB3b3JraW5n
IHdpdGhvdXQgc2VuZGluZyBBVCtDRlVOPTEsIHdlIGNvdWxkIGtlZXAKQ0ZVTj0xIGludG8gZW5h
YmxlKCkgYXMgd2UgZG8gc29tZSB2ZW5kb3IvbW9kZW0gdHlwZSBzcGVjaWZpYyBqb2IgdGhlcmUu
CgpUaGVuIHZlbmRvciBwbHVnaW4gY2FuIGJlIGNob3NlbiB1c2luZyB1ZGV2bmcgdXNpbmcgVmVu
ZG9yIElELCBob3dldmVyCmRyaXZlciB0eXBlIChDRE1BL0dTTSkgY2FuJ3QgbGllIG9uIHRoZSBQ
cm9kdWN0IElELiBTbyBpdCB3aWxsIGJlIGhhcmQKdG8gY2hvc2UgdGhlIHJpZ2h0IHZlbmRvciBw
bHVnaW4gd2l0aCByaWdodCB0eXBlLgpBbmQgaWYgd2UgY2FuJ3Qgc2VuZCBBVCBjb21tYW5kIGJl
Zm9yZSBlbmFibGUoKSB0aW1lIHdlIHdpbGwgZmFjZSB0byBiYWcKZW5kIGUuZy4gOgpGb3IgaHVh
d2VpIHBsdWdpbiB3ZSBzZW5kIEdTTSBzcGVjaWZpYyBBVCBjb21tYW5kIChBVF5SRlNXSVRDSCkg
ZHVyaW5nCnRoZSBlbmFibGUoKSB0aW1lLgpXZSBhcmUgYWxzbyBxdWVyeWluZyB0aGUgc2ltIHN0
YXRlIHVzaW5nIHBvbGxpbmcgbWVjaGFuaXNtIHRoYXQgbWlnaHQKZmFpbCBmb3IgQ0RNQSBtb2Rl
bXMgdGhhdCBpcyBub3QgdXNpbmcgU0lNLgpXaGF0IHdvdWxkIHlvdSBzdWdnZXN0IGhlcmU/Cjwv
cHJlPgogICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICAgIDxw
cmUgd3JhcD0iIj5hcyBJIHNhaWQgYmVmb3JlLCBubyBBVCBjb21tYW5kcyBiZWZvcmUgLSZndDtl
bmFibGUoKSBjYWxsYmFjayBmcm9tIHRoZQpjb3JlLgoKVGhlIGNhbGxiYWNrIC0mZ3Q7cHJvYmUo
KSBpcyBmb3IgYWNjZXB0aW5nIHRoZSBtb2RlbSBkcml2ZXIgYmluZGluZyBhbmQKYWxsb2NhdGlu
ZyBtb2RlbSBzcGVjaWZpYyBkYXRhIG1lbW9yeS4gVGhlIGNhbGxiYWNrIC0mZ3Q7cmVtb3ZlKCkg
aXMgZm9yCmNsZWFudXAuCgpUaGUgY2FsbGJhY2tzIC0mZ3Q7ZW5hYmxlKCksIC0mZ3Q7ZGlzYWJs
ZSgpIGFuZCAtJmd0O3NldF9vbmxpbmUoKSBhcmUgdGhlIG9ubHkgSU8KZW50cnkgcG9pbnRzIGZv
ciBldmVyeSBtb2RlbSBkcml2ZXIuIEFuZCB3ZSBuZWVkIHRvIGtlZXAgaXQgbGlrZSB0aGlzLgo8
L3ByZT4KICAgICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgIDxwcmUg
d3JhcD0iIj5Paywgc28gSSBzdWdnZXN0IHRvIGRvIHRoZSBBVEkgYXQgdGhlIHZlcnkgYmVnaW5u
aW5nIG9mIC0mZ3Q7ZW5hYmxlKCkgY2FsbGJhY2suCjwvcHJlPgogICAgICAgICAgICAgIDwvYmxv
Y2txdW90ZT4KICAgICAgICAgICAgICA8cHJlIHdyYXA9IiI+dGhlIGZpcnN0IGNvbW1hbmQgaGFz
IHRvIGJlIGFsd2F5cyBBVEUwICtDTUVFPTEgc2luY2Ugb3RoZXJ3aXNlIHlvdSBhKQpjYW4gbm90
IHVzZSB0aGUgcGVybWlzc2l2ZSBzeW50YXggcGFyc2VyIGFuZCBiKSB5b3VyIGVycm9yIHZhbHVl
cyB3aWxsCmJlIHVzZWxlc3MuCgpCdXQgeWVzLCBhZnRlciB0aGF0IGl0IGlzIGZpbmUgdG8gc2Vu
ZCBBVEkuCgo8L3ByZT4KICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICA8cHJl
IHdyYXA9IiI+T2sKCjwvcHJlPgogICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4K
ICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgICAgIDxw
cmUgd3JhcD0iIj5UaGVuIGRlcGVuZGluZyBvbiB0aGUgQVRJIGFuc3dlcjoKICAgICAgIC0gdGFn
IHRoZSBodWF3ZWkgbW9kZW0gZGF0YSB3aXRoIEdTTSAvIENETUEgdHlwZS4KICAgICAgIC0gc2Vu
ZCB0aGUgR1NNIC8gQ0RNQSBzcGVjaWZpYyBBVCBjb21tYW5kcyBmb2xsb3dlZCBieSBBVCtDRlVO
PTEuCjwvcHJlPgogICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICA8cHJl
IHdyYXA9IiI+V2hhdCBkaWZmZXJlbnQgY29tbWFuZHMgZGVwZW5kaW5nIG9uIEdTTSBvciBDRE1B
IGRvIHlvdSBhY3R1YWxseSBoYXZlPwoKVGhlIEFUXlJGU1dJVENIPT8gaXMgZXhhY3RseSBkZXNp
Z25lZCB0byBoYW5kbGUgaWYgdGhhdCBjb21tYW5kIGlzCnN1cHBvcnRlZCBvciBub3QuIFRoZXJl
IGFyZSBwbGVudHkgb2YgR1NNIHZlcnNpb25zIG9mIHRoZSBIdWF3ZWkgdGhhdCBkbwpub3Qgc3Vw
cG9ydCBBVF5SRlNXSVRDSC4gWW91IGRvIG5lZWQgdG8ga25vdyBpZiB0aGlzIGlzIHN1cHBvcnRl
ZCBvcgpub3QuCjwvcHJlPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgIDxw
cmUgd3JhcD0iIj5JIHNlZSwgc28gd2UgY2FuIHNlbmQgQVReUkZTV0lUQ0ggZm9yIGJvdGggdHlw
ZS4gSWYgaXQgaXMgbm90IHN1cHBvcnRlZCwKaXQgd2lsbCBiZSBpZ25vcmVkIHVzaW5nIHRlcm1p
bmF0b3IgYW5kIHRoZW4gdXNlCmRlZmF1bHQgQVQrQ0ZVTj01LgoKPC9wcmU+CiAgICAgICAgICAg
IDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgIDxwcmUgd3JhcD0iIj5BbHNv
IHdlIGRvIG5vdCBzZW5kIEFUK0NGVU49MSBpbiAtJmd0O2VuYWJsZSgpIGNhbGxiYWNrLiBXZSBi
cmluZyB0aGUgbW9kZW0KaW50byBvZmZsaW5lIG1vZGUuIFRoZSBvbmx5IHRpbWUgeW91IHNlbmQg
QVQrQ0ZVTj0xIGlzIGlmIHlvdSBoYXZlCmhhcmR3YXJlIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBv
bmxpbmUvb2ZmbGluZSBkaXN0aW5jdGlvbi4gU28gaWYgdGhpcyBpcwp0cnVlIGZvciBIdWF3ZWkg
Q0RNQSBtb2RlbXMsIHRoZW4gdGhlIG9idmlvdXMgcXVlc3Rpb25zIGlzIHdoeSB0aGF0IGlzCnRo
ZSBjYXNlPyBPciBpcyB0aGlzIGEgYnVnIHdpdGggb3VyIENETUEgc3VwcG9ydCBub3Qgc3VwcG9y
dGluZyBvZmZsaW5lCm1vZGUuCgo8L3ByZT4KICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAg
ICAgICAgICA8cHJlIHdyYXA9IiI+Rm9yIHRoZSBtb21lbnQsIENETUEgbW9kZW1zIGFyZSBub3Qg
dXNpbmcgLSZndDtzZXRfb25saW5lKCkgY2FsbGJhY2sgKGl0IGlzCmF1dG9tYXRpY2FsbHkgc2V0
IG9ubGluZSBpbnRvIG1vZGVtLmMpLgpXZSB3aWxsIGhhdmUgdG8gbWFrZSBzb21lIHRlc3QgdG8g
Y2hlY2sgQVQrQ0ZVTj01IGlzIHdvcmtpbmcgb24gQ0RNQSBtb2RlbXMuCjwvcHJlPgogICAgICAg
ICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgPHByZSB3cmFwPSIiPlRoZSBIdWF3ZWkgR1NNIHN1
cHBvcnQgaXMgdXNpbmcgLSZndDtzZXRfb25saW5lKCkgY2FsbGJhY2suIEFuZCBzbyB0aGlzCm1l
YW5zIHRoYXQgeW91IG5lZWQgaXQgYWxzbyBmb3IgQ0RNQSBzdXBwb3J0LiBPdGhlcndpc2UgeW91
IGFyZSBiYWNrIGF0CnNxdWFyZSBvbmUuCgpBY3R1YWxseSB5b3UgbmVlZCB0byB0ZXN0IHRoZSBm
dWxsIENETUEgc3VwcG9ydCBhbmQgaWYgaXQgY2FuIHByb3Blcmx5CmhhbmRsZSAtJmd0O3NldF9v
bmxpbmUoKSBzdXBwb3J0LiBJZiBub3QsIHRoZW4gdGhpcyBuZWVkcyBmaXhpbmcuCgpBbHNvIEkg
YW0gc3RpbGwgbm90IHNlZWluZyBwcm9wZXIgc3VwcG9ydCBmb3IgQ0RNQSBTSU0gYXRvbS4gV2Ug
bmVlZCB0bwpzdG9wIGhhY2tpbmcgYXJvdW5kIGhlcmUuIFRoZSBjb3JlIGZ1bmN0aW9uYWxpdHkg
bmVlZHMgdG8gYmUgaW1wbGVtZW50ZWQKZmlyc3QuIFdpdGhvdXQgaXQsIHRoZSBtb2RlbSBwbHVn
aW5zIGNhbiBub3QgZnVuY3Rpb24gcHJvcGVybHkuCgpTbyB3aHkgYXJlIHdlIHdhc3RpbmcgdGlt
ZSB3aXRoIG1vZGVtIGRldGFpbHMgaGVyZS4gSWYgSSByZW1lbWJlcgpjb3JyZWN0bHksIERlbmlz
IGFuZCBJIG1hZGUgaXQgcHJldHR5IGNsZWFyIHRoYXQgU0lNIGF0b20gYW5kIG5ldHdvcmsKcmVn
aXN0cmF0aW9uIGF0b20gaXMgYSBmdW5kYW1lbnRhbCByZXF1aXJlbWVudCBmb3IgQ0RNQSBzdXBw
b3J0Lgo8L3ByZT4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPHByZSB3cmFwPSIiPgpJ
IGFncmVlIHdlIG5lZWQgU0lNIHN1cHBvcnQgZm9yIENETUEgbW9kZW0uCkhvd2V2ZXIgd2UgaGF2
ZSBubyBpbmZvIGFib3V0IEFUIGNvbW1hbmRzIHRvIG1hbmFnZSB0aGUgU0lNICBhbmQgaXRzIApm
aWxlIHN5c3RlbSBmcm9tIHRoZSB2ZW5kb3IuCkV2ZXJ5IENETUEgbW9kZW1zIGFyZSBRdWFsY29t
bSBiYXNlZCBhbmQgdGhlaXIgZHJpdmVycyBhcmUgbm90IG9wZW4tc291cmNlZC4KVW5sZXNzIHlv
dSBoYXZlIHNvbWUgc3BlY2lmaWNhdGlvbnMgY29uY2VybmluZyBDRE1BIGRyaXZlcnMgSSBkb24n
dCAKdGhpbmsgd2Ugd2lsbCBiZSBhYmxlIHRvIG1hbmFnZSBjb21wbGV0ZWx5IGFueSBTSU0gYXRv
bSBmb3IgQ0RNQSBtb2RlbXMuCjwvcHJlPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUg
d3JhcD0iIj4KeW91IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGNvcmUgbW9kZW0gc3RhdGUg
bG9naWMgd2l0aCB0cmFuc2l0aW9ucwpmcm9tIHByZV9zaW0sIHBvc3Rfc2ltIGFuZCBwb3N0X29u
bGluZSBpbiBjb25qdW5jdGlvbiB3aXRoIHNldF9vbmxpbmUgaXMKd29ya2luZyBzbW9vdGhseSBm
b3IgQ0RNQS4gQW5kIG9mIGNvdXJzZSBub3QgYnJlYWtpbmcgR1NNLgoKSSBkbyBub3Qgc2VlIGhv
dyB0aGlzIGNhbiBiZSBkb25lIHByb3Blcmx5IHdpdGhvdXQgaGF2aW5nIFNJTSBhdG9tCnN1cHBv
cnQgaW4gcGxhY2UuCjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgV2UgY2Fu
IGhhdmUgMyBzdGF0ZXMgaW4gQ0RNQSAoc3BlY2lmaWVkIGluIEh1YXdlaSBkb2N1bWVudGF0aW9u
KTo8YnI+CiAgICA8Zm9udCBzaXplPSIzIj4xOiBWYWxpZCBVSU0gY2FyZCBzdGF0dXM8YnI+CiAg
ICA8L2ZvbnQ+PGZvbnQgc2l6ZT0iMyI+MjQwOiBST01TSU0gdmVyc2lvbjxicj4KICAgIDwvZm9u
dD48Zm9udCBzaXplPSIzIj4yNTU6IFVJTSBjYXJkIG5vdCBleGlzdDwvZm9udD48YnI+CiAgICA8
YnI+CiAgICBDdXJyZW50bHkgdGhlIHByb2JsZW0gaXMgd2UgaGF2ZSBzb21lIENETUEgbW9kZW1z
IHdpdGggUk9NU0lNIGUuZy4KICAgIGVtYmVkZGVkIFNJTS48YnI+CiAgICBXaGVuIHdlIHNlbmQg
QVQrQ1BJTj8gaXQgYW5zd2VycyBDTUUgRVJST1IgU2ltIG5vdCBpbnNlcnRlZC48YnI+CiAgICA8
YnI+CiAgICBJIGRpc2N1c3NlZCB3aXRoIERlbmlzIGFib3V0IHRoaXMgaXNzdWUgYW5kIGhlIHJl
Y29tbWVuZGVkIG1lIG5vdCB0bwogICAgY3JlYXRlIFNJTSBhdG9tIHdoZW4gc3RhdHVzIGlzIFJP
TVNJTSB2ZXJzaW9uLjxicj4KICAgIDxicj4KICAgIEhvd2V2ZXIgd2UgaGF2ZSBzb21lIG90aGVy
IGRvbmdsZXMgd2l0aCBVSU0gd2hvc2Ugc3RhdGUgaXOgIDxmb250CiAgICAgIHNpemU9IjMiPjE6
IFZhbGlkIFVJTSBjYXJkIHN0YXR1cy48YnI+CiAgICA8L2ZvbnQ+VGhleSBzdXBwb3J0IHNvbWUg
QVQgY29tbWFuZHMgZnJvbSAiYXRtb2RlbSIgZHJpdmVycyAoQVQrQ1BJTgogICAgYW5kIEFUK0NJ
TUkgb25seSkgYnV0IG5vbmUgdG8gcmVhZCB0aGUgZmlsZSBzeXN0ZW0uPGJyPgogICAgQWxsIHRo
ZSBkb25nbGVzIHdlIGhhdmUgbGV0IGFyZSBub3QgUElOIGxvY2tlZDo8YnI+CiAgICBBVCtDUElO
PyBhbnN3ZXIgaXMgK0NQSU46IFJFQURZLjxicj4KICAgIDxicj4KICAgIElmIHlvdSB3YW50IGEg
U0lNIGF0b20gaXQgY291bGQgYmUgdXNlZCBmb3IgUElOIG1hbmFnZW1lbnQgb25seSBidXQKICAg
IGFzIEkgdG9sZCB5b3UgSSBoYXZlIG1ldCBub25lIGZvciB0aGUgbW9tZW50Ljxicj4KICAgIENv
bmNlcm5pbmcgLSZndDtzZXRfb25saW5lKCkgY2FsbGJhY2ssIGl0IGNhbiB3b3JrIHdpdGhvdXQg
U0lNIGF0b20KICAgIGJ1dCB3ZSBoYXZlIHRvIG1vZGlmeSBpdCBpbnRvIHRoZSB1bmlmaWVkIHBs
dWdpbi48YnI+CiAgICA8YnI+CiAgICBFdmVuIHdpdGggU0lNIGF0b20gZm9yIENETUEgbW9kZW1z
LCB3ZSB3aWxsIG5ldmVyIGJlIGFibGUgdG8gcmVhZAogICAgdGhlIFVJTSBmaWxlIHN5c3RlbSAo
QVQrQ1JTTSBpcyBub3Qgc3VwcG9ydGVkKS48YnI+CiAgICBXZSBjYW4gb25seSBleHBlY3Qgc29t
ZSBzdXBwb3J0IGZyb20gbWFudWZhY3R1cmVycyB0byBzdXBwb3J0IFVJTQogICAgZmlsZSBzeXN0
ZW0gbWFuYWdlbWVudC48YnI+CiAgICA8YnI+CiAgICBLaW5kIHJlZ2FyZHMsPGJyPgogICAgR3Vp
bGxhdW1lPGJyPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============4871276239666848830==--

