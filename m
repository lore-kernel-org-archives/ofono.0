Content-Type: multipart/mixed; boundary="===============3827858385789023690=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Thu, 25 Jun 2015 21:20:36 -0500
Message-ID: <558CB6F4.2070808@gmail.com>
In-Reply-To: <55914918.80109@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3827858385789023690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

 >
> _And the fail log _(on reconnect):
>
> Jun 29 15:19:34 mx31tt01 daemon.debug ofonod[657]:
> gprs-context.c(240):at_gprs_activate_primary() cid 1
> Jun 29 15:19:34 mx31tt01 daemon.info ofonod[657]: Modem: >
> AT+CGDCONT=3D1,"IP","web.one.at"\r

Your modem is not responding to this AT command.  There's not much that =

can be done on the oFono side.  You need to figure out why the modem is =

acting this way.

> ...
>
> Jun 29 15:20:14 mx31tt01 daemon.err connmand[561]: Failed to change
> property: /he910_0/context15 org.ofono.ConnectionContext.Active:
> org.freedesktop.DBus.Error.NoReply Did not receive a reply. Possible

Regards,
-Denis

--===============3827858385789023690==--

