Content-Type: multipart/mixed; boundary="===============2475151982152771057=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 15:38:22 +0200
Message-ID: <1294061902.2077.51.camel@jsaunama-desktop>
In-Reply-To: <87hbdqxlk2.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2475151982152771057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

> > Well, my intention was to make format simple and fast to parse, but
> > still be extensible enough, which I think my proposed format fulfills. =

> >
> > These <access>-elements contain just data needed for GPRS context
> > settings (as attributes), and if there is need for any other operator
> > specific provisioning information, you can always add separate elements,
> > this is still proper XML.
> =

> But IMHO it is really ugly and not a properly designed XML.

Well, to me it looks simple, compact and clean, and most certainly
provides all necessary extensibility any XML format provides.  =


> Again, why not use mobile-broadband-provider-info DTD? If there's somethi=
ng
> missing, I'm sure maintainers are willing to extend it. No need to
> reinvent the wheel.

In this format biggest thing that I see missing is type of access point
("internet","mms","lte"), protocol (for IPv6) and mms-server (or
"homepage"). And I assume <name> of <provider> could be interpreted as
SPN for provisioning.

The good point of using mobile-broadband-provider-info is that it would
indeed provide existing database for testing purposes. For product
creation, manufacturers will anyway create their own databases, and
there the format does not matter much.

The problem using this format is, as I mentioned, more complex parsing. =

And also do we want to bind oFono into some externally defined data
format?

--Jukka
 =





--===============2475151982152771057==--

