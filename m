Content-Type: multipart/mixed; boundary="===============6511012305036158495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gsmdial: add option for Bluetooth DUN dialing
Date: Wed, 16 Feb 2011 15:55:18 -0600
Message-ID: <4D5C47C6.50709@gmail.com>
In-Reply-To: <1297892468-22101-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6511012305036158495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 02/16/2011 03:41 PM, Gustavo F. Padovan wrote:
> ---
>  gatchat/gsmdial.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> =

> diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
> index 1be80e3..bae5efb 100644
> --- a/gatchat/gsmdial.c
> +++ b/gatchat/gsmdial.c
> @@ -56,6 +56,7 @@ static gboolean option_legacy =3D FALSE;
>  static gchar *option_username =3D NULL;
>  static gchar *option_password =3D NULL;
>  static gchar *option_pppdump =3D NULL;
> +static gboolean option_bluetooth =3D 0;

This should be set to FALSE.  I've applied the patch and fixed this for you.

Regards,
-Denis

--===============6511012305036158495==--

