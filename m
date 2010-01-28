Content-Type: multipart/mixed; boundary="===============2907146313466472292=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: FW: [RFC 3/3] STE-plugin: Adding STE plugin
Date: Thu, 28 Jan 2010 11:38:57 +0100
Message-ID: <61D8D34BB13CFE408D154529C120E0790326B437@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2907146313466472292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.

Denis Kenzior <denkenz@gmail.com> wrote:
>> +static void ste_release_specific(struct ofono_voicecall *vc, int id,
>> +				ofono_voicecall_cb_t cb, void *data) {
>> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>> +	struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
>> +	char buf[32]; +	struct ofono_call *call;
>> +	GSList *l;
>> +	int ac =3D 0;
>> +
>> +	if (!req)
>> +		goto error;
>> +
>> +	req->vc =3D vc;
>> +	req->cb =3D cb;
>> +	req->data =3D data;
>> +	req->id =3D id;
>> +
>> +	/* Count active calls. If there is more than one active call
>> +	 * we cannot use ATH, as it will terminate all calls.
>> +	 * The reason for using ATH and not CHLD is that
>> +	 * emergency calls can not be terminated with AT+CHLD. +	 */
>> +	for (l =3D vd->calls; l; l =3D l->next) {
>> +		call =3D l->data;
>> +
>> +		if (call->status =3D=3D CALL_STATUS_ACTIVE)
>> +			ac++;
>> +	}
>> +
>> +	l =3D g_slist_find_custom(vd->calls, GUINT_TO_POINTER(id),
>> +				call_compare_by_id); +	if (l =3D=3D NULL) {
>> +		ofono_error("Hangup request for unknow call");
>> +		goto error;
>> +	}
>> +	call =3D l->data;
>> +	/* Check the state of the call, as AT+CHLD does not terminate
>> +	 * calls in state Dialing, Alerting and Incoming */
>> +	if (call->status =3D=3D CALL_STATUS_DIALING ||
>> +	    call->status =3D=3D CALL_STATUS_ALERTING ||
>> +	    call->status =3D=3D CALL_STATUS_INCOMING)
>> +		sprintf(buf, "ATH");
>> +
>> +	/* Waiting call can not be terminated by at+chld=3D1x,
>> +	 * have to use at+chld =3D 0, but that will also terminate
>> +	 * other held calls. Bug in STE's AT module.
>> +	 */
>> +	else if (call->status =3D=3D CALL_STATUS_WAITING)
>> +		sprintf(buf, "AT+CHLD=3D0");
>> +
>> +	else {
>> +		/* A held call can not be released by ATH, need to use CHLD */
>> +		if (ac > 1 || call->status =3D=3D CALL_STATUS_HELD)
>> +			sprintf(buf, "AT+CHLD=3D1%d", id);
>> +		else /* This is the last call, ok to use ATH. */ =

>> +			sprintf(buf,
>> "ATH"); +	}
>> +
>> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
>> +				release_id_cb, req, g_free) > 0)
>> +		return;
>> +
>> +error:
>> +	if (req)
>> +		g_free(req);
>> +
>> +	CALLBACK_WITH_FAILURE(cb, data);
>> +}
> =

> All of this logic needs to go away.  The core already handles all of =

> this, including selection of ATH/CHLD, waiting/held.  Please review =

> src/voicecall.c.
> If the core logic is not sufficient or does not properly handle a =

> certain case, then lets see if we can fix the core first.  Drivers =

> should not concern themselves with this stuff.

OK, we can remove the state logic, but STE modem cannot terminate
calls in state DIALING and ALERTING with CHLD=3D1X. We need to use =

ATH (or AT+CHUP) instead.

For now I think we will remove the state logic from ste_release_specific as =

you suggest. Terminating calls in state DIALING and ALERTING must then be  =

handled by the Core part. The simplest would probably be to use hangup in =

this case, but I suspect hangup work differently for different modems.
So if you cannot use hangup as the general approach, maybe it could be =

implemented by adding callback functions release_dialing and release_alerti=
ng =

in struct ofono_voicecall_driver. The STE driver could send ATH from =

release_dialing and release_alerting, other drivers could leave them empty
and this could default to use release_specific instead?

> =

> With this in mind, you might not need to track any state in this =

> driver at all.  See drivers/calypsomodem/voicecall.c for details.
> TI's CPI notifications are almost exactly the same as the STE ECAV.  =


The STE ECAV update is giving delta updates on the state information, =

right now I don't see how we can get the ofono_voicall_notify right =

without keeping some state information in ecav_notify. =



BR/Sjur

--===============2907146313466472292==--

