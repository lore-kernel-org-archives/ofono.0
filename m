Content-Type: multipart/mixed; boundary="===============8843139723115790417=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: SIM PIN unlock
Date: Mon, 26 Oct 2009 18:45:56 +0100
Message-ID: <fb249edb0910261045m5bf88ad6hd87aac5f30f35434@mail.gmail.com>
In-Reply-To: <4AE5D4E5.60602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8843139723115790417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

2009/10/26 Ryan Raasch <ryan.raasch@gmail.com>:
> It seems that if the sim card is unlocked, then the remaining "cascading"
> functions are not called.
>
> query_manufacturer(info);
>
> Got SIM READY
>
> NOT CALLED...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query_model(info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query_revision(info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0query_serial(info);
>
>
> ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
> ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
> ofonod[3965]: > AT+CGMI\r
> ofonod[3965]: < AT+CGM
> ofonod[3965]: < I\r
> ofonod[3965]: < \r\nSIEME
> ofonod[3965]: < NS
> ofonod[3965]: < \r\n\r\nOK\r\n
> ofonod[3965]: attr_cb got result: 1
> ofonod[3965]: Final response: OK
> ofonod[3965]: Response line: SIEMENS
> ofonod[3965]: > AT+CPIN?\r
> ofonod[3965]: < AT+CPI
> ofonod[3965]: < N?\r
> ofonod[3965]: < \r\n+CPIN: READY\r\n\r\nO
> ofonod[3965]: < K\r
> ofonod[3965]: < \n
> ofonod[3965]: at_cpin_cb got result: 1
> ofonod[3965]: Final response: OK
> ofonod[3965]: Response line: +CPIN: READY
> ofonod[3965]: crsm_pin_cb: READY
> ofonod[3965]: > AT+CRSM=3D192,28421\r
> ofonod[3965]: < AT+CRSM=3D192
> ofonod[3965]: < ,28
> ofonod[3965]: < 421\r
> ofonod[3965]: < \r\n+CRSM: 144,0,850D00046F05040001FFAA03020
> ofonod[3965]: < 000\r\n\r\n
> ofonod[3965]: < \r\nOK\r\n

There seems to be an additional \r\n before the last OK (?).  I'm not
sure how this can result from the PIN request but maybe using the
permissive mode of the parser, like plugin/phonesim.c does, helps (or
not).  You also have echo enabled, shouldn't be a problem but maybe
worth trying without it.

Regards

--===============8843139723115790417==--

