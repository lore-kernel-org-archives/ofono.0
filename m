Content-Type: multipart/mixed; boundary="===============7775604510206134529=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 22:25:47 +0300
Message-ID: <200909012225.47712.remi@remlab.net>
In-Reply-To: <4A9D6FD3.7040207@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7775604510206134529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mardi 1 septembre 2009 22:02:43 Jean-Christian de Rivaz, vous avez =C3=
=A9crit :
> With GPRS support, Ofono become very interesting!
>
> I failed to understand how the "isi_gprs" code in your patch communicate
> with a PPP stack.

That would be because it does NOT use a PPP stack.

ISI modems have their own IP path using a dedicated kernel driver =

(net/phonet/pep-gprs.c in Linux 2.6.28 amd later). There is no point in usi=
ng =

the PPP line discipline.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============7775604510206134529==--

