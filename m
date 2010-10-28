Content-Type: multipart/mixed; boundary="===============4645107868559595634=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 3/6] radio settings: add FastDormancy property
Date: Thu, 28 Oct 2010 15:32:24 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7DCA1810@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CC8EDA5.8030703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4645107868559595634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Patch has been applied, thanks.  I did make a couple of minor tweaks
> afterwards.

Thanks. A question regarding this particular tweak:

diff --git a/src/radio-settings.c b/src/radio-settings.c
index cb0a598..eb2a42d 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -126,8 +126,7 @@ static void radio_set_fast_dormancy(struct ofono_radio_=
settings *rs,
        const char *path =3D __ofono_atom_get_path(rs->atom);
        dbus_bool_t value =3D enable;
 =

-       if ((rs->flags & RADIO_SETTINGS_FLAG_CACHED) &&
-               rs->fast_dormancy =3D=3D enable)
+       if (rs->fast_dormancy =3D=3D enable)
                return;
 =

        ofono_dbus_signal_property_changed(conn, path,

The fundamental problem here is that there is only a single CACHED flag for=
 multiple properties, which may be modified individually. So, either you ge=
t extra signals or you get too few. I checked the CACHED flag here because =
otherwise the following might happen:

1. client tries to GetProperties() and gets the "Operation already in progr=
ess" error.
2. client waits for PropertyChanged signal to get the FastDormancy value
3. signal never comes because the default value happens to match the one re=
turned by the driver and the signal is suppressed

I do agree that sending extra signals is bad but I think that not sending a=
 signal is even worse. If the client cannot rely on getting a PropertyChang=
ed signal after a busy error, all it can do is resort to polling. I.e., eve=
ry client has to implement a polling pattern for GetProperties:

while (GetProperties() =3D=3D BUSY)
	sleep(FOR_A_WHILE);

Having a separate CACHED flag for each value would solve this optimally. Fa=
iling that, I don't think a few extra signals is so bad. Forcing clients to=
 poll is just ugly.

Am I missing something?

	MikaL

--===============4645107868559595634==--

