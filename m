Content-Type: multipart/mixed; boundary="===============0235161857631530231=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Thu, 27 May 2010 06:51:55 -0500
Message-ID: <201005270651.56052.denkenz@gmail.com>
In-Reply-To: <1274959965.3755.492.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0235161857631530231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > -	{ "SendMessage",	"ss",	"",		sms_send_message,
> > +	{ "SendMessage",	"ssb",	"",		sms_send_message,
> >  							G_DBUS_METHOD_FLAG_ASYNC },
> >  	{ }
> >  };
> =

> I don't like this being an argument to SendMessage(). I think it needs
> to be exposed, but as a property instead. Is there a use case for
> setting this per message? I think majority of current phones either
> provide a global setting for this, or set it on by default.
> =


I agree, we should expose this as the 'UseDeliveryReports' property on =

SmsManager or alternatively use a global oFono setting read at startup.

Regards,
-Denis

--===============0235161857631530231==--

