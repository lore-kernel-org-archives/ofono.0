Content-Type: multipart/mixed; boundary="===============8703992908701861465=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: sd-bus
Date: Thu, 03 Jan 2019 13:51:45 +0100
Message-ID: <8724974F-FE39-4E9A-878C-4B76FD2044F1@holtmann.org>
In-Reply-To: <CAKSBH7HqFbg64sjtcz=Y=dm82mWS=4qpRMU0r_G-Z-Yjv9jpiw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8703992908701861465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> > would it be interesting to port ofono from GDBus, which comes with the
> > huge GLib dependency, to sd-bus?
> > It is a lot of work, but the main question is whether we can assume
> > that systemd is deployed enough to allow the switch.
> =

> actually ELL provides its own D-Bus support. So the switch should towards=
 ELL D-Bus and not sd-bus. oFono already links against ELL and at some poin=
t that should be its only dependency. We also want to remove the GLib depen=
dency as well. Newer projects like iwd for example solely use ELL.
> =

> thank you for this information. I didn't notice the dbus in ELL, at least=
 not in the part currently in ofono.
> Is this another implementation than glib or a part of it, or is it a wrap=
per for the libdbus?

it is a from-scratch and clean implementation of the D-Bus protocol. You cu=
rrently don=E2=80=99t see it since the build magic in oFono only copies ELL=
 pieces that it currently needs. However it is simple change in Makefile.am=
 to also include ELL D-Bus.

Regards

Marcel


--===============8703992908701861465==--

