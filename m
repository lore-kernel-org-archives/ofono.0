Content-Type: multipart/mixed; boundary="===============0902612150098527759=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH 1/2] Fix: Username and Password must be set after context
 is created.
Date: Mon, 01 Feb 2010 18:23:33 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E079032A1ED6@eseldmw101.eemea.ericsson.se>
In-Reply-To: <1265040566.31341.45.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0902612150098527759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

Marcel Holtmann wrote:
>>  	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
>> =

>>  	if (ctx->apn)
>>  		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", =

>> ctx->apn); =

>> =

>> +	/* Set username and password. Must be done after context creation */ =

>> +	len =3D strlen(buf); =

>> +	sprintf(buf+len, ";*EIAAUW=3D%d,1,\"%s\",\"%s\"", ctx->cid, =

>> +		ctx->username, ctx->password); =

>> +
>>  	if (g_at_chat_send(gcd->chat, buf, none_prefix,
>>  				ste_cgdcont_cb, cbd, g_free) > 0)
>>  		return;
> =

> this looks pretty much complicated and I prefer we don't use this
> crazy concat of AT commands. Also it violates the coding style. =

> =

> There is no problem to just use g_at_chat_send twice since it will
> queue the commands for you properly. However if this really depends
> on CGDCONT succeeding, then we better do it in the callback.  =


We originally did send EIAAUW in the callback, but Denis changed this =

because MBM did it EIAAUW before CGDCONT.

> And we might wanna check if MBM cards behave similar and ensure that
> STE and MBM cards use a similar code flow. =


When testing this EIAAUW fails if there are no prior PDP context on the mod=
em.
Most likely this is the case with the MBM module as well, but I have not te=
sted this.

BR/Sjur

--===============0902612150098527759==--

