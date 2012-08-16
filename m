Content-Type: multipart/mixed; boundary="===============5285849586912908826=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] netreg: adapt CMER and CIEV for telit
Date: Thu, 16 Aug 2012 00:57:42 -0500
Message-ID: <502C8BD6.1080001@gmail.com>
In-Reply-To: <502C99C4.1060902@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5285849586912908826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

>>
>> That looks a bit strange. Can you rm -rf /var/lib/ofono, rerun oFono
>> and see if that message persists?
>
> I did that but the message still shows up:
>
> ...
> Aug 8 11:40:00 mx31tt01 daemon.info ofonod[622]: Aux: >
> AT+CRSM=3D176,28486,0,0,17\r
> Aug 8 11:40:00 mx31tt01 daemon.info ofonod[622]: Aux: < \r\n+CRSM:
> 144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
> Aug 8 11:40:00 mx31tt01 daemon.debug ofonod[622]:
> drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 17
> Aug 8 11:40:00 mx31tt01 daemon.debug ofonod[622]:
> src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 17
> Aug 8 11:40:00 mx31tt01 daemon.err ofonod[622]: EFspn read successfully,
> but couldn't parse
> ...
>
> I hardly know anything about SIM FS yet, can you tell me the
> consequences of this please.
>

Consequence of removing /var/lib/ofono or of the error message?

If the former, then that is a heavy-handed way of clearing all settings =

oFono stores on disk, including the sim EF cache.  In your previous log =

the contents of EFspn were being read from cache.  So I just told you to =

wipe the cache so the contents show up in the AT log.  Otherwise I'd =

have to give you complicated directions on how to read the contents ;) =

If you want to know more about the EF cache itself, just ask me on IRC =

some time.

For the error message, it was actually a bug I fixed in commit =

54de04a828d945e8f081c7cd99161881736666b8.  The error message was being =

printed, yet things still worked correctly (by luck.)  You should not be =

seeing that message pop up again.

Regards,
-Denis

--===============5285849586912908826==--

