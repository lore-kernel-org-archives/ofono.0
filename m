Content-Type: multipart/mixed; boundary="===============5167651854052370030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Synchronize call status in case of Hangup error
Date: Tue, 04 Aug 2015 23:34:29 -0500
Message-ID: <55C19255.9080604@gmail.com>
In-Reply-To: <1438704016-24150-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5167651854052370030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 08/04/2015 11:00 AM, Kuba Pawlak wrote:
> It is possible for the phone to accept Dial request
> but not actually dial. This leaves a voicecall object
> in state 'dialling' that cannot be removed.
> Proposed workaround is to trigger AT+CLCC when an error
> is returned for Hangup. As the call is not on the list,
> this would remove this hanging object and signal CallRemoved.
> ---
>   drivers/hfpmodem/voicecall.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index e3e6e0f5eccbbd61972c4b823c8093dd227e4bb9..06ad216b91bcbe99f9632f3c1=
29a8f61756fd585 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -318,21 +318,31 @@ static void generic_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   	struct change_state_req *req =3D user_data;
>   	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
>   	struct ofono_error error;
> +	unsigned int num_calls =3D 0;
>
>   	decode_at_error(&error, g_at_result_final_response(result));
>
> -	if (ok && req->affected_types) {
> +	if (req->affected_types) {

Would it not be far easier to simply add an if statement at the end. =

Something like:

if (!ok && vd->calls)
	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
				clcc_poll_cb, req->vc, NULL);

>   		GSList *l;
>   		struct ofono_call *call;
>
>   		for (l =3D vd->calls; l; l =3D l->next) {
>   			call =3D l->data;
>
> -			if (req->affected_types & (1 << call->status))
> -				vd->local_release |=3D (1 << call->id);
> +			if (req->affected_types & (1 << call->status)) {
> +				if (ok)
> +					vd->local_release |=3D (1 << call->id);
> +				else
> +					num_calls++;
> +			}
>   		}
>   	}
>
> +	/* AG returned an error, but some calls are present, resync*/
> +	if (num_calls)
> +		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
> +					clcc_poll_cb, req->vc, NULL);
> +
>   	req->cb(&error, req->data);
>   }
>
>

Regards,
-Denis

--===============5167651854052370030==--

