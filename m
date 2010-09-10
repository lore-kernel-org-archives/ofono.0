Content-Type: multipart/mixed; boundary="===============1337305337349316970=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RFC: Supporting STK without PDUs
Date: Fri, 10 Sep 2010 13:14:28 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145B3ED3@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1337305337349316970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It looks like the preferred way to handle STK with IFX modems is to use a d=
edicated mode where the modem handles most of STK commands and only a few r=
emaining commands are passed on to the apps processor for further handling.

The draw back with oFono of this approach is that the commands that are bei=
ng passed on are passed on in a parsed form and not in the form of the orig=
inal PDU as expected by oFono.

For example, DISPLAY TEXT is notified with an URC as follow:
	+STKPRO: 33, <type>, <dcs>, <hex string>, <icon_id>

And the Terminal Response needs to be reported back with:
	AT+STKTR: 33, <result>, <add_result>

Another -worst case- example is SELECT ITEM:
	+STKPRO: 36, <type>, <alpha>, <item_id>, <total items>, <item_text>,
	<next_action>, <default_item>, <icon_id>, <icon_id_list_element>

And the expected Terminal Response:
	AT+STKTR: 36, <result>, <add_result>, 0, <dcs>, <hex_string>

With the current oFono/STK modem plugin interface the above can be supporte=
d by having the modem plugin re-generate a PDU (may not match the original =
exactly), only for oFono core to decode it again. And vice-versa for the te=
rminal response / envelope. This approach seems viable but would not be the=
 most efficient.

Instead I would like to propose an addition to the oFono/STK modem plugin i=
nterface so that the modem driver can just pass in a pre-parsed SAT command=
 structure.

So in addition to the existing STK functions in the modem plugin interface:

	void (*envelope)(struct ofono_stk *stk,
		int length, const unsigned char *command,
		ofono_stk_envelope_cb_t cb, void *data);
	void (*terminal_response)(struct ofono_stk *stk,
		int length, const unsigned char *resp,
		ofono_stk_generic_cb_t cb, void *data);

	void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
		int length, const unsigned char *pdu);

I propose to add a set of additional (optional) STK functions that a modem =
plugin can chose to use/implement instead:

	void (*envelope_parsed)(struct ofono_stk *stk,
		struct stk_envelope *e,
		ofono_stk_envelope_cb_t cb, void *data);
	/* if envelope_parsed is non-NULL then stk_send_envelope /
	   envelope_queue_run should call envelope_parsed(...) instead of
	   stk_pdu_from_envelope(...) + envelope(...)
	*/

	void (*terminal_response_parsed)(struct ofono_stk *stk,
		struct stk_response *rsp,
		ofono_stk_generic_cb_t cb, void *data);
	/* if terminal_response_parsed is non-NULL then stk_respond()
	   should call terminal_response_parsed(...) instead of =

	   stk_pdu_from_response(...) + terminal_response(...)
	*/

	void ofono_stk_proactive_command_parsed_notify(struct ofono_stk *stk,
		struct stk_command *command);
	/* ofono_stk_proactive_command_parsed_notify is like
	   ofono_stk_proactive_command_notify without the call to
	   stk_command_new_from_pdu(pdu, length);
	*/

Thoughts?

Cheers,
Waldo
-- =

Intel Corporation - Hillsboro, Oregon
Ultra Mobility Group - Platform Software Architecture
Tel: +1 503 264 6237 - Mobile: +1 503 703-7327

--===============1337305337349316970==--

