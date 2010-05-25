Content-Type: multipart/mixed; boundary="===============4615774404699999525=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bring back -d option without need for argument
Date: Tue, 25 May 2010 11:09:46 +0200
Message-ID: <1274778586.27220.123.camel@localhost.localdomain>
In-Reply-To: <1274774961-11297-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4615774404699999525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> ---
>  src/main.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> =

> diff --git a/src/main.c b/src/main.c
> index 8e686ac..8f4092c 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -96,8 +96,19 @@ static gchar *option_debug =3D NULL;
>  static gboolean option_detach =3D TRUE;
>  static gboolean option_version =3D FALSE;
>  =

> +static gboolean parse_debug(const char *key, const char *value, gpointer=
 user_data, GError **error)
> +{

patch has been applied, but same as with ConnMan, this declaration is
too long.

Regards

Marcel



--===============4615774404699999525==--

