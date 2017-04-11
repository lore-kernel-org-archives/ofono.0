Content-Type: multipart/mixed; boundary="===============1585487436509573754=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 0/1] Gemalto: Improve init process
Date: Tue, 11 Apr 2017 11:04:10 +0200
Message-ID: <1491901451-25109-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1585487436509573754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch improves the robustness of Gemalto init process.
Interfaces don't show up sometimes, such as SimManager. In particular,
setting the modem Online->Offline->Online causes issue.
Also gprs reactivation is broken.

 - Change the Airplane mode to keep the SIM connected. It solves
run issue when setting Online again.
 - Use URC to enable SIM detection. It solves run issue on modem poweron.
 - Change the way/conditions to create the interfaces.
 - Shutdown the modem on exit.
 - Fix enable/disable return value.

Vincent Cesson (1):
  gemalto: Improve init process

 plugins/gemalto.c | 467 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 431 insertions(+), 36 deletions(-)

-- =

1.9.1


--===============1585487436509573754==--

