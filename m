Content-Type: multipart/mixed; boundary="===============3732759685644087322=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [RFC PATCH v6 0/1] lte core: additional properties for the default
 context
Date: Sat, 13 Oct 2018 09:34:32 +0200
Message-ID: <20181013073433.26680-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3732759685644087322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a partial submit, for comments.
Related to v5, I have updated the submit description,
added a comment for the storage (that makes clear that protocol and =

authentication method are always saved because of their defaults),
and changed the handling of the SetProperty key, taking it from the
incoming message, as suggested by Denis.


Giacinto Cifelli (1):
  lte: protocol and authentication for default ctx

 src/lte.c | 241 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 185 insertions(+), 56 deletions(-)

-- =

2.17.1


--===============3732759685644087322==--

