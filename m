Content-Type: multipart/mixed; boundary="===============1521669851402474045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Wed, 03 Dec 2014 17:48:01 -0600
Message-ID: <547FA131.9000001@gmail.com>
In-Reply-To: <556279298.28727836.1417601666074.JavaMail.root@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1521669851402474045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

 >
> My modem has two interfaces : one interface on which I can do a PPP conne=
ction and another interface QMI to make wwan connection.
> My SIM card has 2 APNs and I must connect to them simultaneously. So, I n=
eed to be connected in PPP with APN1 and in qmi/wwan with APN2.
>

This sort of depends on whether your hardware actually supports multiple =

contexts being activated at once.

> The two ways of being connected work. I have successfully configured "2 o=
fonos" to make my modem works with "atmodem" for the PPP side and, by setti=
ng ofono driver to gobi in udevng (such as Huawei does) for wwan side. To s=
um up, Ofono works with PPP or with QMI. Now, I need to make it work with P=
PP _and_ QMI at the same time.
>
> I tried to connect, on the same modem, in my plugin file, the interface "=
Device" to "qmimodem" driver (so what "gobi" plugin does) and the "Applicat=
ion" and "Modem" interfaces to "atmodem" driver but it failed because dbus =
interfaces already exist (created by the first called).
>
> So I was wondering : what should be the best way to do it ? And is it pos=
sible ?
> Should I create one modem with 2 drivers (with my own driver using atmode=
m and gobi driver) ?
> Or should I create 2 modems with each one the driver needed (gobi/qmimode=
m and my own driver/atmodem) ?
>

You could try modifying the gobi plugin and udevng to allocate 2 =

gprs-contexts.  One using the QMI driver and the other using PPP.

e.g. something like:

gc =3D ofono_gprs_context_create(modem, 0, "qmimodem", device);
ofono_gprs_add_context(gprs, gc);

gc =3D ofono_gprs_context_create(modem, 0, "atmodem", ppp_chat);
ofono_gprs_add_context(gprs, gc);

and see if that works.

Regards,
-Denis

--===============1521669851402474045==--

