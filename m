Content-Type: multipart/mixed; boundary="===============5087621955116598578=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: A way of polling SIM status 
Date: Tue, 19 Oct 2010 12:41:23 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805CEE378@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5087621955116598578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =


Due to some other tasks, it a long time did not take part in the
discussion
Here.  I see there are much discussion about how to polling SIM status. =


Maybe we can start to polling the SIM status with AT+CPIN? when the
probe
 function of SIM atom driver is invoke. If it return  +CME: 10  or +CME:
SIM not
 inserted. It means there is no SIM inserted. If it return other result,
invoke =

ofono_sim_register register the APIs first and then waiting user input
password
(if password is required) or notify SIM is ready(if SIM is ready).

Following are the proposed implementation:

static ofono_bool_t sim_status_poll(void *user_data)
{
	if(!user_data)
		return FALSE;

	struct ofono_sim *sim =3D user_data;
	struct sim_data *ud =3D ofono_sim_get_data(sim);
	=

	g_at_chat_send(ud->chat, "AT+CPIN?", cpin_prefix,
					sim_status_cb, sim, NULL);
	return FALSE;
}
	=

static void sim_status_cb(gboolean ok, GAtResult *result, gpointer
user_data)
{
	struct ofono_sim *sim =3D user_data;
	GAtResultIter iter;
	struct ofono_error error;
	const char *pin_required;
	=

	const char *final =3D g_at_result_final_response(result);

	decode_at_error(&error, final);
	if(error.type =3D=3D OFONO_ERROR_TYPE_CME && error.error =3D=3D 10)
		return;  /* SIM is not inserted */
	=

	if (!ok)  {
		g_timeout_add_seconds(5, sim_status_poll, sim);
		return;
	}
	=

	g_at_result_iter_init(&iter, result);

	if (!g_at_result_iter_next(&iter, "+CPIN:"))  /* fatal error,
should not occur */
			return;

	g_at_result_iter_next_unquoted_string(&iter, &pin_required);

	ofono_bool_t ready =3D FALSE;
	if (!strcasecmp(pin_required,
at_sim_name[OFONO_SIM_PASSWORD_NONE].name))
		ready =3D TRUE;

	if( ofono_sim_get_state(sim) =3D=3D OFONO_SIM_STATE_NOT_PRESENT)  {
		ofono_sim_register(sim);
		ofono_sim_inserted_notify(sim, TRUE);
	}
	=

	if( ready )
		ofono_sim_set_ready(sim);
	else =

		g_timeout_add_seconds(5, sim_status_poll, sim);

}

static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
				void *data)
{
	GAtChat *chat =3D data;
	struct sim_data *ud;

	ud =3D g_new0(struct sim_data, 1);
	ud->chat =3D chat;
	ud->vendor =3D vendor;

	ofono_sim_set_data(sim, ud);

	g_at_chat_send(ud->chat, "AT+CPIN?", cpin_prefix,
					sim_status_cb, sim, NULL);

	return 0;
}

For modem that with SIM status unsolicited indication, should register
And monitor the SIM status at the same time.

Best regards
Caiwen

--===============5087621955116598578==--

