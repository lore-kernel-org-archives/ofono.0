Content-Type: multipart/mixed; boundary="===============8889534315562970655=="
MIME-Version: 1.0
From: milan.satpathy@accenture.com
Subject: RE: [HELP Required]Routing Of SCO data to BT Host Speaker
Date: Fri, 11 Mar 2011 20:13:59 +0530
Message-ID: <10D123A956DC4B4FA9D7A48B3335836214DEF015CB@INDXM3131.dir.svc.accenture.com>
In-Reply-To: <20110311072142.GA2454@candlejack.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8889534315562970655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the quick assistance.

I tried the same approach as suggested by you.

Steps:
------
1.$pacmd
2.$list-sources
( got 2 sources )

  name: <alsa_output.pci-0000_00_05.0.analog-stereo.monitor>

  (and)

  name: <alsa_input.pci-0000_00_05.0.analog-stereo>
3.$list-sinks
( got 1 sink )

name: <alsa_output.pci-0000_00_05.0.analog-stereo>

4.created a shell script "ofono.sh" with contents as below:
pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_05.0.ana=
log-stereo" sink=3D"bluez_sink.A8_7E_33_AF_23_A4"
pactl load-module module-loopback source=3D"bluez_source.A8_7E_33_AF_23_A4"=
 sink=3D"alsa_output.pci-0000_00_05.0.analog-stereo"
(A8_7E_33_AF_23_A4 is the BT address of handset paired to the host)

5. Now I connect the host to the handset through HFP.
6.After SLC is established , I dial a number and establish a voice call.
7.As soon as the state is "Playing" ( SCO connected) , I run the "ofono.sh"=
 ( as mentioned in step 4).

Result:
-------
I am getting the following errors:

Failure: Module initalization failed
Failure: Module initalization failed


Requesting Clarification
------------------------
1.I was wondering if any modification is required in pulseaudio configurati=
on files to enable dynamic loading of module-loopback.( e.g "module-loading=
 =3D yes" in /etc/pulse/daemon.conf ).Currently all settings are maintained=
 as default.

2.Also, do I need to modify "SCORouting=3DPCM" in "audio.conf" file. (defau=
lt is HCI)

It will be of great help to receive any further inputs regarding the above =
issue.

Best Regards,
Milan

-----Original Message-----
From: Daniel Wagner [mailto:wagi(a)monom.org]
Sent: Friday, March 11, 2011 12:52 PM
To: Satpathy, Milan
Cc: ofono(a)ofono.org
Subject: Re: [HELP Required]Routing Of SCO data to BT Host Speaker

Hi Milan,

On Fri, Mar 11, 2011 at 10:56:34AM +0530, milan.satpathy(a)accenture.com wr=
ote:
> Hi,
>
> Recently I have been trying to use Ofono to write a Handsfree based appli=
cation( Using C on Ubuntu 10.10).
> I am able to connect(SLC) to the AG using Ofono. After connection I am al=
so successful in dialing to another number.
> Bluetoothd indicates status as "Playing" ( SCO connection successful) onc=
e the call is established.
>
> Problem Faced:
> ----------------------
> However, after accepting the call I am unable to hear any voice through t=
he speaker.

You might have to loop back the PulseAudio BT source and sink to your sound=
 card, e.g.

pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_1b.0.ana=
log-stereo" sink=3D"bluez_sink.78_47_1D_44_34_10"
pactl load-module module-loopback source=3D"bluez_source.78_47_1D_44_34_10"=
 sink=3D"alsa_output.pci-0000_00_1b.0.analog-stereo"

You have to do this within 5 seconds after the SCO connection has been
established otherwise PulseAudio will suspend (which leads to a BT
stream stop) the streams.

HTH,
daniel


This message is for the designated recipient only and may contain privilege=
d, proprietary, or otherwise private information.  If you have received it =
in error, please notify the sender immediately and delete the original.  An=
y other use of the email by you is prohibited.

--===============8889534315562970655==--

