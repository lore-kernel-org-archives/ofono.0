Content-Type: multipart/mixed; boundary="===============5820485444125818425=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Remove extra code for Esim Handling
Date: Thu, 18 Jun 2020 15:20:22 -0500
Message-ID: <0e6bb8aa-8a45-37f2-141d-8d73819ba229@gmail.com>
In-Reply-To: <1591859177-23599-2-git-send-email-shweta2.jain@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5820485444125818425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shweta,

On 6/11/20 2:06 AM, shweta wrote:
> From: Shweta Jain <shweta2.jain@intel.com>
> =


Can you elaborate a bit more why this code is no longer needed?  Also, how =
does =

the driver now guarantee that +CUSATP will be received by the stk atom?  I =

believe this was originally added for those devices that didn't shut down f=
ully =

(like USB ones) and kept the sim initialized even when .disable() callback =
was =

called.

If this new device/firmware doesn't need this logic, it might be simpler to=
 just =

not pass in the OFONO_VENDOR_XMM (use 0 instead) in plugins/xmm7xxx.c

> ---
>   drivers/atmodem/stk.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> =

> diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
> index b2d2081..18510fe 100644
> --- a/drivers/atmodem/stk.c
> +++ b/drivers/atmodem/stk.c
> @@ -180,7 +180,7 @@ static gboolean at_stk_register(gpointer user)
>   {
>   	struct ofono_stk *stk =3D user;
>   	struct stk_data *sd =3D ofono_stk_get_data(stk);
> -
> +    DBG("");

This code not according to our coding style.  Nor is it really related to t=
his =

commit description.

>   	g_at_chat_register(sd->chat, "+CUSATP:", phonesim_cusatp_notify,
>   						FALSE, stk, NULL);
>   =

> @@ -190,25 +190,9 @@ static gboolean at_stk_register(gpointer user)
>   	if (sd->vendor =3D=3D OFONO_VENDOR_PHONESIM)
>   		g_at_chat_register(sd->chat, "*HCMD:", phonesim_hcmd_notify,
>   						FALSE, stk, NULL);
> -
> -	if (sd->vendor =3D=3D OFONO_VENDOR_XMM) {
> -		/*	enabling stk	*/
> -		g_at_chat_send(sd->chat, "AT+CFUN=3D6", none_prefix,
> -						NULL, NULL, NULL);
> -		/*	Here ofono has missed stk menu proactive command
> -		 *	that comes after sim initialization only. Doing a
> -		 *	sim reset will enable the stk driver to get the
> -		 *	missed +CUSATP notifications.
> -		 */
> -		g_at_chat_send(sd->chat, "AT+CFUN=3D27,1", none_prefix,
> -						NULL, NULL, NULL);
> -	}
> -
>   	ofono_stk_register(stk);
> -
>   	return FALSE;
>   }
> -

This change results in a violation of the coding style as well.  See =

doc/coding-style.txt for more details.

>   static int at_stk_probe(struct ofono_stk *stk, unsigned int vendor, voi=
d *data)
>   {
>   	GAtChat *chat =3D data;
> =


Regards,
-Denis
--===============5820485444125818425==--

