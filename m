Content-Type: multipart/mixed; boundary="===============7854838470060144868=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/6] SetProperty for UseDeliveryReports.
Date: Fri, 04 Jun 2010 12:08:35 -0500
Message-ID: <201006041208.35564.denkenz@gmail.com>
In-Reply-To: <1275650257-30593-5-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7854838470060144868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/sms.c       |   34 +++++++++++++++++++++++++++++++++-
>  src/smsutil.c   |    5 +++--
>  src/smsutil.h   |    3 ++-
>  test/send-sms   |    7 ++++++-
>  unit/test-sms.c |   10 +++++-----

Please break this up into a series of 4 patches:
1. smsutil changes
2. unit test changes
3. sms core atom changes
4. unit test changes.

> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -67,6 +67,7 @@ struct ofono_sms {
>  	const struct ofono_sms_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	gboolean use_delivery_reports;

Use ofono_bool_t as the type here

>  };
> =

> +	if (!strcmp(property, "UseDeliveryReports")) {
> +		const char *path =3D __ofono_atom_get_path(sms->atom);
> +		gboolean value;

use dbus_bool_t as the type as it is more type-correct.

>  GSList *sms_text_prepare(const char *utf8, guint16 ref,
> -				gboolean use_16bit, int *ref_offset)
> +				gboolean use_16bit, int *ref_offset,
> +				const gboolean use_delivery_reports)

For basic integer types, no need to declare them const.

Regards,
-Denis

--===============7854838470060144868==--

