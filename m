Content-Type: multipart/mixed; boundary="===============4620833915457943687=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/2] Fix: Username and Password must be set after context
 is created.
Date: Mon, 01 Feb 2010 11:10:45 -0800
Message-ID: <1265051445.31341.54.camel@localhost.localdomain>
In-Reply-To: <61D8D34BB13CFE408D154529C120E079032A1ED6@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4620833915457943687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >>  	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
> >> =

> >>  	if (ctx->apn)
> >>  		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", =

> >> ctx->apn); =

> >> =

> >> +	/* Set username and password. Must be done after context creation */ =

> >> +	len =3D strlen(buf); =

> >> +	sprintf(buf+len, ";*EIAAUW=3D%d,1,\"%s\",\"%s\"", ctx->cid, =

> >> +		ctx->username, ctx->password); =

> >> +
> >>  	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> >>  				ste_cgdcont_cb, cbd, g_free) > 0)
> >>  		return;
> > =

> > this looks pretty much complicated and I prefer we don't use this
> > crazy concat of AT commands. Also it violates the coding style. =

> > =

> > There is no problem to just use g_at_chat_send twice since it will
> > queue the commands for you properly. However if this really depends
> > on CGDCONT succeeding, then we better do it in the callback.  =

> =

> We originally did send EIAAUW in the callback, but Denis changed this =

> because MBM did it EIAAUW before CGDCONT.

I know that Denis changed it and it makes sense to keep this in sync. We
just don't know about these details. And we have to put comments in the
source code to remind us.

And to be honest, I am not sure if anybody really tested it. I only know
of one public network that requires username/password for their APN. I
need to get a SIM card from them once I am back in Germany.

> > And we might wanna check if MBM cards behave similar and ensure that
> > STE and MBM cards use a similar code flow. =

> =

> When testing this EIAAUW fails if there are no prior PDP context on the m=
odem.
> Most likely this is the case with the MBM module as well, but I have not =
tested this.

Then we have to do that in the callback in an extra step. I don't really
like it, but seems the way to go. Please send a patch that also changes
this for MBM devices. We really wanna keep these in sync.

Regards

Marcel



--===============4620833915457943687==--

