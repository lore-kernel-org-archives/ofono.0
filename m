Content-Type: multipart/mixed; boundary="===============7034731081939945024=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 0/4] Query retry counters
Date: Tue, 04 Jan 2011 20:22:55 -0200
Message-ID: <1294179779-4013-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7034731081939945024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Difference from previous version is that now the pin_retries field is no mo=
re a
GSList because it's not allowed to be on public header files. So, it's now
passed from drivers to core and stored there as an array of ints.

Lucas De Marchi (4):
  include: add method to query pin Retries
  sim: query remaining pin retries
  doc: detail Retries property
  atmodem: implement query for remaining pin retries

 doc/sim-api.txt       |   12 ++++++
 drivers/atmodem/sim.c |   90 +++++++++++++++++++++++++++++++++++++++++++++
 include/sim.h         |    5 +++
 src/sim.c             |   97 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 204 insertions(+), 0 deletions(-)

-- =

1.7.3.4


--===============7034731081939945024==--

