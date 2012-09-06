Content-Type: multipart/mixed; boundary="===============7149671802438702379=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] dbus: Add Terminated error
Date: Thu, 06 Sep 2012 10:22:07 -0500
Message-ID: <5048BF9F.3080703@gmail.com>
In-Reply-To: <1346941306-3168-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7149671802438702379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/06/2012 09:21 AM, Philippe Nunes wrote:
> ---
>   src/dbus.c  |    8 ++++++++
>   src/ofono.h |    1 +
>   2 files changed, 9 insertions(+)
>

The patch has been applied with a few changes:

> diff --git a/src/dbus.c b/src/dbus.c
> index 3f5c12d..1f9f9ba 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -409,6 +409,14 @@ DBusMessage *__ofono_error_not_recognized(DBusMessag=
e *msg)
>   					"String not recognized as USSD/SS");
>   }
>
> +DBusMessage *__ofono_error_terminated_by_network(DBusMessage *msg)

I amended the patch to read '__ofono_error_network_terminated'

> +{
> +	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
> +					".Terminated",
> +					"Operation is terminated by the"

and changed "is" to "was"

> +					" network");
> +}
> +
>   DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
>   						DBusMessage *msg)
>   {
> diff --git a/src/ofono.h b/src/ofono.h
> index aca81b4..e20d8fa 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -66,6 +66,7 @@ DBusMessage *__ofono_error_emergency_active(DBusMessage=
 *msg);
>   DBusMessage *__ofono_error_incorrect_password(DBusMessage *msg);
>   DBusMessage *__ofono_error_not_allowed(DBusMessage *msg);
>   DBusMessage *__ofono_error_not_recognized(DBusMessage *msg);
> +DBusMessage *__ofono_error_terminated_by_network(DBusMessage *msg);
>
>   DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
>   						DBusMessage *msg);

Regards,
-Denis

--===============7149671802438702379==--

