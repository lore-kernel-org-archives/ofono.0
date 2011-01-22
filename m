Content-Type: multipart/mixed; boundary="===============5370941407758106188=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] doc: fix class information of UMTS band
Date: Sat, 22 Jan 2011 10:43:53 -0200
Message-ID: <AANLkTikpFcrPzn4-yATNhgW2PsrYfcDyiu5_MSNbL+64@mail.gmail.com>
In-Reply-To: <1295699439-3144-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5370941407758106188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On Sat, Jan 22, 2011 at 10:30 AM, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> ---
> =C2=A0doc/radio-settings-api.txt | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
> index c8e9264..da46ffe 100644
> --- a/doc/radio-settings-api.txt
> +++ b/doc/radio-settings-api.txt
> @@ -81,7 +81,7 @@ Properties =C2=A0 =C2=A0string TechnologyPreference [re=
adwrite]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"850" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Operate only on 850 MHz, known
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0as CLR (class V).
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"900" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Operate only on 900 MHz, known
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 as GSM (class VII).
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 as GSM (class VIII).

Good catch. This was my bad.


Thanks

Lucas De Marchi

--===============5370941407758106188==--

