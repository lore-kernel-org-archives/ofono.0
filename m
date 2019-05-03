Content-Type: multipart/mixed; boundary="===============5910573784648085409=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: ofono.service failure
Date: Fri, 03 May 2019 10:52:46 +0200
Message-ID: <2c0b09e0-0cf3-4156-cfb3-33366ad857da@norrbonn.se>
In-Reply-To: <CAA=hcWSQT2t1_jrkU9KdO7iRKZSZBc6kgiWFFk8-FU0=AUXMYw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5910573784648085409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 02/05/2019 17:03, JH wrote:
> Hi,
> =

> The official ofono recipe ofono.inc defines SYSTEMD_SERVICE_${PN} =3D
> "ofono.service", but the ofonod is not started by system service
> automatically, I have to start the ofonod manually, what could be the
> issue?

This question should be directed to the OpenEmbedded mailing list as it =

has nothing to do with ofono, per se.

That said:
i)  it works for me on all recent versions of OE
ii) including some relevant logging (journalctl, etc.) is generally =

helpful in debugging these matters; both the log of the ofono service, =

in case it fails to start due to crashes, and the log from systemd =

itself, in case systemd is deciding not to start the service for some =

reason.

/Jonas

> =

> Thank you.
> =

> Kind regards,
> =

> - jupiter
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============5910573784648085409==--

