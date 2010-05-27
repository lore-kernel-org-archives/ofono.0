Content-Type: multipart/mixed; boundary="===============3055912128667850668=="
MIME-Version: 1.0
From: Jussi Kukkonen <jku@linux.intel.com>
Subject: Re: Getting Modem properties using qt dbus programming -reg
Date: Thu, 27 May 2010 16:07:37 +0300
Message-ID: <4BFE6E99.1080606@linux.intel.com>
In-Reply-To: <COL106-W39D2FB4FE36047A6B0D0FFF6EA0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3055912128667850668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/27/2010 03:35 PM, krishna k wrote:
>
> Hi,
>
> I am trying to implement application using qt dbus module, Which will cal=
l SetProperty with parameters QString, QVariant.
...
> I am trying the same thing using qt program...
>
>      QDBusConnection bus =3D QDBusConnection::systemBus();
>
>      QDBusInterface dbus_iface("org.ofono", "/phonesim0/operator/23402",
>                                    "org.ofono.Modem", bus);
>       bool value =3D true;
>       dbus_iface.call("SetProperty", QString("Powered"), QVariant(QVarian=
t::Bool,&value));

I believe "v" maps to QDBusVariant, not QVariant. Maybe something like =

this works:

bool value =3D true;
var =3D QDBusVariant (QVariant(QVariant::Bool,&value));
dbus_iface.call("SetProperty", QString("Powered"), var);


Jussi

--===============3055912128667850668==--

