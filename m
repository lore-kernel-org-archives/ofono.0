Content-Type: multipart/mixed; boundary="===============6494172741982981705=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/4] radio settings: allow for more than one property
Date: Fri, 22 Oct 2010 09:08:56 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7D092E75@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CC04849.8070703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6494172741982981705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


> > Oops, will fix. For some reason my checkpatch script did =

> not complain about this.
> > =

> > You must be using a script as well. To avoid unnecessary =

> fuss like this, would it be possible to integrate it to the =

> oFono tree so everyone would check their patches using the same thing?
> =

> Not a script, but Johan's magic vim macro.  I paste it here =

> for reference:
> highlight RedundantWhitespace ctermbg=3Dred guibg=3Dred
> match RedundantWhitespace /\s\+$\|\t\+\ze \+[^*]\| \+\ze\t/
> =

> Between checkpatch, git am and this one we catch most issues.

Thanks. Still, I'd vote for a common checkpatch script in the oFono tree. ;)

> =

> > =

> >> I prefer you keep the current implementation as it is =

> consistent with
> >> the rest of ofono core.  The way the rest of the core works =

> >> is that you
> >> query each in sequence, then set the the CACHED flag (only one is
> >> actually required).
> >>
> >> We use a single cached flag to keep the logic simpler and =

> optimize for
> >> the general case (e.g. UI will query the properties first before
> >> allowing the user to set them)  While this does lead to us =

> >> querying some
> >> attributes unnecessarily in certain extremely unlikely =

> corner cases, I
> >> believe it is an acceptable compromise.
> > =

> > This was my intention as well but I did it in a different =

> way, as I didn't realize there was an existing pattern for it.
> > =

> > My code does actually query all the properties up front but =

> I serialized the driver queries in a different way. I.e., I =

> used a separate CACHED flag for each property to keep track =

> of whether the value is already valid. Each driver callback =

> attempts to create the pending reply. The attempt to create =

> the reply either succeeds or triggers a new driver query for =

> another missing property value. This goes on until all the =

> properties are cached and the pending reply can be sent.
> > =

> > I now see that the other services use a separate state =

> machine to fetch the properties. That introduces more code =

> than my solution but I guess I can do it that way if you feel =

> it is easier to read.
> > =

> =

> In the beginning we tried many approaches, including ones =

> similar to the
> path you took.  We found that the current approach used in the core,
> while while by no means perfect in every situation, was the best
> compromise.  It is quite scalable as the number of attributes =

> / queries
> grows and it blocks multiple (potentially malicious) applications from
> DDoSing the modem when the information is not cached.

Well, my solution does exactly what you're asking, only with less code. You=
 seem to think that it allows parallel property queries from multiple clien=
ts. That is not the case. See here:

static DBusMessage *radio_get_properties(DBusConnection *conn, DBusMessage =
*msg,
                                        void *data)
{
        struct ofono_radio_settings *rs =3D data;

        if (rs->pending)
                return __ofono_error_busy(msg);

        return radio_get_properties_reply(msg, rs);
}

A busy error is returned if a previous query is in progress.

I don't mind rewriting the stuff if need be but I'd like it to be for the r=
ight reason.

	MikaL

--===============6494172741982981705==--

