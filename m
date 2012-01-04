Content-Type: multipart/mixed; boundary="===============8955609174524483453=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: The way to install proper driver for 3G dongle in oFono
Date: Wed, 04 Jan 2012 10:57:04 +0100
Message-ID: <4F042270.4020305@linux.intel.com>
In-Reply-To: <688E999A39D0DD478D9CFCDC485D64828E15@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8955609174524483453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel and Ying An,

On 23/12/2011 15:03, Deng, Ying An wrote:
>> Hi Ying An,
>>
>>>>>> and what about the case when the SIM card is present, but PIN locked?
>>>>>>
>>>>>>> According to the result, it might be interesting to send ATI when t=
he
>>>>>>> constructor plugin is probe by oFono.
>>>>>>> Thus with +GCAP info we can decide which driver to use.
>>>>>> Is sending +GCAP after ATI really a standard? Have we tried anything
>>>>>> else besides Huawei or ZTE?
>>>>> I tried with more dongles from different vendors, as attached table.
>>>>> The scenarios include:
>>>>> With valid sim card, sim card PIN locked, no sim card, sim card locke=
d.
>>>>> N(ROM) in table indicates the SIM in ROM already.
>>>>> ATI command can always return GCAP content in all tests.
>>>> and what about other manufactures other than Huawei, ZTE and SpeedUp?
>>>> What about Sierra, Ericsson etc.?
>>> Just checked Dell 5530 with Ericsson module,
>>> With SIM card or not, at+gcap can return +GCAP:+CGSM, +DS
>>> But the ATI only returns: D5530
>> I think it is clear that we need to do our homework here and properly
>> document the different manufacturers. Someone sending patches for our
>> doc/ directory?
> There're many vendors of 3G dongle..
> Huawei, ZTE (they share 70%+ of global market), Longcheer, Haier, Sentar,=
 Viton, D-link, SCV, BandRich, Strongrising.. (more than 30 vendors in Chin=
a)
> Sierra, Sony-Ericsson, Option, Novatel, Alcatel, Samsung, LG, AnyData, C-=
motech, Micromax...
> We can try with them step by step, but can we work out the 2 biggest firs=
tly?
> Looks ATI command can work for both Huawei and ZTE dongles.
>

I agree here, the work to be done over all manufacturers will be =

fastidious and might require a lot of dongles that we don't have currently.
Maybe we could do as Ying An proposed as we are sure ATI works for =

Huawei and ZTE (at least the ones we have).
However, conerning ZTE I haven't seen any CDMA dongle for the moment.

>>>>>> Also you do realize that the GAtChat object and thus the file descri=
ptor
>>>>>> is owned by the modem plugin. The plugin itself is the only one that
>>>>>> should do any kind of IO.
>>>>>>
>>>>>> So if we require to run ATI first to identify if we are GSM or CDMA,
>>>>>> then this is a per modem manufacture specific detail. And we rather =
add
>>>>>> a helper function like we did for CPIN polling that makes this easie=
r.
>>>>>>
>>>>> In current code the 'driver' is hardcoded by comparing with vendor_li=
st[].
>>>>> So if it possible to break the step into several:
>>>>> vendor_list[] in udevng just cares about vendor - by comparing vendor=
 ID
>> only,
>>>>> and add all possible drivers according to that vendor - (for example =
add
>>>>> WCDMA, CDMA2k, TDSCDMA, LTE ...drivers if Huawei dongle is plugged
>> in),
>>>>> and the probe interface in each driver does real probe work as to iss=
ue
>>>>> ATI command to ensure only correct driver will be loaded?
>>>> As I said before, the only time IO can be started is when the ->enable=
()
>>>> callback of the modem plugin is called. Not a second earlier.
>>> But if done after enable() called, from semantic aspect the correct dri=
ver has
>> been
>>> chosen. Indeed the probe() interface in each driver is not doing someth=
ing to
>> probe,
>>> then can the work be done in probe()? As set CFUN=3D1 then doing some d=
ongle
>> vendor
>>> specific work as query model or network mode by ATI, AT+GCAP command,
>> etc..? After
>>> that disable dongle when quit probe()?
>> The probe() callback is for accepting the driver and allocating required
>> local data structures. It is not for IO. And as you can see it has no
>> callback handling like enable() with set_powered().
>>
>> As I said before, no AT commands before enable() has been called. That
>> is how it is suppose to be. We are not changing this.

First, ATI command is working without sending AT+CFUN=3D1, we could keep =

CFUN=3D1 into enable() as we do some vendor/modem type specific job there.

Then vendor plugin can be chosen using udevng using Vendor ID, however =

driver type (CDMA/GSM) can't lie on the Product ID. So it will be hard =

to chose the right vendor plugin with right type.
And if we can't send AT command before enable() time we will face to bag =

end e.g. :
For huawei plugin we send GSM specific AT command (AT^RFSWITCH) during =

the enable() time.
We are also querying the sim state using polling mechanism that might =

fail for CDMA modems that is not using SIM.
What would you suggest here?

Kind regards,
Guillaume

--===============8955609174524483453==--

