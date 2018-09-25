Content-Type: multipart/mixed; boundary="===============7654972197760968885=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/4] drivers: default gprs authentication
Date: Tue, 25 Sep 2018 15:20:35 +0200
Message-ID: <20180925132035.19417-4-gciofono@gmail.com>
In-Reply-To: <20180925132035.19417-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7654972197760968885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Default value for gprs authentication method:
for most of the atoms, there is already a default, that is either
no authentication or error.
In case of error (only PAP and CHAP supported), this is unchanged, like
for atmodem PPP. This legacy code will run as-is today, defaulting later
to no authentication if username or password are empty.
In case of default to no authentication, the new value
OFONO_GPRS_AUTH_METHOD_NONE is added to make this explicit.

It turns out that only the atmodem (PPP) and the mbimmodem need to have
default value in the switch/case for selecting the method.
For the atmodem, it is in the ublox vendor logic, and the fix removes
the method prefix in the APN name. According to ublox specification,
it is the right way to do it.

For the mbim modem, NONE is supported, it just needs to be added to the
switch/case.

There are 3 more drivers containing a gprs-context atom, which have a
default behavior as follow:
error for:  telitmodem, ubloxmodem,
no authentication for: qmimodem
---
 drivers/atmodem/gprs-context.c   | 4 ++++
 drivers/mbimmodem/gprs-context.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 79ac4c8e..b10777a5 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -304,6 +304,10 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 				snprintf(buf + len, sizeof(buf) - len - 3,
 						",\"PAP:%s\"", ctx->apn);
 				break;
+			default:
+				snprintf(buf + len, sizeof(buf) - len - 3,
+						",\"%s\"", ctx->apn);
+				break;
 			}
 			break;
 		default:
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index 79793c92..ce33b927 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -75,6 +75,8 @@ static uint32_t auth_method_to_auth_protocol(enum ofono_g=
prs_auth_method method)
 		return 2; /* MBIMAuthProtocolChap */
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return 1; /* MBIMAuthProtocolPap */
+	default:
+		return 0;
 	}
 =

 	return 0;
-- =

2.17.1


--===============7654972197760968885==--

