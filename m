Content-Type: multipart/mixed; boundary="===============1751420334216894331=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Thu, 24 Feb 2011 12:34:14 +0200
Message-ID: <4D663426.7020706@nokia.com>
In-Reply-To: <4D655760.3000701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1751420334216894331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
>>> -----Original Message-----
>>> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
>>> Behalf Of Denis Kenzior
>>> Sent: Wednesday, February 23, 2011 5:50 PM
>>> To: ofono(a)ofono.org
>>> Cc: tomasz.gregorek(a)gmail.com
>>> Subject: Re: [PATCH] atmodem: CEREG support for LTE network status
>>> reporting in AT modem
>>>> After discussing internally with Fred Joly I would like to come back
>>> on the 4 properties :
>>>> - Suspended is applicable in LTE in case of CS Voice Call using CSFB
>>> My understanding was that CS Fallback physically switches technologies.
>>>   It is not 'suspending' LTE like it does with GPRS.  Am I wrong on this
>>> one?
>> I would say yes. :)
>> In case you are obliged to fallback from 4G to 2G without support of DTM=
, exaclty like in GPRS.
>  From what I understood you physically lose the EPS network registration
> and fall back to 3G / 2G.  How is this the same as the suspended
> property where your attached status does not change?
>>
For CSFB there are two settings. First one is that the UE should be =

voice centric.
A voice centric UE will always try to make voice service available =

either using IMS or by CSFB.
And if it cannot avail voice service using the above mechanisms, then it =

should leave E-UTRA and re connect to GERAN/UTRA. A data centric UE in =

turn will not leave E-UTRA if it cannot make a voice service available. =

(23.221, section 7.2a)

The second is that the voice call mode (domain), this can be set to CS, =

CS preferred, PS or PS preferred. A UE with CS or CS preferred will =

always try to make voice service through CS (CSFB or by re connecting to =

GERAN/UTRA). 24.167 and also 23.221 describes these setting. I think the =

AT commands for these in 27.007 are AT+CEMODE and +VCMOD

A UE indicates its CSFB capability in attach and location/routing area =

updates. The network in turn also indicates whether these are supported =

in network.
23.272 section 6.2 details a CSFB for MO call, where PS handover is =

supported. 6.3 where PS handover is not supported and 6.5 where how to =

return to E-UTRA when PS is suspended.

My understanding is that the context behaves the same way as in GPRS, =

where it can be suspended, deactivated or handed over while doing CSFB =

and the attach status will not change because when you are doing CSFB =

you have done a combined attach (EPS/IMSI).

>>> Perhaps, but again we have no control of the attach procedure with LTE.
>>>   So the implementation has to rely on vendor specific radio settings.
>>> Same arguments about shoehorning logic apply here.
>> I'm a bit puzzled by this statement. It is not specific to LTE, but rela=
ted to +CFUN proprietary implementation against  +COPS or +CGATT  usage, is=
n't it?
>>
> The current GPRS logic is controlled with the equivalent of CGATT.  This
> is a well-defined command by 3GPP, but it is not applicable to EPS
> domain.  It is applicable only to PS domain, correct?
27.007 release 10, section 10, lists all commands applicable to EPS and =

CGATT is one of them.

> If so, then the
> powered property does not map to LTE at all.  Your proprietary CFUN/COPS
> map to the TechnologyPreference setting in RadioSettings.
>
Regards,
Arun


--===============1751420334216894331==--

