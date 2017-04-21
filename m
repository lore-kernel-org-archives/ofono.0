Content-Type: multipart/mixed; boundary="===============3096387049419097900=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 0/1] atmodem: Fix SMS reception for Gemalto modems
Date: Fri, 21 Apr 2017 16:06:55 +0200
Message-ID: <1492783616-5897-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3096387049419097900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patch fixes SMS reception for Gemalto modems. It impacts sens=
ible
code in atmodem driver. I need to add a case for Gemalto concerning +CMT
parsing. This parsing was executed in at_parse_cmt(), which is called only =
by
at_cmt_notify(). Based on at_cmgr_notify(), I moved parsing code from
at_parse_cmt() to at_cmt_notify() and I added a switch case for Gemalto mod=
ems.
I moved code because I need access to data->vendor.

Vincent Cesson (1):
  atmodem: Fix SMS reception for Gemalto modems

 drivers/atmodem/sms.c | 66 +++++++++++++++++++++++++++++------------------=
----
 plugins/gemalto.c     |  2 +-
 2 files changed, 39 insertions(+), 29 deletions(-)

-- =

1.9.1


--===============3096387049419097900==--

