Content-Type: multipart/mixed; boundary="===============7022901345096142105=="
MIME-Version: 1.0
From: Riccardo Sala <riccardo.sala@springtech.it>
Subject: Simcom SIM800 gprs data connection not working
Date: Tue, 28 May 2019 10:10:35 +0200
Message-ID: <4bfc977a-f809-f3d9-d280-e03f5c80de4a@springtech.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7022901345096142105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear All,

 =C2=A0 I have a Simcom SIM800 modem that is working with Ofono.

My question: how can I hangup an outgoing call **before** it is answered?

I've tried with:

 =C2=A0=C2=A0=C2=A0 # dbus-send --system --print-reply --dest=3Dorg.ofono /=
sim900_0 =

org.ofono.VoiceCallManager.HangupAll

but the answer is:

 =C2=A0=C2=A0=C2=A0 Error org.ofono.Error.InProgress: Operation already in =
progress

and with:

 =C2=A0=C2=A0=C2=A0 # dbus-send --system --print-reply --dest=3Dorg.ofono =

/sim900_0/voicecall01 org.ofono.VoiceCall.Hangup

but the answer is:

 =C2=A0=C2=A0=C2=A0 Error org.freedesktop.DBus.Error.UnknownObject: Method =
"Hangup" =

with signature "" on interface "org.ofono.VoiceCall" doesn't exi

that is correct because the path /sim900_0/voicecall01 only exists when =

the call is already answered.


I'm stuck. Is it possible?

Thanks a lot.


Regards,

Riccardo



--===============7022901345096142105==--

