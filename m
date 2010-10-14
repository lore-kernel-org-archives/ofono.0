Content-Type: multipart/mixed; boundary="===============4313200529890981734=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 3/8] sim: add new parameter to file-info utility
Date: Fri, 15 Oct 2010 00:02:50 +0300
Message-ID: <1287090175-3018-4-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287090175-3018-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4313200529890981734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 42b19bd..7860e24 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -82,6 +82,7 @@ typedef void (*ofono_sim_file_info_cb_t)(const struct ofo=
no_error *error,
 					enum ofono_sim_file_structure structure,
 					int recordlength,
 					const unsigned char access[3],
+					unsigned char file_status,
 					void *data);
 =

 typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
-- =

1.6.3.3



--===============4313200529890981734==--

