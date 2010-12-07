Content-Type: multipart/mixed; boundary="===============8529339273843873673=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: What should happen after losing and retrieving gsm signal ?
Date: Tue, 07 Dec 2010 19:09:49 +0200
Message-ID: <201012071909.49252.remi.denis-courmont@nokia.com>
In-Reply-To: <20101207170412.263820@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8529339273843873673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 December 2010 19:00:49 ext Beno=C3=AEt Monin, you wrote:
> So first, some short and general questions : What should happen after
> going off gsm coverage and back again ?

The modem should periodically try to register again. When that happens oFon=
o =

will go back online.

> In particular, is ofono taking care of the network registration or
> does it need a manual call org.ofono.NetworkRegistration.Register ?

Neither of those.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8529339273843873673==--

