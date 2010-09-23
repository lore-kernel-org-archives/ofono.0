Content-Type: multipart/mixed; boundary="===============6270940622074352802=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: support of "emergency call when SIM not inserted" ?
Date: Thu, 23 Sep 2010 10:14:24 -0500
Message-ID: <4C9B6ED0.5010607@gmail.com>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A09201B01496@renesas4bis.renesas-rdf.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6270940622074352802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

> =

> I need a clarification about SIM:
> =

> Most GSM mobile phones can dial emergency calls even when the phone is wi=
thout a SIM card.
> =

> But it seems that oFono does not support an emergency call if the sim dri=
ver is present but no SIM is inserted:
> =


This used to be supported, but was broken by the new Online state
changes.  Basically we need a way to trigger Online state when an
emergency call is dialed, but remain in Offline state if the SIM is not
inserted / locked.

Please see the Emergency Calls section in the TODO list.

Regards,
-Denis

--===============6270940622074352802==--

