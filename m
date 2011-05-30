Content-Type: multipart/mixed; boundary="===============3494164403042730455=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem: Improper handling of missed call
Date: Mon, 30 May 2011 15:03:38 +0300
Message-ID: <BANLkTinQC+b_7_i_podTj2yXM6AiakmWiA@mail.gmail.com>
In-Reply-To: <1306164011-29368-1-git-send-email-arunlee@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3494164403042730455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

2011/5/23 Arun Ravindran <arunlee@gmail.com>:
> @@ -548,9 +555,26 @@ static void isi_call_notify(struct ofono_voicecall *=
ovc, struct isi_call *call)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_MO_RELEASE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_MT_RELEASE:
> - =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_TERMINATED:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Core requires the ca=
ll status to be either incoming
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * or waiting to identi=
fy the disconnected call as missed.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The MT RELEASE is no=
t mapped to any state in +CLCC, but
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we need the disconne=
ct reason.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isi_call_set_disco=
nnect_reason(call);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_TERMINATED:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("State( CALL_STATU=
S_TERMINATED ) need not be reported to Core");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The call terminated =
is not reported to core as
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * these intermediate s=
tates are not processed in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the core. We report =
the call status when it becomes
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * idle and TERMINATED =
is not mapped to +CLCC. The disconnect
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * reason is set, so th=
at the call termination cause
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * in case of error is =
available to the core.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isi_call_set_disconnec=
t_reason(call);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;

These comment blocks had some trailing whitespace.

I tested this patch, and I don't think it's still doing the right
thing. I don't seem to be able to generate a missed call, at least
when using the isiusb plugin. Somehow, ofono_voicecall_disconnect()
does not get called with the correct reason code.

Can you post logs on such a successful case, if you have any around?

Cheers,
Aki

--===============3494164403042730455==--

