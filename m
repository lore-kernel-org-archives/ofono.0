Content-Type: multipart/mixed; boundary="===============2724252560015576000=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem: Improper handling of missed call
Date: Thu, 19 May 2011 15:19:00 +0300
Message-ID: <BANLkTinrHrn_XgjWmu1ZFbOodGqCAU4UZg@mail.gmail.com>
In-Reply-To: <1305715652-4357-1-git-send-email-arunlee@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2724252560015576000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

2011/5/18 Arun Ravindran <arunlee@gmail.com>:
> + =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_MT_RELEASE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((call->prev_status=
 =3D=3D CALL_STATUS_MT_ALERTING) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (call->prev_status =3D=3D CALL_STATUS_CO=
MING) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (call->prev_status =3D=3D CALL_STATUS_WA=
ITING))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 4;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return 6;
> +

Extra whitespace here.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_ACTIVE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_HOLD_INITIATED:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -548,9 +555,14 @@ static void isi_call_notify(struct ofono_voicecall *=
ovc, struct isi_call *call)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_MO_RELEASE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_MT_RELEASE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isi_call_set_disconect=
_reason(call):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_TERMINATED:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isi_call_set_disco=
nnect_reason(call);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("State( CALL_STATU=
S_TERMINATED ) need not be reported to Core");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_STATUS_ANSWERED:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("State need no=
t be reported to Core");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;

If the intention is not to report this up, then why set the disconnect
reason with isi_call_set_disconnect_reason()? Why not just fold these
two case statements together?

Cheers,
Aki

--===============2724252560015576000==--

