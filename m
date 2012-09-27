Content-Type: multipart/mixed; boundary="===============5707562835748535478=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/3] gdbus patches
Date: Thu, 27 Sep 2012 08:58:56 -0300
Message-ID: <1348747139-1881-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5707562835748535478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches were applied to BlueZ repository. Please, have a look and app=
ly
them on other projects.

Johan Hedberg (1):
  gdbus: Fix crash when getting disconnected from the bus

Lucas De Marchi (2):
  gdbus: Fix wrong signal handler match
  gdbus: Refactor filter_data_find()

 gdbus/mainloop.c |   9 ++--
 gdbus/watch.c    | 122 ++++++++++++++++++++++++++++++++++++---------------=
----
 2 files changed, 86 insertions(+), 45 deletions(-)

-- =

1.7.12.1


--===============5707562835748535478==--

