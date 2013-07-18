Content-Type: multipart/mixed; boundary="===============8470225011953346671=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] build-sys: Use libgdbus-internal.la
Date: Thu, 18 Jul 2013 08:04:13 -0700
Message-ID: <7D4E1C1D-CB48-419B-B35B-11CBE2E5BF18@holtmann.org>
In-Reply-To: <1372855776-24235-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8470225011953346671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> With the current approach if we have different CFLAGS for each binary we =
would
> build gdbus several times for no reason.
> =

> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
> a convenience library thas is used internally only, thus with a "-interna=
l"
> suffix.
> ---
> Makefile.am | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)

your patch has been applied.

Regards

Marcel


--===============8470225011953346671==--

