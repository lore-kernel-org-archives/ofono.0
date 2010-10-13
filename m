Content-Type: multipart/mixed; boundary="===============1375409332653123185=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] stk: Expose icon IDs on D-Bus.
Date: Wed, 13 Oct 2010 09:34:14 -0500
Message-ID: <4CB5C366.5020005@gmail.com>
In-Reply-To: <1286461206-4446-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1375409332653123185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/07/2010 09:20 AM, Andrzej Zaborowski wrote:
> Update the docs to match the properties in stk.c.
> ---
>  doc/stk-api.txt |   16 ++++++-
>  src/stk.c       |  112 ++++++++++++++++++++++++++++++++++---------------=
------
>  src/stkagent.c  |   41 ++++++++++++--------
>  src/stkagent.h  |   34 +++++++++-------
>  4 files changed, 125 insertions(+), 78 deletions(-)

This patch no longer applies, can you please rebase it?

Also, please split up this patch up some more.

> =

> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> index f5b9ebc..c29872a 100644
> --- a/doc/stk-api.txt
> +++ b/doc/stk-api.txt
> @@ -55,23 +55,33 @@ Signals		PropertyChanged(string property, variant val=
ue)
>  			Signal is emitted whenever a property has changed.
>  			The new value is passed as the signal argument.
>  =

> -Properties	string IdleText
> +Properties	string IdleModeText

This is a bug fix, and should be in a separate patch.

>  =

>  			Contains the text to be used when the home screen is
> -			idle.  This text is set by the SIM and can be changed
> +			idle.  This text is set by the SIM and can change
>  			at any time.

Squash this into the patch above.

>  =

> +		byte IdleModeIcon
> +
> +			Contains the identifier of the icon accompanying
> +			the idle mode text.
> +
>  		array{struct{string, byte}} MainMenu
>  =

>  			Contains the items that make up the main menu.  This
>  			is populated by the SIM when it sends the Setup Menu
>  			Proactive Command.  The main menu is always available,
> -			but its contents can be changed at any time.
> +			but its contents can be changed at any time.  Each
> +			item contains the item label and icon identifier.
>  =

>  		string MainMenuTitle
>  =

>  			Contains the title of the main menu.
>  =

> +		string MainMenuIcon
> +
> +			Contains the identifier of the icon for the main menu.
> +
>  		array{byte} Icons
>  =


Rest should be in a separate doc update patch.

>  			Contains the identifiers of all available icons for
> diff --git a/src/stk.c b/src/stk.c
> index 84a22c9..7aa2ea6 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -72,6 +72,7 @@ struct ofono_stk {
>  	guint remove_agent_source;
>  	struct extern_req *extern_req;
>  	char *idle_mode_text;
> +	struct stk_icon_id idle_mode_icon;

Idle Mode Icon and Main Menu Icon support should be in a separate patch.

>  	struct timeval get_inkey_start_ts;
>  };
>  =

> @@ -256,19 +257,28 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk=
, const struct cbs *msg)
>  }
>  =

>  static struct stk_menu *stk_menu_create(const char *title,
> -		const struct stk_text_attribute *title_attr, GSList *items,
> +		const struct stk_text_attribute *title_attr,
> +		const struct stk_icon_id *icon, GSList *items,
>  		const struct stk_item_text_attribute_list *item_attrs,
> +		const struct stk_item_icon_id_list *item_icon_ids,
>  		int default_id, gboolean soft_key, gboolean has_help)
>  {
>  	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
> +	unsigned int len =3D g_slist_length(items);
>  	GSList *l;
>  	int i;
>  =

>  	DBG("");
>  =

> +	if (item_attrs && item_attrs->len && item_attrs->len !=3D len * 4)
> +		goto error;
> +
> +	if (item_icon_ids && item_icon_ids->len && item_icon_ids->len !=3D len)
> +		goto error;
> +
>  	ret->title =3D g_strdup(title ? title : "");
> -	ret->icon_id =3D 0;
> -	ret->items =3D g_new0(struct stk_menu_item, g_slist_length(items) + 1);
> +	memcpy(&ret->icon, icon, sizeof(ret->icon));
> +	ret->items =3D g_new0(struct stk_menu_item, len + 1);
>  	ret->default_item =3D -1;
>  	ret->soft_key =3D soft_key;
>  	ret->has_help =3D has_help;
> @@ -278,12 +288,18 @@ static struct stk_menu *stk_menu_create(const char =
*title,
>  =

>  		ret->items[i].text =3D g_strdup(item->text);
>  		ret->items[i].item_id =3D item->id;
> +		if (item_icon_ids && item_icon_ids->len)
> +			ret->items[i].icon_id =3D item_icon_ids->list[i];
>  =

>  		if (item->id =3D=3D default_id)
>  			ret->default_item =3D i;
>  	}
>  =

>  	return ret;
> +
> +error:
> +	g_free(ret);
> +	return NULL;
>  }

This part should be in a separate patch

<snip>

> @@ -381,7 +409,8 @@ static void dict_append_menu(DBusMessageIter *dict, s=
truct stk_menu *menu)
>  	dbus_message_iter_close_container(dict, &entry);
>  }
>  =

> -static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
> +static void stk_alpha_id_set(struct ofono_stk *stk, const char *text,
> +		const struct stk_icon_id *icon)

stk_alpha_id_set changes should be in a separate patch ;)

<snip>

>  =

> -	if (!stk->pending_cmd->send_sms.alpha_id ||
> -			!stk->pending_cmd->send_sms.alpha_id[0])
> -		return;
> -

This part does not look related to icon ids at all.  Please break it out
into a separate patch.

>  	stk_alpha_id_unset(stk);
>  }
>  =

> @@ -684,9 +713,7 @@ static void send_sms_submit_cb(gboolean ok, void *dat=
a)
>  		return;
>  	}
>  =

> -	if (stk->pending_cmd->send_sms.alpha_id &&
> -			stk->pending_cmd->send_sms.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);

Same comment as above.

<snip>

> @@ -1628,9 +1662,7 @@ static void send_ussd_callback(int error, int dcs, =
const unsigned char *msg,
>  	enum sms_charset charset;
>  	unsigned char no_cause[] =3D { 0x00 };
>  =

> -	if (stk->pending_cmd->send_ussd.alpha_id &&
> -			stk->pending_cmd->send_ussd.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);

And here as well.

> @@ -1834,9 +1865,7 @@ static void send_dtmf_cancel(struct ofono_stk *stk)
>  	stk->respond_on_exit =3D FALSE;
>  	stk->extern_req->cancelled =3D TRUE;
>  =

> -	if (stk->pending_cmd->send_dtmf.alpha_id &&
> -			stk->pending_cmd->send_dtmf.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);

And here

>  }
>  =

>  static void dtmf_sent_cb(const struct ofono_error *error, void *user_dat=
a)
> @@ -1855,9 +1884,7 @@ static void dtmf_sent_cb(const struct ofono_error *=
error, void *user_data)
>  =

>  	stk->respond_on_exit =3D FALSE;
>  =

> -	if (stk->pending_cmd->send_dtmf.alpha_id &&
> -			stk->pending_cmd->send_dtmf.alpha_id[0])
> -		stk_alpha_id_unset(stk);
> +	stk_alpha_id_unset(stk);

And here

<snip>

>  struct stk_menu {
>  	char *title;
> -	uint8_t icon_id;
> +	struct stk_icon_id icon;
>  	struct stk_menu_item *items;
>  	int default_item;
>  	gboolean soft_key;

The stk menu patches should be in a separate patch.

> @@ -77,45 +77,49 @@ int stk_agent_request_selection(struct stk_agent *age=
nt,
>  				int timeout);
>  =

>  int stk_agent_display_text(struct stk_agent *agent, const char *text,
> -				uint8_t icon_id, ofono_bool_t urgent,
> +				const struct stk_icon_id *icon,
> +				ofono_bool_t urgent,

<snip>

The stkagent changes should be in a separate patch...

Regards,
-Denis

--===============1375409332653123185==--

