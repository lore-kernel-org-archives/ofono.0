Content-Type: multipart/mixed; boundary="===============0990182756995931755=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Change code and commit process
Date: Mon, 23 Nov 2020 14:52:13 +0100
Message-ID: <bb6a569e-d98e-f86f-0b4f-f55c9bbbce94@norrbonn.se>
In-Reply-To: <CAA=hcWTfEQsN=DHGUDLJoCus5u2bUHUS+QrXmxbOAFire_wcpg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0990182756995931755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/11/2020 06:45, Jupiter wrote:
> How to commit code change, who should I contact for approving code change?

- prepare your patches in git on top of origin/master
- create a patch series

$ git format-patch --cover-letter origin/master -o patches

- edit the cover letter file, explaining what your patch series aims to do
- send the patches to the list

$ git send-email --to ofono(a)ofono.org patches

Roughly like that... double-check the commands because I might have =

missed something.

/Jonas

> =

> Thank you.
> =

> Kind regards,
> =

> - jupiter
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>=20
--===============0990182756995931755==--

