Content-Type: multipart/mixed; boundary="===============5662817384156474321=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 09:13:43 +0200
Message-ID: <1294125223.8212.59.camel@jsaunama-desktop>
In-Reply-To: <1294095828.5852.54.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5662817384156474321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On Mon, 2011-01-03 at 15:03 -0800, ext Marcel Holtmann wrote:
> thinking about this a bit more and with the background that there is
> already an existing public database, we might should just enable a
> provision driver inside the oFono core.
> =

> Meaning that we can have multiple implementations of different databases
> with just different priorities. Each nicely separated in their own
> plugin and we don't bother the oFono core with where to get the data
> from. So my idea would be that the oFono core just asks to provision a
> new context. If a plugin feels responsible, then it does so. If not then
> it stays empty.
>
> Running oFono on the desktop/netbook etc. it makes sense to use the
> current mobile broadband provider database. However on a phone that is a
> not so good database. And for you guys it would also be possible to
> continue using a CSV based format.

This sounds very good to me. Making provisioning modular makes a lot of
sense.

But I am not yet very familiar with oFono plugin architecture. Is there
some pattern in oFono code I could follow when implementing this, or
could you or someone provide some skeleton code how this should go?

In my patch (3/4) for gprs.c, I call get_operator_settings() (in
operator-settings.c), which returns list of gprs_access_settings, that
are then created as contexts. I assume now this  get_operator_settings()
would somehow call registered provisioning modules, that similarly would
return list of gprs_access_settings? Or should these plugins directly
call some new gprs atom interface to create the contexts?

--Jukka




--===============5662817384156474321==--

