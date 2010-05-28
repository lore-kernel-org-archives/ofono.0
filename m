Content-Type: multipart/mixed; boundary="===============1081110306482938156=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Fri, 28 May 2010 12:08:41 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A40@jklmail01.ixonos.local>
In-Reply-To: <1274966351.4706.25.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1081110306482938156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>Hi Denis,
>
> > > > - { "SendMessage",        "ss",   "",             sms_send_message,
> > > > + { "SendMessage",        "ssb",  "",             sms_send_message,
> > > >                                                   G_DBUS_METHOD_FLA=
G_ASYNC },
> > > >  { }
> > > >  };
> > > =

> > > I don't like this being an argument to SendMessage(). I think it needs
> > > to be exposed, but as a property instead. Is there a use case for
> > > setting this per message? I think majority of current phones either
> > > provide a global setting for this, or set it on by default.
> > >
> >
> > I agree, we should expose this as the 'UseDeliveryReports' property on
> > SmsManager or alternatively use a global oFono setting read at startup.
>
> I think just a global setting in /etc/ofono/main.conf would be better. I
> don't really see the point in making this an option for the user. My
> personal opinion here is to always request delivery reports by default
> and handle them internally to acknowledge SMS messages.
>
> Regards
>
> Marcel

Thank you for your opinions. We already hoped that you would comment
this part because we also had conversation here about how should this
matter be solved. Current solution is mostly done this way because it
seemed easiest way to get things working.

Have you thought this from the operator point of view. I mean, if you
always request  delivery report, it is going to increase the load of the
operators net and that is something that operator is not going to like.

But when you do the final decision about this matter, please let me know
and I can then implement it.

-Pasi


_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



--===============1081110306482938156==--

