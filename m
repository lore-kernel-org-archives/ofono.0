Content-Type: multipart/mixed; boundary="===============0874355115483658721=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] tools: add client to receive location reporting
Date: Wed, 23 Feb 2011 16:43:04 -0300
Message-ID: <AANLkTik3ngLwP18-pMyqSJGcEPx_cGm_RyvQ1kqV0WV4@mail.gmail.com>
In-Reply-To: <1298486869-11548-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0874355115483658721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, Feb 23, 2011 at 3:47 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> As of now there's no support for fd-passing in D-Bus Python bindings,
> hence a small C client is needed in order to test location-reporting
> atom.
> ---
> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +-
> =C2=A0tools/get-location.c | =C2=A0259 ++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A02 files changed, 263 insertions(+), 1 deletions(-)
> =C2=A0create mode 100644 tools/get-location.c


Argh... don't merge this... there were some changes that I forgot to add.

regards,

Lucas De Marchi

--===============0874355115483658721==--

