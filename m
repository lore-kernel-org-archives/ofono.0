Content-Type: multipart/mixed; boundary="===============5776542533385831295=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Tue, 20 Aug 2019 00:18:19 +1000
Message-ID: <CAA=hcWTsyWsfKPTrJg4prguQ9FpzU5==Keqvj_YObbkDN_aKVg@mail.gmail.com>
In-Reply-To: <e66b0b52-4314-e2b0-f4a9-5a41feda5886@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5776542533385831295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Let me clean up a little bit to take your notes and to answer your question=
s.

On 8/19/19, Jonas Bonn <jonas@norrbonn.se> wrote:
> Aug 17 08:51:46 solar kernel: usb 1-1: USB disconnect, device number 3
> Aug 17 08:51:46 solar kernel: option1 ttyUSB0: GSM modem (1-port)
> converter now disconnected from ttyUSB0
> Aug 17 08:51:46 solar kernel: option 1-1:1.0: device disconnected
> Aug 17 08:51:46 solar kernel: option1 ttyUSB1: GSM modem (1-port)
> converter now disconnected from ttyUSB1
> Aug 17 08:51:46 solar kernel: option 1-1:1.2: device disconnected
> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: nonzero urb status
> received: -71
>
> That's a USB communication failure!

Did you referred to urb status -71 which is protocol error?

Are there any chance that USB communication failure could be caused by
kernel, connman or ofono? I guess the answer will be no.

Is it correct that QMI driver is from ofono? What QMI version is it?

> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback - 0 bytes
> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback -
> usb_submit_urb failed with result -19
> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3 wwan0: unregister
> 'qmi_wwan' usb-ci_hdrc.1-1, WWAN/QMI device
>
> Below, the device (modem) is reenumerated, which would indicate to me
> that it has restarted.  I don't think the kernel automatically sends a
> reset to a device on comm failures...???  This explains the
> communication failure, at least.

It might me to run power up signal when the link was down. My question
is, does the kernel knows how to restart the modem? The modem has a
dedicated POWER_UP line in GPIO I can send echo command to turn the
power up during the boot, according to the hardware engineer you can
also send signal to turn the power down. My power up command is in a
shell script which I make sure it will never put a wrong value to it.

So two possibility, (1) something triggered modem power off; (2)
something made modem crashed. It is unlikely that the kernel, ofono or
connman can turn the modem power off, but any chance that kernel,
ofono or connman could make the modem crash?

> Again, comm error.

Again I guess you referred to -71.

> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback - 0 bytes
> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback -
> usb_submit_urb failed with result -19
> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3 wwan0: unregister
> 'qmi_wwan' usb-ci_hdrc.1-1, WWAN/QMI device
>
> Modem has rebooted and is reenumerated below.
>
> Aug 17 11:32:44 solar kernel: usb 1-1: new high-speed USB device number
> 5 using ci_hdrc
> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device found,
> idVendor=3D05c6, idProduct=3D90b2, bcdDevice=3D 0.00
> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device strings: Mfr=3D1,
> Product=3D2, SerialNumber=3D3
> Aug 17 11:32:45 solar kernel: usb 1-1: Product: QHSUSB__BULK
> Aug 17 11:32:45 solar kernel: usb 1-1: Manufacturer: Qualcomm CDMA
> Technologies MSM
> Aug 17 11:32:45 solar kernel: usb 1-1: SerialNumber: 5ff10299
> Aug 17 11:32:45 solar kernel: option 1-1:1.0: GSM modem (1-port)
> converter detected
> Aug 17 11:32:45 solar kernel: usb 1-1: GSM modem (1-port) converter now
> attached to ttyUSB0
>
> Here, however, the modem isn't booting up into normal operational state,
> but rather into some other configuration that, presumably, is intended
> for doing device firmware updates...

> So you have a couple of things to figure out:
> i)  Why is the modem restarting (crashing) spontaneously?

Did you refer that usb_submit_urb failed with result -19 was crashed
from init callback?

> ii) What are the conditions for entering the bootloader/firmware update
> state?  How are you managing to meet these conditions?

The SARA modem should never enter the bootloader / firmware update
state unless you run the AT to manually update it. I'll check it with
uBlox support.

> iii)  Why is ofono not showing the device reenumeration... it should,
> and it should show the modem being taken down and brought back up again.
>   (I suspect it's just a matter of your logs being out of sync... it's
> probably there if you look, again).

I guess it was logs out of sync, I'll try it again.

>>
>> Let me further clarify it, the issue did not occur very often, it
>> occurred randomly between hours to many days, that is a big worry, LTE
>> should be 100% stable.
>
> The issue doesn't seem to have anything to do with the radio link.  The
> LTE is probably stable; the issue lies elsewhere.

So your assert is something triggered modem power down or crash which
brought the link down? I suggested the hardware engineer that power
supply might not be stable to trigger the modem power down or crash,
he totally denied it, He said, the same power supply for wifi and imx6
as well, if the power supply is the problem, wifi and imx6 would have
problems as well.

> Is the problem reproducible with the EVK?  If not, you've pretty much eli=
minated software as
> the cause of the issue... it's the same device, but with an independent p=
ower supply.

I have never seen the problem running on EVK, but I could not run
uncovered EVK in 24/7 for the safety reason, I might be able to find
another device without integrated power supply and uses an external
power supply, I'll test on that device in 24/7.

> In JH's case, only the 'qmimisc' device and the 'network' interface are i=
n play via ofono.
> These are separate endpoints on a single USB interface, all managed by th=
e qmi-wwan driver
>  in the kernel.

So the kernel managed the USB interface and qmi-wwan driver, can the
kernel cause the problem to crash USB or qmi driver?

Thanks Jonas, I will found something to debug.

- jh

--===============5776542533385831295==--

