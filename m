Content-Type: multipart/mixed; boundary="===============7172309101706197832=="
MIME-Version: 1.0
From: ofonoconn@encambio.com
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 19:38:47 +0200
Message-ID: <20110627173847.GA5316@debut.europalab.com>
In-Reply-To: <20110627172502.GA2366@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7172309101706197832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello again,

On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
>On Mon., June 27, 2011, Denis KENZIOR wrote:
>>On 06/27/2011 10:45 AM, ofonoconn(a)encambio.com wrote:
>  meego$ find /etc/udev/
>  /etc/udev/makedev.d/50-udev.nodes
>  /etc/udev/rules.d/70-persistent-cd.rules
>  /etc/udev/udev.conf
>
>...and nowhere is ofono.rules. Is that the problem? In which package
>are these things usually found? MeeGo includes 'ofono-0.58-1.4.i586'
>and 'ofono-test-0.58-1.4.i586' only.
>
>...but:
>
>  meego$ ls -1 /dev/.udev/db/*an*
>  /dev/.udev/db/net:wlan0
>  /dev/.udev/db/net:wwan0
>
>...so even without a ofono.rules, the modem is being detected?
>
>>See plugins/udev.c add_mbm() for more details.  I see that we
>>definitely do not cover the "Broadband Network Device" case that
>>your modem is reporting.
>>
Hmmm.

  meego$ cat /dev/.udev/db/net\:wwan0
  E:ID_VENDOR=3D=C3=B0_HP_hs2330_Mobile_Broadband_Module
  E:ID_VENDOR_ENC=3D=C3=B0\x03HP\x20hs2330\x20Mobile\x20Broadband\x20Module
  E:ID_VENDOR_ID=3D03f0
  E:ID_MODEL=3DHP_hs2330_Mobile_Broadband_Module
  E:ID_MODEL_ENC=3DHP\x20hs2330\x20Mobile\x20Broadband\x20Module
  E:ID_MODEL_ID=3D271d
  E:ID_REVISION=3D0000
  E:ID_SERIAL=3D=C3=B0_HP_hs2330_Mobile_Broadband_Module_HP_hs2330_Mobile_B=
roadband_Module_0044017003593710
  E:ID_SERIAL_SHORT=3D0044017003593710
  E:ID_TYPE=3Dgeneric
  E:ID_BUS=3Dusb
  E:ID_USB_INTERFACES=3D:020800:020201:0a0000:020901:020a00:0a00ee:
  E:ID_USB_INTERFACE_NUM=3D06
  E:ID_USB_DRIVER=3Dcdc_ether
  E:ID_VENDOR_FROM_DATABASE=3DHewlett-Packard

Is 'cdc_ether' the driver string entry which is missing from
add_mbm() function? Is that why '/usr/lib/ofono/test/list-modems'
comes up empty on my netbook?

Regards,
Michael

--===============7172309101706197832==--

