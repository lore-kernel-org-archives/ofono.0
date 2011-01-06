Content-Type: multipart/mixed; boundary="===============1113651502834034688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Wed, 05 Jan 2011 18:17:09 -0600
Message-ID: <4D250A05.8020405@gmail.com>
In-Reply-To: <1294272721.2521.34.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1113651502834034688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> =

>> If such context is not found create a new one with "Internet" type.
> =

> I don't really agree that we should create a context if no match is
> found. I think the better sensible strategy is to hold this information
> internally and only map it to a context once the user or provisioning
> creates it.

From what I understood it should be quite safe to assume it is an
internet context.  All IMS contexts will have a well-known APN and the
only other one that would make sense for the network to activate
automatically would be the internet one.

Perhaps this is the missing piece in the description? The fact that
either the IMS or an Internet context is created.

I also don't like the temporary approach, since if we roam off LTE we
still need a way to deactivate this context.

Regards,
-Denis

--===============1113651502834034688==--

