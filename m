Content-Type: multipart/mixed; boundary="===============3893958572813900041=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gprs: store APN in settings for auto-discovered
 contexts
Date: Thu, 05 Jul 2018 11:35:14 -0500
Message-ID: <1b7a0430-4e0c-5de3-962c-2b12b7b02302@gmail.com>
In-Reply-To: <1530780318-20577-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3893958572813900041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 07/05/2018 03:45 AM, Christophe Ronco wrote:
> APN has to be stored in settings file after it is modified in
> ofono_gprs_cid_activated function.
> ---
>   src/gprs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 377eced..22d5e36 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2063,6 +2063,13 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *=
gprs, unsigned int cid,
>   =

>   		strcpy(pri_ctx->context.apn, apn);
>   =

> +		if (gprs->settings) {
> +			g_key_file_set_string(gprs->settings, pri_ctx->key,
> +							"AccessPointName", apn);
> +			storage_sync(gprs->imsi, SETTINGS_STORE,
> +								gprs->settings);
> +		}
> +

I'm not too sure that this is the right 'fix'.

So here's a bit of background:
- when GPRS starts it looks for the settings file for GPRS.  If it finds =

one, then all gprs contexts are loaded from there and the D-Bus =

interface comes up.

- If the settings file isn't there, then provisioning is run.  We first =

have to wait for the SIM atom to read the EFspn.

- When EFspn is read, provision_contexts is called.  If provisioning =

fails, a 'special' empty context with type INTERNET is created.  It is =

special because it has a NULL APN.  This tells the upper layers that =

provisioning failed.

So you seem to be reliably triggering an issue which we should probably =

fix, but is a corner case.  Why are you setting the modem online prior =

to contexts getting provisioned?  If you wait for provisioning to happen =

first, most of these issues would go away.

The other problem is that find_usable_context() is defaulting to using =

the 'special' NULL APN context described above.  So what happens now is =

that:
1. If provisioning fails and you go online with LTE, you 'reuse' the =

special NULL context
2. If provisioning is still pending and you go online with LTE, you =

create a new context prior to provisioning being finished.

In both cases above you then sync these changes to permanent storage.  I =

think we should treat contexts created via ofono_gprs_cid_activated as =

'temporary' and not sync them at all.

>   		ofono_dbus_signal_property_changed(conn, pri_ctx->path,
>   					OFONO_CONNECTION_CONTEXT_INTERFACE,
>   					"AccessPointName",
> =


Regards,
-Denis

--===============3893958572813900041==--

