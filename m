Content-Type: multipart/mixed; boundary="===============5138191032335816388=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 0/2] PPP: recording ppp dump to file
Date: Fri, 05 Aug 2011 10:34:02 +0200
Message-ID: <1312533244-28622-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5138191032335816388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create a new env var to activate PPP dump recording into a file.
Store this file in the PPP context, so the recording can occurs from
the beginning of the session, and so we are sure to not loose any frame.

Bertrand Aygon (2):
  gatppp: save dumpfile into ppp info to start recording during open
    phase.
  gprs: use a new var env to active PPP dump.

 drivers/atmodem/gprs-context.c |    5 +++++
 gatchat/gatppp.c               |   11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5138191032335816388==--

