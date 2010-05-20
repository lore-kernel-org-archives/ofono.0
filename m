Content-Type: multipart/mixed; boundary="===============1006236277925630796=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: commit "Fix Use hashtable to record udev path" breaks huawei
Date: Thu, 20 May 2010 09:18:36 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E8DD24D@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <87iq6j7w5j.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1006236277925630796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Kalle Valo wrote:
> Kalle Valo <kalle.valo@canonical.com> writes:
> =

>> while working on third version of my huawei gprs patches I noticed
>> that this commit breaks huawei:
>> =

>> commit af976f7e524746b1b55645967e11ab8250f593a8
>> Author: Zhenhua Zhang <zhenhua.zhang@intel.com>
>> Date:   Tue May 11 09:04:28 2010 +0800
>> =

>>     Fix Use hashtable to record udev path
>> =

>>     Sometimes, Udev device 'remove' event could not report correct
>>     parent node of current udev_device. Current code replies on the
>>     devpath attached on the parent node to find modem and then
>> remove it. =

>> =

>>     This fix is to change the way to store the devpath info into a
>>     hashtable. So that we search hashtable to get devpath and remove
>> the     modem. =

>> =

>> I reverted the commit and huawei works again for me. More details
>> later today.
> =

> Sorry, I was too hasty. The patch is fine, I was just testing
> inproperly. After a bit more testing I found out that problem
> always happens when I plugin the usb modem:
> =

> May 19 17:20:09 tukki connmand[30925]:
> plugins/ofono.c:modem_changed() path /huawei1 May 19 17:20:10
> tukki ofonod[672]: < ATE0\r\r\nOK\r\n May 19 17:20:10 tukki
> ofonod[672]: > AT+CFUN=3D1\r May 19 17:20:10 tukki ofonod[672]:
> < \r\nOK\r\n May 19 17:20:10 tukki ofonod[672]:
> plugins/huawei.c:cfun_enable() May 19 17:20:10 tukki
> ofonod[672]: > AT+CRC=3D1\r May 19 17:20:10 tukki ofonod[672]: <
> \r\n+CME ERROR: SIM busy\r\n May 19 17:20:10 tukki
> ofonod[672]: > AT+CLIP=3D1\r May 19 17:20:10 tukki ofonod[672]:
> < \r\n+CME ERROR: SIM busy\r\n May 19 17:20:10 tukki
> ofonod[672]: > AT+COLP=3D1\r May 19 17:20:10 tukki ofonod[672]:
> < \r\n+CME ERROR: SIM busy\r\n May 19 17:20:10 tukki
> ofonod[672]: > AT+CCWA=3D1\r May 19 17:20:10 tukki ofonod[672]:
> < \r\n+CME ERROR: SIM busy\r\n May 19 17:20:10 tukki
> ofonod[672]:
> drivers/atmodem/voicecall.c:at_voicecall_initialized()
> voicecall_init: registering to notifications May 19 17:20:10
> tukki ofonod[672]: src/sim.c:ofono_sim_add_state_watch()
> 0x132bcd0 May 19 17:20:10 tukki ofonod[672]: * <
> \r\n^STIN:0,0,0\r\n May 19 17:20:10 tukki ofonod[672]: >
> AT+CGMI\r May 19 17:20:10 tukki connmand[30925]:
> plugins/ofono.c:modem_changed() path /huawei1 May 19 17:20:10
> tukki ofonod[672]: < \r\nhuawei\r\n\r\nOK\r\n May 19 17:20:10
> tukki ofonod[672]: > AT+CRSM=3D176,28590,0,0,1\r May 19 17:20:10
> tukki connmand[30925]: plugins/ofono.c:modem_changed() path
> /huawei1 May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR:
> SIM busy\r\n May 19 17:20:10 tukki ofonod[672]: > AT+CLCC\r
> May 19 17:20:10 tukki ofonod[672]: < \r\n+CME ERROR: SIM
> busy\r\n May 19 17:20:10 tukki ofonod[672]: >
> AT+CRSM=3D192,28599\r May 19 17:20:10 tukki ofonod[672]: <
> \r\n+CME ERROR: SIM busy\r\n May 19 17:20:10 tukki
> ofonod[672]: src/voicecall.c:ecc_g2_read_cb() 0 May 19
> 17:20:10 tukki ofonod[672]: > AT+CGMM\r May 19 17:20:10 tukki
> ofonod[672]: < \r\nE1552\r\n\r\nOK\r\n
> =

> But if I start ofono while the usb modem is plugged in it works fine.
> Also modem disable and then enable workarounds it. Oh well.

My commit af976f7e524 should not impact modem detection and power up stage.=
 If you found huawei modem still exists in oFono after you unplug the dungl=
e, I guess something maybe wrong in my patch. :-)

Maybe you need to wait until SIM is settled to power on it. As Denis said, =
listen '^SIMST' notification should be a good idea.

> --
> Kalle Valo
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============1006236277925630796==--

