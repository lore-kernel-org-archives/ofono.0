Content-Type: multipart/mixed; boundary="===============3696553840908483865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/2] sms: status report notify
Date: Thu, 10 Jun 2010 10:07:24 -0500
Message-ID: <201006101007.24947.denkenz@gmail.com>
In-Reply-To: <1276153545-22260-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3696553840908483865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  include/history.h |    3 ++
>  src/sms.c         |   61
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++- 2 files =

changed, 63
>  insertions(+), 1 deletions(-)
> =

> diff --git a/include/history.h b/include/history.h
> index 300a4fb..61a0dea 100644
> --- a/include/history.h
> +++ b/include/history.h
> @@ -33,6 +33,9 @@ enum ofono_history_sms_status {
>  	OFONO_HISTORY_SMS_STATUS_PENDING,
>  	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
>  	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
> +	OFONO_HISTORY_SMS_STATUS_DELIVERED,
> +	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,

Please resubmit the above two lines as a separate patch.  I like to keep =

public API changes separate.

> +	OFONO_HISTORY_SMS_STATUS_ERROR,

Drop this change, lets modify status_report_assembly to do something differ=
ent.

>  };
> =

> +static void handle_sms_status_report(struct ofono_sms *sms,
> +						const struct sms *incoming)
> +{
> +	unsigned int msg_id;
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
> +
> +	if (incoming->status_report.st =3D=3D SMS_ST_COMPLETED_RECEIVED) {
> +
> +		if (status_report_assembly_report(sms->sr_assembly,
> +		incoming, &msg_id) =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVERED)
> +			__ofono_history_sms_send_status(modem, msg_id,
> +				time(NULL), OFONO_HISTORY_SMS_STATUS_DELIVERED);
> +	} else {
> +		status_report_assembly_report(sms->sr_assembly,
> +						incoming, &msg_id);

This looks a little ugly, let the status report assembly decide whether the =

message was delivered / failed.  So something like:

gboolean delivered;
unsigned int message_id;
gboolean update_history;

update_history =3D status_report_assembly_report(assembly, incoming, &msg_i=
d, =

&delivered);
if (update_history)
	...
> +		__ofono_history_sms_send_status(modem, msg_id, time(NULL),
> +				OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);

Otherwise patch looks good to me.

Regards,
-Denis

--===============3696553840908483865==--

