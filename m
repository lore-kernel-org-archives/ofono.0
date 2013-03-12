Content-Type: multipart/mixed; boundary="===============4933960535893020405=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Telit he910 ---- modem port got stuck
Date: Tue, 12 Mar 2013 12:53:08 -0500
Message-ID: <513F6B84.8030909@gmail.com>
In-Reply-To: <513F30AB.6060806@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4933960535893020405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/12/2013 08:42 AM, Jonas Bonn wrote:
> On 03/12/2013 02:26 PM, Ming Li Wu wrote:
>> Hello,
>>
>> I am using Telit HE910 modem, the version of firmware is 12.00.03.
>>
>> Sometimes, the modem port got stuck after sending AT+CGDCONT=3D1.
>> (Such as AT+CGDCONT=3D1,"IP","internet.tele2.se").
>>
>>
>> The following was the situation when this problem happened
>> Aux: > AT+CRSM=3D192,28621\r
>> Modem: > AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
>> Modem: < AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
>> Aux: < \r\n+CME ERROR: 4\r\n
>
> The problem, in short, is that the Telit HE910 does not support sending
> any AT command on the Modem port while there is an outstanding command
> on the Aux port (this should be true for all Telit modems). Does Ofono

Many M2M setups use the modem from multiple applications (e.g. one app =

uses one port for SMS, another for data, another for GPRS).  So I'd be =

surprised if the Telit firmware had such a limitation.  If that is the =

case, then the Telit firmware is broken and should be fixed.

> support synchronizing these two channels so that they effectively share
> a common command queue? If yes, how?

There is no such capability.  That would defeat the purpose of having =

multiple channels in the first place.  About the only thing you can do =

is drive everything off of the AUX serial port and only use the Modem =

port for entering into PPP mode.

Regards,
-Denis

--===============4933960535893020405==--

