Content-Type: multipart/mixed; boundary="===============7511595345030949580=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 3/3] hfpmodem: Add N9 quirk to run CLCC after
 callheld=<2 or 3>
Date: Wed, 27 Mar 2013 00:13:22 -0500
Message-ID: <51527FF2.8020804@gmail.com>
In-Reply-To: <2ec1b7ac69aac4f0edbc6cef843c63684ee16995.1360663430.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7511595345030949580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On 02/13/2013 02:36 AM, Timo Mueller wrote:
> From: Timo Mueller<timo.mueller@bmw-carit.de>
>
> On the Nokia N9 with a call being active, placing a second call on the
> AG device will lead to the active call being put on hold. During the
> transition the phone does not update the list of current calls. This
> leads to an +CLCC response that does not contain the new outgoing
> call, even though an outgoing callsetup was reported.
>
> The list will be updated once the active call was put on hold and
> callheld=3D2 is reported. In this case the list has to be requested
> again (AT+CLCC).
>
> AT sequence that exhibited the failure (AG device was a Nokia N9
> having an active outgoing call and placing a second outgoing call)
>
> <  \r\n+CIEV: 5,2\r\n
>> AT+CLCC\r
> <  \r\n+CLCC: 1,0,0,0,0,"+49xxx1",145\r\n
> <  \r\nOK\r\n
> <  \r\n+CIEV: 6,2\r\n
> <  \r\n+CIEV: 5,3\r\n
> <  \r\n+CIEV: 6,1\r\n
>> AT+CLCC\r
> <  \r\n+CIEV: 5,0\r\n
> <  \r\n+CLCC: 1,0,1,0,0,"+49xxx1",145\r\n
> <  \r\n+CLCC: 2,0,0,0,0,"+49xxx2",145\r\n
> <  \r\nOK\r\n
> ---
>   drivers/hfpmodem/vendor.h    |  3 ++-
>   drivers/hfpmodem/voicecall.c | 17 +++++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hfpmodem/vendor.h b/drivers/hfpmodem/vendor.h
> index fca847a..597ddee 100644
> --- a/drivers/hfpmodem/vendor.h
> +++ b/drivers/hfpmodem/vendor.h
> @@ -21,5 +21,6 @@
>    */
>
>   enum ofono_vendor {
> -	OFONO_VENDOR_GENERIC =3D 0
> +	OFONO_VENDOR_GENERIC =3D 0,
> +	OFONO_VENDOR_NOKIA_N9
>   };
> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index 7d2988e..af2aa75 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -1041,13 +1041,20 @@ out:
>   	vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D value;
>   }
>
> +static int needs_callheld_clcc_quirk(int vendor)
> +{
> +		return vendor =3D=3D OFONO_VENDOR_NOKIA_N9;
> +}
> +

Please don't do this, a switch/case statement is just as effective and =

easier to read.

>   static void ciev_callheld_notify(struct ofono_voicecall *vc,
>   					unsigned int value)
>   {
>   	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>   	GSList *l;
> +	GSList *dialing;
>   	struct ofono_call *call;
>   	unsigned int callheld =3D vd->cind_val[HFP_INDICATOR_CALLHELD];
> +	unsigned int callsetup =3D vd->cind_val[HFP_INDICATOR_CALLSETUP];
>
>   	switch (value) {
>   	case 0:
> @@ -1083,6 +1090,16 @@ static void ciev_callheld_notify(struct ofono_voic=
ecall *vc,
>   				call->status =3D CALL_STATUS_HELD;
>   				ofono_voicecall_notify(vc, call);
>   			}
> +
> +			if (needs_callheld_clcc_quirk(vd->vendor)) {

Have you thought of a way to set / detect when a device requires this quirk?

> +				if (callsetup =3D=3D 2 || callsetup =3D=3D 3) {
> +					dialing =3D find_dialing(vd->calls);
> +
> +					if (dialing =3D=3D NULL)
> +						g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
> +								clcc_poll_cb, vc, NULL);
> +				}
> +			}
>   		} else if (callheld =3D=3D 1) {
>   			if (vd->clcc_source)
>   				g_source_remove(vd->clcc_source);

Regards,
-Denis

--===============7511595345030949580==--

