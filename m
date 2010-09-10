Content-Type: multipart/mixed; boundary="===============5475698007244253280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Supporting STK without PDUs
Date: Fri, 10 Sep 2010 16:38:34 -0500
Message-ID: <4C8AA55A.1090800@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145B3ED3@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5475698007244253280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> I propose to add a set of additional (optional) STK functions that a mode=
m plugin can chose to use/implement instead:
> =

> 	void (*envelope_parsed)(struct ofono_stk *stk,
> 		struct stk_envelope *e,
> 		ofono_stk_envelope_cb_t cb, void *data);
> 	/* if envelope_parsed is non-NULL then stk_send_envelope /
> 	   envelope_queue_run should call envelope_parsed(...) instead of
> 	   stk_pdu_from_envelope(...) + envelope(...)
> 	*/
> =

> 	void (*terminal_response_parsed)(struct ofono_stk *stk,
> 		struct stk_response *rsp,
> 		ofono_stk_generic_cb_t cb, void *data);
> 	/* if terminal_response_parsed is non-NULL then stk_respond()
> 	   should call terminal_response_parsed(...) instead of =

> 	   stk_pdu_from_response(...) + terminal_response(...)
> 	*/
> =

> 	void ofono_stk_proactive_command_parsed_notify(struct ofono_stk *stk,
> 		struct stk_command *command);
> 	/* ofono_stk_proactive_command_parsed_notify is like
> 	   ofono_stk_proactive_command_notify without the call to
> 	   stk_command_new_from_pdu(pdu, length);
> 	*/
> =

> Thoughts?

We have already had a discussion on this one when designing the current
stk modem API.  The bottom line is that oFono tries to keep its core <->
modem interfaces minimal and exposing the entirety of stkutil.h as
official API is definitely too much.

So right now you will need to re-encode into PDU form to support such
modems (or ask the vendor to give the raw pdus)  While this is a bit of
a performance hit, it isn't too bad as the PDUs are always smaller than
256 bytes.

Having said that, such 'pre-parsed' STK APIs are quite common.
Unfortunately they all behave differently, especially when it comes to
handling the more complex commands (e.g. Setup Call, etc)  We have been
kicking around some ideas on how to handle such modems.

Regards,
-Denis

--===============5475698007244253280==--

