Content-Type: multipart/mixed; boundary="===============5187584421221380945=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix: remove extra comma from NotAvailable error
Date: Thu, 19 Aug 2010 19:30:56 +0200
Message-ID: <1282239056.23399.184.camel@localhost.localdomain>
In-Reply-To: <1282234826-30021-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5187584421221380945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  src/dbus.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

> =

> diff --git a/src/dbus.c b/src/dbus.c
> index 09114c3..c51f2a9 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -300,7 +300,7 @@ DBusMessage *__ofono_error_not_supported(DBusMessage =
*msg)
>  =

>  DBusMessage *__ofono_error_not_available(DBusMessage *msg)
>  {
> -	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE,
> +	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
>  					".NotAvailable",
>  					"Operation currently not available");
>  }

good catch. Patch has been applied.

And the compiler should have complained, but of course it only does that
if you annotate this properly in gdbus :(

Regards

Marcel



--===============5187584421221380945==--

