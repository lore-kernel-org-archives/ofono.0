Content-Type: multipart/mixed; boundary="===============2595257853386302842=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Mon, 22 Mar 2010 23:45:14 -0700
Message-ID: <1269326714.11714.42.camel@localhost.localdomain>
In-Reply-To: <20100322231436.5ccfe248@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2595257853386302842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > So Denis and I looked through my changes and he figured out what might
> > have broken it. So your attempt at doing code flow optimization with
> > g_list_length() throw me on the wrong error path. Please don't do this
> > since all the GLib functions will do proper empty list checking.
> =

> I reviewed your patch and it seems that you didn't break it this time :).
> If you ever have questions about the code, feel free to ask me.

please try to keep the code flow inside the functions as simple as
possible. Otherwise things like this happen.

Also in this context I would prefer if you create a helper function like
find_option() instead of manually calling g_list_find_custom() all the
time. From a pure code understanding point of view it is way simpler to
see what the code is meant do be doing. The find_custom + is_option is
not intuitiv.

With a proper helper we didn't need to workaround the casting issue from
guint16/guint8 to guint at every spot. The compiler will inline the
helper anyway if useful. So no real drawback here from a runtime code
point of view. And there was another problem with one variable being
guint16, but the is_option casts it back to guint8. We can't really have
that. Once you start casting on that scale the compiler will not warn
you about type mismatches or if the value of argument is too big for its
type.

Regards

Marcel



--===============2595257853386302842==--

