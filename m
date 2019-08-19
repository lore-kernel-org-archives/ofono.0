Content-Type: multipart/mixed; boundary="===============4227080083622075806=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Mon, 19 Aug 2019 09:56:14 +0200
Message-ID: <83621761-cf50-f5a9-9a17-bcc46cee4895@norrbonn.se>
In-Reply-To: <bd0f33b0-91c9-95d3-fb02-0b8162ce47d9@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4227080083622075806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 19/08/2019 09:50, Jonas Bonn wrote:
> =

> =

> On 19/08/2019 09:36, Michael Nazzareno Trimarchi wrote:
>> Hi
>>
>> On Mon, Aug 19, 2019 at 7:38 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>>> The kernel log has this:
>>>
>>> Aug 17 08:51:46 solar kernel: usb 1-1: USB disconnect, device number 3
>>> Aug 17 08:51:46 solar kernel: option1 ttyUSB0: GSM modem (1-port)
>>> converter now disconnected from ttyUSB0
>>> Aug 17 08:51:46 solar kernel: option 1-1:1.0: device disconnected
>>> Aug 17 08:51:46 solar kernel: option1 ttyUSB1: GSM modem (1-port)
>>> converter now disconnected from ttyUSB1
>>> Aug 17 08:51:46 solar kernel: option 1-1:1.2: device disconnected
>>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: nonzero urb status
>>> received: -71
>>>
>>> That's a USB communication failure!
>>>
>>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback - 0 =

>>> bytes
>>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3: wdm_int_callback -
>>> usb_submit_urb failed with result -19
>>> Aug 17 08:51:46 solar kernel: qmi_wwan 1-1:1.3 wwan0: unregister
>>> 'qmi_wwan' usb-ci_hdrc.1-1, WWAN/QMI device
>>>
>>> Below, the device (modem) is reenumerated, which would indicate to me
>>> that it has restarted.=C2=A0 I don't think the kernel automatically sen=
ds a
>>> reset to a device on comm failures...???=C2=A0 This explains the
>>> communication failure, at least.
>>
>> Can be chattering and rush current? Even are you sure that you don't have
>> some reset our of the ofono service that send an at command that
>> restart the modem?
> =

> Just to try to prevent us from going down the wrong rabbit hole here:
> i)=C2=A0 The modem is a QMI device so there are no AT commands being sent
> ii)=C2=A0 The ofono log should show any such command if it were being =

> transmitted (unfortunately, JH hasn't been able to produce a proper log =

> around this event, yet)
> iii)=C2=A0 I'm pretty certain that the QMI (gobi) driver in ofono doesn't =

> support any 'reset' command
> =

> My inclination would be to look elsewhere.
> =

> i)=C2=A0 figure out what reset signalling the modem does and put a scope =
on it.
> ii)=C2=A0 try to eliminate ofono and connman from the picture entirely by =

> running the modem manually... what's the utility called, qmictl?=C2=A0 co=
mes =

> with libqmi, in any case.=C2=A0 Presumably, if it's a hardware issue, the =

> problem will show itself under these circumstances, as well.
> =


Is the problem reproducible with the EVK?  If not, you've pretty much =

eliminated software as the cause of the issue... it's the same device, =

but with an independent power supply.

/Jonas

--===============4227080083622075806==--

