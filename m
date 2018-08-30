Content-Type: multipart/mixed; boundary="===============3817871094591307323=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: place to intercept BT audio packets?
Date: Wed, 29 Aug 2018 20:23:34 -0500
Message-ID: <c395dd5a-7570-3c7f-f9fb-2a3eeebf5c58@gmail.com>
In-Reply-To: <5B8717CE.9010409@rivaretica.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3817871094591307323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/29/2018 05:01 PM, dev(a)rivaretica.com wrote:
> New to ofono: looking for documentation/pointers that can inform about =

> the best point in ofono to intercept Bluetooth audio packets from/to =

> headset to implement custom audio processing (and does audio stream even =

> thread through ofono?).
> =


oFono does not process the audio stream, it only sets up the transport. =

The actual packets are processed by PulseAudio or directly routed from =

the sound card to the Bluetooth chip in hardware.

This is a fairly complex topic.  I would ask this question on the BlueZ =

and / or Pulse Audio mailing lists.

Regards,
-Denis

--===============3817871094591307323==--

