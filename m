Content-Type: multipart/mixed; boundary="===============5053918920783735078=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Missing CallRemoved signals
Date: Wed, 17 Aug 2011 11:58:50 +0200
Message-ID: <4E4B90DA.2060706@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5053918920783735078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm doing further tests with oFono with a simple UI that handles the =

calls of a certain modem (bluetooth modem in this case).

I keep track of the existing calls by listening to 'VoiceCallManager' =

signals, 'CallAdded' and 'CallRemoved'. The list is initialized using =

'VoiceCallManager.GetCalls()' at startup.

The problem I have found is that some 'CallRemoved' signals are =

apparently never emitted. It is in fact quite easy to reproduce, if a =

modem is powered down while a call is in progress.

Having a look at oFono's source code (src/voicecall.c), my feeling is =

that some calls to 'voicecall_dbus_unregister' are not accompanied by a =

call to 'voicecalls_emit_call_removed', inside the function =

'voicecall_unregister'.

Could anyone confirm if this is a bug in oFono or suggest any workaround =

for the client app?

Regards,
Mikel


--===============5053918920783735078==--

