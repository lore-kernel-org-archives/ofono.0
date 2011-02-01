Content-Type: multipart/mixed; boundary="===============7640493086166430413=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/5] Fix misspellings
Date: Tue, 01 Feb 2011 15:32:47 -0200
Message-ID: <1296581572-3697-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7640493086166430413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are some spelling fixes. The only relevant ones are those in the docs,=
 but
since they are trivial to be included, I'm sending this patch set fixing al=
l of
them. Feel free to ignore the others if you prefer.

They were caught by a new tool I've made, codespell:
http://git.profusion.mobi/cgit.cgi/lucas/codespell/

Lucas De Marchi (5):
  TODO: fix misspelling
  doc: fix misspelling
  drivers: fix misspellings
  plugins: fix misspelling
  test: fix misspelling

 TODO                         |    2 +-
 doc/sim-api.txt              |    2 +-
 drivers/isimodem/sms.c       |    2 +-
 drivers/isimodem/voicecall.c |    2 +-
 plugins/stemgr.c             |    2 +-
 test/set-call-forwarding     |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- =

1.7.4


--===============7640493086166430413==--

