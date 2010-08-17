Content-Type: multipart/mixed; boundary="===============3751328883438373653=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] [RfC] stk-api: Proposed Set Up Call api.
Date: Tue, 17 Aug 2010 18:04:57 +0200
Message-ID: <1282061097.23399.118.camel@localhost.localdomain>
In-Reply-To: <AANLkTimDpcPUxOBtpz3NMROGbVuyBy5TMgfDzTPcA6BN@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3751328883438373653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >>  doc/stk-api.txt |   15 +++++++++++++++
> >>  1 files changed, 15 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> >> index 2e863a9..b85c7db 100644
> >> --- a/doc/stk-api.txt
> >> +++ b/doc/stk-api.txt
> >> @@ -55,6 +55,14 @@ Signals            PropertyChanged(string property,=
 variant value)
> >>                       Signal is emitted whenever a property has change=
d.
> >>                       The new value is passed as the signal argument.
> >>
> >> +             CallSetUp(string message, byte icon_id, object call)
> >
> > to be consistent this should be CallSetup(...)
> =

> They're not interchangeable though because setup is a noun, and in
> this case we're notifying that "a call has been set up / is being set
> up".

then I prefer something like CallSetupCompleted or similar. Do we need a
CallSetupFailed as well? Can it fail? Is this an expected behavior, can
we ignore it?

> >> +                     Informs about a new VoiceCall that is being set
> >> +                     up as a result of a UICC request and gives the
> >> +                     message associated with the call to be shown to
> >> +                     the user.  Hanging-up the call before it is
> >> +                     connected will terminate the current session.
> >> +
> >>  Properties   string IdleText
> >>
> >>                       Contains the text to be used when the home scree=
n is
> >> @@ -189,6 +197,13 @@ Methods          byte RequestSelection(string tit=
le, byte icon_id,
> >>
> >>                       Possible Errors: [service].Error.SimToolkit.GoBa=
ck
> >>
> >> +             boolean ConfirmCallSetup(string message, byte icon_id)
> >> +
> >> +                     Asks the agent to request user to confirm an
> >> +                     outgoing call setup.
> >> +
> >> +                     Possible Errors: [service].Error.SimToolkit.EndS=
ession
> >> +
> >>               void Cancel()
> >>
> >>                       Asks the agent to cancel any ongoing operation in
> >
> > Why do we need two handlers here. One signal and one agent callback. I
> > do understand the agent callback. That is pretty obvious, but why do you
> > also wanna send the signal as well. Would this be just go via the voice
> > call interface and be transparent for the dialer?
> =

> This is a possiblity, I'm not very sure what would be the best option.
>  The reason for the signal was so that the alpha id can be associated
> with given VoiceCall object. (The same VoiceCall object will of course
> be available in VoiceCallManager properties).
> =

> The timeline for call setup is something like:
> =

>  * Modem asks user for confirmation using icon1 / alphaId1.
>  * User confirms
>  * Modem starts dialling, screen displays icon2 / alphaId2,
>  * Call is connected, modem replies to the proactive command, screen
> keeps displaying icon2 / alphaId2 until the phone call is over.

For simplicity, I would say that this should just happen via the new
CallAdded signal and we make icon and alphaid part of the call
properties. That would be my idea right now.

Maybe we just generalize this into Message and Icon property anyway. The
Icon is rather useless, but the Message could be useful for CNAP support
as well. Just an idea.

Regards

Marcel



--===============3751328883438373653==--

