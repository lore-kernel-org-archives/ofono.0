Content-Type: multipart/mixed; boundary="===============2644922043597357494=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v3 2/4] sim: query remaining pin retries
Date: Wed, 05 Jan 2011 15:40:49 -0200
Message-ID: <AANLkTimS=mw625so1rhJabedK_NvZiCyhDKZ=Q-x+L7n@mail.gmail.com>
In-Reply-To: <1294248040-14342-3-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2644922043597357494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Denis

On Wed, Jan 5, 2011 at 3:20 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Check the remaining pin retries after each operation that might have
> changed it, i.e. locking, unlocking, reseting or changing pin.
> ---
> =C2=A0src/sim.c | =C2=A0 97 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A01 files changed, 97 insertions(+), 0 deletions(-)
>

What about this patch?



Lucas De Marchi

--===============2644922043597357494==--

