Content-Type: multipart/mixed; boundary="===============7700470040965336199=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 12/20] packet: add context type default
Date: Mon, 11 Apr 2011 13:20:10 +0300
Message-ID: <1302517218-2147-13-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7700470040965336199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OFONO_PACKET_CONTEXT_TYPE_DEFAULT is added to
ofono_packet_context_type and conversion functions
are updated for the same.
---
 include/packet-context.h |    1 +
 src/packet.c             |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/packet-context.h b/include/packet-context.h
index 44fd69f..02a5c42 100644
--- a/include/packet-context.h
+++ b/include/packet-context.h
@@ -47,6 +47,7 @@ enum ofono_packet_context_type {
 	OFONO_PACKET_CONTEXT_TYPE_MMS,
 	OFONO_PACKET_CONTEXT_TYPE_WAP,
 	OFONO_PACKET_CONTEXT_TYPE_IMS,
+	OFONO_PACKET_CONTEXT_TYPE_DEFAULT,
 };
 =

 struct ofono_packet_context_param {
diff --git a/src/packet.c b/src/packet.c
index 1acbf76..6077617 100644
--- a/src/packet.c
+++ b/src/packet.c
@@ -153,6 +153,8 @@ static const char *packet_context_default_name(enum ofo=
no_packet_context_type ty
 		return "WAP";
 	case OFONO_PACKET_CONTEXT_TYPE_IMS:
 		return "IMS";
+	case OFONO_PACKET_CONTEXT_TYPE_DEFAULT:
+		return "Default";
 	}
 =

 	return NULL;
@@ -172,6 +174,8 @@ static const char *packet_context_type_to_string(
 		return "wap";
 	case OFONO_PACKET_CONTEXT_TYPE_IMS:
 		return "ims";
+	case OFONO_PACKET_CONTEXT_TYPE_DEFAULT:
+		return "default";
 	}
 =

 	return NULL;
@@ -192,6 +196,9 @@ static gboolean packet_context_string_to_type(const cha=
r *str,
 	} else if (g_str_equal(str, "ims")) {
 		*out =3D OFONO_PACKET_CONTEXT_TYPE_IMS;
 		return TRUE;
+	} else if (g_str_equal(str, "default")) {
+		*out =3D OFONO_PACKET_CONTEXT_TYPE_DEFAULT;
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

1.7.0.4


--===============7700470040965336199==--

