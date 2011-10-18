Content-Type: multipart/mixed; boundary="===============8011898511920811859=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Bluetooth Audio Handling IRC Meeting
Date: Tue, 18 Oct 2011 16:33:01 +0200
Message-ID: <4E9D8E1D.8050007@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8011898511920811859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

[Sorry for cross posting but it might be interesting for someone on
these mailing lists]

I would like to invite to a IRC discussion on the HFP audio handling.

Topic is to find a solution for the handling/routing of the audio
streams (SCO link) in BlueZ, PulseAudio and oFono.

- Currently, it is not possible for PulseAudio or BlueZ to know what the
audio stream is carrying (*). This information is need for multi phone
uses cases. Think about two connected phones at the same time and both
are doing HFP.

- If there is need for policy decisions, is desirable to have this done
in one place only. With policy decision is meant deciding when to
suspend and resume a SCO link. Of course we would have to agree first,
if this should be done in placed into one component only.

- For the two phone use cases I also like to discuss how to report the
'content' (*) of the audio links, so the above policies can be
implemented. oFono doesn't export this information and I assume we
really don't want to have a dependency on PulseAudio from oFono.

(*) in band ringing, active call, held call, etc.

irc server: freenode.net
irc channel: #bop_audio
date: 20.10.2011 (10/20/11 for the americans)
time: 16:00 CEST (07:00 PDT, 09:00 CDT, 17:00 EEST)
duration: < 1 hour (hopefully)

If the date/time is really bad for you (sorry Marcel), please let me
know. Johan told me he could also attend it if we start one hour later.

cheers,
daniel

--===============8011898511920811859==--

