Content-Type: multipart/mixed; boundary="===============0474485800997675929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Fri, 31 Jul 2009 11:19:23 -0500
Message-ID: <200907311119.23891.denkenz@gmail.com>
In-Reply-To: <1248941142-13236-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0474485800997675929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Comments are welcome about how the interface should look.  The state of t=
he
> indications is kept in memory and written back to the SIM after any
> changes.
>
> Patch is untested because write ofono_sim_write is unimplemented, I'll add
> it as a separate patch.  Should it take a callback parameter?

Probably would be useful in case you want to notify an external app that =

storing a file failed (e.g. update of MBDN / MSISDN).  For other cases, may=
be =

less useful.

> diff --git a/src/driver.h b/src/driver.h
> index 928c20a..51e5587 100644
> --- a/src/driver.h
> +++ b/src/driver.h
> @@ -439,3 +439,6 @@ void ofono_phonebook_entry(struct ofono_modem *modem,
> int index, const char *adnumber, int adtype,
>  				const char *secondtext, const char *email,
>  				const char *sip_uri, const char *tel_uri);
> +
> +int ofono_message_waiting_register(struct ofono_modem *modem);
> +void ofono_message_waiting_unregister(struct ofono_modem *modem);

Lets keep this out of driver.h, there's nothing here that a driver can =

provide.  Put it in ofono.h or messagewaiting.h

> +	if (mw->messages[i] !=3D value) {
> +		mw->messages[i] =3D value;
> +
> +		if (!mw->pending)
> +			mw->pending =3D g_timeout_add(0, mw_mwis_update, modem);
> +
> +		dbus_gsm_signal_property_changed(conn, modem->path,
> +				MESSAGE_WAITING_INTERFACE,
> +				mw_messages_property_name[i],
> +				DBUS_TYPE_BYTE, &value);
> +	}
> +
> +	return dbus_message_new_method_return(msg);
> +}

Ok, I'm a bit confused here.  Are you sure that MWIs should have the abilit=
y =

to be cleared out by the user?  The way I understood it, the user dials the =

voice mail system and the provider sends another MWI message which clears o=
ut =

the status.

> +void ofono_message_waiting_message(struct ofono_modem *modem, const char
> *msg) +{
> +	struct message_waiting_data *mw =3D modem->message_waiting;
> +	DBusConnection *conn =3D dbus_gsm_connection();
> +
> +	if (!mw)
> +		return;
> +
> +	if (mw->last_message && !strcmp(mw->last_message, msg))
> +		return;
> +
> +	if (mw->last_message)
> +		g_free(mw->last_message);
> +
> +	mw->last_message =3D g_strdup(msg);
> +
> +	dbus_gsm_signal_property_changed(conn, modem->path,
> +			MESSAGE_WAITING_INTERFACE, "LastNotificationText",
> +			DBUS_TYPE_STRING, &mw->last_message);
> +}


> +
> +enum mwi_information_type {
> +	MWI_UNSPECIFIED =3D -1,
> +	MWI_MESSAGES_WAITING =3D -2,
> +	MWI_NO_MESSAGES_WAITING =3D -3,
> +};

Is there a reason these are negative?

> --- a/src/modem.h
> +++ b/src/modem.h
> @@ -43,6 +43,7 @@ struct ofono_modem {
>  	struct sim_manager_data *sim_manager;
>  	struct sms_manager_data *sms_manager;
>  	struct phonebook_data *phonebook;
> +	struct message_waiting_data *message_waiting;
>
>  	GSList *history_contexts;
>  };

Please rebase, this file is now defunct

> +static void handle_mwi(struct ofono_modem *modem,
> +			struct sms *sms, gboolean *out_discard)
> +{
> +	gboolean active, discard;
> +	enum sms_mwi_type type;
> +	char *message;
> +	int profile =3D 1;
> +	GSList *sms_list;
> +
> +	/* "Store" bits are ORed if multiple MWI types are present
> +	 * but if neither Special SMS Message Indication nor DCS based
> +	 * indication is present, the bit must remain set.  */
> +	int set =3D 1, store =3D 0;

What is this comment about, since I don't see any ORing going on below.  Ar=
e =

you trying to accommodate this piece of stupidity from 23.040 9.2.3.24.2?
"In the event of a conflict between this setting and the setting of the Dat=
a =

Coding Scheme (see 3GPP TS 23.038 [9]) then the message shall be stored if =

either the DCS indicates this, or Octet 1 above indicates this."

> +
> +	/* Check MWI types in the order from lowest to highest priority
> +	 * because they will override one another.  */

Can we instead process the different sources from highest to lowest instead=
 and =

bail out early?  No sense in calling message_waiting_notify several times (=
and =

possibly emitting spurious signals) when only once is required.

> +	if (sms_dcs_decode(sms->deliver.dcs, NULL, NULL, NULL, NULL) &&
> +			sms->deliver.udhi) {

This seems to be incorrect.  An MWI DCS message can still contain enhanced =

IEIs.  Should this check just for UDHI instead?

> +final:
> +	/* Only bother the Message Waiting interface with textual
> +	 * notifications that are not to be stored together with other
> +	 * Short Messages in ME.  The other messages will be delivered
> +	 * to the user through normal SMS store.  */

It sounds to me like we can completely ignore the text of such messages.  T=
he =

network is basically saying: "the text isn't important, the contents are." =


Regards,
-Denis

--===============0474485800997675929==--

