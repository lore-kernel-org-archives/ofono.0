Content-Type: multipart/mixed; boundary="===============5165309734818594200=="
MIME-Version: 1.0
From: Kallumari Nagaraja Rao, RammohanX <rammohanx.kallumari.nagaraja.rao@intel.com>
Subject: RE: telit he910 activate-context issue
Date: Fri, 06 Mar 2015 04:20:52 +0000
Message-ID: <222E70FA67D72A4FB8EEDF5AF01724ACC9985E@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <54F87F32.1000606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5165309734818594200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

First of all I am trying these on DK300 device.

Yes I am on root. I have added tun.conf into /etc/init.d & have checked tun=
 getting loaded via lsmod.
I have tried enabling OFONO_AT_DEBUG=3D1, but will send out the log for ref=
erence.

Regards,
<Ram>


-----Original Message-----
From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Denis Kenzior
Sent: Thursday, March 05, 2015 9:37 PM
To: ofono(a)ofono.org
Subject: Re: telit he910 activate-context issue

Hi Ram,

On 03/05/2015 05:56 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> I am currently trying to get the cellular connection up via =

> connman/ofono. We are using Telit HE910 device.
>
> I am currently able to do the following ,
>
> 1.Run daemon in background
>
> 2.Execute enable-modem app
>
> 3.List-contexts, set APN to required value

Are you running with root permissions?  Telit uses PPP for its context driv=
er, which requires us to create a TUN/TAP device.

Can you enable AT command tracing:
export OFONO_AT_DEBUG=3D1

and run oFono with debug information enabled:
sudo ofonod -n -d

Then share this log.

>
> However, while executing 'activate-context 0' I am not able to proceed =

> further.
>
> I get the following error message,
>
> "DBusException: org.freedesktop.DBus.Error.NoReply: Did not receive a rep=
ly.
>
> Possible causes include: the remote application did not send a reply, =

> the
>
> message bus security policy blocked the reply, the reply timeout =

> expired, or
>
> the network connection was broken."
>

Hard to say without an AT command trace, but sounds like the modem is not r=
esponding to the context activation.  Would need additional information to =
say more.

Regards,
-Denis
_______________________________________________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============5165309734818594200==--

