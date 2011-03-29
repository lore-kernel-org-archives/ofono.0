Content-Type: multipart/mixed; boundary="===============5765500338735885985=="
MIME-Version: 1.0
From: claudio Degioanni <claudio.degioanni@zirak.it>
Subject: RE: [PATCH 0/1] isimodem: fix network registration for older modems
Date: Tue, 29 Mar 2011 09:52:31 +0200
Message-ID: <1301385151.17991.1.camel@claudio-ThinkPad-R61>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D945D@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5765500338735885985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,


On Tue, 2011-03-29 at 07:07 +0000, Mika.Liljeberg(a)nokia.com wrote:
> Hi Claudio,
> =

> > I have tested the path of isi modem on nokia n95 and nokia 6760, =

> > and I report the result of my test
> > =

> > 1) Using nokia N95 and ofono =

> > * I have attached the phone to my computer =

> > * I have used the ./online-modem =

> > * I have set apn/username/password and activate the context
> > =

> > It works (log onlineUsingOfonoTest file attached to mail)
> =

> Cool.
> =

> > 2) Using nokia N95 and ofono/connma
> > * I have attached the phone to my computer
> > * Start connman and I have checked it set OnLine the modem correctly =

> > * I have set apn/username/password and activate the context
> > * Using connect of connman, but i receive the message  	=

> > 		=

> > 	org.ofono.Error.NotAttached GPRS is not attached
> > =

> > I reports the log onlineUsingConnmanTest, can be a problem of =

> > connman ? =

> =

> I was able to reproduce this with N95 without using connman. There seems =
to be a conflict with the way atom watches are registered and the way isius=
b creates and probes two variations of the network registration driver in p=
arallel. The problem is timing dependent, which is probably why we haven't =
seen it here before.
> =

> > 1) Using nokia 6760 and ofono
> =

> > * I have attached the phone to my computer =

> > * I have used the ./online-modem =

> > * I have set apn/username/password and activate the context
> > =

> > It not works, (log in nokia6760 file attached to mail)
> > =

> > Any suggestion ? =

> =

> I believe the same problem also happens with 6760 and could potentially h=
appen with any ISI modem. Now that I know what it is, I'll try to provide p=
atches.

Thank you so much for your support and help, please let us know once you
have the patch.

> =

> > is it possible to know the list of supported mobile phone as =

> > 3g modem ?
> =

> We don't have a list of supported phones as such as we're not systematica=
lly tesing oFono against old Nokia phones. The isiusb plugin is primarily a=
 development aid, allowing us to test isimodem drivers on a PC instead of o=
n-target. There are some limitations in using the isimodem driver over USB =
this way. All functionality may not be available with all phones. Mostly it=
 works fine, though.

I see. =


Since each phone can potentially use a different way to talk to the pc
(Android: rndis, Nokia: AT commands / PPP interface over USB if I
understand it correctly), we are trying to understand which of these
methods (hence which phone family) is preferable to be used/supported
with connman / oFono.
Do you have any suggestion for us?

> =

> Regards,
> =

> 	MikaL

regs Claudio



--===============5765500338735885985==--

