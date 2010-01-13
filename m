Content-Type: multipart/mixed; boundary="===============7907440076568977387=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Tue, 12 Jan 2010 18:54:59 -0600
Message-ID: <201001121854.59479.denkenz@gmail.com>
In-Reply-To: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7907440076568977387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Initial impressions:

+static DBusConnection *connection;
+static char *ofono_handsfree_path;
+
+
+static int timeout;
+

These globals seem to belong in per-modem user data unless you only want 1 =
HFP =

device per system?

+
+GIOChannel *g_at_get_channel_from_fd(int fd)
+{
+	GIOChannel *channel;
+	struct termios ti;
+
+	/* Switch TTY to raw mode */
+	memset(&ti, 0, sizeof(ti));
+	cfmakeraw(&ti);
+	tcflush(fd, TCIOFLUSH);
+	tcsetattr(fd, TCSANOW, &ti);
+
+	channel =3D g_io_channel_unix_new(fd);
+
+	if (channel =3D=3D NULL) {
+		close(fd);
+		return NULL;
+	}
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	return channel;
+}

Seriously, what are you trying to do here?  If you want a GIOChannel simply =

use g_io_channel_unix_new(fd) and pass it to gatchat.  See plugins/phonesim=
.c =

phonesim_enable() for details.  That operates on a TCP socket.

+struct ofono_modem *ofono_modem_get_by_path(const char *path);
+

You don't need this, see below.

+	g_dbus_register_interface(conn, obj_path, HFP_AGENT_INTERFACE,
+			agent_methods, NULL, NULL, data, NULL);
+

You can pass the modem object as userdata for the agent when registering th=
e =

interface.  The modem will thus be available as 'data' in =

hfp_agent_new_connection, etc.

Regards,
-Denis

--===============7907440076568977387==--

