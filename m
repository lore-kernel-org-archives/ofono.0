Content-Type: multipart/mixed; boundary="===============1956302125355111851=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 17/20] atmodem: add lte specific functions
Date: Tue, 12 Apr 2011 09:07:20 -0500
Message-ID: <4DA45C98.8020900@gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1EBB237@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1956302125355111851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

>> That is still an assumption that needs to be confirmed. So =

>> does the default context activation from just uses APN =3D=3D "" =

>> and then the network picks the APN to activate. Or does it =

>> just use the APN value from CID 1 for example.
>>
> =

> At this point , if the returned cid is out of range it is assumed this
> would be default context (already activated).
> Network has the APN and other required mandatory parameters required for
> activation of default context.
> This is done part of implicit attach process.
> =


What Marcel is driving at is this comment from 27.007:

"The <cid>s for network-initiated PDP contexts will have values outside
the ranges indicated for the <cid> in the test form of the commands
+CGDCONT and +CGDSCONT."

Please do note that default EPS bearer is not network-initiated.  It is
ME-initiated.  So I currently see no basis for your assumption.  Have
you checked how existing LTE modems actually do this?

Regards,
-Denis

--===============1956302125355111851==--

