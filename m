Content-Type: multipart/mixed; boundary="===============3298204113858477005=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] radio settings: add FastDormancy property
Date: Thu, 28 Oct 2010 10:19:27 -0500
Message-ID: <4CC9947F.8050205@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7DCA1810@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298204113858477005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 10/28/2010 08:32 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>> Patch has been applied, thanks.  I did make a couple of minor tweaks
>> afterwards.
> =

> Thanks. A question regarding this particular tweak:
> =

> diff --git a/src/radio-settings.c b/src/radio-settings.c
> index cb0a598..eb2a42d 100644
> --- a/src/radio-settings.c
> +++ b/src/radio-settings.c
> @@ -126,8 +126,7 @@ static void radio_set_fast_dormancy(struct ofono_radi=
o_settings *rs,
>         const char *path =3D __ofono_atom_get_path(rs->atom);
>         dbus_bool_t value =3D enable;
>  =

> -       if ((rs->flags & RADIO_SETTINGS_FLAG_CACHED) &&
> -               rs->fast_dormancy =3D=3D enable)
> +       if (rs->fast_dormancy =3D=3D enable)
>                 return;
>  =

>         ofono_dbus_signal_property_changed(conn, path,
> =

> The fundamental problem here is that there is only a single CACHED flag f=
or multiple properties, which may be modified individually. So, either you =
get extra signals or you get too few. I checked the CACHED flag here becaus=
e otherwise the following might happen:

Yes, I know.  But this problem is present in every single atom.  oFono
does not guarantee that every attribute is signaled when the atom is
initialized.

> =

> 1. client tries to GetProperties() and gets the "Operation already in pro=
gress" error.
> 2. client waits for PropertyChanged signal to get the FastDormancy value
> 3. signal never comes because the default value happens to match the one =
returned by the driver and the signal is suppressed
>

In general I think that for interfaces where this can happen, the
likelihood is very low that it actually will in the real world.

Do note that I have had the same argument with myself off and on for the
past two years.  So far this was never raised as an issue.  If this ever
becomes a problem, we can fix it properly using an appropriate idiom.

> I do agree that sending extra signals is bad but I think that not sending=
 a signal is even worse. If the client cannot rely on getting a PropertyCha=
nged signal after a busy error, all it can do is resort to polling. I.e., e=
very client has to implement a polling pattern for GetProperties:
> =

> while (GetProperties() =3D=3D BUSY)
> 	sleep(FOR_A_WHILE);
> =

> Having a separate CACHED flag for each value would solve this optimally. =
Failing that, I don't think a few extra signals is so bad. Forcing clients =
to poll is just ugly.
> =


Honestly, if you expect multiple applications to battle over the
FastDormancy property, then it should be modeled differently.  Perhaps
with application registration and lifetime tracking over D-Bus, similar
to how agents work.

> Am I missing something?
> =

> 	MikaL

Regards,
-Denis

--===============3298204113858477005==--

