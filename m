Content-Type: multipart/mixed; boundary="===============2171837638924132581=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Thu, 21 Jan 2010 21:27:34 +0200
Message-ID: <20100121192734.GA31209@jh-x301>
In-Reply-To: <20100121192209.GA30879@jh-x301>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2171837638924132581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

Sorry, not only did I manage not to quote the original patch properly
but the mime-type in my mail was scrwed up. Here's a second try:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Sorry about the delay in getting more comments from me. Here's the
result of an initial (and rather quick) review:

+static const char *connected2str(int i)
+{
+	switch (i) {
+		case GATEWAY_STATE_DISCONNECTED:
+			return "disconnected";
+		case GATEWAY_STATE_CONNECTING:
+			return "connecting";
+		case GATEWAY_STATE_CONNECTED:
+			return "connected";
+		case GATEWAY_STATE_PLAYING:
+			return "playing";
+		default:
+			return "";
+	}
+}

This should be called state2str and the state is gateway_state_t and not
int. Also name the variable more apropriately (e.g. "state").

+static void change_state(struct audio_device *dev, int new_state)

Same goes here. gateway_state_t and not int.

+	gw->sco =3D chan;
+	g_io_channel_ref(chan);

The convention is to do the variable assignment through the return value
of the _ref function. Please do that.

-	/* why is this here? */
 	fcntl(g_io_channel_unix_get_fd(chan), F_SETFL, 0);

Why are you removing this comment? Either remove the fcntl call
altogether, fix the comment to describe why the call is needed or then
don't do anything if you don't know what it's for.

+	if (!dbus_set_error_from_message(&derr, reply)) {
+		info("Agent reply: file descriptor passed successfuly");
+		return;
+	}

I don't think this is worth an info(). Use debug() instead.

+	g_idle_add(gateway_close, gw);

Do you really need to call gateway_close through an idle callback?
What's the problem with calling it directly?

+	/* make /dev/rfcomm serial port from chan */
+	memset(&req, 0, sizeof(req));
+	req.dev_id =3D -1;
+	req.flags =3D (1 << RFCOMM_REUSE_DLC);
+	bacpy(&req.src, &dev->src);
+	bacpy(&req.dst, &dev->dst);
+	req.channel =3D gw->channel;

What's this? I thought you removed all the RFCOMM TTY codde.

+	return;
 }

Unnecessary return at the end of a void function.

+	agent =3D g_new0(struct agent, 1);
+	if (!agent)
+		return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".Failed",
+				"Failed to create a new agent");

g_new0() will either assert or always return non-NULL. Use g_try_new0
if you want to check for failure, but probably you can just remove the
check and keep using g_new0. Btw, src/agent.h already defines a struct
agent so it'd be better if you use another name, e.g. hf_agent.


+	agent->name =3D strdup(name);
+	agent->path =3D strdup(path);

Use g_strdup.

+	g_io_channel_ref(chan);
+	dev->gateway->rfcomm =3D chan;

Again, please do the assignment through the return value of _ref()

There are probably more issues, but these are the ones I found after an
initial glance-through. Please send an updated patch, preferably inline
(since as you notice I didn't manage to get my mailer to properly quote
this time) and I'll take a new look. Thanks.

Johan


--===============2171837638924132581==--

