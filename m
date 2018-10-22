Content-Type: multipart/mixed; boundary="===============8413944847540974057=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: airplane mode
Date: Mon, 22 Oct 2018 19:17:01 +0200
Message-ID: <CAKSBH7FEqU3PMSLu85ZPFFyQsG7Ni4cyr1Lo2o4O57SEjJhxZA@mail.gmail.com>
In-Reply-To: <c264e35a-d7e3-fab0-b307-e3f5dee64ccf@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8413944847540974057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Oct 22, 2018 at 7:02 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> And it is fully possible to make emergency calls.  Just set Online=3DT=
rue
> >> first.
> >
> > ahh, like that yes.... but then, wouldn't be better to create the
> > voicecall atom where it belongs, in post_online ?
> > Or this stage is never reached without a SIM? If not, what handle we
> > have that is called for sure after AT+CFUN=3D1 ?
> >
>
> Correct, without a SIM or PIN not unlocked, you'd never get to
> post_online, even Online=3DTrue being set.

Could we think of another state?
I am seeing a few versions of ofono recently, and all struggle with
things like this.
Not everybody is up to discuss for their needs, so the problem simply
go unnoticed.

>
> You can watch the modem state, but I don't recall that any of our modems
> had this issue...
>
> >>> Also, several test commands fail in airplane mode, e.g.: AT+CLCK=3D?
> >>
> >> I doubt this has anything to do with airplane mode.  Is it that the SIM
> >> is not initialized yet?  But even then, why would the firmware not
> >> report all available locks regardless?
> >>
> >
> > According to the 27.007 (and our modules) AT+CLCK interrogates the
> > network for some locks, and for this it must be online.
> > Au passage, the 27.007 mentions explicitly that the command must be
> > abortable when network facilities are set or interrogated.
>
> Sure, but we're not setting or interrogating any network locks.  We're
> just testing the capability of the modem.  So the above 27.007 part does
> not apply.
>
> >
> > So, that command is not well placed when the module is in CFUN=3D4.
> > I don't know on what insane kind of modules it has been tested, but it
> > is wrong ;)
>
> I would disagree.  We use CLCK to query for SIM locks, facility locks,
> etc...

atmodem asks for AT+CLCK=3D?, and gets what it gets, despite your
exclusive interest in sim-related parameters. In particular all
modules return at least a subset of the following locks, all requiring
network access to determine whether they are available or not:

       "AO" BAOC (Barr All Outgoing Calls) (refer 3GPP TS 22.088 [6] clause=
 1)
       "OI" BOIC (Barr Outgoing International Calls) (refer 3GPP TS
22.088 [6] clause 1)
       "OX" BOIC=E2=80=91exHC (Barr Outgoing International Calls except to
Home Country) (refer 3GPP TS 22.088 [6] clause 1)
       "AI" BAIC (Barr All Incoming Calls) (refer 3GPP TS 22.088 [6] clause=
 2)
       "IR" BIC=E2=80=91Roam (Barr Incoming Calls when Roaming outside the
home country) (refer 3GPP TS 22.088 [6] clause 2)
       "NT" barr incoming calls from numbers Not stored to TA memory
       "NM" barr incoming calls from numbers Not stored to MT memory
       "NS" barr incoming calls from numbers Not stored to SIM/UICC memory
       "NA" barr incoming calls from numbers Not stored in Any memory
       "AB" All Barring services (refer 3GPP TS 22.030 [19])
(applicable only for <mode>=3D0)
       "AG" All outGoing barring services (refer 3GPP TS 22.030 [19])
(applicable only for <mode>=3D0)
       "AC" All inComing barring services (refer 3GPP TS 22.030 [19])
(applicable only for <mode>=3D0)
       "FD" SIM card or active application in the UICC (GSM or USIM)
fixed dialling memory feature (if PIN2 authentication has not been
done during the current session, PIN2 is required as <passwd>)
       "PN" Network Personalization (refer 3GPP TS 22.022 [33])
       "PU" network sUbset Personalization (refer 3GPP TS 22.022 [33])
       "PP" service Provider Personalization (refer 3GPP TS 22.022 [33])

Therefore a modem cannot really honor this command in airplane mode.

>
> >
> >>>
> >>> Is there a way to re-initialize all required atoms at the post-inline=
 stage?
> >>> Or should they be destroyed and re-created?
> >>>
> >>
> >> destroying and recreating is a bad idea because they will be moved into
> >> a different modem state level.  So the next time you go to airplane mo=
de
> >> you will lose your SIM atom.
> >>
> >> You can always listen to modem state changes in the driver, but I
> >> wouldn't recommend it.  The simplest answer is to fix your firmware ;)
> >
> > Let's think about a more reasonable solution.
> > Again, if there is an handle that is called after AT+CFUN=3D1,
> > regardless of the SIM presence, that would be the perfect place.
> >
>
> You can only listen to modem state changes.  oFono core doesn't know
> anything about CFUN=3D1.
>
> Regards,
> -Denis

Regards,
Giacinto

--===============8413944847540974057==--

