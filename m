Content-Type: multipart/mixed; boundary="===============1152827662228993411=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Wed, 04 Nov 2009 01:46:56 +0800
Message-ID: <1257270416.26789.11.camel@zzhan17-mobl.ccr.corp.intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B9CBAB7@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1152827662228993411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
> This driver handles phone informations about registration status, signal
> strength and roaming status listening +CIEV commands.  It also gets the
> Network Operator name with +COPS commands.
> ---
>  Makefile.am                             |    3 +-
>  drivers/hfpmodem/hfpmodem.c             |    2 +
>  drivers/hfpmodem/hfpmodem.h             |    3 +
>  drivers/hfpmodem/network-registration.c |  365 +++++++++++++++++++++++++=
++++++
>  plugins/hfp.c                           |    1 +
>  5 files changed, 373 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/hfpmodem/network-registration.c

On compiling your code I got:

  CC     drivers/hfpmodem/network-registration.o
cc1: warnings being treated as errors
drivers/hfpmodem/network-registration.c: In function =E2=80=98cops_cb=E2=80=
=99:
drivers/hfpmodem/network-registration.c:101: error: label =E2=80=98error=E2=
=80=99
defined but not used
drivers/hfpmodem/network-registration.c:58: error: unused variable =E2=80=
=98nd=E2=80=99
make[1]: *** [drivers/hfpmodem/network-registration.o] Error 1
make: *** [all] Error 2

So I have below patch to remove 'nd' and refine labels in cops_cb.
Please review it.

I would suggest to replace 'out' label by return. We really don't need
two labels that is confusing. Atmodem netreg has the same problem.

---
 drivers/hfpmodem/network-registration.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c
b/drivers/hfpmodem/network-registration.c
index 6cfaf57..e163b79 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -55,7 +55,6 @@ struct netreg_data {
 static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
 	ofono_netreg_operator_cb_t cb =3D cbd->cb;
 	struct ofono_network_operator op;
 	GAtResultIter iter;
@@ -67,23 +66,23 @@ static void cops_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 =

 	if (!ok) {
 		cb(&error, NULL, cbd->data);
-		goto out;
+		return;
 	}
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "+COPS:"))
-		return;
+		goto error;
 =

 	g_at_result_iter_skip_next(&iter);
 =

 	ok =3D g_at_result_iter_next_number(&iter, &format);
 =

 	if (ok =3D=3D FALSE || format !=3D 0)
-		return;
+		goto error;
 =

 	if (g_at_result_iter_next_string(&iter, &name) =3D=3D FALSE)
-		return;
+		goto error;
 =

 	strncpy(op.name, name, HFP_MAX_OPERATOR_NAME_LENGTH);
 	op.name[HFP_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
@@ -93,15 +92,10 @@ static void cops_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 =

 	cb(&error, &op, cbd->data);
 =

-out:
-	g_free(cbd);
-
 	return;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void ciev_notify(GAtResult *result, gpointer user_data)
@@ -274,15 +268,12 @@ static void hfp_current_operator(struct
ofono_netreg *netreg,
 =

 	if (ok)
 		ok =3D g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
-				cops_cb, cbd, NULL);
+				cops_cb, cbd, g_free);
 =

 	if (ok)
 		return;
 =

 error:
-	if (cbd)
-		g_free(cbd);
-
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

-- =

1.6.2.5



--===============1152827662228993411==--

