Content-Type: multipart/mixed; boundary="===============8404410025897908681=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Problems with voice call.
Date: Mon, 13 Jul 2009 17:01:02 +0800
Message-ID: <B94C62E7C2870743865418621F040C130203F1286E@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <4A5AD086.7040103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8404410025897908681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Marko Saukko
>Sent: 2009=E5=B9=B47=E6=9C=8813=E6=97=A5 14:13
>To: ofono(a)ofono.org
>Subject: Problems with voice call.
>
>Hi,
>
>I'm trying to make a voice call with oFono. I'm using Option GlobeSurfer
>ICON 225 HSDPA/UMTS USB as the modem. If I understood correctly voice
>call should be possible with the dbus-messages used below. However, I
>end up with an error "Operation failed".


Yes, it can use dbus-message but python script will be more visibility
Also you can try use d-feet =

As I haven't modem in hand so I use phonesim as simulator, I didn't meet yo=
ur problem and the Voice call work fine with simulator =


>
>$ dbus-send --system --print-reply --dest=3Dorg.ofono /
>org.ofono.at.Manager.Create string:"dev:/dev/ttyHS0" string:"at"
>method return sender=3D:1.540 -> dest=3D:1.544 reply_serial=3D2
>   object path "/modem1"
>
>$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1
>org.ofono.VoiceCallManager.Dial string:"+000000000000" string:"default"
>Error org.ofono.Error.Failed: Operation failed


My result:
dbus-send --system --print-reply --dest=3Dorg.ofono /modem1 org.ofono.Voice=
CallManager.Dial string:"+234" string:"default" =

method return sender=3D:1.829 -> dest=3D:1.851 reply_serial=3D2
   object path "/modem1/voicecall01"

>
>When the second dbus-message is sent the following messages are printed
>by the ofonod:
>
>ofonod[19113]: atd_cb got result: 0
>ofonod[19113]: Final response: ERROR
>ofonod[19113]: Dial callback returned error: (null)
>
>Are the messages I sent to the ofonod correct?
>
So you can check if your modem could receive the ATD command first.
If not, perhaps something wrong in driver part.

>Regards,
>Marko

Zhigang


--===============8404410025897908681==--

