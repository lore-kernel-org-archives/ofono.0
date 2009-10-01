Content-Type: multipart/mixed; boundary="===============6588042314125612999=="
MIME-Version: 1.0
From: Jeroen Wouters <woutersj@gmail.com>
Subject: Re: how ofono runs with simulator
Date: Thu, 01 Oct 2009 13:44:47 +0200
Message-ID: <4AC4962F.708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6588042314125612999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gu, Yang wrote:
> The following steps work for latest 0.4 version:
>
> 1. Modify modem.conf to config your simulator
> # Sample for using phone simulator
> [phonesim]
> Driver=3Dphonesim
> Address=3D127.0.0.1
> Port=3D12345
>
> 2. Start simulator by
> Phonesim -p 12345 -gui data/moblin.xml
>
> 3. Start ofono by
> ofonod -nd
> =

> 4. power on the modem
> dbus-send --system --print-reply --dest=3Dorg.ofono /phonesim0 org.ofono.=
Modem.SetProperty string:Powered variant:boolean:true


Where can I find the moblin.xml file and the source code for the version of=
 phonesim you used?
I've looked for the xml file, but I can't find it. I've also tried the step=
s you describe with Ofono 0.6 and the phonesim version I found here:
https://svn.openmoko.org/trunk/src/host/qemu-neo1973/phonesim/
and with a couple of other XML response files I found on the net, but whate=
ver I do in the phonesim GUI, there is no response from Ofono.
Also, in Ofono, the /phonesim0 modem appears, but only has a org.ofono.SimM=
anager interface, no VoiceCallManager.

Thanks,
Jeroen



--===============6588042314125612999==--

