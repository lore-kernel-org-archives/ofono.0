Content-Type: multipart/mixed; boundary="===============6944865670893794710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Fri, 19 Mar 2010 13:18:34 -0500
Message-ID: <201003191318.35173.denkenz@gmail.com>
In-Reply-To: <80fd4e751003191024w5aa343f1ke2c92fad680df80d@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6944865670893794710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Hi all,
> =

> I think the Modem "Powered" property is meant to control the radios
> (something like at+cfun=3D0 vs. at+cfun=3D1..). Now core automatically
> removes all the atoms in case modem has "Powered" false. However, the
> SIM card should be accessible while the radios are off (cfun=3D0) so
> that PIN code could be entered. If the +CFUN=3D1 is given before PIN
> code is entered, the modem registers to network in limited service
> (emergency call only) mode. Perhaps it would be better to let the
> modem driver itself decide which atoms are active when it is not fully
> powered?
> =


I've been talking about this exact issue with Marcel but so far we have not =

firmly agreed on any solution.  Our current thinking is to keep Powered =

semantics as they are, but to also add Flight mode property.  This would in =

affect allow interaction with the SIM while the radio is off.  For some mod=
ems =

it might not even make sense to support flight mode (e.g. HFP)

We're also trying to figure out how this would interact with SIM removal / =
SIM =

dead events.

If you have strong feelings about a particular approach feel free to discus=
s =

it here or on IRC.

Regards,
-Denis

--===============6944865670893794710==--

