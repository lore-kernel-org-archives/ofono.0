Content-Type: multipart/mixed; boundary="===============1718433555209461939=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Wed, 12 Jan 2011 08:48:46 -0800
Message-ID: <1294850926.3873.101.camel@aeonflux>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802D59EA2@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1718433555209461939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> >> Main reason for separate notification function is to avoid going
> >> through all the cases handled inside voicecall_notify. TTY field in
> >> ofono_call is basically for the GetProperties.
> > =

> > I see. So here is the main question that comes from this now.
> > This seems to be a bit IFX specific driven API. I still have
> > no idea why they can not just indicate this via +CRING and
> > have to use CTM CALL for it.
> > =

> > Are we expecting that all modems will just establish a normal
> > voice call and only later on signal that it is a TTY call?
> > Any input from different vendors other than IFX. What about STE, ISI?
> =

> This notification is to inform the ME that the call is accepted as a TTY
> call
> on the remote side.

I see. Using a +X... IFX style notification would have been much nicer,
but so be it. The question still remains if all other modems do it
similar.

Btw. can you provide the mailing list with an example OFONO_AT_DEBUG=3D1
trace for a TTY call on IFX. I really like to see one of these.

Denis, do you want an extra voicecall_tty_notify() callback or just have
it go through the voicecall_notify() one?

Regards

Marcel



--===============1718433555209461939==--

