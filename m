Content-Type: multipart/mixed; boundary="===============3933504684344638806=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/gprs: added LTE and NR indicators
Date: Thu, 27 Sep 2018 10:46:37 -0500
Message-ID: <b0d703f7-ec34-ffc2-bd5c-680db4135fa9@gmail.com>
In-Reply-To: <20180923051552.5649-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3933504684344638806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/23/2018 12:15 AM, Giacinto Cifelli wrote:
> According to the 27.007 CGREG (both as URC and command) is no longer
> sufficient to determine the registration state.

What does CGREG have to do with the overall registration state?  CGREG =

is only used for packet domain registrations in 2G/3G.  +CREG is still =

the definitive source of information, and in fact the registration state =

is generally ignored by src/gprs.c if technology is set to E-UTRAN.

> New indicators: CEREG for LTE, C5GREG for NR/5G are introduced.
> =

> In practice, legacy modems have CGREG, LTE-only modems have CEREG, and
> several others have both.
> With NR the picture will become even larger.
> =

> The handling of these indicators is not straighforward, because each
> will report the status in its own access technology. So we might have
> CGREG=3D4 but CEREG=3D1. Therefore they must be checked together.
> Particularly troublesome is the case of the URC. In case of hand-over,
> for example for a CSFB call, a common case is to have '+CEREG: 4'
> followed by '+CGREG: 1'. The first URC must be discarded, and this is
> done checking the technology reported by 'AT+COPS?' after the URC is

Err, why?  We should get a proper status from +CREG.  And the =

network-registration state overrides whatever status the gprs atom =

thinks it is in.

Also, the driver is the wrong place for all this logic anyway.  CEREG =

and C5REG status reporting is standardized, so we can easily add this to =

the oFono core (gprs) API.  E.g. ofono_gprs_status_notify was for 2G/3G =

PS domain registration state reporting (CGREG).  We should now introduce =

ofono_gprs_eutran_status_notify for reporting CEREG status and =

ofono_gprs_5g_status_notify for C5REG.  The core then can collate this =

information and act accordingly.  Having each driver doing all this =

logic is wasteful and error prone.

> received, in case the status is different from 1 or 5 (to be done:
> add the check for other roaming states for NR once the first modems are
> available). Note that according to the 27.007 CREG does not apply to PS
> networks, so it cannot be reliably used.

It does not apply to Packet Switched 2G/3G networks.  The registration =

to packet domain is separate in that case.  It still applies to EUTRAN:

"an unsolicited result code +CREG:=C2=A0<stat> when <n>=3D1 and there is a =

change in the MT=E2=80=99s circuit mode network registration status in =

GERAN/UTRAN/E-UTRAN, or unsolicited result code =

+CREG:=C2=A0<stat>[,[<lac>],[<ci>],[<AcT>]] when <n>=3D2 and there is a cha=
nge =

of the network cell in GERAN/UTRAN/E-UTRAN."

> If COPS does not report a technology or reports the same technology,
> we take the indicator.

This sounds unnecessary to me...

> =

> Similar handling for AT+CGREG?, AT+CEREG?, AT+C5GREG? : we take the
> best result.
> =

> An initial verification for the presence of any of these indicators is
> required. Also how many of them are available is needed information.

So the real question is, why do you think you need all this anyway?  The =

GPRS registration status is only important for one case, and that is =

control of packet domain registration while roaming on 2G/3G networks. =

On EUTRAN networks that is not possible anyway, so we're essentially =

always Powered & Attached regardless of the RoamingAllowed setting.

> ---
>   drivers/atmodem/gprs.c | 420 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 364 insertions(+), 56 deletions(-)
> =


Regards,
-Denis

--===============3933504684344638806==--

