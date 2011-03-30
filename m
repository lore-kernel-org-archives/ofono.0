Content-Type: multipart/mixed; boundary="===============3368904590345608214=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 18/18] gsmdial: implement mechanism to send +++ -> ATO0 ->
 +++ -> ATH0
Date: Wed, 30 Mar 2011 15:59:26 -0500
Message-ID: <4D9399AE.1050805@gmail.com>
In-Reply-To: <1301066749-12052-19-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3368904590345608214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 03/25/2011 10:25 AM, Guillaume Zajac wrote:
> ---
>  gatchat/gsmdial.c |  164 ++++++++++++++++++++++++++++++++++++++++++++---=
-----
>  1 files changed, 138 insertions(+), 26 deletions(-)
> =

> diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
> index 92a7ff2..f1b485e 100644
> --- a/gatchat/gsmdial.c
> +++ b/gatchat/gsmdial.c
> @@ -40,6 +40,8 @@
>  =

>  #define IFCONFIG_PATH "/sbin/ifconfig"
>  =

> +#define GUARD_TIMEOUTS 1500
> +
>  static const char *none_prefix[] =3D { NULL };
>  static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
>  static const char *creg_prefix[] =3D { "+CREG:", NULL };
> @@ -238,32 +240,6 @@ static gboolean execute(const char *cmd)
>  	return TRUE;
>  }
>  =

> -static void ppp_connect(const char *iface, const char *local, const char=
 *peer,
> -			const char *dns1, const char *dns2,
> -			gpointer user_data)
> -{
> -	char buf[512];
> -
> -	/* print out the negotiated address and dns server */
> -	g_print("Network Device: %s\n", iface);
> -	g_print("IP Address: %s\n", local);
> -	g_print("Peer IP Address: %s\n", peer);
> -	g_print("Primary DNS Server: %s\n", dns1);
> -	g_print("Secondary DNS Server: %s\n", dns2);
> -
> -	if (getuid() !=3D 0) {
> -		g_print("Need root privilege to config PPP interface\n");
> -		return;
> -	}
> -
> -	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
> -	execute(buf);
> -
> -	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
> -				iface, local, peer);
> -	execute(buf);
> -}
> -
>  static void no_carrier_notify(GAtResult *result, gpointer user_data)
>  {
>  	char buf[64];
> @@ -294,6 +270,142 @@ static void ppp_disconnect(GAtPPPDisconnectReason r=
eason, gpointer user_data)
>  	g_at_chat_resume(modem);
>  }
>  =

> +static void power_down_ppp(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	if (!ok)
> +		return;
> +
> +	g_at_ppp_unref(ppp);
> +	ppp =3D NULL;
> +}
> +
> +static gboolean send_ATH0(gpointer user_data)
> +{
> +	/* Resume AT chat to send ATH0 */
> +	g_at_chat_resume(modem);
> +	g_at_chat_send(modem, "ATH0", none_prefix, power_down_ppp, NULL, NULL);
> +
> +	return FALSE;
> +}
> +
> +static gboolean suspend_and_close(gpointer user_data)
> +{
> +	g_print("Send +++\n");
> +	/* Send the escape sequence to suspend PPP server*/
> +	g_at_io_write(g_at_chat_get_io(modem), "+++", 3);
> +	=

> +	/*
> +	 * Wait GUARD_TIMEOUTS ms before sending ATH0 cmd
> +	 * according to guard timeouts
> +	 */
> +	g_timeout_add(GUARD_TIMEOUTS, send_ATH0, NULL);
> +
> +	return FALSE;
> +}
> +
> +static void ppp_suspend_close(gpointer data)
> +{
> +	/* Delete the write done CB */
> +	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
> +
> +	/*
> +	 * We are sure there are no more PPP packets to be written,
> +	 * we can suspend PPP client
> +	 */
> +	g_at_ppp_suspend(ppp);
> +
> +	/* Wait GUARD_TIMEOUTS ms before sending escape sequence */
> +	g_timeout_add(GUARD_TIMEOUTS, suspend_and_close, NULL);
> +}
> +
> +static void suspend_gat_chat(gboolean ok, GAtResult *result, gpointer us=
er_data)
> +{
> +	/*
> +	 * As soon as the command is treated by AT server
> +	 * we can suspend AT chat and resume PPP client
> +	 */
> +	g_at_chat_suspend(modem);
> +	g_at_ppp_resume(ppp);
> +
> +	/*
> +	 * We wait for another PPP packet to be written
> +	 * to suspend again PPP server and close it
> +	 */
> +	g_at_io_set_write_done(g_at_chat_get_io(modem), ppp_suspend_close, NULL=
);
> +}
> +
> +static gboolean send_ATO0(gpointer user_data)
> +{
> +	/* Resume AT chat to send ATO0 */
> +	g_at_chat_resume(modem);
> +	g_at_chat_send(modem, "ATO0", none_prefix, suspend_gat_chat, NULL, NULL=
);
> +
> +	return FALSE;
> +}
> +
> +static gboolean suspend_resume(gpointer user_data)
> +{
> +	g_print("Send +++\n");
> +	/* Send the escape sequence to suspend PPP server*/
> +	g_at_io_write(g_at_chat_get_io(modem), "+++", 3);
> +
> +	/*
> +	 * Wait GUARD_TIMEOUTS ms before sending ATO0 cmd
> +	 * according to guard timeouts
> +	 */
> +	g_timeout_add(GUARD_TIMEOUTS, send_ATO0, NULL);
> +
> +	return FALSE;
> +}
> +
> +static void ppp_suspend_resume(gpointer data)
> +{
> +	/* Delete the write done CB */
> +	g_at_io_set_write_done(g_at_chat_get_io(modem), NULL, NULL);
> +
> +	/*
> +	 * We are sure there are no more PPP packets to be written,
> +	 * we can suspend PPP client
> +	 */
> +	g_at_ppp_suspend(ppp);
> +
> +	/* Wait GUARD_TIMEOUTS ms before sending escape sequence */
> +	g_timeout_add(GUARD_TIMEOUTS, suspend_resume, NULL);
> +}
> +

The logic for sending a guard timeout, +++, guard timeout should really
belong in GAtChat, otherwise every single client has to repeat the same
state machine.

> +static void ppp_connect(const char *iface, const char *local, const char=
 *peer,
> +			const char *dns1, const char *dns2,
> +			gpointer user_data)
> +{
> +	char buf[512];
> +
> +	/* print out the negotiated address and dns server */
> +	g_print("Network Device: %s\n", iface);
> +	g_print("IP Address: %s\n", local);
> +	g_print("Peer IP Address: %s\n", peer);
> +	g_print("Primary DNS Server: %s\n", dns1);
> +	g_print("Secondary DNS Server: %s\n", dns2);
> +
> +	if (getuid() !=3D 0) {
> +		g_print("Need root privilege to config PPP interface\n");
> +		return;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
> +	execute(buf);
> +
> +	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
> +				iface, local, peer);
> +	execute(buf);
> +
> +	/*
> +	 * As soon as a PPP packet is written by the client, we try to send the=
 escape sequence
> +	 * and resume PPP server using ATO0 cmd
> +	 */
> +	if (option_esc)
> +		g_at_io_set_write_done(g_at_chat_get_io(modem), ppp_suspend_resume, NU=
LL);
> +}
> +
>  static void connect_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
>  {
>  	GAtIO *io;

Regards,
-Denis

--===============3368904590345608214==--

