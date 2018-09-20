Content-Type: multipart/mixed; boundary="===============6282346059303354793=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gemaltomodem: added voicecall atom
Date: Thu, 20 Sep 2018 17:33:27 -0500
Message-ID: <fb7bdfa5-309a-253f-66eb-a2621d0ac1df@gmail.com>
In-Reply-To: <1537414343-3705-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6282346059303354793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/19/2018 10:32 PM, Giacinto Cifelli wrote:
> ---
>   drivers/gemaltomodem/gemaltomodem.c |   3 +-
>   drivers/gemaltomodem/gemaltomodem.h |   3 +
>   drivers/gemaltomodem/voicecall.c    | 965 +++++++++++++++++++++++++++++=
+++++++
>   3 files changed, 970 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gemaltomodem/voicecall.c
> =

> diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/g=
emaltomodem.c
> index 91cf238..614ca81 100644
> --- a/drivers/gemaltomodem/gemaltomodem.c
> +++ b/drivers/gemaltomodem/gemaltomodem.c
> @@ -35,13 +35,14 @@
>   static int gemaltomodem_init(void)
>   {
>   	gemalto_location_reporting_init();
> -
> +	gemalto_voicecall_init();
>   	return 0;
>   }
>   =

>   static void gemaltomodem_exit(void)
>   {
>   	gemalto_location_reporting_exit();
> +	gemalto_voicecall_exit();
>   }
>   =

>   OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
> diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/g=
emaltomodem.h
> index 7ea1e8f..4e6ed16 100644
> --- a/drivers/gemaltomodem/gemaltomodem.h
> +++ b/drivers/gemaltomodem/gemaltomodem.h
> @@ -23,3 +23,6 @@
>   =

>   extern void gemalto_location_reporting_init();
>   extern void gemalto_location_reporting_exit();
> +
> +extern void gemalto_voicecall_init();
> +extern void gemalto_voicecall_exit();
> diff --git a/drivers/gemaltomodem/voicecall.c b/drivers/gemaltomodem/voic=
ecall.c
> new file mode 100644
> index 0000000..2a2af0d
> --- /dev/null
> +++ b/drivers/gemaltomodem/voicecall.c
> @@ -0,0 +1,965 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.

You might want to update this properly

> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/voicecall.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "common.h"
> +
> +#include "gemaltomodem.h"
> +
> +static const char *clcc_prefix[] =3D { "+CLCC:", NULL };

Why not use ^SLCC for everything?

> +static const char *none_prefix[] =3D { NULL };
> +
> +/* According to 27.007 COLP is an intermediate status for ATD */
> +static const char *atd_prefix[] =3D { "+COLP:", NULL };
> +

I question whether you need to pay attention to COLP give ^SLCC

> +#define FLAG_NEED_CLIP 1

And I doubt you need CLIP either

> +
> +struct voicecall_data {
> +	GAtChat *chat;
> +	GSList *calls;
> +	unsigned int local_release;
> +	unsigned int vendor;
> +	unsigned char flags;
> +};
> +
> +struct release_id_req {
> +	struct ofono_voicecall *vc;
> +	ofono_voicecall_cb_t cb;
> +	void *data;
> +	int id;
> +};
> +
> +struct change_state_req {
> +	struct ofono_voicecall *vc;
> +	ofono_voicecall_cb_t cb;
> +	void *data;
> +	int affected_types;
> +};
> +
> +static void generic_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct change_state_req *req =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (ok && req->affected_types) {
> +		GSList *l;
> +		struct ofono_call *call;
> +
> +		for (l =3D vd->calls; l; l =3D l->next) {
> +			call =3D l->data;
> +
> +			if (req->affected_types & (1 << call->status))
> +				vd->local_release |=3D (1 << call->id);
> +		}
> +	}
> +
> +	req->cb(&error, req->data);
> +}
> +
> +static void gemalto_template(const char *cmd, struct ofono_voicecall *vc,
> +			GAtResultFunc result_cb, unsigned int affected_types,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
> +
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->vc =3D vc;
> +	req->cb =3D cb;
> +	req->data =3D data;
> +	req->affected_types =3D affected_types;
> +
> +	if (g_at_chat_send(vd->chat, cmd, none_prefix,
> +				result_cb, req, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(req);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void gemalto_answer(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	gemalto_template("ATA", vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_hangup_all(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
> +				(1 << CALL_STATUS_DIALING) |
> +				(1 << CALL_STATUS_ALERTING) |
> +				(1 << CALL_STATUS_WAITING) |
> +				(1 << CALL_STATUS_HELD) |
> +				(1 << CALL_STATUS_ACTIVE);
> +
> +	/* Hangup all calls */
> +	gemalto_template("AT+CHUP", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_hangup(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +
> +	/* Hangup current active call */
> +	gemalto_template("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_hold_all_active(struct ofono_voicecall *vc,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +	gemalto_template("AT+CHLD=3D2", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_release_all_held(struct ofono_voicecall *vc,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
> +				(1 << CALL_STATUS_WAITING);
> +
> +	gemalto_template("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_set_udub(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
> +				(1 << CALL_STATUS_WAITING);
> +
> +	gemalto_template("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_release_all_active(struct ofono_voicecall *vc,
> +					ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +
> +	gemalto_template("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void release_id_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct release_id_req *req =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (ok)
> +		vd->local_release =3D 1 << req->id;
> +
> +	req->cb(&error, req->data);
> +}
> +
> +static void gemalto_release_specific(struct ofono_voicecall *vc, int id,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
> +	char buf[32];
> +
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->vc =3D vc;
> +	req->cb =3D cb;
> +	req->data =3D data;
> +	req->id =3D id;
> +
> +	snprintf(buf, sizeof(buf), "AT+CHLD=3D1%d", id);
> +
> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
> +				release_id_cb, req, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(req);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void gemalto_private_chat(struct ofono_voicecall *vc, int id,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	char buf[32];
> +
> +	snprintf(buf, sizeof(buf), "AT+CHLD=3D2%d", id);
> +	gemalto_template(buf, vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_create_multiparty(struct ofono_voicecall *vc,
> +					ofono_voicecall_cb_t cb, void *data)
> +{
> +	gemalto_template("AT+CHLD=3D3", vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_transfer(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	/* Held & Active */
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE) |
> +				(1 << CALL_STATUS_HELD);
> +
> +	/* Transfer can puts held & active calls together and disconnects
> +	 * from both.  However, some networks support transferring of
> +	 * dialing/ringing calls as well.
> +	 */
> +	affected |=3D (1 << CALL_STATUS_DIALING) |
> +				(1 << CALL_STATUS_ALERTING);
> +
> +	gemalto_template("AT+CHLD=3D4", vc, generic_cb, affected, cb, data);
> +}
> +

This all is pretty standard, so seems okay...

> +static void gemalto_send_dtmf(struct ofono_voicecall *vc, const char *dt=
mf,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	int len =3D strlen(dtmf);
> +	int s;
> +	int i;
> +	char *buf;
> +	struct ofono_modem *modem =3D ofono_voicecall_get_modem(vc);
> +	int use_quotes =3D ofono_modem_get_integer(modem, "Gemalto_VTS_quotes");
> +
> +	/* strlen("+VTS=3D\"T\";") =3D 9 + initial AT + null */
> +	buf =3D g_try_new(char, len * 9 + 3);
> +
> +	if (buf =3D=3D NULL) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}
> +
> +	if (use_quotes)
> +		s =3D sprintf(buf, "AT+VTS=3D\"%c\"", dtmf[0]);
> +	else
> +		s =3D sprintf(buf, "AT+VTS=3D%c", dtmf[0]);
> +
> +	for (i =3D 1; i < len; i++) {
> +
> +		if (use_quotes)
> +			s +=3D sprintf(buf + s, ";+VTS=3D\"%c\"", dtmf[i]);
> +		else
> +			s +=3D sprintf(buf + s, ";+VTS=3D%c", dtmf[i]);
> +	}
> +
> +	g_at_chat_send(vd->chat, buf, NULL, NULL, NULL, NULL);
> +	g_free(buf);
> +}
> +
> +static struct ofono_call *create_call(struct ofono_voicecall *vc, int ty=
pe,
> +					int direction, int status,
> +					const char *num, int num_type, int clip)
> +{
> +	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
> +	struct ofono_call *call;
> +
> +	/* Generate a call structure for the waiting call */
> +	call =3D g_try_new(struct ofono_call, 1);
> +	if (call =3D=3D NULL)
> +		return NULL;
> +
> +	ofono_call_init(call);
> +
> +	call->id =3D ofono_voicecall_get_next_callid(vc);
> +	call->type =3D type;
> +	call->direction =3D direction;
> +	call->status =3D status;
> +
> +	if (clip !=3D 2) {
> +		strncpy(call->phone_number.number, num,
> +			OFONO_MAX_PHONE_NUMBER_LENGTH);
> +		call->phone_number.type =3D num_type;
> +	}
> +
> +	call->clip_validity =3D clip;
> +	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
> +
> +	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare=
);
> +
> +	return call;
> +}
> +
> +static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	struct ofono_voicecall *vc =3D cbd->user;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	ofono_voicecall_cb_t cb =3D cbd->cb;
> +	GAtResultIter iter;
> +	const char *num;
> +	int type =3D 128;
> +	int validity =3D 2;
> +	struct ofono_error error;
> +	struct ofono_call *call;
> +	GSList *l;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok)
> +		goto out;
> +
> +	/* On a success, make sure to put all active calls on hold */
> +	for (l =3D vd->calls; l; l =3D l->next) {
> +		call =3D l->data;
> +
> +		if (call->status !=3D CALL_STATUS_ACTIVE)
> +			continue;
> +
> +		call->status =3D CALL_STATUS_HELD;
> +		ofono_voicecall_notify(vc, call);
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "+COLP:")) {
> +		g_at_result_iter_next_string(&iter, &num);
> +		g_at_result_iter_next_number(&iter, &type);
> +
> +		if (strlen(num) > 0)
> +			validity =3D 0;
> +		else
> +			validity =3D 2;
> +
> +		DBG("colp_notify: %s %d %d", num, type, validity);
> +	}
> +

Given that you have ^SLCC, do you need any of the above logic?  For =

example, see how simple things are inside drivers/stemodem/voicecall.c

> +	/* Generate a voice call that was just dialed, we guess the ID */
> +	call =3D create_call(vc, 0, 0, CALL_STATUS_DIALING, num, type, validity=
);
> +	if (call =3D=3D NULL) {
> +		ofono_error("Unable to malloc, call tracking will fail!");
> +		return;
> +	}
> +
> +	/* oFono core will generate a call with the dialed number
> +	 * inside its dial callback.  Unless we got COLP information
> +	 * we do not need to communicate that a call is being
> +	 * dialed
> +	 */
> +	if (validity !=3D 2)
> +		ofono_voicecall_notify(vc, call);

> +
> +out:
> +	cb(&error, cbd->data);
> +}
> +
> +static void gemalto_dial(struct ofono_voicecall *vc,
> +			const struct ofono_phone_number *ph,
> +			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[256];
> +
> +	cbd->user =3D vc;
> +
> +	if (ph->type =3D=3D 145)
> +		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
> +	else
> +		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
> +
> +	switch (clir) {
> +	case OFONO_CLIR_OPTION_INVOCATION:
> +		strcat(buf, "I");
> +		break;
> +	case OFONO_CLIR_OPTION_SUPPRESSION:
> +		strcat(buf, "i");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	strcat(buf, ";");
> +
> +	if (g_at_chat_send(vd->chat, buf, atd_prefix,
> +				atd_cb, cbd, g_free) > 0)
> +		return;
> +
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static GSList *gemalto_parse_slcc(GAtResult *result, unsigned int *ret_m=
pty_ids)
> +{
> +	GAtResultIter iter;
> +	GSList *l =3D NULL;
> +	int id, dir, status, type;
> +	ofono_bool_t mpty;
> +	struct ofono_call *call;
> +	unsigned int mpty_ids =3D 0;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CLCC:")) {

This looks wrong?

> +		const char *str =3D "";
> +		int number_type =3D 129;
> +
> +		if (!g_at_result_iter_next_number(&iter, &id))
> +			continue;
> +
> +		if (id =3D=3D 0)
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &dir))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &status))
> +			continue;
> +
> +		if (status > 5)
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &type))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &mpty))
> +			continue;
> +
> +		/* skip 'Reserved=3D0' parameter, only difference from CLCC */
> +		if (!g_at_result_iter_skip_next(&iter))
> +			continue;
> +
> +		if (g_at_result_iter_next_string(&iter, &str))
> +			g_at_result_iter_next_number(&iter, &number_type);
> +
> +		call =3D g_try_new(struct ofono_call, 1);
> +		if (call =3D=3D NULL)
> +			break;
> +
> +		ofono_call_init(call);
> +
> +		call->id =3D id;
> +		call->direction =3D dir;
> +		call->status =3D status;
> +		call->type =3D type;
> +		strncpy(call->phone_number.number, str,
> +				OFONO_MAX_PHONE_NUMBER_LENGTH);
> +		call->phone_number.type =3D number_type;
> +
> +		if (strlen(call->phone_number.number) > 0)
> +			call->clip_validity =3D 0;
> +		else
> +			call->clip_validity =3D 2;
> +
> +		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
> +
> +		if (mpty)
> +			mpty_ids |=3D 1 << id;
> +	}
> +
> +	if (ret_mpty_ids)
> +		*ret_mpty_ids =3D mpty_ids;
> +
> +	return l;
> +}
> +
> +static void clcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GSList *l;
> +
> +	if (!ok)
> +		return;
> +
> +	vd->calls =3D at_util_parse_clcc(result, NULL);
> +
> +	for (l =3D vd->calls; l; l =3D l->next)
> +		ofono_voicecall_notify(vc, l->data);

Okay, but don't you want to use ^SLCC?

> +}
> +
> +static void slcc_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GSList *calls;
> +	GSList *n, *o;
> +	struct ofono_call *nc, *oc;
> +
> +	calls =3D gemalto_parse_slcc(result, NULL);
> +
> +	n =3D calls;
> +	o =3D vd->calls;
> +
> +	while (n || o) {
> +		nc =3D n ? n->data : NULL;
> +		oc =3D o ? o->data : NULL;
> +
> +		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
> +			enum ofono_disconnect_reason reason;
> +
> +			if (vd->local_release & (1 << oc->id))
> +				reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
> +			else
> +				reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
> +
> +			if (!oc->type)
> +				ofono_voicecall_disconnected(vc, oc->id,
> +								reason, NULL);
> +
> +			o =3D o->next;
> +		} else if (nc && (oc =3D=3D NULL || (nc->id < oc->id))) {
> +
> +			if (nc->type =3D=3D 0) /* new call, signal it */
> +				ofono_voicecall_notify(vc, nc);
> +
> +			n =3D n->next;
> +		} else {
> +			/*
> +			 * Always use the clip_validity from old call
> +			 * the only place this is truly told to us is
> +			 * in the CLIP notify, the rest are fudged
> +			 * anyway.  Useful when RING, CLIP is used,
> +			 * and we're forced to use CLCC/SLCC and clip_validity
> +			 * is 1
> +			 */
> +			if (oc->clip_validity =3D=3D 1)
> +				nc->clip_validity =3D oc->clip_validity;
> +
> +			/*
> +			 * CNAP doesn't arrive as part of CLCC, always
> +			 * re-use from the old call
> +			 */
> +			strncpy(nc->name, oc->name,
> +					OFONO_MAX_CALLER_NAME_LENGTH);
> +			nc->name[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
> +			nc->cnap_validity =3D oc->cnap_validity;

You don't even use CNAP, so this logic is probably not useful?

> +
> +			/*
> +			 * CDIP doesn't arrive as part of CLCC, always
> +			 * re-use from the old call
> +			 */
> +			memcpy(&nc->called_number, &oc->called_number,
> +					sizeof(oc->called_number));
> +

And you don't use CDIP either

> +			/*
> +			 * If the CLIP is not provided and the CLIP never
> +			 * arrives, or RING is used, then signal the call
> +			 * here
> +			 */
> +			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
> +					(vd->flags & FLAG_NEED_CLIP)) {
> +				if (nc->type =3D=3D 0)
> +					ofono_voicecall_notify(vc, nc);
> +
> +				vd->flags &=3D ~FLAG_NEED_CLIP;
> +			} else if (memcmp(nc, oc, sizeof(*nc)) && nc->type =3D=3D 0)
> +				ofono_voicecall_notify(vc, nc);
> +

And if you don't use CLIP, then this can also be simplified

> +			n =3D n->next;
> +			o =3D o->next;
> +		}
> +	}
> +
> +	g_slist_free_full(vd->calls, g_free);
> +
> +	vd->calls =3D calls;
> +
> +	vd->local_release =3D 0;
> +}
> +
> +static void ring_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct ofono_call *call;
> +
> +	/* See comment in CRING */
> +	if (g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_WAITING),
> +				at_util_call_compare_by_status))
> +		return;
> +
> +	/* RING can repeat, ignore if we already have an incoming call */
> +	if (g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_INCOMING),
> +				at_util_call_compare_by_status))
> +		return;
> +
> +	/* Generate an incoming call of unknown type */
> +	call =3D create_call(vc, 9, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
> +	if (call =3D=3D NULL) {
> +		ofono_error("Couldn't create call!");
> +		return;
> +	}
> +
> +	/* We don't know the call type, we must wait for the SLCC URC */
> +	vd->flags =3D FLAG_NEED_CLIP;
> +}
> +
> +static void cring_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	const char *line;
> +	int type;
> +
> +	/* Handle the following situation:
> +	 * Active Call + Waiting Call.  Active Call is Released.  The Waiting
> +	 * call becomes Incoming and RING/CRING indications are signaled.
> +	 * Sometimes these arrive before we get the SLCC URC to find about
> +	 * the stage change.  If this happens, simply ignore the RING/CRING
> +	 * when a waiting call exists (cannot have waiting + incoming in GSM)
> +	 */
> +	if (g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_WAITING),
> +				at_util_call_compare_by_status))
> +		return;
> +
> +	/* CRING can repeat, ignore if we already have an incoming call */
> +	if (g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_INCOMING),
> +				at_util_call_compare_by_status))
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CRING:"))
> +		return;
> +
> +	line =3D g_at_result_iter_raw_line(&iter);
> +	if (line =3D=3D NULL)
> +		return;
> +
> +	/* Ignore everything that is not voice for now */
> +	if (!strcasecmp(line, "VOICE"))
> +		type =3D 0;
> +	else
> +		type =3D 9;
> +
> +	/* Generate an incoming call */
> +	create_call(vc, type, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
> +
> +	/* We have a call, and call type but don't know the number and
> +	 * must wait for the CLIP to arrive before announcing the call.
> +	 * And we wait also for SLCC. If the CLIP arrives
> +	 * earlier, we announce the call there
> +	 */
> +	vd->flags =3D FLAG_NEED_CLIP;
> +
> +	DBG("");
> +}
> +
> +static void clip_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	const char *num;
> +	int type, validity;
> +	GSList *l;
> +	struct ofono_call *call;
> +
> +	l =3D g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_INCOMING),
> +				at_util_call_compare_by_status);
> +	if (l =3D=3D NULL) {
> +		ofono_error("CLIP for unknown call");
> +		return;
> +	}
> +
> +	/* We have already saw a CLIP for this call, no need to parse again */
> +	if ((vd->flags & FLAG_NEED_CLIP) =3D=3D 0)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CLIP:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_string(&iter, &num))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &type))
> +		return;
> +
> +	if (strlen(num) > 0)
> +		validity =3D CLIP_VALIDITY_VALID;
> +	else
> +		validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
> +
> +	/* Skip subaddr, satype and alpha */
> +	g_at_result_iter_skip_next(&iter);
> +	g_at_result_iter_skip_next(&iter);
> +	g_at_result_iter_skip_next(&iter);
> +
> +	/* If we have CLI validity field, override our guessed value */
> +	g_at_result_iter_next_number(&iter, &validity);
> +
> +	DBG("%s %d %d", num, type, validity);
> +
> +	call =3D l->data;
> +
> +	strncpy(call->phone_number.number, num,
> +		OFONO_MAX_PHONE_NUMBER_LENGTH);
> +	call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
> +	call->phone_number.type =3D type;
> +	call->clip_validity =3D validity;
> +
> +	if (call->type =3D=3D 0)
> +		ofono_voicecall_notify(vc, call);
> +
> +	vd->flags &=3D ~FLAG_NEED_CLIP;
> +}
> +

Isn't this information directly available from ^SLCC?  If so, there's no =

point in registering for CLIP/RING/CRING at all.

> +static int class_to_call_type(int cls)
> +{
> +	switch (cls) {
> +	case 1:
> +		return 0;
> +	case 4:
> +		return 2;
> +	case 8:
> +		return 9;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void ccwa_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GAtResultIter iter;
> +	const char *num;
> +	int num_type, validity, cls;
> +	struct ofono_call *call;
> +
> +	/* if CCWA is resent, ignore it the second time around */
> +	if (g_slist_find_custom(vd->calls,
> +				GINT_TO_POINTER(CALL_STATUS_WAITING),
> +				at_util_call_compare_by_status))
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CCWA:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_string(&iter, &num))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &num_type))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &cls))
> +		return;
> +
> +	/* Skip alpha field */
> +	g_at_result_iter_skip_next(&iter);
> +
> +	if (strlen(num) > 0)
> +		validity =3D 0;
> +	else
> +		validity =3D 2;
> +
> +	/* If we have CLI validity field, override our guessed value */
> +	g_at_result_iter_next_number(&iter, &validity);
> +
> +	DBG("%s %d %d %d", num, num_type, cls, validity);
> +
> +	call =3D create_call(vc, class_to_call_type(cls), 1, CALL_STATUS_WAITIN=
G,
> +				num, num_type, validity);
> +	if (call =3D=3D NULL) {
> +		ofono_error("Unable to malloc. Call management is fubar");
> +		return;
> +	}
> +
> +	if (call->type =3D=3D 0) /* Only notify voice calls */
> +		ofono_voicecall_notify(vc, call);
> +}

So why do you need this?  Can't you get this information directly from =

^SLCC?

> +
> +static void cssi_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	GAtResultIter iter;
> +	int code, index;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSSI:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &code))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &index))
> +		index =3D 0;
> +
> +	ofono_voicecall_ssn_mo_notify(vc, 0, code, index);
> +}
> +
> +static void cssu_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	GAtResultIter iter;
> +	int code;
> +	int index;
> +	const char *num;
> +	struct ofono_phone_number ph;
> +
> +	ph.number[0] =3D '\0';
> +	ph.type =3D 129;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSSU:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &code))
> +		return;
> +
> +	if (!g_at_result_iter_next_number_default(&iter, -1, &index))
> +		goto out;
> +
> +	if (!g_at_result_iter_next_string(&iter, &num))
> +		goto out;
> +
> +	strncpy(ph.number, num, OFONO_MAX_PHONE_NUMBER_LENGTH);
> +
> +	if (!g_at_result_iter_next_number(&iter, &ph.type))
> +		return;
> +
> +out:
> +	ofono_voicecall_ssn_mt_notify(vc, 0, code, index, &ph);
> +}

So maybe it is time to put CSSI/CSSU notifications into atutil, but I'm =

okay doing it later as well

> +
> +static void gemalto_voicecall_initialized(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +
> +	DBG("voicecall_init: registering to notifications");
> +
> +	/* NO CARRIER, NO ANSWER, BUSY, NO DIALTONE are handled through SLCC */
> +	g_at_chat_register(vd->chat, "^SLCC:", slcc_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+CSSI:", cssi_notify, FALSE, vc, NULL);
> +	g_at_chat_register(vd->chat, "+CSSU:", cssu_notify, FALSE, vc, NULL);
> +
> +	ofono_voicecall_register(vc);
> +
> +	/* Populate the call list */
> +	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_cb, vc, NULL);
> +}
> +
> +static int gemalto_voicecall_probe(struct ofono_voicecall *vc,
> +					unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct voicecall_data *vd;
> +
> +	vd =3D g_try_new0(struct voicecall_data, 1);
> +

No need to use g_try_new0.  Prefer g_new0.

> +	if (vd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	vd->chat =3D g_at_chat_clone(chat);
> +	vd->vendor =3D vendor;
> +	ofono_voicecall_set_data(vc, vd);
> +
> +	// TODO: move to a config atom
> +	g_at_chat_send(vd->chat, "AT^SNFS=3D5", NULL, NULL, NULL, NULL);
> +
> +	g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT+COLP=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT^SLCC=3D1", NULL,
> +				gemalto_voicecall_initialized, vc, NULL);
> +	return 0;
> +}
> +
> +static void gemalto_voicecall_remove(struct ofono_voicecall *vc)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +
> +	ofono_voicecall_set_data(vc, NULL);
> +
> +	g_at_chat_unref(vd->chat);
> +	g_free(vd);
> +}
> +
> +static struct ofono_voicecall_driver driver =3D {
> +	.name			=3D "gemaltomodem",
> +	.probe			=3D gemalto_voicecall_probe,
> +	.remove			=3D gemalto_voicecall_remove,
> +	.dial			=3D gemalto_dial,
> +	.answer			=3D gemalto_answer,
> +	.hangup_all		=3D gemalto_hangup_all,
> +	.hangup_active		=3D gemalto_hangup,
> +	.hold_all_active	=3D gemalto_hold_all_active,
> +	.release_all_held	=3D gemalto_release_all_held,
> +	.set_udub		=3D gemalto_set_udub,
> +	.release_all_active	=3D gemalto_release_all_active,
> +	.release_specific	=3D gemalto_release_specific,
> +	.private_chat		=3D gemalto_private_chat,
> +	.create_multiparty	=3D gemalto_create_multiparty,
> +	.transfer		=3D gemalto_transfer,
> +	.deflect		=3D NULL,
> +	.swap_without_accept	=3D NULL,
> +	.send_tones		=3D gemalto_send_dtmf
> +};
> +
> +void gemalto_voicecall_init(void)
> +{
> +	ofono_voicecall_driver_register(&driver);
> +}
> +
> +void gemalto_voicecall_exit(void)
> +{
> +	ofono_voicecall_driver_unregister(&driver);
> +}
> =


Regards,
-Denis

--===============6282346059303354793==--

