Content-Type: multipart/mixed; boundary="===============3088885515775897502=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH net-next 0/6] Phonet: small pipe protocol fixes
Date: Sat, 26 Feb 2011 11:15:45 +0200
Message-ID: <201102261115.46319.remi@remlab.net>
In-Reply-To: <20110225.112406.246526410.davem@davemloft.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3088885515775897502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le vendredi 25 f=C3=A9vrier 2011 21:24:06 David Miller, vous avez =C3=A9cri=
t :
> > From: "R=C3=A9mi Denis-Courmont" <remi.denis-courmont@nokia.com>
> > Date: Fri, 25 Feb 2011 11:13:41 +0200
> > =

> >> This patch series cleans up and fixes a number of small bits in the
> >> Phonet pipe code, especially the experimental pipe controller. Once
> >> this small bits are sorted out, I will try to fix the controller
> >> protocol implementation proper so that we do not need the
> >> compile-time (experimental) flag anymore.
> > =

> > All applied thanks.
> > =

> > If you want to start using GIT to push phonet changes to me, frankly I
> > would welcome that :-)

No problem in principles. I need to figure out where to put linux-phonet.gi=
t =

though.

> BTW, I had to add the following patch to fix a build warning:

Hmm, right. I am planning to kill this config option and reunify the cough =

cough chal-len-ged *ahem* ST-Ericsson code with the Nokia code... So I conf=
ess =

did not bother to eliminate that ST-Ericsson-only mode warning.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.info/
http://fi.linkedin.com/in/remidenis

--===============3088885515775897502==--

