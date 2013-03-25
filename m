Content-Type: multipart/mixed; boundary="===============5181482810278961489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting Up oFono-1.3 with Telit HE 910
Date: Mon, 25 Mar 2013 11:29:56 -0500
Message-ID: <51507B84.2040800@gmail.com>
In-Reply-To: <CAMtf1D_gk4HtsvB=VHzS+RCnZi3ntZdpFkkamNNbKjvs5Oojow@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5181482810278961489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

On 03/25/2013 10:59 AM, Etienne Mabille wrote:
> Hello everyone,
>
> I am new to the oFono project and am currently trying to set up a Telit
> HE 910 with oFono-1.3
> I looked into the documentation and the code itself but I still have
> some issues.
>
> So far, I have added this udev rule:
>
> ATTRS(idVendor)=3D=3D"1bc7", ATTRS(idProduct)=3D=3D"0021", ENV(OFONO_DRIV=
ER)=3D"telit"
>
> And I have added the changes listed here : Udevng: Support Telit Modems
> Using Cdc-acm Drive
> <http://lists.linuxwimax.org/pipermail/ofono/2012-December/013973.html>
>
> When I run ofono, the telit driver is not loaded properly. Using the
> debug option and adding some DBG messages, I found that during
> the execution of "ofono_modem_register", the "telit" driver is not in
> the in the list.
> I tracked the problem all the way up to the configure file.
> It seems that the Telit plugin needs the Bluetooth option enabled, to be
> included in the built-in modules.
>
> Does anyone know why ? Is it possible to bypass this ?
>
> Any help or clarification will be greatly appreciated.
>

The telit driver is also used to run the Bluetooth SAP client capability =

of the UC864 modems.  This capability requires BlueZ 4.  It should be =

possible to auto-detect the presence of BlueZ on the system at run time, =

however no one has done this work yet.  Hence this plugin requires =

bluetooth capability.

Regards,
-Denis

> Etienne

--===============5181482810278961489==--

