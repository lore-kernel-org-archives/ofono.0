Content-Type: multipart/mixed; boundary="===============7700993836097511200=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 3/5] include: Declaration function to set CHLD features
Date: Mon, 17 Mar 2014 16:47:28 +0100
Message-ID: <1395071250-19440-4-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7700993836097511200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

---
 include/handsfree.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree.h b/include/handsfree.h
index dde7000..a419884 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -54,6 +54,8 @@ struct ofono_handsfree_driver {
 =

 void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
 					unsigned int ag_features);
+void ofono_handsfree_set_ag_chld_features(struct ofono_handsfree *hf,
+					unsigned int ag_mpty_features);
 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
 						ofono_bool_t enabled);
 void ofono_handsfree_voice_recognition_notify(struct ofono_handsfree *hf,
-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============7700993836097511200==--

