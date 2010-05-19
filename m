Content-Type: multipart/mixed; boundary="===============7043802986650695595=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: commit "Fix Use hashtable to record udev path" breaks huawei
Date: Wed, 19 May 2010 08:55:13 -0500
Message-ID: <201005190855.13792.denkenz@gmail.com>
In-Reply-To: <87iq6j7w5j.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7043802986650695595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Sorry, I was too hasty. The patch is fine, I was just testing
> inproperly. After a bit more testing I found out that problem always
> happens when I plugin the usb modem:
> =

> May 19 17:20:09 tukki connmand[30925]: plugins/ofono.c:modem_changed() pa=
th
>  /huawei1 May 19 17:20:10 tukki ofonod[672]: < ATE0\r\r\nOK\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CFUN=3D1\r
> May 19 17:20:10 tukki ofonod[672]: < \r\nOK\r\n
> May 19 17:20:10 tukki ofonod[672]: plugins/huawei.c:cfun_enable()
> May 19 17:20:10 tukki ofonod[672]: > AT+CRC=3D1\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CLIP=3D1\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+COLP=3D1\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CCWA=3D1\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]:
>  drivers/atmodem/voicecall.c:at_voicecall_initialized() voicecall_init:
>  registering to notifications May 19 17:20:10 tukki ofonod[672]:
>  src/sim.c:ofono_sim_add_state_watch() 0x132bcd0 May 19 17:20:10 tukki
>  ofonod[672]: * < \r\n^STIN:0,0,0\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CGMI\r
> May 19 17:20:10 tukki connmand[30925]: plugins/ofono.c:modem_changed() pa=
th
>  /huawei1 May 19 17:20:10 tukki ofonod[672]: < \r\nhuawei\r\n\r\nOK\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CRSM=3D176,28590,0,0,1\r
> May 19 17:20:10 tukki connmand[30925]: plugins/ofono.c:modem_changed() pa=
th
>  /huawei1 May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r=
\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CLCC\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]: > AT+CRSM=3D192,28599\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
> May 19 17:20:10 tukki ofonod[672]: src/voicecall.c:ecc_g2_read_cb() 0
> May 19 17:20:10 tukki ofonod[672]: > AT+CGMM\r
> May 19 17:20:10 tukki ofonod[672]: < \r\nE1552\r\n\r\nOK\r\n
> =

> But if I start ofono while the usb modem is plugged in it works fine.
> Also modem disable and then enable workarounds it. Oh well.
> =


Sounds like the SIM needs some time to be initialized.  Perhaps a Huawei =

specific command might be required to figure out when the SIM is actually r=
eady.  =

Try listening to ^SIMST or simply re-trying a particular command until you =

don't get SIM busy error.

Regards,
-Denis

--===============7043802986650695595==--

