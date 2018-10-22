Content-Type: multipart/mixed; boundary="===============7928739496594156209=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: airplane mode
Date: Mon, 22 Oct 2018 07:19:53 +0200
Message-ID: <CAKSBH7EJzKZSixyAM7L6mwcuvYMSKjeh9DFDa0tD8wFGcC5zAA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7928739496594156209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

I have a series of problems with the ofono structure.
When setting Powered=3DTRUE, it sets the module in airplane mode (AT+CFUN=
=3D4).

This prevents the use of calls, even emergency, so there would be no
point in creating the atom in pre-sim stage.
Additionally, the registration of call URCs for custom voicecall
atoms, might also fail.

Also, several test commands fail in airplane mode, e.g.: AT+CLCK=3D?

Is there a way to re-initialize all required atoms at the post-inline stage?
Or should they be destroyed and re-created?

Thank you,
Giacinto

--===============7928739496594156209==--

