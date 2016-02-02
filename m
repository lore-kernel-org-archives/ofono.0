Content-Type: multipart/mixed; boundary="===============2596461669965589009=="
MIME-Version: 1.0
From: Pawlak, KubaX T <kubax.t.pawlak@intel.com>
Subject: RE: Ofono 1.17 over bluez5 Bluetooth : A2DP and AVRCP is working fine
 , but HFP- No sound -Mic/Speaker ?
Date: Tue, 02 Feb 2016 14:09:30 +0000
Message-ID: <088CC8BACB3382439E91D9919CE350245032DEEB@IRSMSX108.ger.corp.intel.com>
In-Reply-To: <PS1PR0401MB1529A7DDB64BA053E23B77D3E4DF0@PS1PR0401MB1529.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2596461669965589009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Samiran,

> /etc/pulse/default.pa  ( there is no default.conf)
Oops, my mistake.


> Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] main.c: Sink
> alsa_output.usb-Jabra_Jabra_UC_VOICE_150_duo_0000000...exist.
> Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] main.c: Source
> alsa_input.usb-Jabra_Jabra_UC_VOICE_150_duo_000000...exist.
> Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] backend-ofono=
.c:
> Deferred setup failed on fd -1: Transport endpoi...nected
> Dec 10 12:18:01 baytrail32 pulseaudio[406]: E: [pulseaudio] backend-ofono=
.c:
> Deferred setup failed on fd -1: Transport endpoi...nected
> Hint: Some lines were ellipsized, use -l to show in full.

I've never seen this kind of an issue in PulseAudio. =


> HCI Event: Connect Request (0x04) plen 10
> [hci0] 5.114393
>         Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
>         Class: 0x000000
>           Major class: Miscellaneous
>           Minor class: 0x00
>         Link type: eSCO (0x02)
> < HCI Command: Accept Synchronous Connection Request (0x01|0x0029) plen
> 21                                            [hci0] 5.115881
>         Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 65535
>         Setting: 0x0060
>           Input Coding: Linear
>           Input Data Format: 2's complement
>           Input Sample Size: 16-bit
>           # of bits padding at MSB: 0
>           Air Coding Format: CVSD
>         Retransmission effort: Don't care (0xff)
>         Packet type: 0x003f
>           HV1 may be used
>           HV2 may be used
>           HV3 may be used
>           EV3 may be used
>           EV4 may be used
>           EV5 may be used
> > HCI Event: Command Status (0x0f) plen 4
> [hci0] 5.116894
>       Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Disconnect (0x01|0x0006) plen 3
> [hci0] 5.124180
>         Handle: 0
>         Reason: Remote User Terminated Connection (0x13)

So PulseAudio got some socket and calls accept, but there is something wron=
g and just closes the socket. So the issue is around accept. BTW there is a=
 kernel bug here, which is not fixed even in latest mainline. Disconnect is=
 called with handle: 0. This is rejected by the controller few lines below =
with "Unknown Connection Identifier" but kernel already cleaned up internal=
 structures. This is not a major issue here. You are lucky it did not crash.

> > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> [hci0] 5.124646
>         Status: Success (0x00)
>         Handle: 257
>         Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x0c
>         Retransmission window: 0x02
>         RX packet length: 60
>         TX packet length: 60
>         Air mode: CVSD (0x02)

Controller sets up a connection eventually, but there is no one to handle i=
t. =


> < SCO Data TX: Handle 257 flags 0x00 dlen 48
> [hci0] 5.125041
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > HCI Event: Command Status (0x0f) plen 4
> [hci0] 5.125763
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Unknown Connection Identifier (0x02)

Can't really tell you how to fix this. Apart from trying PulseAudio 7.1 or =
a newer kernel. I suggest the kernel. I never tried it on 3.8, only 3.12 (h=
ighly patched), 3.14(with many custom patches), 4.1 or 4.3. Unfortunately b=
ackports of Bluetooth subsystem to 3.8 are not available upstream. =



Kuba
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

--===============2596461669965589009==--

