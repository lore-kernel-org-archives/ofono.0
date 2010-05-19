Content-Type: multipart/mixed; boundary="===============5870002148943199155=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: commit "Fix Use hashtable to record udev path" breaks huawei
Date: Wed, 19 May 2010 18:23:36 +0300
Message-ID: <87iq6j7w5j.fsf@potku.valot.fi>
In-Reply-To: <87tyq46nb7.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5870002148943199155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kalle.valo@canonical.com> writes:

> while working on third version of my huawei gprs patches I noticed that
> this commit breaks huawei:
>
> commit af976f7e524746b1b55645967e11ab8250f593a8
> Author: Zhenhua Zhang <zhenhua.zhang@intel.com>
> Date:   Tue May 11 09:04:28 2010 +0800
>
>     Fix Use hashtable to record udev path
>     =

>     Sometimes, Udev device 'remove' event could not report correct parent
>     node of current udev_device. Current code replies on the devpath
>     attached on the parent node to find modem and then remove it.
>     =

>     This fix is to change the way to store the devpath info into a
>     hashtable. So that we search hashtable to get devpath and remove the
>     modem.
>
> I reverted the commit and huawei works again for me. More details later
> today.

Sorry, I was too hasty. The patch is fine, I was just testing
inproperly. After a bit more testing I found out that problem always
happens when I plugin the usb modem:

May 19 17:20:09 tukki connmand[30925]: plugins/ofono.c:modem_changed() path=
 /huawei1
May 19 17:20:10 tukki ofonod[672]: < ATE0\r\r\nOK\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CFUN=3D1\r
May 19 17:20:10 tukki ofonod[672]: < \r\nOK\r\n
May 19 17:20:10 tukki ofonod[672]: plugins/huawei.c:cfun_enable() =

May 19 17:20:10 tukki ofonod[672]: > AT+CRC=3D1\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CLIP=3D1\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+COLP=3D1\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CCWA=3D1\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: drivers/atmodem/voicecall.c:at_voicecall=
_initialized() voicecall_init: registering to notifications
May 19 17:20:10 tukki ofonod[672]: src/sim.c:ofono_sim_add_state_watch() 0x=
132bcd0
May 19 17:20:10 tukki ofonod[672]: * < \r\n^STIN:0,0,0\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CGMI\r
May 19 17:20:10 tukki connmand[30925]: plugins/ofono.c:modem_changed() path=
 /huawei1
May 19 17:20:10 tukki ofonod[672]: < \r\nhuawei\r\n\r\nOK\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CRSM=3D176,28590,0,0,1\r
May 19 17:20:10 tukki connmand[30925]: plugins/ofono.c:modem_changed() path=
 /huawei1
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CLCC\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: > AT+CRSM=3D192,28599\r
May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM busy\r\n
May 19 17:20:10 tukki ofonod[672]: src/voicecall.c:ecc_g2_read_cb() 0
May 19 17:20:10 tukki ofonod[672]: > AT+CGMM\r
May 19 17:20:10 tukki ofonod[672]: < \r\nE1552\r\n\r\nOK\r\n

But if I start ofono while the usb modem is plugged in it works fine.
Also modem disable and then enable workarounds it. Oh well.

-- =

Kalle Valo

--===============5870002148943199155==--

