Content-Type: multipart/mixed; boundary="===============4675099226404420357=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Wed, 12 Jan 2011 08:29:04 -0800
Message-ID: <1294849744.3873.89.camel@aeonflux>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802D59DA8@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4675099226404420357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> >>  include/voicecall.h |    2 ++
> >>  src/voicecall.c     |   12 ++++++++++++
> >>  2 files changed, 14 insertions(+), 0 deletions(-)
> >> =

> >> diff --git a/include/voicecall.h b/include/voicecall.h index
> >> e37d73b..6f1bdd2 100644 --- a/include/voicecall.h
> >> +++ b/include/voicecall.h
> >> @@ -144,6 +144,8 @@ void ofono_voicecall_notify(struct
> >> ofono_voicecall *vc,  void ofono_voicecall_disconnected(struct
> >>  				ofono_voicecall *vc, int id, enum
> ofono_disconnect_reason
> >>  				reason, const struct ofono_error
> *error);
> >> +void ofono_voicecall_tty_notify(struct ofono_voicecall *vc,
> >> +				const struct ofono_call *call);
> > =

> > what is the advantage of having this separate and not part of
> > the regular voicecall_notify and just extending struct
> > ofono_call with a field for TTY?
> > =

> =

> Main reason for separate notification function is to avoid going through
> all
> the cases handled inside voicecall_notify. TTY field in ofono_call is
> basically
> for the GetProperties.

I see. So here is the main question that comes from this now. This seems
to be a bit IFX specific driven API. I still have no idea why they can
not just indicate this via +CRING and have to use CTM CALL for it.

Are we expecting that all modems will just establish a normal voice call
and only later on signal that it is a TTY call? Any input from different
vendors other than IFX. What about STE, ISI?

Regards

Marcel



--===============4675099226404420357==--

