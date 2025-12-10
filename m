Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9865A275844
	for <ofono@lists.linux.dev>; Wed, 10 Dec 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339613; cv=none; b=STGjv72RU5bTabMSt9qUFTUjz1CgIrAloH3VVvLl+eXG0kM+kqp8ByLYTHmLMecP+cCMDOEpyIB3M10ycfg31Z2kUO0idlTCNzUTkqTC3zksrYC3olx2mgs+dldKEo/9n+0meJdEB9Xxw3U0m9JxQ24CjidzRwZPdu6I5Glwp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339613; c=relaxed/simple;
	bh=5/KvrO1jWhynTvWYw0Navc3Wii3y443tY10evA3sEHo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=X13QOia3WS2ps4Fe9nwPdkFit4CFw0EjbnC6wCqO4aPorCOqz+L0gZhnBFPNCKosuR2Edw9uB+gxMpQLzu7xUpY6/ElW3IPcIp1262twOa3Pvi2+QMFveDmXiAj9PJCfCIy5ghcDMFxyDYoKio+0i91VgpIYCG+rwAuaiA1647s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id A1EF6114711; Tue,  9 Dec 2025 23:00:01 -0500 (EST)
Received: from 5400 (unknown [172.56.167.181])
	by spindle.queued.net (Postfix) with ESMTPSA id 4B1681146EF
	for <ofono@lists.linux.dev>; Tue,  9 Dec 2025 23:00:01 -0500 (EST)
Date: Tue, 9 Dec 2025 22:59:59 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Subject: [PATCH] test: fix list-modems hang & simplify handling of Byte/Bool
 properties
Message-ID: <20251209225959.2355f276@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

=46rom 690d6af7b672d883bd7d7b86435ddcfad5bdc15d Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@queued.net>
Date: Tue, 9 Dec 2025 22:36:16 -0500
Subject: [PATCH] test: fix list-modems hang & simplify handling of Byte/Bool
 properties

Using list-modems with current phonesim (2.0) results in list-modems
hanging while trying to print SimToolkit's IdleModeIcon property. No
errors; it just silently hangs. The issue is that it's a dbus.Byte with
the value b'0' (which python implicitly converts to something that makes
its i/o and string handling deeply unhappy).

It's unpleasant to have to special-case every dbus.Byte property value,
so instead let's display Bytes based on their type. That will help
future-proof this script as new properties get added to interfaces.

While we're at it, also stop implicitly converting dbus.Boolean values
to "1"/"0", and use "TRUE"/"FALSE" to make it clearer that they  are
bools.

A small sample of what list-modem's output looks like with phonesim:

task-0:     [ org.ofono.SimToolkit ]
task-0:         IdleModeText =3D=20
task-0:         IdleModeIcon =3D 0
task-0:         MainMenuTitle =3D=20
task-0:         MainMenuIcon =3D 0
task-0:         MainMenu =3D=20
task-0:     [ org.ofono.MessageWaiting ]
task-0:         VoicemailWaiting =3D TRUE
task-0:         VoicemailMessageCount =3D 1
task-0:         VoicemailMailboxNumber =3D 6789
task-0:     [ org.ofono.SimAuthentication ]
task-0:         NetworkAccessIdentity =3D 12345678@phonesim.org

---
 test/list-modems | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index a163791e..1b262482 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -50,14 +50,6 @@ for path, properties in modems:
 				for i in properties[key]:
 					val +=3D "[" + i + "] =3D '"
 					val +=3D properties[key][i] + "' "
-			elif key in ["MobileNetworkCodeLength",
-						"VoicemailMessageCount",
-						"MicrophoneVolume",
-						"SpeakerVolume",
-						"Strength",
-						"DataStrength",
-						"BatteryChargeLevel"]:
-				val =3D int(properties[key])
 			elif key in ["MainMenu"]:
 				val =3D ", ".join([ text + " (" + str(int(icon)) +
 					")" for text, icon in properties[key] ])
@@ -76,6 +68,10 @@ for path, properties in modems:
 					else:
 						val +=3D properties[key][i]
 				val +=3D " }"
+			elif type(properties[key]) =3D=3D dbus.Byte:
+				val =3D int(properties[key])
+			elif type(properties[key]) =3D=3D dbus.Boolean:
+				val =3D str(bool(properties[key])).upper()
 			else:
 				val =3D properties[key]
 			print("        %s =3D %s" % (key, val))
--=20
2.47.3

