Content-Type: multipart/mixed; boundary="===============6710060461974106208=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 10:59:45 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E706C6@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1299573784-21478-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6710060461974106208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

ofono-bounces(a)ofono.org wrote:
> ---
>  drivers/atmodem/network-registration.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c
> b/drivers/atmodem/network-registration.c
> index 4913611..2d589f0 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result,
>  	gpointer user_data) nd->time.mday =3D mday;
>  	nd->time.mon =3D mon;
>  	nd->time.year =3D 2000 + year;
> +
> +	ofono_netreg_time_notify(netreg, &nd->time);
>  }
> =

>  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)

Since the fix is more to do with the ifx modem, it would be nice if we
have the
commit message changed to reflect that.

Whenever there is a timezone change, CTZV, CTZDST and XNITZINFO URCs
will be reported. That is the main
reason behind calling the ofono_netreg_time_notify from CTZDST. Are you
pretty sure
this is not the case?

Regards,
Jeevaka

--===============6710060461974106208==--

