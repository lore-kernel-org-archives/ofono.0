Content-Type: multipart/mixed; boundary="===============7885755421335745555=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 14:57:29 +0300
Message-ID: <1269950249.2432.3.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <80fd4e751003300436i46cb721fv4b9c6e56113241a3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7885755421335745555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ti, 2010-03-30 kello 13:36 +0200, ext Pekka Pessi kirjoitti:
> Another solution is to use sscd-like daemon also with ofono (the oFono
> Powered property would then just follow the power state of the modem).

My preference would be to have these things handled as oFono plugins.
That being the recommended way of course doesn't preclude some other
modem needing a slave plugin that monitors the accomplishments of a
separate daemon.

Cheers,
Aki


--===============7885755421335745555==--

