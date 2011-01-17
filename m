Content-Type: multipart/mixed; boundary="===============8554627505083459241=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Band selection issue
Date: Mon, 17 Jan 2011 16:31:00 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A29869CE509@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <AANLkTinbsGva8zkS87uKJM_8JJT_UzkbGmOE=tHSPiSt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8554627505083459241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas

The issue was unstable modem. I tried the 1552 modem again, now it works fi=
ne with 2G/3G Band, as the limitation of PCS network, did not test the PCS =
band.

With Emw770, it doesn't work yet, should be modem self issue.

>Could you enable debug and paste the output somewhere?
.......
.......
ofonod[28247]: src/gprs.c:ofono_gprs_status_notify() /huawei2 status 2
ofonod[28247]: PCUI: < \r\n^BOOT:20294258,0,0,0,29\r\n
ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,2a0380,2,4\r
ofonod[28247]: PCUI: < \r\nERROR\r\n
ofonod[28247]: src/radio-settings.c:radio_band_set_callback() Error setting=
 radio frequency band
ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,2a0380,2,4\r
ofonod[28247]: PCUI: < \r\nERROR\r\n
ofonod[28247]: src/radio-settings.c:radio_band_set_callback() Error setting=
 radio frequency band
ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,2a0380,2,4\r
ofonod[28247]: PCUI: < \r\nERROR\r\n
ofonod[28247]: src/radio-settings.c:radio_band_set_callback() Error setting=
 radio frequency band
^[[Aofonod[28247]: PCUI: < \r\n^BOOT:20294258,0,0,0,29\r\n
ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,20100,2,4\r
ofonod[28247]: PCUI: < \r\nERROR\r\n
ofonod[28247]: src/radio-settings.c:radio_band_set_callback() Error setting=
 radio frequency band
ofonod[28247]: PCUI: < \r\n^BOOT:20294258,0,0,0,29\r\n
ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,20100,2,4\r
ofonod[28247]: PCUI: < \r\nERROR\r\n
ofonod[28247]: src/radio-settings.c:radio_band_set_callback() Error setting=
 radio frequency band

Thanks
Zhigang


--===============8554627505083459241==--

