Content-Type: multipart/mixed; boundary="===============4736279893613693409=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 08:28:25 +0200
Message-ID: <cae21e96-7824-6e1c-7bb8-0d73b5139528@southpole.se>
In-Reply-To: <20181017045214.8771-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4736279893613693409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 17/10/18 06:52, Giacinto Cifelli wrote:
> Added voicecall atom specific for Gemalto modems.
> This atom uses the URC ^SLCC to monitor the call status, as well as
> incoming calls.
> Note the use in the atom of the variable GemaltoVtsQuotes: this is
> needed to support future modules, as of today not yet available in the
> plugin.
> ---
>   Makefile.am                         |   3 +-
>   drivers/gemaltomodem/gemaltomodem.c |   3 +
>   drivers/gemaltomodem/gemaltomodem.h |   6 +
>   drivers/gemaltomodem/voicecall.c    | 581 ++++++++++++++++++++++++++++
>   4 files changed, 592 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gemaltomodem/voicecall.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 6667524f..e8e4ed95 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -397,7 +397,8 @@ builtin_modules +=3D gemaltomodem
>   builtin_sources +=3D drivers/atmodem/atutil.h \
>   			drivers/gemaltomodem/gemaltomodem.h \
>   			drivers/gemaltomodem/gemaltomodem.c \
> -			drivers/gemaltomodem/location-reporting.c
> +			drivers/gemaltomodem/location-reporting.c \
> +			drivers/gemaltomodem/voicecall.c
>   =

>   builtin_modules +=3D xmm7modem
>   builtin_sources +=3D drivers/atmodem/atutil.h \
> diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/g=
emaltomodem.c
> index 91cf238a..4818ac66 100644
> --- a/drivers/gemaltomodem/gemaltomodem.c
> +++ b/drivers/gemaltomodem/gemaltomodem.c
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M

OK, this bugs me enough that I need to comment on it.=C2=A0 I find updating =

the copyright header for patches such as this to be _inappropriate_.

i)=C2=A0 The patch is trivial
ii)=C2=A0 If everyone who sends a patch updates the copyright header then w=
e =

end up with 300 lines of copyright header in every source file
iii)=C2=A0 The copyright header barely serves any purpose as it is; as long =

as there is _one_ copyright line in the source then the international =

conventions are applicable in all jurisdictions... i.e. there is never =

any legal reason to add a second copyright line and even the first one =

is mostly not necessary
iv)=C2=A0 Authorship and ownership are tracked in git in case there are eve=
r =

any issues
v)=C2=A0 The one thing that the line brings is a bit of credit to an actor =

who does _major_ work on the file in question, so it's ok to add a line =

if you want visible credit for a _significant_ contribution... a bit of =

free advertising for yourself.=C2=A0 But advertising comes at a cost, so th=
e =

contribution should be significant.

Anyway, that's my two bits worth...

>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -35,12 +36,14 @@
>   static int gemaltomodem_init(void)
>   {
>   	gemalto_location_reporting_init();
> +	gemalto_voicecall_init();
>   =

>   	return 0;
>   }
>   =

>   static void gemaltomodem_exit(void)
>   {
> +	gemalto_voicecall_exit();
>   	gemalto_location_reporting_exit();
>   }
>   =

> diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/g=
emaltomodem.h
> index 7ea1e8fb..c6667411 100644
> --- a/drivers/gemaltomodem/gemaltomodem.h
> +++ b/drivers/gemaltomodem/gemaltomodem.h
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M

Ick... consider what you are providing here:=C2=A0 function declarations.=
=C2=A0 =

What does copyright on this mean?

>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -20,6 +21,11 @@
>    */
>   =

>   #include <drivers/atmodem/atutil.h>
> +#include "gemaltoutil.h"
>   =

>   extern void gemalto_location_reporting_init();
>   extern void gemalto_location_reporting_exit();
> +
> +extern void gemalto_voicecall_init();
> +extern void gemalto_voicecall_exit();
> +

Why are these "extern"?

> diff --git a/drivers/gemaltomodem/voicecall.c b/drivers/gemaltomodem/voic=
ecall.c
> new file mode 100644
> index 00000000..8e2c7e10
> --- /dev/null
> +++ b/drivers/gemaltomodem/voicecall.c
> @@ -0,0 +1,581 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M

OK... here the copyright line feels appropriate.

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

What requires _GNU_SOURCE?

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
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct voicecall_data {
> +	GAtChat *chat;
> +	GSList *calls;
> +	unsigned int local_release;
> +	GSList *new_calls;
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
> +static void gemalto_call_common(const char *cmd, struct ofono_voicecall =
*vc,
> +			GAtResultFunc result_cb, unsigned int affected_types,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct change_state_req *req =3D g_new0(struct change_state_req, 1);
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
> +	g_free(req);
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void gemalto_answer(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	gemalto_call_common("ATA", vc, generic_cb, 0, cb, data);
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
> +	gemalto_call_common("AT+CHUP", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_hangup(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +
> +	/* Hangup current active call */
> +	gemalto_call_common("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_hold_all_active(struct ofono_voicecall *vc,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +	gemalto_call_common("AT+CHLD=3D2", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_release_all_held(struct ofono_voicecall *vc,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
> +				(1 << CALL_STATUS_WAITING);
> +
> +	gemalto_call_common("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_set_udub(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_INCOMING) |
> +				(1 << CALL_STATUS_WAITING);
> +
> +	gemalto_call_common("AT+CHLD=3D0", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_release_all_active(struct ofono_voicecall *vc,
> +					ofono_voicecall_cb_t cb, void *data)
> +{
> +	unsigned int affected =3D (1 << CALL_STATUS_ACTIVE);
> +
> +	gemalto_call_common("AT+CHLD=3D1", vc, generic_cb, affected, cb, data);
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
> +	struct release_id_req *req =3D g_new0(struct release_id_req, 1);
> +	char buf[32];
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
> +	g_free(req);
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void gemalto_private_chat(struct ofono_voicecall *vc, int id,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	char buf[32];
> +
> +	snprintf(buf, sizeof(buf), "AT+CHLD=3D2%d", id);
> +	gemalto_call_common(buf, vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_create_multiparty(struct ofono_voicecall *vc,
> +					ofono_voicecall_cb_t cb, void *data)
> +{
> +	gemalto_call_common("AT+CHLD=3D3", vc, generic_cb, 0, cb, data);
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
> +	gemalto_call_common("AT+CHLD=3D4", vc, generic_cb, affected, cb, data);
> +}
> +
> +static void gemalto_send_dtmf(struct ofono_voicecall *vc, const char *dt=
mf,
> +			ofono_voicecall_cb_t cb, void *data)
> +{
> +	int len =3D strlen(dtmf);
> +	int s;
> +	int i;
> +	char *buf;
> +	struct ofono_modem *modem =3D ofono_voicecall_get_modem(vc);
> +	int use_quotes =3D ofono_modem_get_integer(modem, "GemaltoVtsQuotes");
> +
> +	/* strlen("+VTS=3D\"T\";") =3D 9 + initial AT + null */
> +	buf =3D g_new(char, len * 9 + 3);

Use alloca() instead... currently you are leaking buf.
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
> +	gemalto_call_common(buf, vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_dial(struct ofono_voicecall *vc,
> +			const struct ofono_phone_number *ph,
> +			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
> +			void *data)
> +{
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[256];
> +	size_t len;
> +
> +	cbd->user =3D vc;
> +
> +	if (ph->type =3D=3D 145)
> +		len =3D snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
> +	else
> +		len =3D snprintf(buf, sizeof(buf), "ATD%s", ph->number);
> +
> +	switch (clir) {
> +	case OFONO_CLIR_OPTION_INVOCATION:
> +		len +=3D snprintf(buf+len, sizeof(buf)-len, "I");
> +		break;
> +	case OFONO_CLIR_OPTION_SUPPRESSION:
> +		len +=3D snprintf(buf+len, sizeof(buf)-len, "i");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	snprintf(buf+len, sizeof(buf)-len, ";");
> +
> +	gemalto_call_common(buf, vc, generic_cb, 0, cb, data);
> +}
> +
> +static void gemalto_parse_slcc(GAtResult *result, GSList **l,
> +				ofono_bool_t *ret_mpty, gboolean *last)
> +{
> +	GAtResultIter iter;
> +	int id, dir, status, type;
> +	ofono_bool_t mpty;
> +	struct ofono_call *call;
> +	const char *str =3D "";
> +	int number_type =3D 129;
> +
> +	if (last)
> +		*last =3D TRUE;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	g_at_result_iter_next(&iter, "^SLCC:");
> +
> +	if (!g_at_result_iter_next_number(&iter, &id))
> +		return;
> +
> +	if (last)
> +		*last =3D FALSE;
> +
> +	if (id =3D=3D 0)
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &dir))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
> +		return;
> +
> +	if (status > 5)
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &type))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &mpty))
> +		return;
> +
> +	/* skip 'Reserved=3D0' parameter, only difference from CLCC */
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (g_at_result_iter_next_string(&iter, &str))
> +		g_at_result_iter_next_number(&iter, &number_type);
> +
> +	call =3D g_new0(struct ofono_call, 1);
> +	ofono_call_init(call);
> +	call->id =3D id;
> +	call->direction =3D dir;
> +	call->status =3D status;
> +	call->type =3D type;
> +	strncpy(call->phone_number.number, str,
> +			OFONO_MAX_PHONE_NUMBER_LENGTH);
> +	call->phone_number.type =3D number_type;
> +
> +	if (strlen(str) > 0)
> +		call->clip_validity =3D 2;
> +	else
> +		call->clip_validity =3D 0;
> +
> +	*l =3D g_slist_insert_sorted(*l, call, at_util_call_compare);
> +
> +	if (ret_mpty)
> +		*ret_mpty =3D mpty;
> +
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
> +}
> +
> +/*
> + * ^SLCC, except for one RFU parameter (see above in the parsing), is id=
entical
> + * to +CLCC, but as URC it is parsed line by line, and the last line is
> + * indicated by an empty "^SLCC:" (equivalent to the "OK" for CLCC).
> + */
> +static void slcc_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GSList *n, *o;
> +	struct ofono_call *nc, *oc;
> +	gboolean last;
> +
> +	gemalto_parse_slcc(result, &vd->new_calls, NULL, &last);
> +
> +	if (!last)
> +		return;
> +
> +	n =3D vd->new_calls;
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
> +
> +			DBG("modify call part");
> +
> +			/* notify in case of changes */
> +			if (memcmp(nc, oc, sizeof(*nc)))
> +				ofono_voicecall_notify(vc, nc);
> +
> +			n =3D n->next;
> +			o =3D o->next;
> +		}
> +	}
> +
> +	g_slist_free_full(vd->calls, g_free);
> +	vd->calls =3D vd->new_calls;
> +	vd->new_calls =3D NULL;
> +	vd->local_release =3D 0;
> +}
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
> +	vd =3D g_new0(struct voicecall_data, 1);
> +	vd->chat =3D g_at_chat_clone(chat);
> +	ofono_voicecall_set_data(vc, vd);
> +	g_at_chat_send(vd->chat, "AT+CSSN=3D1,1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(vd->chat, "AT^SLCC=3D1", NULL,
> +			gemalto_voicecall_initialized, vc, NULL);
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

Are other drivers explicit about _not_ providing implementations? I'd =

drop these otherwise?

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


--===============4736279893613693409==--

