Content-Type: multipart/mixed; boundary="===============8206604029567628223=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/4] radio settings: allow for more than one property
Date: Mon, 25 Oct 2010 08:59:45 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7D884F06@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CC1A5F2.6000900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8206604029567628223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> I really don't want to argue about this.
> =

> SetProperty("TechnologyPreference", ..)
> -> Sets RADIO_SETTINGS_MODE_CACHED
> =

> GetProperties() -> queries Fast dormancy
> GetProperties() -> queries Fast dormancy
> ->
> =

> +	} else if (rs->driver->query_fast_dormancy) {
> +		rs->driver->query_fast_dormancy(rs,
> +					=

> fast_dormancy_query_callback, rs);
> +		dbus_message_unref(reply);
> +		return NULL;
> +	}
> +
> =

> You never set pending in the FastDormancy case.

Good catch. That's a bug, of course. Doesn't invalidate the approach, thoug=
h.

> > Understandable. Makes it difficult to improve on design =

> patterns that have already been replicated, though.
> > =

> =

> Nobody is against improving things, but please try to do it in the
> appropriate forum.  E.g. and RFC to the mailing list or an =

> IRC discussion.

Of course. This time I wasn't conciously trying to improve things, though. =
Anyway, enough yakking. I'll do the rewrite sicne you're adamant.

Br,

	MikaL

--===============8206604029567628223==--

