Content-Type: multipart/mixed; boundary="===============4336445250429800465=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: sd-bus
Date: Thu, 03 Jan 2019 13:39:17 +0100
Message-ID: <C0C4E73A-224A-4EB4-BBF3-82EFBF48C479@holtmann.org>
In-Reply-To: <CAKSBH7E66=jEZE4+ByY1zDm0bN5RD-DeT+B3S5OK=4gb-qyz1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4336445250429800465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> would it be interesting to port ofono from GDBus, which comes with the
> huge GLib dependency, to sd-bus?
> It is a lot of work, but the main question is whether we can assume
> that systemd is deployed enough to allow the switch.

actually ELL provides its own D-Bus support. So the switch should towards E=
LL D-Bus and not sd-bus. oFono already links against ELL and at some point =
that should be its only dependency. We also want to remove the GLib depende=
ncy as well. Newer projects like iwd for example solely use ELL.

Regards

Marcel


--===============4336445250429800465==--

