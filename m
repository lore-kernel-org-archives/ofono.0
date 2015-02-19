Content-Type: multipart/mixed; boundary="===============2269263724005446090=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 0/2] Add ResetProperties method to ConnectionContext interface
Date: Thu, 19 Feb 2015 13:59:51 +0200
Message-ID: <1424347193-6828-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2269263724005446090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some cases it is useful to reset connection context settings back to ones
ofono provisioning resolved initially.
What's your opinion on the API design, implementation and use-case described
next?

Deactivation of the context is obviously mandatory. The reasoning for placi=
ng
this into ofono is handling client requests consistently and avoiding race
conditions. Using this approach ofono does not re-activate the context, tha=
t's =

done by ConnMan or whatever connection manger the system uses.

Ps. Patches on behalf of Slava whose emails didn't get through to the maili=
ng
list.

Slava Monich (2):
  gprs: Add ResetProperties method to ConnectionContext interface
  doc: Document ResetProperties method

 doc/connman-api.txt |    9 ++
 src/gprs.c          |  292 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 295 insertions(+), 6 deletions(-)

-- =

1.7.9.5


--===============2269263724005446090==--

