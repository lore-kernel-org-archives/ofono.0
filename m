Content-Type: multipart/mixed; boundary="===============5873142126359663435=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/2] hfpmodem: Request AT+CLCC again after callheld=<2
 or 3>
Date: Wed, 30 Jan 2013 22:09:12 -0600
Message-ID: <5109EE68.5050109@gmail.com>
In-Reply-To: <70cf00e077ef3e1dff65de3f6fcb5df7c754734f.1359360111.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5873142126359663435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On 01/28/2013 04:13 AM, Timo Mueller wrote:
> From: Timo Mueller<timo.mueller@bmw-carit.de>
>
> With a call being active, placing a second call on the AG device will
> lead to the active call being put on hold. During the transition some
> phones do not update the list of current calls. This leads to an +CLCC
> response that does not contain the new outgoing call, even though an
> outgoing callsetup was reported.
>
> The list will be updated once the active call was put on hold and
> callheld=3D2 is reported. In this case the list has to be requested
> again (AT+CLCC).
>
> AT sequence that exhibited the failure (AG device was a Nokia N9
> having an active outgoing call and placing a second outgoing call)
>

Ugh.

<snip>

> @@ -1072,6 +1074,14 @@ static void ciev_callheld_notify(struct ofono_voic=
ecall *vc,
>   				call->status =3D CALL_STATUS_HELD;
>   				ofono_voicecall_notify(vc, call);
>   			}
> +
> +			if (callsetup =3D=3D 2 || callsetup =3D=3D 3) {
> +				dialing =3D find_dialing(vd->calls);
> +
> +				if (dialing =3D=3D NULL)
> +					g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
> +						clcc_poll_cb, vc, NULL);
> +			}
>   		} else if (callheld =3D=3D 1) {
>   			if (vd->clcc_source)
>   				g_source_remove(vd->clcc_source);

I'm seeing reports of too many devices doing too many weird things, and =

if we change the core logic for each and every one then the code becomes =

a huge mess quickly.  It would be hard to validate or regression test it =

without massive investment in automated interoperability testing.

Marcel and I spoke briefly about this and our belief is that we need to =

introduce manufacturer specific quirks to HFP drivers instead of trying =

to solve this generically.

BlueZ should be able to provide us enough information about the remote =

device for us to make a fairly good guess as to the manufacturer / =

version.  Additional details can be queried by manufacturer specific =

commands (e.g. in the case of iOS).  That should be enough for us to =

simply set the vendor / quirk ID and take appropriate action in the driver.

We can always fall back to strict spec compliant behavior by default if =

the manufacturer quirks cannot be determined.  What do you think?

Regards,
-Denis

--===============5873142126359663435==--

