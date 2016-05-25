Content-Type: multipart/mixed; boundary="===============4853536434003677677=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HFP HF - Reject SCO Issue
Date: Wed, 25 May 2016 09:57:25 -0500
Message-ID: <5745BD55.3030108@gmail.com>
In-Reply-To: <HK2PR04MB1203FD52E58A2F1BA7F7D264DE400@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4853536434003677677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 05/25/2016 06:01 AM, Jomon John wrote:
> Hi,
>
> I am trying to configure HFP with Bluez(5.34), Ofono(1.17) and pulseaudio=
(6) on a Freescale i.MX6 board using Linux 4.1.15 kernel, the idea is to us=
e the target board in HFP/Handsfree Unit role. The bluetooth controller is =
a Pluggable USB Bluetooth Dongle (0a5c:21e8 - BCM20702A0) with updated firm=
ware.
>
> The procedure followed is,
>
> * Pair & connect with the android mobile phone with the bluetoothctl
> * Enable modem and dial number using ofono test scripts
>
> After this the call is being made but the audio routing fails with "Rejec=
t SCO : Agent not registered" message from oFono. While checking with btmon=
 its found that the SCO Connect Request has been rejected with the reason o=
f limited resources(0x0d).
>
> Can anyone help me to identify the root cause, I spent a lot of time tryi=
ng different version combinations, loading firmware and checking logs but s=
till nothing.

This looks like a problem with PulseAudio configuration. oFono does not =

handle SCO data, PulseAudio does that. In order to do that, PulseAudio =

needs to register an agent with oFono. Then the SCO socket will be =

established and the fd handed off to PulseAudio to process the audio data.

I have no idea how this is accomplished in PulseAudio.  This question is =

being asked fairly often recently.  Does PulseAudio have an =

FAQ/documentation for this yet?

Regards,
-Denis


--===============4853536434003677677==--

