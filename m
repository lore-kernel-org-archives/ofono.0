Content-Type: multipart/mixed; boundary="===============1332086430289235770=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/3] hfp_hf: Handle ServicesResolved signal
Date: Mon, 01 May 2017 10:57:45 -0500
Message-ID: <f7a51461-d668-a412-f186-f6410394a300@gmail.com>
In-Reply-To: <20170428093108.29461-2-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1332086430289235770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 04/28/2017 04:31 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds handling for ServicesResolved signal which tells when BlueZ
> is done resolving the device services so the code will no longer ignore
> devices that got its services resolved after Paired signal.
> ---
>  plugins/hfp_hf_bluez5.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index fb7cc3f..f7d2450 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -555,9 +555,9 @@ static struct ofono_modem *modem_register_from_proxy(=
GDBusProxy *proxy,
>
>  	dbus_message_iter_get_basic(&iter, &paired);
>
> -	if (paired =3D=3D FALSE) {
> -		modem =3D ofono_modem_find(device_path_compare, (void *) path);
> +	modem =3D ofono_modem_find(device_path_compare, (void *) path);
>
> +	if (paired =3D=3D FALSE) {
>  		if (modem !=3D NULL) {
>  			ofono_modem_remove(modem);
>  			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
> @@ -566,6 +566,9 @@ static struct ofono_modem *modem_register_from_proxy(=
GDBusProxy *proxy,
>  		return NULL;
>  	}
>
> +	if (modem)
> +		return modem;
> +

Why would you return a non-NULL value here?  I thought your intended =

semantics (from patch 1) were to return the modem that was actually =

newly registered?

The new_connection code path is really quite special, so it really begs =

a comment.  I also wonder if modem_register_from_proxy should be =

separated into two functions.  One to handle the actual registration =

path, and one to handle the device removal.

>  	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
>  		return NULL;

Can UUIDs change from having HFP AG to not having HFP AG btw?  We might =

be missing an additional remove path in that case.

Regards,
-Denis

--===============1332086430289235770==--

