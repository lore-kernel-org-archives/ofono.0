Content-Type: multipart/mixed; boundary="===============7083676193676136862=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: SIM PIN unlock
Date: Tue, 27 Oct 2009 16:45:09 +0100
Message-ID: <4AE71585.6040804@gmail.com>
In-Reply-To: <fb249edb0910261045m5bf88ad6hd87aac5f30f35434@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7083676193676136862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok. I have narrowed it down a little.

It seems to be the CRSM command reading the
SIM_EFLI_FILEID when it succeeds.

ofonod[6326]: > AT+CRSM=3D192,28421\r
ofonod[6326]: < \r\n+CRSM: 144,
ofonod[6326]: < 0,850D00046F05040001FFAA03020000\r\n\r\n
ofonod[6326]: < \r\nOK\r\n

goes no further....


HACK:

If I remove

	ofono_sim_read(sim, SIM_EFLI_FILEID,
         	                OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
                 	        sim_efli_read_cb, sim);

from src/sim.c, the code works, for me.


After i tried the above and it worked, i tried to re-enable the function =

  call above, and put a breakpoint in sim_efli_read_cb(), and the code =

execution never hit there.


NOTE:

After entering the pin code for the sim card, only SIM_EFMSISDN_FILEID =

is read from the sim card, but maybe that is intentional, since it succeeds.


Regards,
Ryan


Andrzej Zaborowski wrote:
> Hi Ryan,
> =

> 2009/10/26 Ryan Raasch <ryan.raasch@gmail.com>:
>> It seems that if the sim card is unlocked, then the remaining "cascading"
>> functions are not called.
>>
>> query_manufacturer(info);
>>
>> Got SIM READY
>>
>> NOT CALLED...
>> =C3=82  =C3=82  =C3=82  =C3=82 query_model(info);
>> =C3=82  =C3=82  =C3=82  =C3=82 query_revision(info);
>> =C3=82  =C3=82  =C3=82  =C3=82 query_serial(info);
>>
>>
>> ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
>> ofonod[3965]: src/sim.c:ofono_sim_add_ready_watch() 0x8eb15b0
>> ofonod[3965]: > AT+CGMI\r
>> ofonod[3965]: < AT+CGM
>> ofonod[3965]: < I\r
>> ofonod[3965]: < \r\nSIEME
>> ofonod[3965]: < NS
>> ofonod[3965]: < \r\n\r\nOK\r\n
>> ofonod[3965]: attr_cb got result: 1
>> ofonod[3965]: Final response: OK
>> ofonod[3965]: Response line: SIEMENS
>> ofonod[3965]: > AT+CPIN?\r
>> ofonod[3965]: < AT+CPI
>> ofonod[3965]: < N?\r
>> ofonod[3965]: < \r\n+CPIN: READY\r\n\r\nO
>> ofonod[3965]: < K\r
>> ofonod[3965]: < \n
>> ofonod[3965]: at_cpin_cb got result: 1
>> ofonod[3965]: Final response: OK
>> ofonod[3965]: Response line: +CPIN: READY
>> ofonod[3965]: crsm_pin_cb: READY
>> ofonod[3965]: > AT+CRSM=3D192,28421\r
>> ofonod[3965]: < AT+CRSM=3D192
>> ofonod[3965]: < ,28
>> ofonod[3965]: < 421\r
>> ofonod[3965]: < \r\n+CRSM: 144,0,850D00046F05040001FFAA03020
>> ofonod[3965]: < 000\r\n\r\n
>> ofonod[3965]: < \r\nOK\r\n
> =

> There seems to be an additional \r\n before the last OK (?).  I'm not
> sure how this can result from the PIN request but maybe using the
> permissive mode of the parser, like plugin/phonesim.c does, helps (or
> not).  You also have echo enabled, shouldn't be a problem but maybe
> worth trying without it.
> =

> Regards
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============7083676193676136862==--

