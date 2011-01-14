Content-Type: multipart/mixed; boundary="===============2486118933283140387=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [offline-atoms PATCH 0/2]
Date: Fri, 14 Jan 2011 16:40:51 +0200
Message-ID: <1295016053-31994-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2486118933283140387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here are patches that make gprs and sim atom online-agnostic. The atoms
follow the network registration status and they can be added in
post_sim. =


The intention is to allow GPRS context to be configured and short
messages to be queued while in offline.

The patches has been tested with mbm and n900 modems (admittedly in
December last year).

--Pekka


--===============2486118933283140387==--

