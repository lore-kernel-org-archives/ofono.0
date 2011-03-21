Content-Type: multipart/mixed; boundary="===============4045593869082540494=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2 0/9] HSP profile implementation
Date: Mon, 21 Mar 2011 14:53:20 +0200
Message-ID: <AANLkTi=5w-3j1fE5BwEZQMYpC_UYbO=oMfVM+hJw2ddn@mail.gmail.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4045593869082540494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

2011/3/17 Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@linux.intel.com>:
> This patch will start providing an HSP profile implementation
> in oFono. This is work in progress, and based of what was done for
> HFP profile. Finally added the audio connection, that will provide
> a base for discussion. To avoid emulator depend upon btio, there is
> a callback fom the emulator to the hsp plugin to connect audio,
>
> Some question remains :
>
> * How should pulse audio be notified?

I suppose we should use the Media API to notify PA, it is already
upstream, in that case oFono doesn't need to deal with SCO at all. If
that is the plan then I suggest we first define a D-Bus spec on how to
signal things like SLC and NREC to BlueZ, the record and socket
listening/connection handling logic could also be done in BlueZ side
so we use D-Bus to transfer the fd to oFono.

> * What is the behavior of hsp when receiving CKPD=3D200?

This is what oFono does in BlueZ:

void telephony_key_press_req(void *telephony_device, const char *keys)
{
	struct voice_call *active, *waiting;
	int err;

	DBG("telephony-ofono: got key press request for %s", keys);

	waiting =3D find_vc_with_status(CALL_STATUS_INCOMING);
	if (!waiting)
		waiting =3D find_vc_with_status(CALL_STATUS_DIALING);

	active =3D find_vc_with_status(CALL_STATUS_ACTIVE);

	if (waiting)
		err =3D answer_call(waiting);
	else if (active)
		err =3D release_call(active);
	else
		err =3D 0;

	if (err < 0)
		telephony_key_press_rsp(telephony_device,
							CME_ERROR_AG_FAILURE);
	else
		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
}

> Next step will be to dial/hangup a call.
>
> Fr=C3=A9d=C3=A9ric Dalleau (9):
> =C2=A0bluetooth: add functions for sco connection
> =C2=A0emulator: add hsp emulator type
> =C2=A0hsp_ag: add hsp atom type
> =C2=A0hsp_ag: Initial plugin commit
> =C2=A0hsp_ag: add modem watch
> =C2=A0emulator: add CKPD support
> =C2=A0emulator: add audio connection API
> =C2=A0emulator: implement audio connection API
> =C2=A0hsp_ag: add audio connection support
>
> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
> =C2=A0include/emulator.h =C2=A0| =C2=A0 =C2=A08 ++
> =C2=A0plugins/bluetooth.c | =C2=A0122 +++++++++++++++++++++++++++++++
> =C2=A0plugins/bluetooth.h | =C2=A0 =C2=A07 ++
> =C2=A0plugins/hsp_ag.c =C2=A0 =C2=A0| =C2=A0200 +++++++++++++++++++++++++=
++++++++++++++++++++++++++
> =C2=A0src/emulator.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 50 +++++++++++++
> =C2=A0src/ofono.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A07 files changed, 391 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 plugins/hsp_ag.c
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Luiz Augusto von Dentz
Computer Engineer

--===============4045593869082540494==--

