Content-Type: multipart/mixed; boundary="===============3716610436531394482=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 0/3] Persist TX SMS messages
Date: Fri, 28 Jan 2011 00:39:54 -0200
Message-ID: <1296182397-31963-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3716610436531394482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Third version. It includes some changes suggested by Denis:

- Get rid of the oldpath field in struct txq_backup_entry
- Store the encoded uuid in struct txq_backup_entry
- Use SMS_MSGID_FMT to get the file name
- Some more cleanups

Lucas De Marchi (3):
  sms: store pending tx pdus on disk
  sms: delete sent sms messages from backup
  sms: restore pending tx messages from backup

 src/ofono.h   |    1 +
 src/sms.c     |   91 ++++++++++++++++++++
 src/smsutil.c |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   17 ++++
 4 files changed, 366 insertions(+), 0 deletions(-)

-- =

1.7.3.5


--===============3716610436531394482==--

