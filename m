Content-Type: multipart/mixed; boundary="===============5457189395190176605=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: SIM PIN unlock
Date: Mon, 26 Oct 2009 17:57:09 +0100
Message-ID: <4AE5D4E5.60602@gmail.com>
In-Reply-To: <200910261106.42520.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5457189395190176605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Denis Kenzior wrote:
> Hi Ryan,
> =

>> Hello,
>>
>> I have noticed a difference of ofono on startup. If the PIN number is
>> not required, the daemon never gets past CRSM query, and the remaining
>> interfaces are not added.
> =

> This works fine for other devices.  I would enable at command debugging (=
export =

> OFONO_AT_DEBUG=3D1) and watch for any signs of breakage.  The MC75 is kno=
wn to =

> have a very bad AT command implementation that might be confusing the AT =

> parser.
> =


It seems that if the sim card is unlocked, then the remaining =

"cascading" functions are not called.

query_manufacturer(info);

Got SIM READY

NOT CALLED...
   	query_model(info);
	query_revision(info);
	query_serial(info);


ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
ofonod[3965]: > AT+CGMI\r
ofonod[3965]: < AT+CGM
ofonod[3965]: < I\r
ofonod[3965]: < \r\nSIEME
ofonod[3965]: < NS
ofonod[3965]: < \r\n\r\nOK\r\n
ofonod[3965]: attr_cb got result: 1
ofonod[3965]: Final response: OK
ofonod[3965]: Response line: SIEMENS
ofonod[3965]: > AT+CPIN?\r
ofonod[3965]: < AT+CPI
ofonod[3965]: < N?\r
ofonod[3965]: < \r\n+CPIN: READY\r\n\r\nO
ofonod[3965]: < K\r
ofonod[3965]: < \n
ofonod[3965]: at_cpin_cb got result: 1
ofonod[3965]: Final response: OK
ofonod[3965]: Response line: +CPIN: READY
ofonod[3965]: crsm_pin_cb: READY
ofonod[3965]: > AT+CRSM=3D192,28421\r
ofonod[3965]: < AT+CRSM=3D192
ofonod[3965]: < ,28
ofonod[3965]: < 421\r
ofonod[3965]: < \r\n+CRSM: 144,0,850D00046F05040001FFAA03020
ofonod[3965]: < 000\r\n\r\n
ofonod[3965]: < \r\nOK\r\n

Cheers,
Ryan

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============5457189395190176605==--

