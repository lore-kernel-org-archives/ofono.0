Content-Type: multipart/mixed; boundary="===============9029671116479637106=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Mon, 19 Aug 2019 09:50:58 +0200
Message-ID: <bd0f33b0-91c9-95d3-fb02-0b8162ce47d9@norrbonn.se>
In-Reply-To: <CAOf5uw=6hQkfhAt=OWH+mim30NyOHU6Z8GVMJ6yKCEf=1NFw8w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9029671116479637106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 19/08/2019 09:36, Michael Nazzareno Trimarchi wrote:
> Hi
> =

> On Mon, Aug 19, 2019 at 7:38 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>> The kernel log has this:
>>
>> Aug 17 08:51:46 solar kernel: usb 1-1: USB disconnect, device number 3
>> Aug 17 08:51:46 solar kernel: option1 ttyUSB0: GSM modem (1-port)
>> converter now disconnected from ttyUSB0
>> Aug 17 08:51:46 solar kernel: option 1-1:1.0: device disconnected
>> Aug 17 08:51:46 solar kernel: option1 ttyUSB1: GSM modem (1-port)
>> converter now disconnected from ttyUSB1
>> Aug 17 08:51:46 solar kernel: option 1-1:1.2: device disconnected
>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: nonzero urb status
>> received: -71
>>
>> That's a USB communication failure!
>>
>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback - 0 byt=
es
>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback -
>> usb_submit_urb failed with result -19
>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3 wwan0: unregister
>> 'qmi_wwan' usb-ci_hdrc.1-1, WWAN/QMI device
>>
>> Below, the device (modem) is reenumerated, which would indicate to me
>> that it has restarted.  I don't think the kernel automatically sends a
>> reset to a device on comm failures...???  This explains the
>> communication failure, at least.
> =

> Can be chattering and rush current? Even are you sure that you don't have
> some reset our of the ofono service that send an at command that
> restart the modem?

Just to try to prevent us from going down the wrong rabbit hole here:
i)  The modem is a QMI device so there are no AT commands being sent
ii)  The ofono log should show any such command if it were being =

transmitted (unfortunately, JH hasn't been able to produce a proper log =

around this event, yet)
iii)  I'm pretty certain that the QMI (gobi) driver in ofono doesn't =

support any 'reset' command

My inclination would be to look elsewhere.

i)  figure out what reset signalling the modem does and put a scope on it.
ii)  try to eliminate ofono and connman from the picture entirely by =

running the modem manually... what's the utility called, qmictl?  comes =

with libqmi, in any case.  Presumably, if it's a hardware issue, the =

problem will show itself under these circumstances, as well.

/Jonas


> =

> Michael
> =

>>
>> Aug 17 08:51:49 solar kernel: usb 1-1: new high-speed USB device number
>> 4 using ci_hdrc
>> Aug 17 08:51:50 solar kernel: usb 1-1: New USB device found,
>> idVendor=3D05c6, idProduct=3D90b2, bcdDevice=3D 0.00
>> Aug 17 08:51:50 solar kernel: usb 1-1: New USB device strings: Mfr=3D3,
>> Product=3D2, SerialNumber=3D4
>> Aug 17 08:51:50 solar kernel: usb 1-1: Product: Qualcomm CDMA
>> Technologies MSM
>> Aug 17 08:51:50 solar kernel: usb 1-1: Manufacturer: Qualcomm, Incorpora=
ted
>> Aug 17 08:51:50 solar kernel: usb 1-1: SerialNumber: 5ff10299
>> Aug 17 08:51:50 solar kernel: option 1-1:1.0: GSM modem (1-port)
>> converter detected
>> Aug 17 08:51:50 solar kernel: usb 1-1: GSM modem (1-port) converter now
>> attached to ttyUSB0
>> Aug 17 08:51:50 solar kernel: option 1-1:1.2: GSM modem (1-port)
>> converter detected
>> Aug 17 08:51:50 solar kernel: usb 1-1: GSM modem (1-port) converter now
>> attached to ttyUSB1
>> Aug 17 08:51:50 solar kernel: qmi_wwan 1-1:1.3: cdc-wdm0: USB WDM device
>> Aug 17 08:51:50 solar kernel: qmi_wwan 1-1:1.3 wwan0: register
>> 'qmi_wwan' at usb-ci_hdrc.1-1, WWAN/QMI device, f6:0d:90:fa:af:24
>>
>> ofono should _definitely_ show this device reenumeration in its logs.
>> Why is that not there???
>>
>> -----------------------
>>
>> Subsequently, the kernel log shows:
>>
>> Aug 17 11:32:43 solar kernel: usb 1-1: USB disconnect, device number 4
>> Aug 17 11:32:43 solar kernel: option1 ttyUSB0: GSM modem (1-port)
>> converter now disconnected from ttyUSB0
>> Aug 17 11:32:43 solar kernel: option 1-1:1.0: device disconnected
>> Aug 17 11:32:43 solar kernel: option1 ttyUSB1: GSM modem (1-port)
>> converter now disconnected from ttyUSB1
>> Aug 17 11:32:43 solar kernel: option 1-1:1.2: device disconnected
>> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3: nonzero urb status
>> received: -71
>>
>> Again, comm error.
>>
>> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback - 0 byt=
es
>> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback -
>> usb_submit_urb failed with result -19
>> Aug 17 11:32:44 solar kernel: qmi_wwan 1-1:1.3 wwan0: unregister
>> 'qmi_wwan' usb-ci_hdrc.1-1, WWAN/QMI device
>>
>> Modem has rebooted and is reenumerated below.
>>
>> Aug 17 11:32:44 solar kernel: usb 1-1: new high-speed USB device number
>> 5 using ci_hdrc
>> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device found,
>> idVendor=3D05c6, idProduct=3D90b2, bcdDevice=3D 0.00
>> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device strings: Mfr=3D1,
>> Product=3D2, SerialNumber=3D3
>> Aug 17 11:32:45 solar kernel: usb 1-1: Product: QHSUSB__BULK
>> Aug 17 11:32:45 solar kernel: usb 1-1: Manufacturer: Qualcomm CDMA
>> Technologies MSM
>> Aug 17 11:32:45 solar kernel: usb 1-1: SerialNumber: 5ff10299
>> Aug 17 11:32:45 solar kernel: option 1-1:1.0: GSM modem (1-port)
>> converter detected
>> Aug 17 11:32:45 solar kernel: usb 1-1: GSM modem (1-port) converter now
>> attached to ttyUSB0
>>
>> Here, however, the modem isn't booting up into normal operational state,
>> but rather into some other configuration that, presumably, is intended
>> for doing device firmware updates...
>>
>> So you have a couple of things to figure out:
>> i)  Why is the modem restarting (crashing) spontaneously?
>> ii) What are the conditions for entering the bootloader/firmware update
>> state?  How are you managing to meet these conditions?
>> iii)  Why is ofono not showing the device reenumeration... it should,
>> and it should show the modem being taken down and brought back up again.
>>    (I suspect it's just a matter of your logs being out of sync... it's
>> probably there if you look, again).
>>
>>>
>>> Let me further clarify it, the issue did not occur very often, it
>>> occurred randomly between hours to many days, that is a big worry, LTE
>>> should be 100% stable.
>>
>> The issue doesn't seem to have anything to do with the radio link.  The
>> LTE is probably stable; the issue lies elsewhere.
>>
>> /Jonas
>>
>>>
>>> Thank you.
>>>
>>> Kind regards,
>>>
>>> - jh
>>>
> =

> =

>=20

--===============9029671116479637106==--

