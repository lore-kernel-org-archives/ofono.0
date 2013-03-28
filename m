Content-Type: multipart/mixed; boundary="===============1601967572095130787=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 11:04:30 -0500
Message-ID: <51546A0E.6020005@gmail.com>
In-Reply-To: <CAAs3wMijW_8Cm9Af673zHjLBvvg4ZshWLcBrLuiiVfxKyTyVMQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1601967572095130787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Thanks for ppp issue I understand. I tried my code (that worked on x86)
> on the embedded ARM  board but we have problem , here the logs:
> ofonod[16939]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
> 00, 15
> ofonod[16939]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
> 0, tocopy: 15
> ofonod[16939]: MUX: waking up writer
> ofonod[16939]: MUX: creating source: 0x14a0390, channel: 0x148a6a0,
> writer: 4, reader: 0
> ofonod[16939]: MUX: can write data
> ofonod[16939]: MUX: checking channel for write: 0x148ac50
> ofonod[16939]: MUX: checking channel for write: 0x148a6a0
> ofonod[16939]: MUX: dispatching write sources: 0x148a6a0
> ofonod[16939]: MUX: checking source: 0x14a0390
> ofonod[16939]: MUX: dispatching source: 0x14a0390
> ofonod[16939]: Chat2: > AT+CRSM=3D192,28474\r
> ofonod[16939]: MUX: removing source: 0x14a0390
> ofonod[16939]: MUX: checking source: 0x149eb80
> ofonod[16939]: MUX: checking channel for write: 0x1488ec0
> ofonod[16939]: MUX: dispatching write sources: 0x1488ec0
> ofonod[16939]: MUX: checking source: 0x148aaf0
> ofonod[16939]: MUX: checking channel for write: 0x1490430
> ofonod[16939]: MUX: dispatching write sources: 0x1490430
> ofonod[16939]: MUX: checking source: 0x148ad60
> ofonod[16939]: Chat1: Wakeup got no response
> ofonod[16939]: Aborting (signal 11) [ofonod]
> ofonod[16939]: ++++++++ backtrace ++++++++
>
> I suspect that should be a syncronization issue between the virtual
> channel. Any idea?
>

Can you compile oFono with debug information on (export CFLAGS=3D-O0, =

--enable-debug) and see whether you get a better backtrace.  This is =

pretty hard to debug with the information provided.

Regards,
-Denis


--===============1601967572095130787==--

