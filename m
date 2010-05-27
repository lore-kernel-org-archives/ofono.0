Content-Type: multipart/mixed; boundary="===============2980688874948378286=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Getting Modem properties using qt dbus programming -reg
Date: Thu, 27 May 2010 17:05:33 +0200
Message-ID: <AANLkTikT5AJguGhaZlM8DZjHXxGWqmPaBB-Tly2FBgH3@mail.gmail.com>
In-Reply-To: <COL106-W39D2FB4FE36047A6B0D0FFF6EA0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2980688874948378286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2010 at 2:35 PM, krishna k <id_kishore@live.in> wrote:
[...]
> =C2=A0=C2=A0=C2=A0=C2=A0 bool value =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0 dbus_iface.call("SetProperty", QString("Powered"=
), QVariant(QVariant::Bool, &value));

use: QVariant::fromValue(QDBusVariant(value))

warning, the call you are using is not async.

Regards

    Niko

--===============2980688874948378286==--

