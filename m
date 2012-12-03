Content-Type: multipart/mixed; boundary="===============8338171349583964491=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Telit HE910 modem --- unable be put on line by Connman
Date: Mon, 03 Dec 2012 14:13:47 +0100
Message-ID: <50BCA58B.6080102@southpole.se>
In-Reply-To: <50BC8FB6.7020309@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8338171349583964491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/03/2012 12:40 PM, Jonas Bonn wrote:
> So, my thinking is that we need to do something like this:
>
> i)   At telit_enable, set CFUN=3D1 and wait for QSS=3D2 or QSS=3D3.
> ii)  When we get QSS=3D2 or QSS=3D3 then we can set SIM_READY state so th=
at
> post_sim gets called... this should be called after all the IMSI
> querying, etc. (right?)
> iii) Once we're in SIM_READY state, we set CFUN=3D4... this is the 'end'
> of the 'telit_enable' phase
> iv)  While in CFUN=3D4 state, we ignore QSS: 0
> V)   This should result in the GPRS interface being exported so that
> connman can call 'online' call which will result in the switch to the
> "real" CFUN=3D1

I gave this a try with the HE910 from Telit and the following works (not =

in git format, this is just for reference... I will resubmit it later =

after comment).  Just note that it takes about 1 min for the SIM to =

reach "ready" state after power up.

This also doesn't account for QSS: 0 occurring during 'offline' state... =

need to check what happens there.

Comments?


diff --git a/plugins/telit.c b/plugins/telit.c
index fe2ccd6..40d72fe 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -339,7 +339,7 @@ static int telit_enable(struct ofono_modem *modem)
         g_at_chat_send(data->chat, "AT#QSS=3D0", none_prefix, NULL, NULL, =

NULL);

         /* Set phone functionality */
-       g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+       g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
                                 cfun_enable_cb, modem, NULL);

         return -EINPROGRESS;
@@ -565,6 +565,16 @@ static void telit_post_sim(struct ofono_modem *modem)

         if (gprs && gc)
                 ofono_gprs_add_context(gprs, gc);
+
+       /*
+        * We need the modem in CFUN!=3D4 state in order to get to
+        * post_sim... now we can check if we really should be offline
+        * and, if so, set CFUN=3D4
+        */
+       if (!ofono_modem_get_online(modem)) {
+               g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+                               NULL, NULL, NULL);
+       }
  }

  static void set_online_cb(gboolean ok, GAtResult *result, gpointer =

user_data)

/Jonas

--===============8338171349583964491==--

