Content-Type: multipart/mixed; boundary="===============2317921038331669260=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 12:52:16 -0600
Message-ID: <4D655760.3000701@gmail.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D701098A699C@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2317921038331669260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

On 02/23/2011 12:24 PM, Joly, Frederic wrote:
> Hi Denis,
> =

>> -----Original Message-----
>> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
>> Behalf Of Denis Kenzior
>> Sent: Wednesday, February 23, 2011 5:50 PM
>> To: ofono(a)ofono.org
>> Cc: tomasz.gregorek(a)gmail.com
>> Subject: Re: [PATCH] atmodem: CEREG support for LTE network status
>> reporting in AT modem
>>> After discussing internally with Fred Joly I would like to come back
>> on the 4 properties :
>>> - Suspended is applicable in LTE in case of CS Voice Call using CSFB
>>
>> My understanding was that CS Fallback physically switches technologies.
>>  It is not 'suspending' LTE like it does with GPRS.  Am I wrong on this
>> one?
> =

> I would say yes. :) =

> In case you are obliged to fallback from 4G to 2G without support of DTM,=
 exaclty like in GPRS.

From what I understood you physically lose the EPS network registration
and fall back to 3G / 2G.  How is this the same as the suspended
property where your attached status does not change?

> =

>>
>> Perhaps, but again we have no control of the attach procedure with LTE.
>>  So the implementation has to rely on vendor specific radio settings.
>> Same arguments about shoehorning logic apply here.
> =

> I'm a bit puzzled by this statement. It is not specific to LTE, but relat=
ed to +CFUN proprietary implementation against  +COPS or +CGATT  usage, isn=
't it?
>

The current GPRS logic is controlled with the equivalent of CGATT.  This
is a well-defined command by 3GPP, but it is not applicable to EPS
domain.  It is applicable only to PS domain, correct?  If so, then the
powered property does not map to LTE at all.  Your proprietary CFUN/COPS
map to the TechnologyPreference setting in RadioSettings.

Regards,
-Denis

--===============2317921038331669260==--

