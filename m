Content-Type: multipart/mixed; boundary="===============4144277934380270534=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: RE: The way to install proper driver for 3G dongle in oFono
Date: Wed, 21 Dec 2011 15:34:13 +0800
Message-ID: <CE59C043D0EC3349B2BF41C0EC72229B12E8C2047E@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1324399281.1965.118.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4144277934380270534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Marcel Holtmann
>Sent: Wednesday, December 21, 2011 12:41 AM
>To: ofono(a)ofono.org
>Subject: Re: The way to install proper driver for 3G dongle in oFono
>
>Hi Guillaume,
>
>> >> We are facing a problem in oFono when using 3G modems:
>> >>
>> >> A CDMA2000 modem can have same PID with WCDMA modem, or
>TDS-CDMA
>> >> modem -- 3G modem vendors already confirm they do that.
>> >>
>> >> That's to say, if following current strategy, it will be a problem to
>> >> install proper driver for this kind of 3G modem.
>> >>
>> >> So, is it feasible to find out a solution such as to probe the modem
>> >> firstly, find out what kind of network modes it supports, and then
>> >> install the driver?
>> >>
>> >> The way to probe the modem could be some action as to read the
>> >> capability or get system mode, or issue some specific AT command that
>> >> only response to certain network mode?
>> >>
>> >
>> > Indeed, we could use for Huawei modems for instance the AT^SYSINFO
>> > command and retrieve the sys_mode field and parse it, I have found
>> > this in public Huawei specifications:
>> >
>> > <sys_mode>: System mode. The values are as follows:
>> > 0 No service.
>> > 1 AMPS mode
>> > 2 CDMA mode
>> > 3 GSM/GPRS mode
>> > 4 HDR mode
>> > 5 WCDMA mode
>> > 8 CDMA/HDR HYBRID mode
>> >
>> > Thus we can chose accordingly the drivers to create oFono atoms.
>>
>> After some investigations, it seems SYSINFO won't be enough to get the
>> modem type because with this AT command we will have to be registered to
>> the network to get the system mode.
>> The only way I found until now is using the AT+GCAP to check whether the
>> modem is CDMA or GSM type.
>> However if we do the AT+GCAP request for each constructor plugin
>> (huawei, zte, ...) it will bring some duplicated code.
>> Does someone see any better solution?
>
>I like to see that we do proper homework here. The first question is
>actually can you execute AT+GCAP if not SIM card has been inserted or is
>actually locked? And if not does, ATI provide an extra +GCAP response.
>Without a SIM atom you will not be able to unlock the modem. And you can
>only create the SIM atom if you know what modem technology you are
>using. Additionally of course additionally, what are the responses for
>various modem models and manufactures. Are they doing this actually
>properly.
>
>We need OFONO_AT_DEBUG traces for all the various permutations of this
>behavior. This needs to be documented first. Feel free to send patches
>to add the results to doc/ directory inside oFono.
>
>Just randomly hacking around will get us in trouble and will make well
>behaved modems like MBM or IFX fail or suffer for no apparent reasons.
>
>Regards
>
>Marcel
>

The at+gcap command only effective after SIM card inserted.
It is feasible to firstly find the vendor, then choose specific method to d=
etect
if it is wcdma/cdma2k, then install proper driver?

>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============4144277934380270534==--

