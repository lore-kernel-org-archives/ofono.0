Content-Type: multipart/mixed; boundary="===============7378585899624580418=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 0/2] mmsd: error management
Date: Fri, 27 Apr 2012 17:47:02 +0200
Message-ID: <1335541624-23000-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7378585899624580418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
The first patch removes the MMS reception part from TODO file which
has been done some times ago.
This model of error management applies also for MMS emission, except that
it shouldn't be silent because initiated by the user.

S=C3=A9bastien Bianti (2):
  TODO: MMS reception error management done
  service: emit signal when send has failed

 TODO          |   13 -------------
 src/service.c |   32 ++++++++++++++++++++------------
 2 files changed, 20 insertions(+), 25 deletions(-)

-- =

1.7.4.4


--===============7378585899624580418==--

