Content-Type: multipart/mixed; boundary="===============1752482681999471004=="
MIME-Version: 1.0
From: Samiran Sarkar <samiran.s@hcl.com>
Subject: RE: Ofono 1.17 over bluez5 Bluetooth : A2DP and AVRCP is working fine
 , but HFP- No sound -Mic/Speaker ?
Date: Tue, 02 Feb 2016 11:52:51 +0000
Message-ID: <PS1PR0401MB1529A7DDB64BA053E23B77D3E4DF0@PS1PR0401MB1529.apcprd04.prod.outlook.com>
In-Reply-To: <088CC8BACB3382439E91D9919CE350245032CE1A@IRSMSX108.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1752482681999471004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

Thanks for your support , still problem is there - no Audio input/output ( =
USB headphone - connected to the target hardware)


I have modified =

/etc/pulse/default.pa  ( there is no default.conf)
load-module module-bluetooth-discover headset=3Dofono   ( earlier it was   =
headset=3Dauto)

after modifying default.ps =


I rebooted.
Steps done.
1. connected a Phone over Bluetooth.
2. started Pulseaudio
3. pactl set-card-profile bluez_card.F8_32_E4_FB_FD_28 headset_audio_gateway

Then made a call from target --( ofono- bluez5)-- call goes  out ----answer=
ed  -- no Sound.
4. Incoming call - answered in Target hardware -

In both the cases I  made sure that conversation is transferred ( from phon=
e ) over Bluetooth device ( there is no audio output at the phone side) tha=
t means conversation has been transferred to target hardware -- but .......=
.no sound =


Any other check points to make target Audio output.

Thanks
Samiran



Some logs are .............................................................=
............................................................

root(a)baytrail32:~# systemctl status pulseaudio
=E2=97=8F pulseaudio.service - pulseaudio server
   Loaded: loaded (/lib/systemd/system/pulseaudio.service; disabled)
   Active: active (running) since Thu 2015-12-10 10:41:24 UTC; 1h 37min ago
  Process: 403 ExecStartPre=3D/bin/chmod 0700 /run/user/root/pulse (code=3D=
exited, status=3D0/SUCCESS)
  Process: 400 ExecStartPre=3D/bin/mkdir -p /run/user/root/pulse (code=3Dex=
ited, status=3D0/SUCCESS)
 Main PID: 406 (pulseaudio)
   CGroup: /system.slice/pulseaudio.service
           =E2=94=94=E2=94=80406 /usr/bin/pulseaudio --log-level=3D0 --exit=
-idle-time=3D-1

Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] main.c: Sink al=
sa_output.usb-Jabra_Jabra_UC_VOICE_150_duo_0000000...exist.
Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] main.c: Source =
alsa_input.usb-Jabra_Jabra_UC_VOICE_150_duo_000000...exist.
Dec 10 10:41:24 baytrail32 pulseaudio[406]: E: [pulseaudio] backend-ofono.c=
: Deferred setup failed on fd -1: Transport endpoi...nected
Dec 10 12:18:01 baytrail32 pulseaudio[406]: E: [pulseaudio] backend-ofono.c=
: Deferred setup failed on fd -1: Transport endpoi...nected
Hint: Some lines were ellipsized, use -l to show in full.

...........................................................................=
..............................................
root(a)baytrail32:~# systemctl status bluetooth
=E2=97=8F bluetooth.service - Bluetooth service
   Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled)
   Active: active (running) since Thu 2015-12-10 10:09:00 UTC; 2h 9min ago
     Docs: man:bluetoothd(8)
 Main PID: 252 (bluetoothd)
   Status: "Running"
   CGroup: /system.slice/bluetooth.service
           =E2=94=94=E2=94=80252 /usr/lib/bluez5/bluetooth/bluetoothd

Dec 10 10:40:16 baytrail32 bluetoothd[252]: Endpoint registered: sender=3D:=
1.13 path=3D/MediaEndpoint/A2DPSource
Dec 10 10:40:16 baytrail32 bluetoothd[252]: Endpoint registered: sender=3D:=
1.13 path=3D/MediaEndpoint/A2DPSink
Dec 10 10:40:36 baytrail32 bluetoothd[252]: Endpoint unregistered: sender=
=3D:1.13 path=3D/MediaEndpoint/A2DPSource
Dec 10 10:40:36 baytrail32 bluetoothd[252]: Endpoint unregistered: sender=
=3D:1.13 path=3D/MediaEndpoint/A2DPSink
Dec 10 10:41:11 baytrail32 bluetoothd[252]: a2dp-source profile connect fai=
led for F8:32:E4:FB:FD:28: Protocol not available
Dec 10 10:41:24 baytrail32 bluetoothd[252]: Endpoint registered: sender=3D:=
1.15 path=3D/MediaEndpoint/A2DPSource
Dec 10 10:41:24 baytrail32 bluetoothd[252]: Endpoint registered: sender=3D:=
1.15 path=3D/MediaEndpoint/A2DPSink
Dec 10 12:18:02 baytrail32 bluetoothd[252]: Can't open input device: No suc=
h file or directory (2)
Dec 10 12:18:02 baytrail32 bluetoothd[252]: AVRCP: failed to init uinput fo=
r F8:32:E4:FB:FD:28
Dec 10 12:18:13 baytrail32 bluetoothd[252]: /org/bluez/hci0/dev_F8_32_E4_FB=
_FD_28/fd0: fd(23) ready

...........................................................................=
..............................................

root(a)baytrail32:~# systemctl status ofono
=E2=97=8F ofono.service - Telephony service
   Loaded: loaded (/lib/systemd/system/ofono.service; enabled)
   Active: active (running) since Thu 2015-12-10 10:09:00 UTC; 2h 9min ago
 Main PID: 197 (ofonod)
   CGroup: /system.slice/ofono.service
           =E2=94=94=E2=94=80197 /usr/sbin/ofonod -n

Dec 10 10:09:00 baytrail32 ofonod[197]: oFono version 1.17
Dec 10 10:41:11 baytrail32 ofonod[197]: Service level connection established
Dec 10 12:18:01 baytrail32 ofonod[197]: Service level connection established

...........................................................................=
..............................................
Card #5
        Name: bluez_card.F8_32_E4_FB_FD_28
        Driver: module-bluez5-device.c
        Owner Module: 26
        Properties:
                device.description =3D "ASUS Z00LD"
                device.string =3D "F8:32:E4:FB:FD:28"
                device.api =3D "bluez"
                device.class =3D "sound"
                device.bus =3D "bluetooth"
                device.form_factor =3D "phone"
                bluez.path =3D "/org/bluez/hci0/dev_F8_32_E4_FB_FD_28"
                bluez.class =3D "0x5a020c"
                bluez.alias =3D "ASUS_Z00LD"
                device.icon_name =3D "audio-card-bluetooth"
        Profiles:
                a2dp_source: High Fidelity Capture (A2DP Source) (sinks: 0,=
 sources: 1, priority: 10, available: yes)
                headset_audio_gateway: Headset Audio Gateway (HSP/HFP) (sin=
ks: 1, sources: 1, priority: 20, available: yes)
                off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
        Active Profile: off
        Ports:
                phone-output: Phone (priority: 0, latency offset: 0 usec)
                        Part of profile(s): headset_audio_gateway
                phone-input: Phone (priority: 0, latency offset: 0 usec)
                        Part of profile(s): a2dp_source, headset_audio_gate=
way

...........................................................................=
..............................................

btmon -S
Bluetooth monitor ver 5.37
=3D New Index: 34:B1:F7:8C:72:B8 (BR/EDR,UART,hci0)                        =
                                             [hci0] 0.665769
> HCI Event: Mode Change (0x14) plen 6                                     =
                                           [hci0] 0.868252
        Status: Success (0x00)
        Handle: 1
        Mode: Sniff (0x02)
        Interval: 500.000 msec (0x0320)
> HCI Event: Mode Change (0x14) plen 6                                     =
                                           [hci0] 5.108358
        Status: Success (0x00)
        Handle: 1
        Mode: Active (0x00)
        Interval: 0.000 msec (0x0000)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                           [hci0] 5.113089
        Handle: 1
        Max slots: 1
> HCI Event: Connect Request (0x04) plen 10                                =
                                           [hci0] 5.114393
        Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
        Link type: eSCO (0x02)
< HCI Command: Accept Synchronous Connection Request (0x01|0x0029) plen 21 =
                                           [hci0] 5.115881
        Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 65535
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding@MSB: 0
          Air Coding Format: CVSD
        Retransmission effort: Don't care (0xff)
        Packet type: 0x003f
          HV1 may be used
          HV2 may be used
          HV3 may be used
          EV3 may be used
          EV4 may be used
          EV5 may be used
> HCI Event: Command Status (0x0f) plen 4                                  =
                                           [hci0] 5.116894
      Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                             =
                                           [hci0] 5.124180
        Handle: 0
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Synchronous Connect Complete (0x2c) plen 17                   =
                                           [hci0] 5.124646
        Status: Success (0x00)
        Handle: 257
        Address: F8:32:E4:FB:FD:28 (OUI F8-32-E4)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x02
        RX packet length: 60
        TX packet length: 60
        Air mode: CVSD (0x02)
< SCO Data TX: Handle 257 flags 0x00 dlen 48                               =
                                           [hci0] 5.125041
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> HCI Event: Command Status (0x0f) plen 4                                  =
                                           [hci0] 5.125763
      Disconnect (0x01|0x0006) ncmd 1
        Status: Unknown Connection Identifier (0x02)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                           [hci0] 5.127917
        Handle: 1
        Max slots: 5
< SCO Data TX: Handle 257 flags 0x00 dlen 48                               =
                                           [hci0] 5.128235
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
< SCO Data TX: Handle 257 flags 0x00 dlen 48                               =
                                           [hci0] 5.131186
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
< SCO Data TX: Handle 257 flags 0x00 dlen 48                               =
                                           [hci0] 5.134140
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                          [hci0] 12.149850
        Handle: 1
        Max slots: 1
> HCI Event: Mode Change (0x14) plen 6                                     =
                                          [hci0] 12.150152
        Status: Success (0x00)
        Handle: 1
        Mode: Sniff (0x02)
        Interval: 93.750 msec (0x0096)
> ACL Data RX: Handle 1 flags 0x02 dlen 22                                 =
                                          [hci0] 18.027348
      Channel: 65 len 18 [PSM 0 mode 0] {chan 0}
        19 ef 1d 0d 0a 2b 43 49 45 56 3a 20 31 2c 31 0d  .....+CIEV: 1,1.
        0a 55                                            .U
> ACL Data RX: Handle 1 flags 0x02 dlen 22                                 =
                                          [hci0] 18.028425
      Channel: 65 len 18 [PSM 0 mode 0] {chan 0}
        19 ef 1d 0d 0a 2b 43 49 45 56 3a 20 32 2c 30 0d  .....+CIEV: 2,0.
        0a 55                                            .U
> ACL Data RX: Handle 1 flags 0x02 dlen 19                                 =
                                          [hci0] 30.777623
      Channel: 65 len 15 [PSM 0 mode 0] {chan 0}
        19 ef 17 0d 0a 2b 56 47 53 3a 20 38 0d 0a 55     .....+VGS: 8..U
> ACL Data RX: Handle 1 flags 0x02 dlen 19                                 =
                                          [hci0] 31.527641
      Channel: 65 len 15 [PSM 0 mode 0] {chan 0}
        19 ef 17 0d 0a 2b 56 47 53 3a 20 39 0d 0a 55     .....+VGS: 9..U
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 31.808997
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 30 0d 0a 55  .....+VGS: 10..U
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 31.997641
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 31 0d 0a 55  .....+VGS: 11..U
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 32.277663
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 32 0d 0a 55  .....+VGS: 12..U
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 32.465198
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 33 0d 0a 55  .....+VGS: 13..U
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 32.746433
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 34 0d 0a 55  .....+VGS: 14..U
< ACL Data TX: Handle 1 flags 0x00 dlen 9                                  =
                                          [hci0] 32.746557
      Channel: 79 len 5 [PSM 0 mode 0] {chan 0}
        1b ff 01 1e 93                                   .....
< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2                        =
                                          [hci0] 32.746610
        Handle: 1
> HCI Event: Command Status (0x0f) plen 4                                  =
                                          [hci0] 32.747147
      Exit Sniff Mode (0x02|0x0004) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
                                          [hci0] 32.751182
        Num handles: 1
        Handle: 1
        Count: 1
> HCI Event: Mode Change (0x14) plen 6                                     =
                                          [hci0] 32.751489
        Status: Success (0x00)
        Handle: 1
        Mode: Active (0x00)
        Interval: 0.000 msec (0x0000)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                          [hci0] 32.751556
        Handle: 1
        Max slots: 5
> ACL Data RX: Handle 1 flags 0x02 dlen 20                                 =
                                          [hci0] 32.947683
      Channel: 65 len 16 [PSM 0 mode 0] {chan 0}
        19 ef 19 0d 0a 2b 56 47 53 3a 20 31 35 0d 0a 55  .....+VGS: 15..U
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                          [hci0] 39.820467
        Handle: 1
        Max slots: 1
> HCI Event: Mode Change (0x14) plen 6                                     =
                                          [hci0] 39.820563
        Status: Success (0x00)
        Handle: 1
        Mode: Sniff (0x02)
        Interval: 93.750 msec (0x0096)
> HCI Event: Disconnect Complete (0x05) plen 4                             =
                                          [hci0] 53.990896
        Status: Success (0x00)
        Handle: 257
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                          [hci0] 53.990968
        Handle: 1
        Max slots: 5
> ACL Data RX: Handle 1 flags 0x02 dlen 22                                 =
                                          [hci0] 54.085643
      Channel: 65 len 18 [PSM 0 mode 0] {chan 0}
        19 ef 1d 0d 0a 2b 43 49 45 56 3a 20 31 2c 30 0d  .....+CIEV: 1,0.
        0a 55                                            .U
> HCI Event: Sniff Subrating (0x2e) plen 11                                =
                                          [hci0] 54.361880
        Status: Success (0x00)
        Handle: 1
        Max transmit latency: 93.750 msec (0x0096)
        Max receive latency: 750.000 msec (0x04b0)
        Min remote timeout: 0.000 msec (0x0000)
        Min local timeout: 1.250 msec (0x0002)
> HCI Event: Mode Change (0x14) plen 6                                     =
                                          [hci0] 61.115871
        Status: Success (0x00)
        Handle: 1
        Mode: Active (0x00)
        Interval: 0.000 msec (0x0000)
> HCI Event: Mode Change (0x14) plen 6                                     =
                                          [hci0] 61.145747
        Status: Success (0x00)
        Handle: 1
        Mode: Sniff (0x02)
        Interval: 500.000 msec (0x0320)


-----Original Message-----
From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Pawlak, KubaX T
Sent: Tuesday, February 02, 2016 4:44 PM
To: ofono(a)ofono.org
Subject: RE: Ofono 1.17 over bluez5 Bluetooth : A2DP and AVRCP is working f=
ine , but HFP- No sound -Mic/Speaker ?

Hi Samiran,

> I 'm using an Intel IVI development board,
> =

> Configuration is like this,  using Bluez -5.37, Pulseaudio 6.0 , ofono =

> 1.17, Bluetooth A2DP and AVRCP is working fine , HFP is showing =

> working but no sound -

Connect a phone and do 'pactl list cards'. Your phone should be there as a =
card.
If not then edit /etc/pulse/default.conf , find line saying:
load-module module-bluetooth-discover
and add "headset=3Dofono" at the end of it, so it looks like this:
load-module module-bluetooth-discover headset=3Dofono

Reboot, reconnect and check again. Virtual audio card should be there.

Regards,
Kuba
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter Chairperson=
 of the Supervisory Board: Nicole Lau Registered Office: Munich Commercial =
Register: Amtsgericht Muenchen HRB 186928 _________________________________=
______________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============1752482681999471004==--

