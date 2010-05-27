Content-Type: multipart/mixed; boundary="===============6886258615393601300=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Thu, 27 May 2010 15:19:11 +0200
Message-ID: <1274966351.4706.25.camel@aeonflux.t-mobile.de>
In-Reply-To: <201005270651.56052.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6886258615393601300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > -	{ "SendMessage",	"ss",	"",		sms_send_message,
> > > +	{ "SendMessage",	"ssb",	"",		sms_send_message,
> > >  							G_DBUS_METHOD_FLAG_ASYNC },
> > >  	{ }
> > >  };
> > =

> > I don't like this being an argument to SendMessage(). I think it needs
> > to be exposed, but as a property instead. Is there a use case for
> > setting this per message? I think majority of current phones either
> > provide a global setting for this, or set it on by default.
> > =

> =

> I agree, we should expose this as the 'UseDeliveryReports' property on =

> SmsManager or alternatively use a global oFono setting read at startup.

I think just a global setting in /etc/ofono/main.conf would be better. I
don't really see the point in making this an option for the user. My
personal opinion here is to always request delivery reports by default
and handle them internally to acknowledge SMS messages.

Regards

Marcel



--===============6886258615393601300==--

