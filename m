Content-Type: multipart/mixed; boundary="===============0393592991632827224=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gprs: pri_set_apn not exclusively a DBus method
Date: Thu, 04 May 2017 10:59:41 -0500
Message-ID: <880e6dc7-7ab9-2aec-b52a-26c6c45903ec@gmail.com>
In-Reply-To: <20170504132430.28813-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393592991632827224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 05/04/2017 08:24 AM, Jonas Bonn wrote:
> pri_set_apn is called by ofono_gprs_cid_activated() which is not a DBus
> method; as such, there is no DBus return message.  Attempting to create
> the return message with a NULL 'msg' may cause the DBus library to
> call abort().
> ---
>  src/gprs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index c5e7709..ed2131e 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1030,8 +1030,12 @@ static DBusMessage *pri_set_apn(struct pri_context=
 *ctx, DBusConnection *conn,
>  	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
>  		return __ofono_error_invalid_format(msg);
>
> -	if (g_str_equal(apn, ctx->context.apn))
> -		return dbus_message_new_method_return(msg);
> +	if (g_str_equal(apn, ctx->context.apn)) {
> +		if (msg)
> +			return dbus_message_new_method_return(msg);
> +		else
> +			return NULL;
> +	}

This doesn't really help as __ofono_error still uses dbus_message_new... =

with a NULL argument.

I suspect that the code in this function likely needs to be duplicated =

for the cid_activated case.

>
>  	if (is_valid_apn(apn) =3D=3D FALSE)
>  		return __ofono_error_invalid_format(msg);
>

Regards,
-Denis

--===============0393592991632827224==--

