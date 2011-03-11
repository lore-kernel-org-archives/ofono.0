Content-Type: multipart/mixed; boundary="===============9180864915326011750=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [HELP Required]Routing Of SCO data to BT Host Speaker
Date: Fri, 11 Mar 2011 08:21:42 +0100
Message-ID: <20110311072142.GA2454@candlejack.bmw-carit.intra>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836214DEE684E4@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9180864915326011750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On Fri, Mar 11, 2011 at 10:56:34AM +0530, milan.satpathy(a)accenture.com wr=
ote:
> Hi,
> =

> Recently I have been trying to use Ofono to write a Handsfree based appli=
cation( Using C on Ubuntu 10.10).
> I am able to connect(SLC) to the AG using Ofono. After connection I am al=
so successful in dialing to another number.
> Bluetoothd indicates status as "Playing" ( SCO connection successful) onc=
e the call is established.
> =

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

--===============9180864915326011750==--

