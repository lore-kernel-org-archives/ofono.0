Content-Type: multipart/mixed; boundary="===============6190558975650546014=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] isi: fix handling of incoming/waiting calls
Date: Mon, 08 Nov 2010 14:18:35 -0600
Message-ID: <4CD85B1B.9070703@gmail.com>
In-Reply-To: <1289245785-1640-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190558975650546014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/08/2010 01:49 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Isimodem driver reports the mobile-terminated call as soon as possible,
> however, it is not possible to answer a call before it is in
> "MT-ALERTING" or "WAITING" state.
> =

> Also, report the state of an early mobile-terminated call to the core as
> "waiting" or "incoming", depending on the state of the other calls.
> ---
>  drivers/isimodem/voicecall.c |  121 ++++++++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 108 insertions(+), 13 deletions(-)
> =

> diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
> index c3365f6..511c38e 100644
> --- a/drivers/isimodem/voicecall.c
> +++ b/drivers/isimodem/voicecall.c
> @@ -65,8 +65,10 @@ struct isi_voicecall {
>  static void isi_call_notify(struct ofono_voicecall *ovc,
>  				struct isi_call *call);
>  static void isi_call_release(struct ofono_voicecall *, struct isi_call *=
);
> -static struct ofono_call isi_call_as_ofono_call(struct isi_call const *);
> -static int isi_call_status_to_clcc(struct isi_call const *call);
> +static struct ofono_call isi_call_as_ofono_call(struct isi_voicecall con=
st *,
> +						struct isi_call const *);
> +static int isi_call_status_to_clcc(struct isi_voicecall const *,
> +					struct isi_call const *);

Is there really a need for all these forward declarations?  Try to avoid
these whenever possible.  Also, the general convention so far has been
to use const struct foo *, not struct foo const *.  They are equivalent,
but people with non-C++ background are typically more used to the first one.

>  static struct isi_call *isi_call_set_idle(struct isi_call *call);
>  =

>  typedef void GIsiIndication(GIsiClient *client,
> @@ -97,12 +99,30 @@ typedef void isi_call_req_step(struct isi_call_req_co=
ntext *, int reason);
>  struct isi_call_req_context {
>  	struct isi_call_req_context *next, **prev;
>  	isi_call_req_step *step;
> +	int id;
>  	struct ofono_voicecall *ovc;
>  	ofono_voicecall_cb_t cb;
>  	void *data;
>  };
>  =

>  static struct isi_call_req_context *
> +isi_call_req_context_new(struct ofono_voicecall *ovc,
> +				ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct isi_call_req_context *irc;
> +
> +	irc =3D g_try_new0(struct isi_call_req_context, 1);
> +
> +	if (irc) {
> +		irc->ovc =3D ovc;
> +		irc->cb =3D cb;
> +		irc->data =3D data;
> +	}
> +
> +	return irc;
> +}
> +
> +static struct isi_call_req_context *
>  isi_call_req(struct ofono_voicecall *ovc,
>  		void const *restrict req,
>  		size_t len,
> @@ -135,7 +155,8 @@ isi_call_req(struct ofono_voicecall *ovc,
>  }
>  =

>  static void isi_ctx_queue(struct isi_call_req_context *irc,
> -				isi_call_req_step *next)
> +				isi_call_req_step *next,
> +				int id)
>  {
>  	if (irc->prev =3D=3D NULL) {
>  		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(irc->ovc);
> @@ -149,6 +170,7 @@ static void isi_ctx_queue(struct isi_call_req_context=
 *irc,
>  	}
>  =

>  	irc->step =3D next;
> +	irc->id =3D id;
>  }
>  =

>  static void isi_ctx_remove(struct isi_call_req_context *irc)
> @@ -503,18 +525,65 @@ static void isi_call_status_ind_cb(GIsiClient *clie=
nt,
>  	isi_call_notify(ovc, call);
>  }
>  =

> +static void isi_wait_incoming(struct isi_call_req_context *irc, int even=
t);
> +

And another forward declaration of a static function...

>  static struct isi_call_req_context *
>  isi_call_answer_req(struct ofono_voicecall *ovc,
>  			uint8_t call_id, ofono_voicecall_cb_t cb, void *data)
>  {
> +	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
> +
>  	uint8_t const req[] =3D {
>  		CALL_ANSWER_REQ, call_id, 0
>  	};
>  	size_t rlen =3D sizeof req;
>  =

> +	int id =3D 0;

why do you bother initializing this variable here? You're
re-initializing it again 2 lines down.  Please see doc/coding-style.txt
item M7.

> +
> +	for (id =3D 1; id <=3D 7; id++) {
> +		if ((ivc->calls[id].status =3D=3D CALL_STATUS_PROCEEDING ||
> +				ivc->calls[id].status =3D=3D CALL_STATUS_COMING) &&
> +			(ivc->calls[id].mode_info & CALL_MODE_ORIGINATOR))
> +			break;

Please see coding-style.txt item M4.

> +	}
> +
> +	if (id <=3D 7) {
> +		struct isi_call_req_context *irc;
> +		irc =3D isi_call_req_context_new(ovc, cb, data);
> +		if (irc) {
> +			isi_ctx_queue(irc, isi_wait_incoming, id);
> +			return irc;
> +		}
> +	}
> +

This code might be easier to follow if you move the if condition into
the for loop above and use a continue statement as needed.

>  	return isi_call_req(ovc, req, rlen, isi_call_answer_resp, cb, data);
>  }
>  =

> +static void isi_wait_incoming(struct isi_call_req_context *irc,
> +				int event)
> +{
> +	struct isi_voicecall *ivc;
> +
> +	DBG("irc=3D%p event=3D%u", (void *)irc, event);
> +
> +	switch (event) {
> +	case CALL_STATUS_MT_ALERTING:
> +	case CALL_STATUS_WAITING:
> +		isi_call_answer_req(irc->ovc, CALL_ID_ALL, irc->cb, irc->data);
> +		isi_ctx_free(irc);
> +		return;
> +	}
> +
> +	ivc =3D ofono_voicecall_get_data(irc->ovc);
> +	switch (ivc->calls[irc->id].status) {

Rule M2 applies here as well.

> +	case CALL_STATUS_MO_RELEASE:
> +	case CALL_STATUS_MT_RELEASE:
> +	case CALL_STATUS_TERMINATED:
> +	case CALL_STATUS_IDLE:
> +		isi_ctx_return_failure(irc);
> +	}
> +}
> +
>  static gboolean isi_call_answer_resp(GIsiClient *client,
>  					void const *restrict data,
>  					size_t len,
> @@ -830,11 +899,11 @@ static void isi_call_notify(struct ofono_voicecall =
*ovc,
>  		return;
>  	}
>  =

> -	ocall =3D isi_call_as_ofono_call(call);
> +	ocall =3D isi_call_as_ofono_call(ivc, call);
>  =

> -	DBG("id=3D%u,%s,%u,\"%s\",%u,%u",
> +	DBG("id=3D%u,\"%s\",%u,\"%s\",%u,%u",
>  		ocall.id,
> -		ocall.direction ? "terminated" : "originated",
> +		ocall.direction ? "mt" : "mo",
>  		ocall.status,
>  		ocall.phone_number.number,
>  		ocall.phone_number.type,
> @@ -875,14 +944,15 @@ static void isi_call_release(struct ofono_voicecall=
 *ovc,
>  		isi_call_set_idle(call);
>  }
>  =

> -static struct ofono_call isi_call_as_ofono_call(struct isi_call const *c=
all)
> +static struct ofono_call isi_call_as_ofono_call(struct isi_voicecall con=
st *ivc,
> +						struct isi_call const *call)
>  {
>  	struct ofono_call ocall =3D { call->id };
>  	struct ofono_phone_number *number =3D &ocall.phone_number;
>  =

>  	ocall.type =3D 0;	/* Voice call */
>  	ocall.direction =3D call->mode_info & CALL_MODE_ORIGINATOR;
> -	ocall.status =3D isi_call_status_to_clcc(call);
> +	ocall.status =3D isi_call_status_to_clcc(ivc, call);
>  	memcpy(number->number, call->address, sizeof number->number);
>  	number->type =3D 0x80 | call->addr_type;
>  	ocall.clip_validity =3D call->presentation & 3;
> @@ -892,17 +962,41 @@ static struct ofono_call isi_call_as_ofono_call(str=
uct isi_call const *call)
>  	return ocall;
>  }
>  =

> +static int isi_call_waiting_or_incoming(struct isi_voicecall const *ivc,
> +					struct isi_call const *call)
> +{
> +	int id =3D 0;

And again, rule M7 being broken

> +
> +	for (id =3D 1; id <=3D 7; id++) {
> +		switch (ivc->calls[id].status) {
> +		case CALL_STATUS_ANSWERED:
> +		case CALL_STATUS_ACTIVE:
> +		case CALL_STATUS_MO_RELEASE:
> +		case CALL_STATUS_MT_RELEASE:
> +		case CALL_STATUS_HOLD_INITIATED:
> +		case CALL_STATUS_HOLD:
> +		case CALL_STATUS_RETRIEVE_INITIATED:
> +		case CALL_STATUS_RECONNECT_PENDING:
> +		case CALL_STATUS_SWAP_INITIATED:
> +			return 5; /* waiting */
> +		}
> +	}
> +

You don't use variable call at all here...

> +	return 4;		/* incoming */
> +}
> +
>  /** Get +CLCC status */
> -static int isi_call_status_to_clcc(struct isi_call const *call)
> +static int isi_call_status_to_clcc(struct isi_voicecall const *ivc,
> +					struct isi_call const *call)

You add a new parameter to this function to pass into the target
function, but end up not using it in the target.  Hmm... ;)

>  {
>  	switch (call->status) {
>  	case CALL_STATUS_CREATE:
>  		return 2;
>  	case CALL_STATUS_COMING:
> -		return 4;
> +		return isi_call_waiting_or_incoming(ivc, call);
>  	case CALL_STATUS_PROCEEDING:
>  		if ((call->mode_info & CALL_MODE_ORIGINATOR))
> -			return 4; /* MT */
> +			return isi_call_waiting_or_incoming(ivc, call); /* MT */
>  		else
>  			return 2; /* MO */
>  	case CALL_STATUS_MO_ALERTING:
> @@ -1072,9 +1166,9 @@ static void isi_release_all_active(struct ofono_voi=
cecall *ovc,
>  		if (irc =3D=3D NULL)
>  			;
>  		else if (waiting)
> -			isi_ctx_queue(irc, isi_wait_and_answer);
> +			isi_ctx_queue(irc, isi_wait_and_answer, 0);
>  		else if (hold)
> -			isi_ctx_queue(irc, isi_wait_and_retrieve);
> +			isi_ctx_queue(irc, isi_wait_and_retrieve, 0);
>  	} else
>  		CALLBACK_WITH_FAILURE(cb, data);
>  }
> @@ -1149,6 +1243,7 @@ static void isi_release_specific(struct ofono_voice=
call *ovc, int id,
>  		uint8_t cause =3D CALL_CAUSE_RELEASE_BY_USER;
>  =

>  		switch (status->status) {
> +		case CALL_STATUS_COMING:
>  		case CALL_STATUS_MT_ALERTING:
>  		case CALL_STATUS_WAITING:
>  			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;

Regards,
-Denis

--===============6190558975650546014==--

