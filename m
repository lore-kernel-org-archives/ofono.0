Content-Type: multipart/mixed; boundary="===============7545043391110999443=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: u-blox modem plugin: missing VoiceCallManager and MessageManager
 interfaces
Date: Mon, 07 Sep 2015 09:04:02 -0500
Message-ID: <55ED9952.6050405@gmail.com>
In-Reply-To: <CAJvjxsyYoj1BR73kYSpUPHXqZits9PF14N=E45smWFekFRab5A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7545043391110999443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On 09/07/2015 02:08 AM, Fabio wrote:
> Hello,
> I'm using the u-blox driver with a LISA-U200 modem: the modem is
> correctly detected, registers to the network, connects to vodafone apn
> and browses Internet.
> My problem is that the VoiceCallManager and MessageManager interfaces
> are not exposed, and I need to send sms and make calls.

The current u-blox driver does not instantiate the voicecall or sms =

atoms.  Someone (that has access to these devices) will have to write =

supporting code to enable the missing features.  Patches are always =

welcome :)

Regards,
-Denis

--===============7545043391110999443==--

