Content-Type: multipart/mixed; boundary="===============5308862312666618755=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] isimodem: Adding version isimodem and isimodem2.5
Date: Tue, 25 Jan 2011 13:23:48 +0100
Message-ID: <1295958228.1520.36.camel@aeonflux>
In-Reply-To: <1295957422-28723-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5308862312666618755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> Adding a version enum to differentiate between isimodem2.0 and isimodem2.=
5.
> =

> Needed for isimodem2.5 patches planned to follow shortly.
> =

> Best Regards,
> Jessica

same comments about commit body apply here as well.

> ---
>  drivers/isimodem/isimodem.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
> index 37191c7..a2a827d 100644
> --- a/drivers/isimodem/isimodem.h
> +++ b/drivers/isimodem/isimodem.h
> @@ -19,6 +19,11 @@
>   *
>   */
>  =

> +enum isi_version {
> +	ISI_20 =3D 0,
> +	ISI_25 =3D 1
> +};
> +

If we follow the same layout as with all other modem drivers, then the
*modem.h should only contain the prototypes for the init callbacks.

>  extern struct ofono_modem *isi_modem_by_interface(char const *ifname);

This one already violates this one and might need to be cleaned up.

The ISI modem is special since it really only has two users anyway in
the end, but maybe drivers/isimodem/version.h analog to vendor.h from
atmodem might be a good idea.

Aki, what is your preference here?

Regards

Marcel



--===============5308862312666618755==--

