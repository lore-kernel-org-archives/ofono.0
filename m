Content-Type: multipart/mixed; boundary="===============8105325850345562380=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/6] stk-api.txt. Introduce the new API ConfirmOpenChannel
Date: Sat, 09 Apr 2011 06:53:13 -0700
Message-ID: <1302357193.2572.205.camel@aeonflux>
In-Reply-To: <4D9F3F0D.3070608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8105325850345562380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>  doc/stk-api.txt |    7 +++++++
> >>  1 files changed, 7 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> >> index 0bcc6b5..aaa9fba 100644
> >> --- a/doc/stk-api.txt
> >> +++ b/doc/stk-api.txt
> >> @@ -278,6 +278,13 @@ Methods		byte RequestSelection(string title, byte=
 icon_id,
> >>  =

> >>  			Possible Errors: [service].Error.SimToolkit.EndSession
> >>  =

> >> +		boolean ConfirmOpenChannel(string information, byte icon_id)
> >> +
> >> +			Asks the agent to request user to confirm the channel
> >> +			set-up.
> >> +
> >> +			Possible Errors: [service].Error.SimToolkit.EndSession
> >> +
> > =

> > we need to talk a bit about these boolean return parameters for
> > confirmation. Since essentially a positive D-Bus reply can be considered
> > as TRUE and a D-Bus error as FALSE. So this essentially implicit.
> > =

> > You can not return FALSE and an error. That is not how D-Bus works.
> =

> Actually I'm fine with this.  The error has a different intent.
> =

> There are three potential outcomes of this operation:
> =

> - User accepts (True)
> - User Rejects (False)
> - User decides to end the session, which in addition to rejecting the
> command as above, also reboots the STK session.
> =

> Unless you want to introduce org.ofono.Error.SimToolkit.UserRejected,
> which to me looks ugly.

so within BlueZ, we did exactly that. We introduced an error to be able
to reject this. Mainly since we actually expected an accept reply with
data.

I don't find the rejected error ugly, but that is more like a personal
preference. I can see both arguments here.

Anyhow if we keep it this way, then the documentation needs to clearly
state the above with true =3D=3D accept and false =3D=3D reject.

Regards

Marcel



--===============8105325850345562380==--

