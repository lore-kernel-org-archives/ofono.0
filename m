Content-Type: multipart/mixed; boundary="===============4173114939536960453=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 12:07:10 -0600
Message-ID: <d70b4ed7-3fb9-1a33-1cf8-e2c28e6bc16a@gmail.com>
In-Reply-To: <20210115163856.18674-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4173114939536960453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/15/21 10:38 AM, Sergey Matyukevich wrote:
> Make sure that IMPI is a valid UTF8 string before attempting
> to report it via DBus. Otherwise ofono may crash on dbus assert.
> This field may not be defined for ISIM in use. In this case the
> field still can be read from ISIM, though it will not contain
> a valid UTF8 string. For instance, it may contain 255 0xFF bytes.

Ugh, seems like the SIM vendor can't follow RFC's either?  31.103 Section 4=
.2.2 =

says:

"For contents and syntax of NAI TLV data object values see IETF RFC 2486 [2=
4]. =

The NAI shall be encoded to an octet string according to UTF-8 encoding rul=
es as =

specified in IETF RFC 3629 [27]. The tag value of the NAI TLV data object s=
hall =

be '80'. "

> ---
>   src/sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 33e1245f..f60f5d1b 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -423,7 +423,7 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
>   		ofono_dbus_dict_append(&dict, "ServiceProviderName",
>   					DBUS_TYPE_STRING, &sim->spn);
>   =

> -	if (sim->impi)
> +	if (sim->impi && g_utf8_validate(sim->impi, 255, NULL))

Hmm, this would imply that we're setting sim->impi incorrectly..  Also, sin=
ce we =

have __ofono_sim_get_impi() API, the better fix would be to make sure sim->=
impi =

is set correctly in impi_read_cb()

>   		ofono_dbus_dict_append(&dict, "ImsPrivateIdentity",
>   					DBUS_TYPE_STRING, &sim->impi);
>   =

> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
> =


Regards,
-Denis
--===============4173114939536960453==--

