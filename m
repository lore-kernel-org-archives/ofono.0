Content-Type: multipart/mixed; boundary="===============2128424542834754070=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: [PATCH] doc: New file about using the calypso modem
Date: Tue, 28 Dec 2010 20:29:17 +0000
Message-ID: <87ei91hc9u.fsf@ossau.uklinux.net>
In-Reply-To: <1293555680.9439.63.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2128424542834754070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Neil,

Hi Marcel,

> it is spelled oFono.

Sorry, will fix in the next version of this patch.  (All occurrences.)

> Since we had this discussion on IRC. Has this rule been proven to do the
> right thing?

Well I've certainly tested that it works for me, yes - on the 2.6.34
kernel, which is the newest working kernel for the Freerunner.

> Even in case of the weird renaming of the original serial
> port?

I'm not sure what you mean here.  If you're thinking of the difference
between "/devices/platform/s3c2440-uart.0/tty/ttySAC0" and
"/dev/ttySAC0": my understanding is that the 2.6.34 kernel decides on
the ttySAC0 name itself, and hence this name isn't a result of any udev
renaming.  Does that help at all>?

     Neil


--===============2128424542834754070==--

