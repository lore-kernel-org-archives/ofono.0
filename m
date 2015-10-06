Content-Type: multipart/mixed; boundary="===============3574357419810382655=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: HandsfreeAudioCard registration for HFP AG plugin
Date: Tue, 06 Oct 2015 12:48:11 +0200
Message-ID: <1444128494-31742-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3574357419810382655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey everybody,

after some more detailed discussion with Denis yesterday on IRC I've
reworked the previously sent patches a bit and included two patches
Denis worked on before but never submitted yet. With this the audio
card is only registered if we have a service level connection
successfully established.

What is missing currently is codec negotiation between AG and HF but
I already started to implement this and will send further patches
with support for this soon.

regards,
Simon


--===============3574357419810382655==--

