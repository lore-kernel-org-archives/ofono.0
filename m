Content-Type: multipart/mixed; boundary="===============5490750547932797235=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/1] isimodem: fix network registration for older modems
Date: Tue, 29 Mar 2011 07:07:30 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D945D@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1301048512.9106.17.camel@claudio-ThinkPad-R61>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5490750547932797235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> I have tested the path of isi modem on nokia n95 and nokia 6760, =

> and I report the result of my test
> =

> 1) Using nokia N95 and ofono =

> * I have attached the phone to my computer =

> * I have used the ./online-modem =

> * I have set apn/username/password and activate the context
> =

> It works (log onlineUsingOfonoTest file attached to mail)

Cool.

> 2) Using nokia N95 and ofono/connma
> * I have attached the phone to my computer
> * Start connman and I have checked it set OnLine the modem correctly =

> * I have set apn/username/password and activate the context
> * Using connect of connman, but i receive the message  	=

> 		=

> 	org.ofono.Error.NotAttached GPRS is not attached
> =

> I reports the log onlineUsingConnmanTest, can be a problem of =

> connman ? =


I was able to reproduce this with N95 without using connman. There seems to=
 be a conflict with the way atom watches are registered and the way isiusb =
creates and probes two variations of the network registration driver in par=
allel. The problem is timing dependent, which is probably why we haven't se=
en it here before.

> 1) Using nokia 6760 and ofono

> * I have attached the phone to my computer =

> * I have used the ./online-modem =

> * I have set apn/username/password and activate the context
> =

> It not works, (log in nokia6760 file attached to mail)
> =

> Any suggestion ? =


I believe the same problem also happens with 6760 and could potentially hap=
pen with any ISI modem. Now that I know what it is, I'll try to provide pat=
ches.

> is it possible to know the list of supported mobile phone as =

> 3g modem ?

We don't have a list of supported phones as such as we're not systematicall=
y tesing oFono against old Nokia phones. The isiusb plugin is primarily a d=
evelopment aid, allowing us to test isimodem drivers on a PC instead of on-=
target. There are some limitations in using the isimodem driver over USB th=
is way. All functionality may not be available with all phones. Mostly it w=
orks fine, though.

Regards,

	MikaL

--===============5490750547932797235==--

