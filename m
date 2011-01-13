Content-Type: multipart/mixed; boundary="===============7883421067113061360=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 8/9] doc: add CalledLinePresentation property to
 CallSettings
Date: Thu, 13 Jan 2011 15:09:22 -0200
Message-ID: <AANLkTimBgcxwOns3LBSFTBXKHV-XmKDpwSMYyjOfUisz@mail.gmail.com>
In-Reply-To: <1294831667-7447-9-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7883421067113061360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2011 at 9:27 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
> =C2=A0doc/call-settings-api.txt | =C2=A0 15 +++++++++++++++
> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
> index b6dc1cc..44e0dbb 100644
> --- a/doc/call-settings-api.txt
> +++ b/doc/call-settings-api.txt
> @@ -30,6 +30,21 @@ Properties =C2=A0 string CallingLinePresentation [read=
only]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"enabled",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"unknown"
>
> +Properties =C2=A0 =C2=A0 string CalledLinePresentation [readonly]

hunmn... This "Properties" shouldn't be here



Lucas De Marchi

--===============7883421067113061360==--

