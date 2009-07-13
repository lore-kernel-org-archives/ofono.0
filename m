Content-Type: multipart/mixed; boundary="===============0767773384590264353=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Problems with voice call.
Date: Mon, 13 Jul 2009 09:13:26 +0300
Message-ID: <4A5AD086.7040103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0767773384590264353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to make a voice call with oFono. I'm using Option GlobeSurfer
ICON 225 HSDPA/UMTS USB as the modem. If I understood correctly voice
call should be possible with the dbus-messages used below. However, I
end up with an error "Operation failed".

$ dbus-send --system --print-reply --dest=3Dorg.ofono /
org.ofono.at.Manager.Create string:"dev:/dev/ttyHS0" string:"at"
method return sender=3D:1.540 -> dest=3D:1.544 reply_serial=3D2
   object path "/modem1"

$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1
org.ofono.VoiceCallManager.Dial string:"+000000000000" string:"default"
Error org.ofono.Error.Failed: Operation failed

When the second dbus-message is sent the following messages are printed
by the ofonod:

ofonod[19113]: atd_cb got result: 0
ofonod[19113]: Final response: ERROR
ofonod[19113]: Dial callback returned error: (null)

Are the messages I sent to the ofonod correct?

Regards,
Marko

--===============0767773384590264353==--

