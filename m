Content-Type: multipart/mixed; boundary="===============9151632205209198266=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 19/20] SMS: introduce sms_msg_cancel and its D-Bus wrapper
Date: Tue, 27 Jul 2010 12:16:46 -0500
Message-ID: <4C4F147E.5000706@gmail.com>
In-Reply-To: <6d6f0ad3aacec87f5a6e75fed17e1020bfcddb0a.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9151632205209198266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 04:00 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> This introduces the ability to cancel a pending SMS message,
> accessible via an internal API and over a D-Bus wrapper.
> =

> Sending a note to the network to cancel an in-transit message is not
> yet implemented.
> =

> Note the test case code requires follow up commits that propagate the
> message's state changes over D-Bus.
> ---
>  src/sms.c                |   63 +++++++++++++++++
>  src/smsutil.h            |   15 ++++
>  test/test-sms-msg-cancel |  173 ++++++++++++++++++++++++++++++++++++++++=
++++++

Multiple patches please.  One for each directory.

>  3 files changed, 251 insertions(+), 0 deletions(-)
>  create mode 100755 test/test-sms-msg-cancel
> =

> diff --git a/src/sms.c b/src/sms.c
> index c0b2e00..97c9eab 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -538,6 +538,24 @@ static void __ofono_sms_tx_state_set(struct tx_queue=
_entry *entry,
>  =

>  =

>  /*
> + * Note that the D-Bus specific cleanups are taken care by the
> + * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
> + */
> +static DBusMessage *dbus_sms_msg_cancel(
> +	DBusConnection * conn, DBusMessage *msg, void *data)
> +{
> +	gboolean do_network_cancel =3D FALSE;
> +	struct tx_queue_entry *sms_msg =3D data;
> +	if (!dbus_message_get_args(msg, NULL,
> +				   DBUS_TYPE_BOOLEAN, &do_network_cancel))
> +		return __ofono_error_invalid_args(msg);
> +	sms_msg_cancel(sms_msg,
> +		       do_network_cancel ? SMS_MSG_CANCEL_IN_NETWORK : 0);
> +	return dbus_message_new_method_return(msg);
> +}
> +
> +

You're ignoring about every part of the coding standard in this chunk...

> +/**
> + * Cancel a pending SMS message
> + *
> + * @sms_msg: message to cancel
> + * @flags: modifies for the action
> + *
> + * This function cancels a message that is pending or being
> + * actively transmitted. Note that after this function returns, the
> + * @sms_msg handle is no longer valid.
> + *
> + * \internal
> + *
> + * There is no need to cancel the calling of tx_next() by
> + * g_timeout_add() scheduled in sms_msg_send(). The rationale behind
> + * this is that the tx_next() function is scheduled to go over the
> + * list of messages in the @sms object, so it might have been
> + * scheduled for other messages also rather than just for this one
> + * @sms_msg. By the time it gets to run, it might see the list empty
> + * or see other messages, but @sms_msg won't be there.
> + */
> +void sms_msg_cancel(struct tx_queue_entry *sms_msg,
> +		    enum sms_msg_cancel_flags flags)
> +{
> +	struct ofono_sms *sms =3D sms_msg->sms_mgr;
> +	DBG("%s (%p)\n", __func__, sms_msg);
> +	if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_QUEUED)
> +		g_queue_remove(sms->txq, sms_msg);
> +	else if (sms_msg->state =3D=3D OFONO_SMS_TX_ST_WSR)
> +		g_queue_remove(sms->tx_wsrq, sms_msg);
> +	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELING);
> +	if (flags & SMS_MSG_CANCEL_IN_NETWORK)
> +		ofono_warn("%s(): SMS_MSG_CANCEL_IN_NETWORK support "
> +			   "not yet implemented\n", __func__);
> +	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_CANCELLED);
> +	tx_queue_entry_destroy_free(sms_msg, NULL);
> +}
> +
> +

And again ignoring the coding standard...

Regards,
-Denis

--===============9151632205209198266==--

