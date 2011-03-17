Content-Type: multipart/mixed; boundary="===============1175439742949255808=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [HELP Required]Routing Of SCO data to BT Host Speaker
Date: Thu, 17 Mar 2011 15:21:57 +0100
Message-ID: <4D821905.7010402@monom.org>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836214DEF015CB@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1175439742949255808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

sorry, your mail got drowned in my inbox. I saw that Andreas had a tip.

HTH,
daniel

On 03/11/2011 03:43 PM, milan.satpathy(a)accenture.com wrote:
> Hi Daniel,
>
> Thanks for the quick assistance.
>
> I tried the same approach as suggested by you.
>
> Steps:
> ------
> 1.$pacmd
> 2.$list-sources
> ( got 2 sources )
>
>    name:<alsa_output.pci-0000_00_05.0.analog-stereo.monitor>
>
>    (and)
>
>    name:<alsa_input.pci-0000_00_05.0.analog-stereo>
> 3.$list-sinks
> ( got 1 sink )
>
> name:<alsa_output.pci-0000_00_05.0.analog-stereo>
>
> 4.created a shell script "ofono.sh" with contents as below:
> pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_05.0.a=
nalog-stereo" sink=3D"bluez_sink.A8_7E_33_AF_23_A4"
> pactl load-module module-loopback source=3D"bluez_source.A8_7E_33_AF_23_A=
4" sink=3D"alsa_output.pci-0000_00_05.0.analog-stereo"
> (A8_7E_33_AF_23_A4 is the BT address of handset paired to the host)
>
> 5. Now I connect the host to the handset through HFP.
> 6.After SLC is established , I dial a number and establish a voice call.
> 7.As soon as the state is "Playing" ( SCO connected) , I run the "ofono.s=
h" ( as mentioned in step 4).
>
> Result:
> -------
> I am getting the following errors:
>
> Failure: Module initalization failed
> Failure: Module initalization failed
>
>
> Requesting Clarification
> ------------------------
> 1.I was wondering if any modification is required in pulseaudio configura=
tion files to enable dynamic loading of module-loopback.( e.g "module-loadi=
ng =3D yes" in /etc/pulse/daemon.conf ).Currently all settings are maintain=
ed as default.
>
> 2.Also, do I need to modify "SCORouting=3DPCM" in "audio.conf" file. (def=
ault is HCI)
>
> It will be of great help to receive any further inputs regarding the abov=
e issue.
>
> Best Regards,
> Milan
>
> -----Original Message-----
> From: Daniel Wagner [mailto:wagi(a)monom.org]
> Sent: Friday, March 11, 2011 12:52 PM
> To: Satpathy, Milan
> Cc: ofono(a)ofono.org
> Subject: Re: [HELP Required]Routing Of SCO data to BT Host Speaker
>
> Hi Milan,
>
> On Fri, Mar 11, 2011 at 10:56:34AM +0530, milan.satpathy(a)accenture.com =
wrote:
>> Hi,
>>
>> Recently I have been trying to use Ofono to write a Handsfree based appl=
ication( Using C on Ubuntu 10.10).
>> I am able to connect(SLC) to the AG using Ofono. After connection I am a=
lso successful in dialing to another number.
>> Bluetoothd indicates status as "Playing" ( SCO connection successful) on=
ce the call is established.
>>
>> Problem Faced:
>> ----------------------
>> However, after accepting the call I am unable to hear any voice through =
the speaker.
>
> You might have to loop back the PulseAudio BT source and sink to your sou=
nd card, e.g.
>
> pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_1b.0.a=
nalog-stereo" sink=3D"bluez_sink.78_47_1D_44_34_10"
> pactl load-module module-loopback source=3D"bluez_source.78_47_1D_44_34_1=
0" sink=3D"alsa_output.pci-0000_00_1b.0.analog-stereo"
>
> You have to do this within 5 seconds after the SCO connection has been
> established otherwise PulseAudio will suspend (which leads to a BT
> stream stop) the streams.
>
> HTH,
> daniel
>
>
> This message is for the designated recipient only and may contain privile=
ged, proprietary, or otherwise private information.  If you have received i=
t in error, please notify the sender immediately and delete the original.  =
Any other use of the email by you is prohibited.


--===============1175439742949255808==--

