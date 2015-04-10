Content-Type: multipart/mixed; boundary="===============3476574112059301339=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Port configuration for location services on Telit HE910
Date: Fri, 10 Apr 2015 09:45:30 -0500
Message-ID: <5527E20A.70703@gmail.com>
In-Reply-To: <loom.20150410T151424-282@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3476574112059301339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Izhar,

On 04/10/2015 08:20 AM, Izhar Mahalalel wrote:
> Hi,
>
> I'm trying to enable the LocationReporting interface in ofono. If I
> understood the documentation correctly, in order for this interface to sh=
ow
> up in Manager.GetModems, I need first to send an appropriate AT command to
> the device, for it to change to port configuration #8, and then power cyc=
le
> the board for changes to take effect.
>
> I have tried the following:
>
> # systemctl stop ofono
> # cat /dev/ttyACM3 &
> # echo 'AT#PORTCFG=3D8\r' > /dev/ttyACM3
>
> OK
>
> # reboot
>

Reboot the modem, not the system.

> But I still do not see the location reporting interface when running
> Manager.GetModems:
>

I would enable AT command debugging and follow the logic inside =

drivers/telitmodem/location-reporting.c.  Maybe one of the AT commands =

fails or the ports are setup differently on your particular version of =

the hardware.

Regards,
-Denis

--===============3476574112059301339==--

