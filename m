Content-Type: multipart/mixed; boundary="===============1942553767201624641=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] quectel: implement dbus signals for modem power
 notifications
Date: Fri, 19 Jul 2019 01:14:34 -0500
Message-ID: <c296ded9-00f1-f579-e7a3-41193a74d398@gmail.com>
In-Reply-To: <20190716191053.71990-7-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1942553767201624641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 7/16/19 2:10 PM, Martin Hundeb=C3=B8ll wrote:
> The Quectel modems issues unsolicited strings in case of power related
> events. The UC15 uses +QIND: for the events, while M95 and MC60 uses
> descriptive strings. (UC15 also uses a string for normal power down).
> =

> Register listeners for these strings/codes. The handler emits an
> appropriate dbus signal, and closes down the modem if needed.
> ---
>   doc/quectel-hardware-api.txt |  19 +++++
>   plugins/quectel.c            | 148 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 166 insertions(+), 1 deletion(-)
> =


2 separate commits please per HACKING, 'Submitting Patches'

<snip>

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 3c1d49cd..3c74fc41 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -108,8 +108,122 @@ struct dbus_hw {
>   	gint voltage;
>   };
>   =

> +enum quectel_power_event {
> +	LOW_POWER_DOWN    =3D -2,
> +	LOW_WARNING       =3D -1,
> +	NORMAL_POWER_DOWN =3D  0,
> +	HIGH_WARNING      =3D  1,
> +	HIGH_POWER_DOWN   =3D  2,
> +};
> +
>   static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardw=
are";
>   =

> +static void close_serial(struct ofono_modem *modem);
> +

We generally frown upon forward declaration of statics...

Regards,
-Denis

--===============1942553767201624641==--

