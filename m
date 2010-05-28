Content-Type: multipart/mixed; boundary="===============8308944007707372186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: VS: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Fri, 28 May 2010 12:34:22 -0500
Message-ID: <201005281234.22971.denkenz@gmail.com>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A40@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8308944007707372186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> >Hi Denis,
> >
> > > > > - { "SendMessage",        "ss",   "",             sms_send_messag=
e,
> > > > > + { "SendMessage",        "ssb",  "",             sms_send_messag=
e,
> > > > >                                                  =

> > > > > G_DBUS_METHOD_FLAG_ASYNC }, { }
> > > > >  };
> > > >
> > > > I don't like this being an argument to SendMessage(). I think it
> > > > needs to be exposed, but as a property instead. Is there a use case
> > > > for setting this per message? I think majority of current phones
> > > > either provide a global setting for this, or set it on by default.
> > >
> > > I agree, we should expose this as the 'UseDeliveryReports' property on
> > > SmsManager or alternatively use a global oFono setting read at startu=
p.
> >
> > I think just a global setting in /etc/ofono/main.conf would be better. I
> > don't really see the point in making this an option for the user. My
> > personal opinion here is to always request delivery reports by default
> > and handle them internally to acknowledge SMS messages.
> >
> > Regards
> >
> > Marcel
> =

> Thank you for your opinions. We already hoped that you would comment
> this part because we also had conversation here about how should this
> matter be solved. Current solution is mostly done this way because it
> seemed easiest way to get things working.
> =

> Have you thought this from the operator point of view. I mean, if you
> always request  delivery report, it is going to increase the load of the
> operators net and that is something that operator is not going to like.

Most operators / phones do expose this setting in the UI and leave it off b=
y =

default.

> =

> But when you do the final decision about this matter, please let me know
> and I can then implement it.

I suggest using a Property (UseDeliveryReports) for this setting and storin=
g =

it in the sms imsi-keyed settings file for now.  =


Regards,
-Denis

--===============8308944007707372186==--

