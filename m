Content-Type: multipart/mixed; boundary="===============3130926174864099196=="
MIME-Version: 1.0
From: Leaf John <leafjohn@gmail.com>
Subject: [PATCH] add default property setter for modemconf
Date: Mon, 09 Aug 2010 14:48:35 +0800
Message-ID: <AANLkTi=itV4peGUyvxmU5LeS-cryWVTqFJm=jR5dPuM_@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3130926174864099196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was trying to run ofono for a huawei usb modem on my meego netbook,
but the udev on netbook seems not work for ofono, so that I've to
mannualy write settings in modem.conf.

Huawei driver needs two device, pcui & modem, and I can't specify them
by either Interface & Device in modem.conf.

Then I wrote this patch, It will load all Key=3DValue pairs in
modem.conf file( Except Driver=3Dxxx pair ), and store them to modem
properties.

Then I add Pcui=3D & Modem=3D entry in modem.conf file, it works, I can
use ofono to send & recieve message by huawei stick now.

Here comes the patch:
-----------------------------------------------------------------

diff -wpB --git a/plugins/modem.conf b/plugins/modem.conf
index 66bf932..e1ef1cd 100644

#Author: Leaf Johnson <leafjohn@gmail.com>
#Based on ofono 0.25
#Introduciton:
#This patch will add a function to modemconf.c: set_default_modem_param;
#It will load all Key=3DValue pairs in modem.conf file( Except
Driver=3Dxxx pair ), and store them to modem properties.
#It is used in the system doesn't have enough udev support, e.g. meego netb=
ooks.
#The modification in modem.conf is the adaption for using Huawei
USB-modem on a meego netbook.

--- a/plugins/modem.conf
+++ b/plugins/modem.conf
@@ -44,3 +44,9 @@
 #[n900]
 #Driver=3Dn900modem
 #Interface=3Dphonet0
+
+#Huawei driver, for meego platform
+#[Huawei]
+#Driver=3Dhuawei
+#Pcui=3D/dev/ttyUSB_utps_pcui
+#Modem=3D/dev/ttyUSB_utps_modem
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 3747cd9..646dc6a 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -128,6 +128,32 @@ static int set_interface(struct ofono_modem *modem,
 	return 0;
 }

+static int set_default_modem_param( struct ofono_modem *modem,
+						GKeyFile *keyfile, const char * group )
+{
+	char **keys;
+	char **ptr;
+	char *value;
+
+	keys =3D g_key_file_get_keys( keyfile, group, NULL, NULL );
+	if( ! keys ){//get error
+		return -EINVAL;
+	}
+
+	for( ptr =3D keys; *ptr !=3D NULL; ++ptr ){
+		value =3D g_key_file_get_string( keyfile, group, *ptr, NULL );
+		if( ! value )
+			continue;
+		if( ! g_str_equal( *ptr, "Driver" ) )
+			ofono_modem_set_string( modem, *ptr, value );
+		g_free( value );
+		value =3D NULL;
+	}
+	g_strfreev( keys );
+
+	return 0;
+}
+
 static struct {
 	const char *driver;
 	int (*func) (struct ofono_modem *modem,
@@ -142,6 +168,7 @@ static struct {
 	{ "palmpre",	set_device	},
 	{ "isimodem",	set_interface	},
 	{ "n900modem",	set_interface	},
+	{ "huawei", 	set_default_modem_param	},
 	{ NULL }
 };

@@ -150,6 +177,7 @@ static struct ofono_modem *create_modem(GKeyFile
*keyfile, const char *group)
 	struct ofono_modem *modem;
 	char *driver;
 	int i;
+	int processed=3D0;

 	driver =3D g_key_file_get_string(keyfile, group, "Driver", NULL);
 	if (!driver)
@@ -160,8 +188,14 @@ static struct ofono_modem *create_modem(GKeyFile
*keyfile, const char *group)
 		goto error;

 	for (i =3D 0; setup_helpers[i].driver; i++) {
-		if (!g_strcmp0(driver, setup_helpers[i].driver))
+		if (!g_strcmp0(driver, setup_helpers[i].driver)){
 			setup_helpers[i].func(modem, keyfile, group);
+			processed =3D 1;
+			break;
+		}
+	}
+	if( ! processed ){//Unregconizable driver name, use default param setter
+		set_default_modem_param( modem, keyfile, group );
 	}

 error:


-- =

Best Reagres,
Leaf Johnson<leafjohn@gmail.com>

--===============3130926174864099196==--

