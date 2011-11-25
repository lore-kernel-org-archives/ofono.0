Content-Type: multipart/mixed; boundary="===============4595694952758863842=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Fri, 25 Nov 2011 17:31:14 +0100
Message-ID: <4ECFC2D2.7040303@linux.intel.com>
In-Reply-To: <4ECDEC28.4020505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4595694952758863842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> Looking to the modem manager, the priority is indeed to retrieve the SID
>> using the qcdm port com (thanks to the result of a radio status query).
>> In case of error, there is however a fallback to use the AT command
>> +CSS. Also, if no qcdm port is available, the SID is retrieved  by using
>> this AT command (please refer to 'legacy_get_serving_system').
>>
>> Note that in modem manager, there is also a special treatment for Huawei
>> modem which use the IS-707-A format (no band and class).
>
> I also noticed various comments stating that +CSS does not report any
> information when registered to EV-DO and it seems that the Huawei driver
> doesn't even bother using fallback mechanisms for EVDO capable hardware
> in the first place.  But maybe I'm not reading the code right...

You're right. I missed this point as this consideration seems rather =

linked with the registration state query.
In fact, I started to see the code from the network manager applet to =

see how the SID was retrieved.
That's why, I looked only for the 'GetServingSystem' method in modem =

manager. This method is implemented in the generic part and the flag =

'reg_try_css' is not checked here.

In fact, this problematic is not explicitely considered when getting the =

serving system in modem manager as the query is done first on the qcdm =

port. So, I presume that this port should always be available with EVDO =

capabale hardware.
So, the qcdm part seems mandatory.


>
>>
>> So far, the AT command "Serving system" seems relevant. Now, do you
>> expect us to communicate also through the qcdm port when using cdma mode=
m?
>
> Have you tested that your theories work?
Yes, I checked locally with huawei cdma dongles and the speedup SU 7300 =

that the command "AT+CSS?" was effectively supported.
I tested also remotely (through SSH with a machine in China where a =

huawei cdma dongle is plugged) that the SID was correctly returned when =

registered.

As you can see below:

ofonod[30357]: Modem: < \r\n^MODE: =

2\r\r\n\r\r\n^RSSILVL:60\r\r\n\r\r\n^HRSSILVL:0\r\n
ofonod[30357]: PCUI: < \r\n^MODE: =

2\r\r\n\r\r\n^RSSILVL:60\r\r\n\r\r\n^HRSSILVL:0\r\n
ofonod[30357]: Modem: > AT^SYSINFO\r
ofonod[30357]: Modem: < \r\n^SYSINFO:2,255,0,2,1\r\n\r\nOK\r\n
ofonod[30357]: drivers/cdmamodem/network-registration.c:parse_sysinfo() =

2, 255, 0
ofonod[30357]: Modem: > AT+CSS=3D?\r
ofonod[30357]: Modem: < \r\n?, 13840\r\n\r\nOK\r\n
ofonod[30357]: =

drivers/cdmamodem/network-registration.c:serving_system_cb() serving =

system: SID 13840
ofonod[30357]: src/cdma-netreg.c:serving_system_callback() Serving =

system Identifier: 13840

Here the provider name is not found. Maybe the provider info file placed =

in the remote desktop is not sufficiently populated.


Right now I'm seeing you
> making lots of assumptions, and moving code from the huawei specific
> driver to some generic driver when in fact no such generality exists.
> CDMA does not have an AT command standard ;)

In fact, I applied the same approach as for the atmodem driver.
We only have one network-registration driver which is taking care of all =

manufacturer specific commands (as for Huawei).
As the AT command '+CSS' is supported by both Speedup cdma And Huawei =

cdma, I took the initiative indeed to move the specific huawei part into =

a generic driver.
Also, the AT command AT+CSS is implemented in the generic part in modem =

manager.

>
> And yes, if the AT command does not do what we need, then using QCDM
> would be required.

As stated above, I will start to implement the QCDM part as this should =

be required when using EVDO capable hardware.

Thanks.

Regards,

Philippe.

--===============4595694952758863842==--

