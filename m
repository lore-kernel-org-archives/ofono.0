Content-Type: multipart/mixed; boundary="===============0636859473327486932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-volume: Minor coding style fix
Date: Fri, 26 Nov 2010 15:03:13 -0600
Message-ID: <4CF02091.3020601@gmail.com>
In-Reply-To: <1290783465-5541-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0636859473327486932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 11/26/2010 08:57 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-volume.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> =

> diff --git a/src/call-volume.c b/src/call-volume.c
> index dd1be92..0accdf2 100644
> --- a/src/call-volume.c
> +++ b/src/call-volume.c
> @@ -114,7 +114,6 @@ static DBusMessage *cv_get_properties(DBusConnection =
*conn,
>  	dbus_bool_t muted;
>  =

>  	reply =3D dbus_message_new_method_return(msg);
> -
>  	if (!reply)
>  		return NULL;
>  =


Style wise this is actually OK, but if you really want to be
style-pedantic :) then this should be:

reply =3D ...
if (reply =3D=3D NULL)
	return NULL

Regards,
-Denis

--===============0636859473327486932==--

