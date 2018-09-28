Content-Type: multipart/mixed; boundary="===============3443260324864852755=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/gprs: added LTE and NR indicators
Date: Fri, 28 Sep 2018 08:07:58 +0200
Message-ID: <CAKSBH7HJ0XghPAVzMxhFoarg03xo6CWde-GzSW7=TjnaKzFyhA@mail.gmail.com>
In-Reply-To: <b0d703f7-ec34-ffc2-bd5c-680db4135fa9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3443260324864852755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Sep 27, 2018 at 5:46 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 09/23/2018 12:15 AM, Giacinto Cifelli wrote:
> > According to the 27.007 CGREG (both as URC and command) is no longer
> > sufficient to determine the registration state.
>
> What does CGREG have to do with the overall registration state?  CGREG
> is only used for packet domain registrations in 2G/3G.  +CREG is still
> the definitive source of information, and in fact the registration state
> is generally ignored by src/gprs.c if technology is set to E-UTRAN.

Apologies, wrong terminology, I meant attach.

>
> > New indicators: CEREG for LTE, C5GREG for NR/5G are introduced.
> >
> > In practice, legacy modems have CGREG, LTE-only modems have CEREG, and
> > several others have both.
> > With NR the picture will become even larger.
> >
> > The handling of these indicators is not straighforward, because each
> > will report the status in its own access technology. So we might have
> > CGREG=3D4 but CEREG=3D1. Therefore they must be checked together.
> > Particularly troublesome is the case of the URC. In case of hand-over,
> > for example for a CSFB call, a common case is to have '+CEREG: 4'
> > followed by '+CGREG: 1'. The first URC must be discarded, and this is
> > done checking the technology reported by 'AT+COPS?' after the URC is
>
> Err, why?  We should get a proper status from +CREG.  And the
> network-registration state overrides whatever status the gprs atom
> thinks it is in.

yes and no. In case of handover things get messy today.
I will try to collect a log to show this.

>
> Also, the driver is the wrong place for all this logic anyway.  CEREG
> and C5REG status reporting is standardized, so we can easily add this to
> the oFono core (gprs) API.  E.g. ofono_gprs_status_notify was for 2G/3G
> PS domain registration state reporting (CGREG).  We should now introduce
> ofono_gprs_eutran_status_notify for reporting CEREG status and
> ofono_gprs_5g_status_notify for C5REG.  The core then can collate this
> information and act accordingly.  Having each driver doing all this
> logic is wasteful and error prone.

this is specific to AT-based modem. qmi and mbim do not suffer from this.
I don't know about dun, ril, isi drivers (the other ones that
implement a gprs atom)
So, in my opinion is related to the 27.007, and stays in the driver.

>
> > received, in case the status is different from 1 or 5 (to be done:
> > add the check for other roaming states for NR once the first modems are
> > available). Note that according to the 27.007 CREG does not apply to PS
> > networks, so it cannot be reliably used.
>
> It does not apply to Packet Switched 2G/3G networks.  The registration
> to packet domain is separate in that case.  It still applies to EUTRAN:

here I am wrong.
I have re-checked the 27.007 and CREG applies for all technologies.

>
> "an unsolicited result code +CREG: <stat> when <n>=3D1 and there is a
> change in the MT=E2=80=99s circuit mode network registration status in
> GERAN/UTRAN/E-UTRAN, or unsolicited result code
> +CREG: <stat>[,[<lac>],[<ci>],[<AcT>]] when <n>=3D2 and there is a change
> of the network cell in GERAN/UTRAN/E-UTRAN."
>
> > If COPS does not report a technology or reports the same technology,
> > we take the indicator.
>
> This sounds unnecessary to me...

the problem here is that when there are different indicators for 2G/3G and =
LTE,
in case of change of technology one of them reports a deregistration
(from the previous technology), and promptly ofono sends AT+CGATT=3D0.

>
> >
> > Similar handling for AT+CGREG?, AT+CEREG?, AT+C5GREG? : we take the
> > best result.
> >
> > An initial verification for the presence of any of these indicators is
> > required. Also how many of them are available is needed information.
>
> So the real question is, why do you think you need all this anyway?  The
> GPRS registration status is only important for one case, and that is
> control of packet domain registration while roaming on 2G/3G networks.
> On EUTRAN networks that is not possible anyway, so we're essentially
> always Powered & Attached regardless of the RoamingAllowed setting.
>

maybe this is the issue: roaming should be handled at context-activation st=
age,
not with the attach.
All hand-over cases don't work well with ofono.
Even a simple registration in 3G first then upgraded to LTE by the
network will not work because
the module would send +CGREG=3D4 and ofono AT+CGATT=3D0, and detach from LT=
E,
back to 3G, perform another attach and repeat forever...

LTE modules are supposed to react to AT+CGATT=3Dx, just like any pre-LTE on=
es.
I haven't seen anywhere in the 27.007 that CGATT doesn't apply there.

I understand from your comments that the aim of ofono is to handle
first the registration with CREG,
then the attach.
I see if it is possible to come with some clean scenarios for this in
case of multiple technologies,
but I fear not without this kind of code.
Note that it will be the same for LTE->NR as it is now for 2G/3G->LTE.

> > ---
> >   drivers/atmodem/gprs.c | 420 +++++++++++++++++++++++++++++++++++------
> >   1 file changed, 364 insertions(+), 56 deletions(-)
> >
>
> Regards,
> -Denis

Regards,
Giacinto

--===============3443260324864852755==--

