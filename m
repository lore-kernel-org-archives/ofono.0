Content-Type: multipart/mixed; boundary="===============8720872841885742480=="
MIME-Version: 1.0
From: Bret Hassler <bret_hassler@starkey.com>
Subject: RE: Outgoing call from AG fails
Date: Wed, 08 Aug 2012 12:36:18 +0000
Message-ID: <7B61C5BDDF8BC44292054F5CB731ED1E031D16@ep2p-exmbs2.ms.starkey.com>
In-Reply-To: <5021154E.6020305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8720872841885742480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's a Vtech DS6321-3.
https://www.bluetooth.org/tpg/EPL_Detail.cfm?ProductID=3D13096
It provides a Handsfree Gateway service. I was wondering if it doesn't send=
 any callsetup indicators because it is not cellular. Otherwise, you're pro=
bably correct that it's not a proper device.

-Bret

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Tuesday, August 07, 2012 8:17 AM
To: ofono(a)ofono.org
Cc: Bret Hassler
Subject: Re: Outgoing call from AG fails

Hi Bret,

On 08/07/2012 04:58 PM, Bret Hassler wrote:
> I have a handsfree unit with ofono connecting to a VTech landline =

> phone as audio gateway. On outgoing calls, the only HFP notification =

> for the call is only a +CIEV: call status,1.
>

call indicator should not be going to 1 without first having the callsetup =
indicator going to 1.  Doesn't sound like this is a proper HFP device.  Wha=
t type of device is this?

> drivers/hfpmodem/voicecall.c: ciev_call_notify() will not do anything =

> if without a call already created. The VTech phone also returns error =

> to
> AT+CLCC command.
>
> I am thinking to create the ofono_call in drivers/hfpmodem/voicecall.c:
> ciev_call_notify() if no call has been created. However, this might =

> have big impacts other phones. Specifically, does "+CIEV: call =

> status,1" get emitted outside of standard phone calls, such as for =

> alarms or notifications with some phones? Any thoughts on this?
>

Instead of hcidump you might want to use the built-in oFono AT logging. =

  See HACKING for details.

Regards,
-Denis

--===============8720872841885742480==--

