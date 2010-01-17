Content-Type: multipart/mixed; boundary="===============5265267389210539121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Sun, 17 Jan 2010 16:50:53 -0600
Message-ID: <201001171650.53252.denkenz@gmail.com>
In-Reply-To: <1263749312-6567-4-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5265267389210539121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> diff --git a/drivers/stemodem/network-registration.c
>  b/drivers/stemodem/network-registration.c new file mode 100644
> index 0000000..4eeb239
> --- /dev/null
> +++ b/drivers/stemodem/network-registration.c
> +static void ciev_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_netreg *netreg =3D user_data;
> +	int strength, ind;
> +	GAtResultIter iter;
> +
> +	dump_response("ciev_notify", TRUE, result);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CIEV:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &ind))
> +		return;
> +
> +	if (ind =3D=3D 2) { /* signal strength indication */
> +		if (!g_at_result_iter_next_number(&iter, &strength))
> +			return;
> +
> +		strength =3D (strength * 100) / 5;
> +		ofono_netreg_strength_notify(netreg, strength);
> +	}
> +}
> +
> +static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_netreg_strength_cb_t cb =3D cbd->cb;
> +	int strength;
> +	GAtResultIter iter;
> +	struct ofono_error error;
> +
> +	dump_response("cind_cb", ok, result);
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, -1, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CIND:")) {
> +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		return;
> +	}
> +
> +	/* Skip battery charge level, which is the first reported  */
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_next_number(&iter, &strength);
> +
> +	strength =3D (strength * 100) / 5;
> +
> +	cb(&error, strength, cbd->data);
> +}
> +
> +static void ste_signal_strength(struct ofono_netreg *netreg,
> +				ofono_netreg_strength_cb_t cb, void *data)
> +{
> +	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	if (!cbd)
> +		goto error;
> +
> +	if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
> +				cind_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	if (cbd)
> +		g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, data);
> +}

I really prefer the above to be integrated into drivers/atmodem/network-
registration.c and quirked.  There are many modems that will need this (MBM =

modems in particular.)

> +
> +static void creg_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_netreg *netreg =3D user_data;
> +	GAtResultIter iter;
> +	int status;
> +	int lac =3D -1, ci =3D -1, tech =3D -1;
> +	const char *str;
> +
> +	dump_response("creg_notify", TRUE, result);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CREG:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
> +		lac =3D strtol(str, NULL, 16);
> +	else
> +		goto out;
> +
> +	if (g_at_result_iter_next_string(&iter, &str) =3D=3D TRUE)
> +		ci =3D strtol(str, NULL, 16);
> +	else
> +		goto out;
> +
> +	g_at_result_iter_next_number(&iter, &tech);
> +
> +out:
> +	ofono_debug("creg_notify: %d, %d, %d, %d", status, lac, ci, tech);
> +
> +	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
> +}

What is different about this function from the regular CREG unsolicited par=
ser =

in drivers/atmodem/atutil.c at_util_parse_reg_unsolicited?

> +
> +	g_at_chat_register(nd->chat, "+CIEV:",
> +				ciev_notify, FALSE, netreg, NULL);

Move this to drivers/atmodem/network-registration.c and quirk it.

> +static int ste_netreg_probe(struct ofono_netreg *netreg, unsigned int
>  vendor, +				void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct netreg_data *nd;
> +
> +	nd =3D g_new0(struct netreg_data, 1);
> +
> +	nd->chat =3D chat;
> +	ofono_netreg_set_data(netreg, nd);
> +
> +	g_at_chat_send(chat, "AT+CMER=3D3,0,0,1", NULL, NULL, NULL, NULL);

Same as above.

> +
> +	g_at_chat_send(chat, "AT+CREG=3D2", NULL,
> +				ste_network_registration_initialized,
> +				netreg, NULL);

Assuming STE modems support AT+CREG=3D?, the atmodem netreg driver should t=
ake =

care of this properly as well.  With these changes you no longer need a =

dedicated stemodem driver for netreg or the ofono_netreg_driver_get part.

> +++ b/drivers/stemodem/voicecall.c
> +static gint call_compare(gconstpointer a, gconstpointer b)
> +{
> +	const struct ofono_call *ca =3D a;
> +	const struct ofono_call *cb =3D b;
> +
> +	if (ca->id < cb->id)
> +		return -1;
> +
> +	if (ca->id > cb->id)
> +		return 1;
> +
> +	return 0;
> +}

Please use at_util_call_compare

> +
> +static gint call_compare_by_id(gconstpointer a, gconstpointer b)
> +{
> +	const struct ofono_call *call =3D a;
> +	unsigned int id =3D GPOINTER_TO_UINT(b);
> +
> +	if (id < call->id)
> +		return -1;
> +
> +	if (id > call->id)
> +		return 1;
> +
> +	return 0;
> +}

You might find that you simply don't need this function, but if you do, ple=
ase =

add it to atutil.c

> +static void ste_release_specific(struct ofono_voicecall *vc, int id,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
> +	char buf[32];
> +	struct ofono_call *call;
> +	GSList *l;
> +	int ac =3D 0;
> +
> +	if (!req)
> +		goto error;
> +
> +	req->vc =3D vc;
> +	req->cb =3D cb;
> +	req->data =3D data;
> +	req->id =3D id;
> +
> +	/* Count active calls. If there is more than one active call
> +	 * we cannot use ATH, as it will terminate all calls.
> +	 * The reason for using ATH and not CHLD is that
> +	 * emergency calls can not be terminated with AT+CHLD.
> +	 */
> +	for (l =3D vd->calls; l; l =3D l->next) {
> +		call =3D l->data;
> +
> +		if (call->status =3D=3D CALL_STATUS_ACTIVE)
> +			ac++;
> +	}
> +
> +	l =3D g_slist_find_custom(vd->calls, GUINT_TO_POINTER(id),
> +				call_compare_by_id);
> +	if (l =3D=3D NULL) {
> +		ofono_error("Hangup request for unknow call");
> +		goto error;
> +	}
> +	call =3D l->data;
> +	/* Check the state of the call, as AT+CHLD does not terminate
> +	 * calls in state Dialing, Alerting and Incoming */
> +	if (call->status =3D=3D CALL_STATUS_DIALING ||
> +	    call->status =3D=3D CALL_STATUS_ALERTING ||
> +	    call->status =3D=3D CALL_STATUS_INCOMING)
> +		sprintf(buf, "ATH");
> +
> +	/* Waiting call can not be terminated by at+chld=3D1x,
> +	 * have to use at+chld =3D 0, but that will also terminate
> +	 * other held calls. Bug in STE's AT module.
> +	 */
> +	else if (call->status =3D=3D CALL_STATUS_WAITING)
> +		sprintf(buf, "AT+CHLD=3D0");
> +
> +	else {
> +		/* A held call can not be released by ATH, need to use CHLD */
> +		if (ac > 1 || call->status =3D=3D CALL_STATUS_HELD)
> +			sprintf(buf, "AT+CHLD=3D1%d", id);
> +		else /* This is the last call, ok to use ATH. */
> +			sprintf(buf, "ATH");
> +	}
> +
> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
> +				release_id_cb, req, g_free) > 0)
> +		return;
> +
> +error:
> +	if (req)
> +		g_free(req);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}

All of this logic needs to go away.  The core already handles all of this, =

including selection of ATH/CHLD, waiting/held.  Please review src/voicecall=
.c.  =

If the core logic is not sufficient or does not properly handle a certain c=
ase, =

then lets see if we can fix the core first.  Drivers should not concern =

themselves with this stuff.

With this in mind, you might not need to track any state in this driver at =

all.  See drivers/calypsomodem/voicecall.c for details. TI's CPI notificati=
ons =

are almost exactly the same as the STE ECAV.

--===============5265267389210539121==--

