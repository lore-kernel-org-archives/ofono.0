Content-Type: multipart/mixed; boundary="===============8464960406660363247=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix sending User Cancel response to Set Up Call.
Date: Thu, 09 Sep 2010 09:37:28 -0500
Message-ID: <4C88F128.4040007@gmail.com>
In-Reply-To: <1283968796-5308-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464960406660363247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 09/08/2010 12:59 PM, Andrzej Zaborowski wrote:
> One of the clean-up commits changed the semantics of the dial request
> callback's parameter (NULL if call setup failed, non-NULL if success
> or user cancelled).
> ---
>  src/stk.c       |    2 +-
>  src/voicecall.c |   14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletions(-)
> =

> diff --git a/src/stk.c b/src/stk.c
> index b469467..b6ed4c3 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -1419,7 +1419,7 @@ static void call_setup_connected(struct ofono_call =
*call, void *data)
>  	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILUR=
E };
>  	static unsigned char facility_rejected_result[] =3D { 0x9d };
>  =

> -	if (!call) {
> +	if (!call || call->status =3D=3D CALL_STATUS_DISCONNECTED) {

If the call has been disconnected by the user, shouldn't we be sending
USER_CANCEL?  At least that is what the old behavior implies.

>  		memset(&rsp, 0, sizeof(rsp));
>  =

>  		rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
> diff --git a/src/voicecall.c b/src/voicecall.c
> index 3bd4dff..e536089 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -361,6 +361,16 @@ static DBusMessage *voicecall_deflect(DBusConnection=
 *conn,
>  	return NULL;
>  }
>  =

> +static void dial_request_user_cancel(struct ofono_voicecall *vc,
> +					struct voicecall *call)
> +{
> +	if (!vc->dial_req)
> +		return;
> +
> +	if (!call || call =3D=3D vc->dial_req->call)
> +		dial_request_finish(vc->dial_req->call->vc, TRUE);
> +}
> +
>  static DBusMessage *voicecall_hangup(DBusConnection *conn,
>  					DBusMessage *msg, void *data)
>  {
> @@ -372,6 +382,8 @@ static DBusMessage *voicecall_hangup(DBusConnection *=
conn,
>  	if (vc->pending)
>  		return __ofono_error_busy(msg);
>  =

> +	dial_request_user_cancel(vc, v);
> +

I don't see the need for this part, don't we already take care of this
in voicecall_set_call_status?

>  	switch (call->status) {
>  	case CALL_STATUS_DISCONNECTED:
>  		return __ofono_error_failed(msg);
> @@ -1278,6 +1290,8 @@ static DBusMessage *manager_hangup_all(DBusConnecti=
on *conn,
>  		return reply;
>  	}
>  =

> +	dial_request_user_cancel(vc, NULL);
> +

Same as above...

>  	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
>  =

>  	vc->pending =3D dbus_message_ref(msg);

Regards,
-Denis

--===============8464960406660363247==--

