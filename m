Content-Type: multipart/mixed; boundary="===============6620771098569409665=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: HFP HF - Reject SCO Issue
Date: Wed, 25 May 2016 11:01:26 +0000
Message-ID: <HK2PR04MB1203FD52E58A2F1BA7F7D264DE400@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6620771098569409665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to configure HFP with Bluez(5.34), Ofono(1.17) and pulseaudio(6=
) on a Freescale i.MX6 board using Linux 4.1.15 kernel, the idea is to use =
the target board in HFP/Handsfree Unit role. The bluetooth controller is a =
Pluggable USB Bluetooth Dongle (0a5c:21e8 - BCM20702A0) with updated firmwa=
re.

The procedure followed is, =


* Pair & connect with the android mobile phone with the bluetoothctl =

* Enable modem and dial number using ofono test scripts

After this the call is being made but the audio routing fails with "Reject =
SCO : Agent not registered" message from oFono. While checking with btmon i=
ts found that the SCO Connect Request has been rejected with the reason of =
limited resources(0x0d).

Can anyone help me to identify the root cause, I spent a lot of time trying=
 different version combinations, loading firmware and checking logs but sti=
ll nothing.
-
With Regards
John J

  =20
--===============6620771098569409665==--

